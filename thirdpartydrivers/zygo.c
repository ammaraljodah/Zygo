// daquanserq8.c - xPC Target, non-inlined S-function driver for the
// D/A section of the Quanser Q8 Data Acquisition System

// Copyright 2003-2014 The MathWorks, Inc.

#define     S_FUNCTION_LEVEL  2
#undef      S_FUNCTION_NAME
#define     S_FUNCTION_NAME   zygo

#include "simstruc.h"

#ifdef  MATLAB_MEX_FILE
#include    "mex.h"
#endif

#ifndef MATLAB_MEX_FILE
#include    <windows.h>
#include    "xpctarget.h"
#endif

#define NUM_ARGS       4
#define N_AXIS_ARG    ssGetSFcnParam(S,0) // int
#define COUNT2NM_ARG  ssGetSFcnParam(S,1)
#define SAMP_TIME_ARG ssGetSFcnParam(S,2) // double
#define BASE_ADDR8316   (uint16_T)mxGetPr(ssGetSFcnParam(S,3))[0]  // Base address

#define NUM_I_WORKS    (0)
#define NUM_R_WORKS    (0)

static char_T msg[256];

#define ADDR8316_DIO_IN			(BASE_ADDR8316 + 0x0E)	// read  digital 16 bits input
#define ADDR8316_DIO_OUT		(BASE_ADDR8316 + 0x0E)	// write digital 16 bits output

#define IOE_DISABLE 0x0040
#define IOE_ENABLE 0x0100

#define SCLK1_DISABLE 0x0200
#define SCLK1_ENABLE 0x0080

static void mdlInitializeSizes(SimStruct *S)
{
    size_t i;
    size_t n_axis=(int_T)mxGetPr(N_AXIS_ARG)[0];
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
    
    if(!ssSetNumOutputPorts(S,n_axis )) return;
    for (i = 0;i < n_axis; i++) {
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
    const uint16_T AXIS_ADDRESS [8]={0xF00,0xF08,0xF10,0xF18,0xF20,0xF28,0xF30,0xF38};
    real_T delay_in_sec=0.0000001;// 100 nano sec (0.1 micro sec)
    uint16_T dig_out=SCLK1_DISABLE+IOE_DISABLE;
    xpcOutpW(ADDR8316_DIO_OUT, dig_out);
    xpcBusyWait(delay_in_sec);
#endif
}

static void mdlOutputs(SimStruct *S, int_T tid)
{
#ifndef MATLAB_MEX_FILE
    const uint16_T AXIS_ADDRESS [8]={0xF00,0xF08,0xF10,0xF18,0xF20,0xF28,0xF30,0xF38};
    uint16_T   nAxis     = (uint16_T)mxGetPr(N_AXIS_ARG)[0],i,j,dig_out,regdata,reg2data,reg3data;
    uint32_T pos;
    real_T  pos_real,count2Nm=(real_T)mxGetPr(COUNT2NM_ARG)[0],*y,delay_in_sec;
    
    dig_out=SCLK1_ENABLE + IOE_DISABLE + AXIS_ADDRESS[0];
    xpcOutpW(ADDR8316_DIO_OUT, dig_out);
    delay_in_sec=0.0000001; // wait for 100 Nano sec
    xpcBusyWait(delay_in_sec);
    
    dig_out=SCLK1_DISABLE + IOE_DISABLE + AXIS_ADDRESS[0];
    xpcOutpW(ADDR8316_DIO_OUT, dig_out);
    
    
    for (i = 0; i < nAxis; i++)
    {
        for (j=0;j<=3;j++) // loop to read the MSB byte then the LSB byte
        {
            
            dig_out=SCLK1_DISABLE + IOE_DISABLE + AXIS_ADDRESS[i]+ j; // give address for MSB
            
            xpcOutpW(ADDR8316_DIO_OUT, dig_out);
            delay_in_sec=0.000000015; // wait for 15 Nano sec
            
            xpcBusyWait(delay_in_sec);
            
            dig_out=SCLK1_DISABLE + IOE_ENABLE + AXIS_ADDRESS[i]+j; // Activate the IOE
            xpcOutpW(ADDR8316_DIO_OUT, dig_out);
            delay_in_sec=0.000000065; // wait for 65 Nano sec
            
            xpcBusyWait(delay_in_sec);
            
            
            regdata=xpcInpW( ADDR8316_DIO_IN); // Read the MSB
            if (j==2)
                reg2data=regdata;
            if (j==3)
                reg3data=regdata;
        }
        
        y= ssGetOutputPortRealSignal(S, i);
        y[0] = ((real_T)((int32_T)((reg2data<<16)+reg3data)))*count2Nm;
    }
    
#endif
}

static void mdlTerminate(SimStruct *S)
{
#ifndef MATLAB_MEX_FILE
    const uint16_T AXIS_ADDRESS [8]={0xF00,0xF08,0xF10,0xF18,0xF20,0xF28,0xF30,0xF38};
    real_T delay_in_sec=0.0000001;// 100 nano sec (0.1 micro sec)
    uint16_T dig_out=SCLK1_DISABLE+IOE_DISABLE;
    xpcOutpW(ADDR8316_DIO_OUT, dig_out);
    xpcBusyWait(delay_in_sec);
#endif
    
}


#ifdef MATLAB_MEX_FILE
#include "simulink.c"
#else
#include "cg_sfun.h"
#endif




