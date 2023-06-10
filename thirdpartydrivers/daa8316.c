// daquanserq8.c - xPC Target, non-inlined S-function driver for the
// D/A section of the Quanser Q8 Data Acquisition System

// Copyright 2003-2014 The MathWorks, Inc.

#define     S_FUNCTION_LEVEL  2
#undef      S_FUNCTION_NAME
#define     S_FUNCTION_NAME   daa8316

#include "simstruc.h"

#ifdef  MATLAB_MEX_FILE
#include    "mex.h"
#endif

#ifndef MATLAB_MEX_FILE
#include    <windows.h>
#include    "xpctarget.h"
#endif

#define NUM_ARGS       4
#define CHANNEL_ARG    ssGetSFcnParam(S,0) // vector of [1:8]
#define SAMP_TIME_ARG  ssGetSFcnParam(S,1) // double
#define BASE_ADDR8316   (uint16_T)mxGetPr(ssGetSFcnParam(S,2))[0]  // Base address
#define RANGE_ARG ssGetSFcnParam(S,3)
#define NUM_I_WORKS    (0)
#define NUM_R_WORKS    (0)

static char_T msg[256];
// Base address

// register address, offset definition table

#define ADDR8316_AD_DATA		( BASE_ADDR8316 + 0x04)	// read ADC data

#define ADDR8316_AD_CH_STAT		( BASE_ADDR8316 + 0x08)	// read ADC channel and status
#define ADDR8316_FIFO_ENABLE	( BASE_ADDR8316 + 0x08)	// write FIFO enable

#define ADDR8316_INPUT_RANGE 	( BASE_ADDR8316 + 0x09)	// write to gain control

#define ADDR8316_SELECT_CH	 	( BASE_ADDR8316 + 0x0A)	// write to channel MUX

#define ADDR8316_INT_SRC_SET	( BASE_ADDR8316 + 0x0B)	// read  interrup source setting

#define ADDR8316_AD_MODE_SET	( BASE_ADDR8316 + 0x0C)	// read  AD mode setting

#define ADDR8316_SOFT_AD_TRIG	( BASE_ADDR8316 + 0x0A)	// read - software A/D trigger

#define AD_10_00V			0x00   // Bipolar +/-  10V
#define AD_05_00V			0x01   // Bipolar +/-  5V
#define AD_02_50V			0x02   // Bipolar +/-  2.5V
#define AD_01_25V			0x03   // Bipolar +/-  1.25V

// Interrupt Trigger Source Control
// function _8316_AD_Set_INT_Source(source)
#define	INT_SRC_EXTERNAL	0x01	// external interrupt source

// AD mode control register value
#define AD_SOFT_TRIG		0x00	// software trigger

#define EOC_MASK			0x80

#define FIFO_DISABLE		0x00

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
    if(!ssSetNumInputPorts(S, 0)) return;
    
    if(!ssSetNumOutputPorts(S, (int_T)mxGetN(CHANNEL_ARG))) return;
    for (i = 0;i < mxGetN(CHANNEL_ARG); i++) {
        ssSetOutputPortWidth(S, i, 1);
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
    
    // set input range
    uint8_T inrange =(uint8_T)mxGetPr(RANGE_ARG)[0];
    switch (inrange){
        case 1:
            xpcOutpB( ADDR8316_INPUT_RANGE, AD_10_00V);
            break;
        case 2:
            xpcOutpB( ADDR8316_INPUT_RANGE, AD_05_00V);
            break;
        case 3:
            xpcOutpB( ADDR8316_INPUT_RANGE, AD_02_50V);
            break;
        case 4:
            xpcOutpB( ADDR8316_INPUT_RANGE, AD_01_25V);
            break;
    }
    
    
    // set FIFO
    xpcOutpB( ADDR8316_FIFO_ENABLE, FIFO_DISABLE);
    
    // set interrupt source
    xpcOutpB( ADDR8316_INT_SRC_SET, INT_SRC_EXTERNAL);
    
    // set adc mode
    xpcOutpB( ADDR8316_AD_MODE_SET, AD_SOFT_TRIG);
    
#endif
}

static void mdlOutputs(SimStruct *S, int_T tid)
{
#ifndef MATLAB_MEX_FILE
    size_t   nChans     = mxGetN(CHANNEL_ARG);
    uint16_T   i,chan,value;
    uint8_T	eoc;
    real_T *y;
    
    
    for (i = 0; i < nChans; i++)
    {
        
        // select channel
        chan = (uint16_T) mxGetPr(CHANNEL_ARG)[i] - 1;
        xpcOutpB( ADDR8316_SELECT_CH, chan);
        
        // software trigger to start conversion
        xpcInpB( ADDR8316_SOFT_AD_TRIG);
        
        // Wait for rising edge of conversion complete, eoc = 0x80
        eoc = 0x00;
        while (eoc == 0x00)
        {
            eoc = (xpcInpB( ADDR8316_AD_CH_STAT ) & EOC_MASK) >> 7;
        }
        
        value = xpcInpW( ADDR8316_AD_DATA );
        y= ssGetOutputPortRealSignal(S, i);
        y[0] = (real_T) value / 3276.7;
    }
#endif
}

static void mdlTerminate(SimStruct *S)
{
#ifndef MATLAB_MEX_FILE
    
#endif
}


#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#else
#include "cg_sfun.h"
#endif




