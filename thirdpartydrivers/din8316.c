// daquanserq8.c - xPC Target, non-inlined S-function driver for the
// D/A section of the Quanser Q8 Data Acquisition System

// Copyright 2003-2014 The MathWorks, Inc.

#define     S_FUNCTION_LEVEL  2
#undef      S_FUNCTION_NAME
#define     S_FUNCTION_NAME   din8316

#include "simstruc.h"

#ifdef  MATLAB_MEX_FILE
#include    "mex.h"
#endif

#ifndef MATLAB_MEX_FILE
#include    <windows.h>
#include    "xpctarget.h"
#endif

#define NUM_ARGS       2
#define SAMP_TIME_ARG ssGetSFcnParam(S,0) // double
#define BASE_ADDR8316   (uint16_T)mxGetPr(ssGetSFcnParam(S,1))[0]  // Base address

#define NUM_I_WORKS    (0)
#define NUM_R_WORKS    (0)

static char_T msg[256];

#define ADDR8316_DIO_IN			(BASE_ADDR8316 + 0x0E)	// read  digital 16 bits input
#define ADDR8316_DIO_OUT		(BASE_ADDR8316 + 0x0E)	// write digital 16 bits output


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
    
    if(!ssSetNumOutputPorts(S,1 )) return;
    ssSetOutputPortWidth(S, 0, 1);
    
    
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
#endif
}

static void mdlOutputs(SimStruct *S, int_T tid)
{
#ifndef MATLAB_MEX_FILE
    uint16_T   din;
    real_T *y;
    din=xpcInpW(ADDR8316_DIO_IN);
       
    y= ssGetOutputPortRealSignal(S, 0);
    y[0] = (real_T) din;
    
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




