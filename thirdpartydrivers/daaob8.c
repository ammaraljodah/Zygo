// daquanserq8.c - xPC Target, non-inlined S-function driver for the
// D/A section of the Quanser Q8 Data Acquisition System

// Copyright 2003-2014 The MathWorks, Inc.

#define     S_FUNCTION_LEVEL  2
#undef      S_FUNCTION_NAME
#define     S_FUNCTION_NAME   daaob8

#include "simstruc.h"

#ifdef  MATLAB_MEX_FILE
#include    "mex.h"
#endif

#ifndef MATLAB_MEX_FILE
#include    <windows.h>
#include    "xpctarget.h"
#endif

#define NUM_ARGS       8
#define CHANNEL_ARG    ssGetSFcnParam(S,0) // vector of [1:8]
#define RANGE_ARG      ssGetSFcnParam(S,1) // vector of [1:8]
#define CALIB_ARG      ssGetSFcnParam(S,2) // vector of calib values
#define SIMUL_ARG      ssGetSFcnParam(S,3) // 1: yes, 2: no
#define RESET_ARG      ssGetSFcnParam(S,4) // vector of boolean
#define INIT_VAL_ARG   ssGetSFcnParam(S,5) // vector of double
#define SAMP_TIME_ARG  ssGetSFcnParam(S,6) // double
#define BASE_ADDR816   (uint16_T)mxGetPr(ssGetSFcnParam(S,7))[0]  // Base address

#define NUM_I_WORKS    (0)
#define NUM_R_WORKS    (0)

static char_T msg[256];
// Base address
//#define BASE_ADDR816		0x300  // card base address

// Number of Address Bytes
#define AOB816_ADDRSPACE	0x10

// place card in simultaneous mode without updating outputs
#define ADDR816_SIM_NO_UPDATE		(BASE_ADDR816 + 0x00)	// 8-bit, read

// release card from simultaneous mode to auto mode without updating outputs
#define ADDR816_AUTO_NO_UPDATE		(BASE_ADDR816 + 0x02)	// 8-bit, read

// update all outputs and place card in simultaneous mode
#define ADDR816_UPDATE_IN_SIM		(BASE_ADDR816 + 0x08)	// 8-bit, read

// update all outputs and release card from simultaneous to auto mode
#define ADDR816_UPDATE_IN_AUTO		(BASE_ADDR816 + 0x0A)	// 8-bit, read

// set all outputs to zero
#define ADDR816_SET_ZERO			(BASE_ADDR816 + 0x0E)	// 8-bit, read

// release zero latch
#define ADDR816_RELEASE_ZERO_LATCH	(BASE_ADDR816 + 0x0F)	// 8-bit, read

// card is set to Bipolar, -10 to +10 V
// 16-bit resolution
// N: 0 to (2^16-1)  = 65535
// N = 65535 * Vout (V) / full scale (V) = 6553.5 * Vout (V), full scale = 10 V

static uint16_T volt2count(real_T volt,int_T ch_range);

static void mdlInitializeSizes(SimStruct *S)
{
    size_t i;
    
    ssSetNumSFcnParams(S, NUM_ARGS);
    if (ssGetNumSFcnParams(S) != ssGetSFcnParamsCount(S)) {
        sprintf(msg, "%d input args expected, %d passed",
                NUM_ARGS, ssGetSFcnParamsCount(S));
        ssSetErrorStatus(S, msg);
        return;
    }
    
    ssSetNumContStates(S, 0);
    ssSetNumDiscStates(S, 0);
    if(!ssSetNumOutputPorts(S, 0)) return;
    
    if(!ssSetNumInputPorts(S, (int_T)mxGetN(CHANNEL_ARG))) return;
    for (i = 0;i < mxGetN(CHANNEL_ARG); i++) {
        ssSetInputPortWidth(S, i, 1);
        ssSetInputPortDirectFeedThrough(S, i, 1);
    }
    
    ssSetSimStateCompliance(S, HAS_NO_SIM_STATE);
    
    ssSetNumSampleTimes(S, 1);
    ssSetNumRWork(S, NUM_R_WORKS);
    ssSetNumIWork(S, NUM_I_WORKS);
    ssSetNumPWork(S, 0);
    ssSetNumModes(S, 0);
    ssSetNumNonsampledZCs(S, 0);
    
    for (i = 0; i < NUM_ARGS; i++) {
        ssSetSFcnParamTunable(S, i, SS_PRM_NOT_TUNABLE);
    }
    
    ssSetOptions(S, SS_OPTION_DISALLOW_CONSTANT_SAMPLE_TIME | SS_OPTION_EXCEPTION_FREE_CODE );
}

static void mdlInitializeSampleTimes(SimStruct *S)
{
    ssSetModelReferenceSampleTimeInheritanceRule(S, USE_DEFAULT_FOR_DISCRETE_INHERITANCE);
    if (mxGetPr(SAMP_TIME_ARG)[0] == -1.0) {
        ssSetSampleTime(S, 0, INHERITED_SAMPLE_TIME);
        ssSetOffsetTime(S, 0, FIXED_IN_MINOR_STEP_OFFSET);
    } else {
        ssSetSampleTime(S, 0, mxGetPr(SAMP_TIME_ARG)[0]);
        ssSetOffsetTime(S, 0, 0.0);
    }
}

#define MDL_START
static void mdlStart(SimStruct *S)
{
#ifndef MATLAB_MEX_FILE
    
    int_T   simul      = (int_T)mxGetPr(SIMUL_ARG)[0],ch_range;
    size_t   nChans     = mxGetN(CHANNEL_ARG);
    uint16_T   i, chan,count;
    // release zero latch
    xpcInpB( ADDR816_RELEASE_ZERO_LATCH );
    
    // set all outputs to zero
    xpcInpB( ADDR816_SET_ZERO );
    
    // place card in simultaneous mode
    xpcInpB( ADDR816_SIM_NO_UPDATE );
    
    
    for (i = 0; i < nChans; i++)
    {
        chan = (uint16_T) mxGetPr(CHANNEL_ARG)[i] - 1;
        ch_range=(int_T)mxGetPr(RANGE_ARG)[i];
        count=volt2count(0, ch_range);
        xpcOutpW((BASE_ADDR816 + (chan * 2)), count);
        
    }
    if (simul)
        xpcInpB( ADDR816_UPDATE_IN_SIM );
    else
        xpcInpB( ADDR816_UPDATE_IN_AUTO );
    
#endif
}

static void mdlOutputs(SimStruct *S, int_T tid)
{
#ifndef MATLAB_MEX_FILE
    int_T   simul      = (int_T)mxGetPr(SIMUL_ARG)[0],ch_range;
    size_t   nChans     = mxGetN(CHANNEL_ARG);
    real_T  voltage,calib;
    uint16_T   i, chan,count;
    
    
    InputRealPtrsType uPtrs;
    
    // compute the counts
    for (i = 0; i < nChans; i++)
    {
        chan = (uint16_T) mxGetPr(CHANNEL_ARG)[i] - 1;
        
        uPtrs = ssGetInputPortRealSignalPtrs(S, i);
        voltage = *uPtrs[0];
        calib= (real_T) mxGetPr(CALIB_ARG)[i];
        ch_range=(int_T)mxGetPr(RANGE_ARG)[i];
        count=volt2count(voltage * calib, ch_range);
        
        xpcOutpW((BASE_ADDR816 + (chan * 2)), count);
        
    }
    
    if (simul)
        xpcInpB( ADDR816_UPDATE_IN_SIM );
    
#endif
}

static void mdlTerminate(SimStruct *S)
{
#ifndef MATLAB_MEX_FILE
    int_T   simul      = (int_T)mxGetPr(SIMUL_ARG)[0],ch_range;
    size_t   nChans     = mxGetN(CHANNEL_ARG);
    
    real_T  voltage,calib;
    uint16_T   i, chan,count;
    
    
    // compute the counts and set the valid indicators
    for (i = 0; i < nChans; i++)
    {
        chan = (int_T) mxGetPr(CHANNEL_ARG)[i] - 1;
        
        // when downloading, set channels to initial values;
        // when terminating, set requested channels to initial values
        
        if (!xpcIsModelInit() && !(uint_T)mxGetPr(RESET_ARG)[i])
            continue;
        
        voltage = mxGetPr(INIT_VAL_ARG)[i];
        calib= (real_T) mxGetPr(CALIB_ARG)[i];
        ch_range=(int_T)mxGetPr(RANGE_ARG)[i];
        count=volt2count(voltage * calib, ch_range);
        xpcOutpW((BASE_ADDR816 + (chan * 2)), count);
        
    }
    
    if (simul)
        xpcInpB( ADDR816_UPDATE_IN_SIM );
#endif
    
}

uint16_T volt2count(real_T volt,int_T ch_range)
{   uint16_T out;
    real_T MAX_VOLT,MIN_VOLT,DAC_BITS_PER_VOLT;
    
    switch (ch_range){
        case -10:
            
            MAX_VOLT=10;
            MIN_VOLT=-10;
            DAC_BITS_PER_VOLT=3276.7;
            if (volt>MAX_VOLT)
                volt=MAX_VOLT;
            if (volt<MIN_VOLT)
                volt=MIN_VOLT;
            if (volt<0)
                out=(uint16_T)(32767+volt*DAC_BITS_PER_VOLT) & 0x7FFF;
            else
                out= (uint16_T)(volt*DAC_BITS_PER_VOLT) | 0x8000 ;
            break;
            
        case -5:
            
            MAX_VOLT=5;
            MIN_VOLT=-5;
            DAC_BITS_PER_VOLT=6553.4;
            if (volt>MAX_VOLT)
                volt=MAX_VOLT;
            if (volt<MIN_VOLT)
                volt=MIN_VOLT;
            if (volt<0)
                out=(uint16_T)(32767+volt*DAC_BITS_PER_VOLT) & 0x7FFF;
            else
               out= (uint16_T)(volt*DAC_BITS_PER_VOLT) | 0x8000 ;
            break;
        case 5:
            
            MAX_VOLT=5;
            MIN_VOLT=0;
            DAC_BITS_PER_VOLT=13107;
            if (volt>MAX_VOLT)
                volt=MAX_VOLT;
            if (volt<MIN_VOLT)
                volt=MIN_VOLT;
            out= (uint16_T)(volt*DAC_BITS_PER_VOLT);
            break;
        case 10:
            
            MAX_VOLT=10;
            MIN_VOLT=0;
            DAC_BITS_PER_VOLT=6553.5;
            if (volt>MAX_VOLT)
                volt=MAX_VOLT;
            if (volt<MIN_VOLT)
                volt=MIN_VOLT;
            out= (uint16_T)(volt*DAC_BITS_PER_VOLT);
            break;
    }
    
    return out;
    
}




#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#else
#include "cg_sfun.h"
#endif




