function [] = zygo_m()
%% GUI Creation
clc
close all
clear all
% GUI
handles = struct();
% --- FIGURE -------------------------------------
handles.figure1 = figure( ...
    'Tag', 'figure1', ...
    'Units', 'characters', ...
    'Position', [71.2 17.1538461538462 178 44.6923076923077], ...
    'Name', 'Zygo_GUI', ...
    'MenuBar', 'none', ...
    'NumberTitle', 'off', ...
    'Color', get(0,'DefaultUicontrolBackgroundColor'));
fig_hdl = handles.figure1;

% --- PANELS -------------------------------------
handles.uipanel1 = uipanel( ...
    'Parent', handles.figure1, ...
    'Tag', 'uipanel1', ...
    'Units', 'characters', ...
    'Position', [4 23.8461538461539 61.2 16.4615384615385], ...
    'Title', 'Enviroment Variables');

handles.uipanel2 = uipanel( ...
    'Parent', handles.figure1, ...
    'Tag', 'uipanel2', ...
    'Units', 'characters', ...
    'Position', [66.6 1.61538461538462 109 38.6923076923077], ...
    'Title', 'System Messages');

% --- STATIC TEXTS -------------------------------------
handles.lbl_temp = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'lbl_temp', ...
    'Style', 'text', ...
    'Units', 'characters', ...
    'Position', [1.6 12.5384615384615 18.4 1.53846153846154], ...
    'FontSize', 10, ...
    'String', 'Temp (Deg C)');

handles.lbl_Pr = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'lbl_Pr', ...
    'Style', 'text', ...
    'Units', 'characters', ...
    'Position', [2.2 9.46153846153846 22.6 1.53846153846154], ...
    'FontSize', 10, ...
    'String', 'Pressure (mm Hg)');

handles.lbl_Hu = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'lbl_Hu', ...
    'Style', 'text', ...
    'Units', 'characters', ...
    'Position', [1.8 6.23076923076923 21.4 1.53846153846154], ...
    'FontSize', 10, ...
    'String', 'Rel Humidity (%)');

handles.lbl_no_axis = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'lbl_no_axis', ...
    'Style', 'text', ...
    'Units', 'characters', ...
    'Position', [4.4 21.3076923076923 18.4 1.53846153846154], ...
    'FontSize', 10, ...
    'String', 'Number of Axis');

handles.text1 = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'text1', ...
    'Style', 'text', ...
    'Units', 'characters', ...
    'Position', [55.2 40.4615384615385 61.8 2.92307692307692], ...
    'FontSize', 15, ...
    'String', 'Zygo Laser Measurment System');

% --- PUSHBUTTONS -------------------------------------
handles.pb_Apply = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'pb_Apply', ...
    'Style', 'pushbutton', ...
    'Units', 'characters', ...
    'Position', [32.4 0.923076923076923 25.4 3.92307692307692], ...
    'String', 'Apply', ...
    'Callback', @pb_Apply_Callback);

handles.pb_Def = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'pb_Def', ...
    'Style', 'pushbutton', ...
    'Units', 'characters', ...
    'Position', [2 0.92307692307692 25.4 3.92307692307692], ...
    'String', 'Default', ...
    'Callback', @pb_Def_Callback);

handles.pb_Ini = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'pb_Ini', ...
    'Style', 'pushbutton', ...
    'Units', 'characters', ...
    'Position', [4.2 16.6923076923077 59.6 3.61538461538462], ...
    'String', 'Initialize', ...
    'Callback', @pb_Ini_Callback);

handles.pb_Acqire = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'pb_Acqire', ...
    'Style', 'pushbutton', ...
    'Units', 'characters', ...
    'Position', [27.6 11.0769230769231 32.2 4.69230769230769], ...
    'String', 'Acquire Data', ...
    'Callback', @pb_Acqire_Callback);
handles.pb_Acqire = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'pb_Status', ...
    'Style', 'pushbutton', ...
    'Units', 'characters', ...
    'Position', [27.6 5.153846153846154 32.2 4.69230769230769], ...
    'String', 'Status', ...
    'Callback', @pb_Status_Callback);
% --- CHECKBOXES -------------------------------------
handles.cb_axi1 = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'cb_axi1', ...
    'Style', 'checkbox', ...
    'Units', 'characters', ...
    'Position', [4.2 12.5384615384615 20.2 3.38461538461539], ...
    'String', 'Axis 1');

handles.cb_axi2 = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'cb_axi2', ...
    'Style', 'checkbox', ...
    'Units', 'characters', ...
    'Position', [4 9.76923076923077 20.2 3.38461538461539], ...
    'String', 'Axis 2');

handles.cb_axi3 = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'cb_axi3', ...
    'Style', 'checkbox', ...
    'Units', 'characters', ...
    'Position', [3.8 6.38461538461539 20.2 3.38461538461539], ...
    'String', 'Axis 3');

handles.cb_axi4 = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'cb_axi4', ...
    'Style', 'checkbox', ...
    'Units', 'characters', ...
    'Position', [4.2 2.53846153846154 20.2 3.38461538461539], ...
    'String', 'Axis 4');

% --- EDIT TEXTS -------------------------------------
handles.txt_C = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'txt_C', ...
    'Style', 'edit', ...
    'Units', 'characters', ...
    'Position', [25.6 11.7692307692308 32.8 2.46153846153846], ...
    'BackgroundColor', [1 1 1], ...
    'String', '20');

handles.txt_Pr = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'txt_Pr', ...
    'Style', 'edit', ...
    'Units', 'characters', ...
    'Position', [25.6 8.69230769230769 32.8 2.46153846153846], ...
    'BackgroundColor', [1 1 1], ...
    'String', '760');

handles.txt_Hu = uicontrol( ...
    'Parent', handles.uipanel1, ...
    'Tag', 'txt_Hu', ...
    'Style', 'edit', ...
    'Units', 'characters', ...
    'Position', [25.6 5.53846153846154 32.8 2.46153846153846], ...
    'BackgroundColor', [1 1 1], ...
    'String', '50');


% --- POPUP MENU -------------------------------------
handles.pop_no_axis = uicontrol( ...
    'Parent', handles.figure1, ...
    'Tag', 'pop_no_axis', ...
    'Style', 'popupmenu', ...
    'Units', 'characters', ...
    'Position', [25.8 20 38.4 3.23076923076923], ...
    'BackgroundColor', [1 1 1], ...
    'String', {'2','4'});
% --- LISTBOXES -------------------------------------
handles.lst_sysmsg = uicontrol( ...
    'Parent', handles.uipanel2, ...
    'Tag', 'lst_sysmsg', ...
    'Style', 'listbox', ...
    'Units', 'characters', ...
    'Position', [3 0.384615384615385 103.6 36.4615384615385], ...
    'BackgroundColor', [1 1 1], ...
    'String', {''});
set(handles.cb_axi1,'Enable','on');
set(handles.cb_axi2,'Enable','on') ;
set(handles.cb_axi3,'Enable','on');
set(handles.cb_axi4,'Enable','on') ;

set(handles.pb_Apply,'Enable','off') ;
set(handles.pb_Def,'Enable','off') ;
set(handles.pb_Ini,'Enable','off') ;
set(handles.pb_Acqire,'Enable','off') ;

printmsg('Wait ')

%% Ending the previous connection to the VME
a=instrfind;
if (isempty(a)==0)
    fclose(a);
    pause(1)
    delete(a);
    pause(1)
    clear a;
    pause(1)
end

%% ======CONSTANTS ========
ZYGO_MANF_ID							=hex2dec('1000'); 	% Zygo VXI manufacturer ID of device
ZYGO_MODEL_CODE							=hex2dec('1010');	% model code of device ZMI2402

% Zygo VME bus offset address
VME_COMMAND_REG							=hex2dec('00');	% W
VME_STATUS_REG							=hex2dec('00');	% R
VME_INTERRUPT_ENABLE_REG				=hex2dec('02'); % RW
VME_AUX_DATA_ADDR_REG					=hex2dec('04'); % W
VME_ERROR_STATUS_REG					=hex2dec('04'); % R
VME_INTERRUPT_VECTOR_REG				=hex2dec('06'); % RW
VME_CONTROL_01_REG						=hex2dec('08'); % RW
VME_CONTROL_02_REG						=hex2dec('0A');	% RW

VME_SAMPLE_TIMER_REG					=hex2dec('0C'); % rW
VME_DIAG_ADC_REG_M0                     =hex2dec('0C');	% R  M0
VME_SAMPLE_TIMER_REG_M1					=hex2dec('0C'); % R  M1
VME_OFFSET_MSB_REG_M2					=hex2dec('0C'); % R  M2
VME_QUICK_RESET_MSB_REG_M3				=hex2dec('0C');	% R  M3
VME_PHASE_METER_DIAG_REG_M4             =hex2dec('0C');	% R  M4
VME_P2_INTERRUPT_MASK_REG_M5			=hex2dec('0C');	% R  M5
VME_AUX_CONFIG_REG_M6					=hex2dec('0C');	% R  M6
VME_AUX_DATA_READ_REG_M7				=hex2dec('0C'); % R  M7

VME_HIGH_NIBBLES_REG					=hex2dec('0E');	% rW
VME_HIGH_NIBBLES_REG_M0					=hex2dec('0E');	% R  M0
VME_USER_EXCESS_VELOCITY_REG_M1			=hex2dec('0E'); % R  M1
VME_OFFSET_LSB_REG_M2					=hex2dec('0E'); % R  M2
VME_QUICK_RESET_LSB_REG_M3				=hex2dec('0E');	% R  M3
VME_DATA_AGE_ADJUST_REG_M4				=hex2dec('0E'); % R  M4
VME_EEPROM_DATA_READ_REG_M5				=hex2dec('0E'); % R  M5
VME_QUICK_RESET_HIGH_REG_M6				=hex2dec('0E'); % R  M6
VME_AUX_STATUS_REG_M7					=hex2dec('0E'); % R  M7

VME_OFFSET_MSB_REG						=hex2dec('10'); % rW
VME_OFFSET_LSB_REG						=hex2dec('12'); % rW
VME_POSITION_MSB_REG					=hex2dec('10'); % R
VME_POSITION_LSB_REG					=hex2dec('12');	% R
VME_DATA_AGE_ADJUST_REG                 =hex2dec('14');	% rW
VME_DIAG_ADC_MUX_REG					=hex2dec('16');	% W
VME_SAMPLED_POSITION_MSB_REG			=hex2dec('14'); % R
VME_SAMPLED_POSITION_LSB_REG			=hex2dec('16'); % R
VME_USER_EXCESS_VELOCITY_REG			=hex2dec('18');	% rW
VME_P2_INTERRUPT_MASK_REG				=hex2dec('1A');	% rW
VME_VELOCITY_MSB_REG					=hex2dec('18');	% R
VME_VELOCITY_LSB_REG					=hex2dec('1A'); % R
VME_EEPROM_CONTROL_REG					=hex2dec('1C'); % W
VME_EEPROM_DATA_WRITE_REG				=hex2dec('1E');	% W
VME_AUX_DATA_WRITE_REG					=hex2dec('1E'); % W
VME_TIME_MSB_REG						=hex2dec('1C');	% R
VME_TIME_LSB_REG						=hex2dec('1E');	% R

% Zygo Aux Data offset address
VME_ADA_AUX_CONTROL_00_REG				=hex2dec('00'); % RW
VME_ADA_FIRMWARE_VERSION_REG			=hex2dec('01'); % R
VME_ADA_FIRMWARE_REVISION_REG			=hex2dec('02'); % R
VME_ADA_ABSOLUTE_PHASE_REG				=hex2dec('03'); % R
VME_ADA_SSI_OFFSET_REG					=hex2dec('04'); % R
VME_ADA_SSI_MAX_REG						=hex2dec('05'); % R
VME_ADA_SSI_MIN_REG						=hex2dec('06'); % R
VME_ADA_SSI_SQUELCH_REG					=hex2dec('07'); % RW
VME_ADA_PHASE_NOISE_PEAK_REG			=hex2dec('08'); % R
VME_ADA_SW2345_REG						=hex2dec('09'); % R
VME_ADA_SW67_REG						=hex2dec('0A'); % R
VME_ADA_SW78_REG						=hex2dec('0B'); % R
VME_ADA_SSI_DAC_TEST_REG				=hex2dec('0C'); % RW
VME_ADA_TEST_STATUS_REG                 =hex2dec('0D'); % R
VME_ADA_DIAG_RAM_START_REG		 		=hex2dec('0E'); % R

VME_ADA_AUX_CONTROL_01_REG				=hex2dec('20'); % RW
VME_ADA_DIAG_TEMP_MONITOR_READ_REG		=hex2dec('21'); % R
VME_ADA_DIAG_TEMP_MONITOR_WRITE_REG		=hex2dec('22'); % RW
VME_ADA_DIAG_TEMP_MONITOR_CONTROL_REG	=hex2dec('23'); % RW
VME_ADA_ADC_CONTROL_REG					=hex2dec('24'); % RW
VME_ADA_ADC_READ_REG					=hex2dec('25'); % R
VME_ADA_ADC_WRITE_REG					=hex2dec('26'); % RW
VME_ADA_TEST_SW8_REG					=hex2dec('27'); % RW
VME_ADA_TEST_SW7_REG					=hex2dec('28'); % RW
VME_ADA_TEST_SW6_REG					=hex2dec('29'); % RW

% Zygo system constants
ZYGO_SAMPLE_PERIOD                      =0.00025;  % 4.0 kHz sample period in seconds

% EEPROM data at 0X01
ZYGO_DAY_MANUFACTURE_MASK				=hex2dec('001F'); % bits 0-4  are day of manufacture
ZYGO_MONTH_MANUFACTURE_MASK             =hex2dec('01E0'); %bits 5-8  are month of manufacture
ZYGO_YEAR_MANUFACTURE_MASK				=hex2dec('1E00'); %bits 9-12 are year of manufacture + 1996
ZYGO_BOARD_MODEL_CODE_MASK				=hex2dec('E000'); %bits 13-15 are board model code

ZYGO_BOARD_MODEL_CODE_2401				=hex2dec('2000'); %	0000
ZYGO_BOARD_MODEL_CODE_2402				=hex2dec('4000'); %	2000
ZYGO_BOARD_MODEL_CODE_2404				=hex2dec('8000'); %	4000

ZYGO_MAX_AXES							=4;		%max. number of axes
ZYGO_STRING_SIZE						=256;		%size of data string or error string

ZYGO_RECORD_DATA_SIZE					=2000000;	%size of recorded data

ZYGO_OFF_LINE							=0;         %for device on/off line
ZYGO_ON_LINE							=1;

% return of Zygo function
ZYGO_OK							     	=0;
ZYGO_ERROR								=1;
ZYGO_LOOP_CTRL_COUNT_MAX				=5000;

%time in sec, one count = 25 nsec
ZYGO_TIME_COUNT_TO_SECOND               =0.000000025;

ZYGO_LAMBDA_F1_VACUUM_VERTICAL			=632.991501; 	% nm
ZYGO_LAMBDA_F2_VACUUM_HORIZONTAL		=632.991528; 	% nm

ZYGO_DEFAULT_TEMPERATURE				=20;            % Deg C
ZYGO_DEFAULT_PRESSURE					=760;           % mm Hg
ZYGO_DEFAULT_RELATIVE_HUMIDITY			=50;            % %

ZYGO_RETROSPACING_COMPACT_2_AXES_HSPMI	=12.688;        % mm
ZYGO_WAVELENGTH_COMPENSATOR_LENGTH		=70.000;        % mm

ZYGO_PI								=3.1415926535897932384626433832795;
%% Zygo Structure
for i=1:ZYGO_MAX_AXES/2
    if (i==1)
        VMEDevice(1)= visa('ni','VXI0::400::INSTR');
        fopen(VMEDevice(1));
    end
    if (i==2)
        VMEDevice(2)= visa('ni','VXI0::405::INSTR');
        fopen(VMEDevice(2));
    end
    if (i==3)
        VMEDevice(3)= visa('ni','VXI0::410::INSTR');
        fopen(VMEDevice(3));
    end
    if (i==4)
        VMEDevice(4)= visa('ni','VXI0::415::INSTR');
        fopen(VMEDevice(4));
    end
    if (i==5)
        VMEDevice(5)= visa('ni','VXI0::420::INSTR');
        fopen(VMEDevice(5));
    end
    if (i==6)
        VMEDevice(6)= visa('ni','VXI0::425::INSTR');
        fopen(VMEDevice(6));
    end
end

ZG.positionInt              =zeros(1,ZYGO_MAX_AXES); %unit: nano metre (nm)
ZG.velocityInt              =zeros(1,ZYGO_MAX_AXES);		%  unit: nm / sec
ZG.timeInt                  =zeros(1,ZYGO_MAX_AXES);		%  unit: sec
ZG.timeIntPrev              =zeros(1,ZYGO_MAX_AXES);		%  unit: sec
ZG.timeIndex                =zeros(1,ZYGO_MAX_AXES);		%  number of times for time to cross-over 0xFFFFFFFF
ZG.timeFirstInt             =zeros(1,ZYGO_MAX_AXES);		%  number of times for time to cross-over 0xFFFFFFFF

ZG.positionDouble			 =zeros(1,ZYGO_MAX_AXES);		%  unit: nano metre (nm)
ZG.velocityDouble			 =zeros(1,ZYGO_MAX_AXES);		%  unit: nm / sec
ZG.timeDouble 				 =zeros(1,ZYGO_MAX_AXES);		%  unit: sec

ZG.positionRecordInt		 =zeros(ZYGO_MAX_AXES,ZYGO_RECORD_DATA_SIZE);%  unit: nano metre (nm)
ZG.velocityRecordInt		 =zeros(ZYGO_MAX_AXES,ZYGO_RECORD_DATA_SIZE);	%  unit: nm / sec
ZG.timeCommonRecordInt		 =zeros(1,ZYGO_RECORD_DATA_SIZE);	                %  unit: sec

ZG.delayMeasurement          =zeros(1,ZYGO_MAX_AXES);		%
ZG.delayReference			 =zeros(1,ZYGO_MAX_AXES);		%
ZG.dataAge              	 =zeros(1,ZYGO_MAX_AXES);		%
ZG.dataAgeAdjust= 0;

ZG.vmeInterruptLevel		 =zeros(1,ZYGO_MAX_AXES);		%
ZG.posDirectionSense		 =zeros(1,ZYGO_MAX_AXES);		%
ZG.controlRegisterOneData	 =zeros(1,ZYGO_MAX_AXES);		%
ZG.controlRegisterTwoData	 =zeros(1,ZYGO_MAX_AXES);		%

ZG.filterKP                 =zeros(1,ZYGO_MAX_AXES);		%
ZG.filterKV                 =zeros(1,ZYGO_MAX_AXES);		%

ZG.errorStatusReg			 =zeros(1,ZYGO_MAX_AXES);		%
ZG.statusRegister			 =zeros(1,ZYGO_MAX_AXES);		%

ZG.flagMeasurementNoSignal	 =zeros(1,ZYGO_MAX_AXES);		% no signal = 1, normal = 0
ZG.flagReferenceNoSignal	 =zeros(1,ZYGO_MAX_AXES);		% no signal = 1, normal = 0
ZG.flagMeasurementError     =zeros(1,ZYGO_MAX_AXES);		% error = 1, normal = 0
ZG.flagReferenceError		 =zeros(1,ZYGO_MAX_AXES);		% error = 1, normal = 0
ZG.flagOverFlowError		 =zeros(1,ZYGO_MAX_AXES);		% error = 1, normal = 0
ZG.flagVelocityError		 =zeros(1,ZYGO_MAX_AXES);		% error = 1, normal = 0


ZG.zygoAxisDeviceNumber     =zeros(1,ZYGO_MAX_AXES);
ZG.zygoAxisOffsetAddr		 =zeros(1,ZYGO_MAX_AXES);

ZG.selectedAxes             =zeros(1,ZYGO_MAX_AXES); 		% selected = 1, not selected = 0
ZG.selectedPosVel			 =zeros(1,ZYGO_MAX_AXES); 		% pos-&-vel= 1, pos-only     = 2
ZG.selectedFreq             =zeros(1,ZYGO_MAX_AXES); 		% f1       = 1, f2           = 2
ZG.selectedWriteFilePhyRaw  =zeros(1,ZYGO_MAX_AXES);		% physical = 1, raw          = 2
ZG.selectedLinearAngular    =zeros(1,ZYGO_MAX_AXES); 		% linear   = 1, angular      = 2
ZG.selectedPosScale         =zeros(1,ZYGO_MAX_AXES); 		% nm   = 1, um   = 2, mm   = 3, m   = 4 OR n-deg   = 1, ...
ZG.selectedVelScale         =zeros(1,ZYGO_MAX_AXES); 		% nm/s = 1, um/s = 2, mm/s = 3, m/s = 4 OR n-deg/s = 1, ...

ZG.wavelengthCompensationYesNo=0;                           % yes      = 1, no           = 0
ZG.wavelengthCompensationFreq=0;                            % f1       = 1, f2           = 2
ZG.wavelengthCompensationAxis=0;

ZG.temperatureDegC=0;
ZG.pressureMmHg=0;
ZG.relativeHumidityPercent=0;
ZG.retrospacingCompact2AxesHSPMIMm=0;
ZG.wavelengthCompensatorLengthMm=0;                         % L = 70 mm +/- ...

ZG.wavelengthCompRefractiveIndex=0;
ZG.initialRefractiveIndex=0;
ZG.initialLambda_F1=0;
ZG.initialLambda_F2=0;
ZG.positionF1Count2Nm=0;                                     % Nanometre
ZG.positionF2Count2Nm=0;
ZG.velocityF1Count2NmPerSec=0;
ZG.velocityF2Count2NmPerSec=0;
ZG.angleF1Count2TanQ=0;
ZG.angleF2Count2TanQ=0;
ZG.angVelF1Count2TanQPerSec=0;
ZG.angVelF2Count2TanQPerSec=0;

ZG.samplePeriod=0;
ZG.numberOfAxes=4;
ZG.axisNumber=0;

ZG.eepromDataAddr=0;                                    % EEPROM address
ZG.eepromDataU16=0;                                     % EEPROM data

ZG.vmeDeviceNumber=0;
ZG.vmeBusDataU16=0;
ZG.vmeBusDataU32=0;
ZG.vmeBusOffsetAddr=0;

ZG.vmeBusRegisterAddr=0;                                % VME bus register or offset address
ZG.vmeBusRegisterDataU16=0;                             % VME bus register data

ZG.systemMessage='system error' ; 	% report system error message based on the below error code
printmsg('ready')
set(handles.pb_Apply,'Enable','on') ;
set(handles.pb_Def,'Enable','on') ;
set(handles.pb_Ini,'Enable','on') ;
set(handles.pb_Acqire,'Enable','on') ;
set(handles.cb_axi1,'Enable','on') ;
set(handles.cb_axi2,'Enable','on') ;
set(handles.cb_axi1,'value',0) ;
set(handles.cb_axi2,'value',0) ;
% pb_Ini_Callback(0,0);
%% GUI Functions
    function pb_Apply_Callback(h,e)
        ZG.temperatureDegC=str2num(get(handles.txt_C,'string'));
        ZG.pressureMmHg=str2num(get(handles.txt_Pr,'string'));
        ZG.relativeHumidityPercent=str2num(get(handles.txt_Hu,'string'));
        ZygoCalculateConversionFactors();
        printmsg('Enviroment settings applied successfully');
    end


    function pb_Def_Callback(h,e)
        EnvDefault_system();
        set(handles.txt_C,'String',num2str(ZG.temperatureDegC));
        set(handles.txt_Pr,'String',num2str(ZG.pressureMmHg));
        set(handles.txt_Hu,'String',num2str(ZG.relativeHumidityPercent));
        printmsg('Enviroment Defaults applied');
    end

    function pb_Ini_Callback(h,e)
        ZG.numberOfAxes=get(handles.pop_no_axis,'val')*2;
        set(handles.cb_axi1,'value',0) ;
        set(handles.cb_axi2,'value',0) ;
        set(handles.cb_axi3,'value',0) ;
        set(handles.cb_axi4,'value',0) ;
        if ZG.numberOfAxes==2
            set(handles.cb_axi1,'Enable','on') ;
            set(handles.cb_axi2,'Enable','on') ;
            set(handles.cb_axi3,'Enable','off') ;
            set(handles.cb_axi4,'Enable','off') ;
        else
            set(handles.cb_axi1,'Enable','on') ;
            set(handles.cb_axi2,'Enable','on') ;
            set(handles.cb_axi3,'Enable','on') ;
            set(handles.cb_axi4,'Enable','on') ;
        end
        Initialise_system();
        Print_status();
    end

    function pb_Acqire_Callback(h,e)
        axis1=get(handles.cb_axi1, 'Value');
        axis2=get(handles.cb_axi2, 'Value');
        axis3=get(handles.cb_axi3, 'Value');
        axis4=get(handles.cb_axi4, 'Value');
%         
%         if axis1==1
%             if check_status(1)==ZYGO_ERROR
%                 printmsg('can not read from axis try to clear all the errors')
%                 return
%             end
%         end
%         if axis2==1
%             if check_status(2)==ZYGO_ERROR
%                 printmsg('can not read from axis try to clear all the errors')
%                 return
%             end
%         end
%         
%         if axis3==1
%             if check_status(3)==ZYGO_ERROR
%                 printmsg('can not read from axis try to clear all the errors')
%                 return
%             end
%         end
%         
%         if axis4==1
%             if check_status(4)==ZYGO_ERROR
%                 printmsg('can not read from axis try to clear all the errors')
%                 return
%             end
%         end
ZygoInitialize();
                    ZygoCalculateConversionFactors();

      
        nsamples=500;
        pos=zeros(1,nsamples);
        
       jj=1;
        for i=1:10000
            
        
        
            if axis1==1
               
                ZygoForceExternalSample();
                ZygoReadSampledPositionVelocityTime(1);
                
                pos(1:nsamples-1)=pos(2:nsamples);
                pos(nsamples)=ZG.positionInt(1)*ZG.positionF1Count2Nm;
                figure(2)
              
                clc
                ZG.positionInt(1)
%                 ylim([-500 500])
                % ZG.velocityInt(axis)* zygo.velocityF1Count2NmPerSec;
                % ZG.timeInt(axis)
               
            end
            
            jj=jj+1;
            if jj>20
                  plot(pos)
                  drawnow
                  jj=0;
            end
            
        end
    
        
        
        
    end
    function pb_Status_Callback(h,e)
        Print_status();
    end



%% Hardware functions
    function  zygo_fnc_out= RegisterRead16BitData()
        try
            ZG.vmeBusDataU16 = memread(VMEDevice(ZG.vmeDeviceNumber),ZG.vmeBusOffsetAddr,'uint16');
            zygo_fnc_out= ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function  zygo_fnc_out= RegisterRead32BitData()
        try
            ZG.vmeBusDataU32= memread(VMEDevice(ZG.vmeDeviceNumber),ZG.vmeBusOffsetAddr,'uint32');
           ZG.vmeBusDataU32= typecast(uint32(ZG.vmeBusDataU32), 'int32');
            zygo_fnc_out= ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function  zygo_fnc_out= RegisterWrite16BitData()
        try
            memwrite(VMEDevice(ZG.vmeDeviceNumber),ZG.vmeBusDataU16,ZG.vmeBusOffsetAddr,'uint16');
            zygo_fnc_out= ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function  zygo_fnc_out= RegisterWrite32BitData()
        try
            memwrite(VMEDevice(ZG.vmeDeviceNumber),ZG.vmeBusDataU16,ZG.vmeBusOffsetAddr,'uint32');
            zygo_fnc_out= ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

%%  Zygo Functions

    function  zygo_fnc_out= ZygoInitialize()
        try
            ZG.samplePeriod = ZYGO_SAMPLE_PERIOD;
            % get up Zygo axis addresses, interrupt levels, position direction sense, and SCLK enable
            for (axis = 1:ZG.numberOfAxes)
                
                if(axis == 1)  ZG.zygoAxisDeviceNumber(1)  = 1; end
                if(axis == 2)  ZG.zygoAxisDeviceNumber(2)  = 1; end
                if(axis == 3)  ZG.zygoAxisDeviceNumber(3)  = 2; end
                if(axis == 4)  ZG.zygoAxisDeviceNumber(4)  = 2; end
                if(axis == 5)  ZG.zygoAxisDeviceNumber(5)  = 3; end
                if(axis == 6)  ZG.zygoAxisDeviceNumber(6)  = 3; end
                if(axis == 7)  ZG.zygoAxisDeviceNumber(7)  = 4; end
                if(axis == 8)  ZG.zygoAxisDeviceNumber(8)  = 4; end
                if(axis == 9)  ZG.zygoAxisDeviceNumber(9)  = 5; end
                if(axis == 10) ZG.zygoAxisDeviceNumber(10) = 5; end
                if(axis == 11) ZG.zygoAxisDeviceNumber(11) = 6; end
                if(axis == 12) ZG.zygoAxisDeviceNumber(12) = 6; end
                
                if(axis == 1)  ZG.zygoAxisOffsetAddr(1)  = hex2dec('00'); end
                if(axis == 2)  ZG.zygoAxisOffsetAddr(2)  = hex2dec('20'); end
                if(axis == 3)  ZG.zygoAxisOffsetAddr(3)  = hex2dec('00'); end
                if(axis == 4)  ZG.zygoAxisOffsetAddr(4)  = hex2dec('20'); end
                if(axis == 5)  ZG.zygoAxisOffsetAddr(5)  = hex2dec('00'); end
                if(axis == 6)  ZG.zygoAxisOffsetAddr(6)  = hex2dec('20'); end
                if(axis == 7)  ZG.zygoAxisOffsetAddr(7)  = hex2dec('00'); end
                if(axis == 8)  ZG.zygoAxisOffsetAddr(8)  = hex2dec('20'); end
                if(axis == 9)  ZG.zygoAxisOffsetAddr(9)  = hex2dec('00'); end
                if(axis == 10) ZG.zygoAxisOffsetAddr(10) = hex2dec('20'); end
                if(axis == 11) ZG.zygoAxisOffsetAddr(11) = hex2dec('00'); end
                if(axis == 12) ZG.zygoAxisOffsetAddr(12) = hex2dec('20');end
                
                if(axis == 1)  ZG.vmeInterruptLevel(1)  = 1; end
                if(axis == 2)  ZG.vmeInterruptLevel(2)  = 1; end
                if(axis == 3)  ZG.vmeInterruptLevel(3)  = 2; end
                if(axis == 4)  ZG.vmeInterruptLevel(4)  = 2; end
                if(axis == 5)  ZG.vmeInterruptLevel(5)  = 3; end
                if(axis == 6)  ZG.vmeInterruptLevel(6)  = 3; end
                if(axis == 7)  ZG.vmeInterruptLevel(7)  = 4; end
                if(axis == 8)  ZG.vmeInterruptLevel(8)  = 4; end
                if(axis == 9)  ZG.vmeInterruptLevel(9)  = 5; end
                if(axis == 10) ZG.vmeInterruptLevel(10) = 5; end
                if(axis == 11) ZG.vmeInterruptLevel(11) = 6; end
                if(axis == 12) ZG.vmeInterruptLevel(12) = 6; end
                
            end
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end
    function  zygo_fnc_out= ZygoOffline()
        try
            fclose(VMEDevice);
            delete(VMEDevice);
            clear VMEDevice;
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out= ZygoEepromReadData()
        try
            axis =ZG.axisNumber;
            % get VME device number
            ZG.vmeDeviceNumber =ZG.zygoAxisDeviceNumber(axis);
            % set up to read EEPROM by writing to EEPROM control register
            ZG.vmeBusOffsetAddr = VME_EEPROM_CONTROL_REG;
            ZG.vmeBusDataU16	  = hex2dec('0080') + (bitand(ZG.eepromDataAddr , hex2dec('003F')));
            if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            % wait for EEPROM busy to go low by reading from status register
            ZG.vmeBusOffsetAddr = VME_STATUS_REG;
            loopCount = 0;
            statusInt = hex2dec('0080');
            while(bitand(statusInt , hex2dec('0080')))
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                statusInt =ZG.vmeBusDataU16;
                if( loopCount >=  ZYGO_LOOP_CTRL_COUNT_MAX )
                    printmsg('Error: Zygo reads EEPROM failed!');
                    zygo_fnc_out=ZYGO_ERROR; return;
                end
                loopCount=loopCount+1;
                pause(0.002);	% 2 ms delay
            end
            
            % read from the interrupt vector register and put the data into reg6Int
            ZG.vmeBusOffsetAddr = VME_INTERRUPT_VECTOR_REG;
            if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            reg6Int =ZG.vmeBusDataU16;
            
            % write to set up M5 in the interrupt vector register
            ZG.vmeBusDataU16 = bitand( reg6Int , hex2dec('F8FF') ) + hex2dec('0500');
            if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            
            % read from the EEPROM data read register
            ZG.vmeBusOffsetAddr = VME_EEPROM_DATA_READ_REG_M5;
            if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            ZG.eepromDataU16 =ZG.vmeBusDataU16;
            
            % restore the interrupt vector register with reg6Int
            ZG.vmeBusOffsetAddr = VME_INTERRUPT_VECTOR_REG;
            ZG.vmeBusDataU16  = reg6Int;
            if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            
            zygo_fnc_out= ZYGO_OK;
            
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end



    function zygo_fnc_out= ZygoGetDataAge()
        try
            % get calibration data from the on-board EEPROM
            for(axis = 1:ZG.numberOfAxes)
                % get axis number
                ZG.axisNumber = axis;
                
                if(ZG.zygoAxisOffsetAddr(axis) == hex2dec('20'))
                    % board axis two
                    ZG.eepromDataAddr = hex2dec('10');
                    if(ZygoEepromReadData() ~= ZYGO_OK);zygo_fnc_out=ZYGO_ERROR; return;end
                    ZG.delayReference(axis)   =bitand( ZG.eepromDataU16 , hex2dec('003F'));	% ref delay
                    ZG.eepromDataAddr = hex2dec('11');
                    if(ZygoEepromReadData() ~= ZYGO_OK);zygo_fnc_out=ZYGO_ERROR; return;end
                    ZG.delayMeasurement(axis) = int32(ZG.eepromDataU16 / 256);	    % mea delay
                    
                else
                    % board axis one
                    ZG.eepromDataAddr = hex2dec('06');
                    if(ZygoEepromReadData() ~= ZYGO_OK);zygo_fnc_out=ZYGO_ERROR; return;end
                    ZG.delayReference(axis)  = bitand(ZG.eepromDataU16 , hex2dec('003F'));	% ref delay
                    ZG.eepromDataAddr = hex2dec('07');
                    if(ZygoEepromReadData() ~= ZYGO_OK);zygo_fnc_out=ZYGO_ERROR; return;end
                    ZG.delayMeasurement(axis) = int32(ZG.eepromDataU16 / 256);	    % mea delay
                end
                
                % calculate data age adjustments
                % board #1
                if(axis ==  1); ZG.dataAge (1) = int32(ZG.delayMeasurement (1));end
                if(axis ==  2); ZG.dataAge (2) = int32(ZG.delayMeasurement (2));end
                % board #2
                if(axis ==  3); ZG.dataAge (3) = int32(ZG.delayMeasurement (3) - ZG.delayReference(3));end
                if(axis ==  4); ZG.dataAge (4) = int32(ZG.delayMeasurement (4) - ZG.delayReference(3));end
                % board #3
                if(axis ==  5); ZG.dataAge (5) = int32(ZG.delayMeasurement (5) - ZG.delayReference(3) - ZG.delayReference(5));end
                if(axis ==  6); ZG.dataAge (6) = int32(ZG.delayMeasurement (6) - ZG.delayReference(3) - ZG.delayReference(5));end
                % board #4
                if(axis ==  7); ZG.dataAge (7) = int32(ZG.delayMeasurement (7) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7));end
                if(axis ==  8); ZG.dataAge (8) = int32(ZG.delayMeasurement (8) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7));end
                % board #5
                if(axis ==  9); ZG.dataAge (9) = int32(ZG.delayMeasurement (9) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7) - ZG.delayReference(9));end
                if(axis == 10); ZG.dataAge(10) = int32(ZG.delayMeasurement(10) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7) - ZG.delayReference(9));end
                % board #6
                if(axis == 11); ZG.dataAge(11) = int32(ZG.delayMeasurement(11) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7) - ZG.delayReference(9) - ZG.delayReference(11));end
                if(axis == 12); ZG.dataAge(12) = int32(ZG.delayMeasurement(12) - ZG.delayReference(3) - ZG.delayReference(5) - ZG.delayReference(7) - ZG.delayReference(9) - ZG.delayReference(11));end
            end
            
            % find max and min of adjustments
            minAdjust =  9999;
            maxAdjust = -9999;
            for(axis = 1: ZG.numberOfAxes)
                % find max
                if(ZG.dataAge(axis) > maxAdjust); maxAdjust = ZG.dataAge(axis);end
                % find min
                if(ZG.dataAge(axis) < minAdjust); minAdjust = ZG.dataAge(axis);end
            end
            
            % offset adjustments so range is near zero
            % find middle
            ZG.dataAgeAdjust = int32((maxAdjust + minAdjust) / 2);
            disp(['data age adjeust' num2str(ZG.dataAgeAdjust )])
            % get data adjustments with offset
            for(axis = 1: ZG.numberOfAxes)
                ZG.dataAge(axis) = bitand(int16(ZG.dataAgeAdjust - ZG.dataAge(axis)) , hex2dec('01FF'));
            end
            zygo_fnc_out= ZYGO_OK;
            
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end


    function zygo_fnc_out= ZygoRegisterInitialiseAxisReset()
        try
            
            % initialise all axis registers
            for(axis = 1:ZG.numberOfAxes)
                % get VME device number
                ZG.vmeDeviceNumber = ZG.zygoAxisDeviceNumber(axis);
                
                % disable VME interrupts
                ZG.vmeBusOffsetAddr = VME_INTERRUPT_ENABLE_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16	  = hex2dec('0080');
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % interrupt vector
                ZG.vmeBusOffsetAddr = VME_INTERRUPT_VECTOR_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = hex2dec('1000') * ZG.vmeInterruptLevel(axis) + axis;
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % control register 1, set P2 SCK0 output enable on all axis except the last one,  set clock disable on before last axis (numberOfAxes-1) axis only
                ZG.vmeBusOffsetAddr = VME_CONTROL_01_REG + ZG.zygoAxisOffsetAddr(axis);
                % the code commented below is for VME setting 
                %#############################################
%                 if( axis == (ZG.numberOfAxes-1) )
%                     ZG.vmeBusDataU16 = hex2dec('0C00') + hex2dec('0078');
%                 else
%                     ZG.vmeBusDataU16 = hex2dec('0400') + hex2dec('0078');   % Disable the P2 SCLK0 sample clock
%                 end
                
                % Ammar change the code here for P2 interface 
                %##############################################
                if( axis == (ZG.numberOfAxes-1) )
                    ZG.vmeBusDataU16 = hex2dec('0E00');
                else
                    ZG.vmeBusDataU16 = hex2dec('0600');   % Disable the P2 SCLK0 sample clock
                end
%                 
%                  if( axis == (ZG.numberOfAxes-1) )
%                     ZG.vmeBusDataU16 = hex2dec('0978');
%                 else
%                     ZG.vmeBusDataU16 = hex2dec('0578');   % Disable the P2 SCLK0 sample clock
%                 end
                %#############################################
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % control register 2, position direction sense, Kp, and Kv
                ZG.posDirectionSense(axis) = 1;
                ZG.filterKP(axis) = 4;
                ZG.filterKV(axis) = 4;
                ZG.vmeBusOffsetAddr = VME_CONTROL_02_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = hex2dec('0400') + hex2dec('4000') * ZG.posDirectionSense(axis) + (ZG.filterKP(axis) * 16) +  ZG.filterKV(axis);
                
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % position high nibble
                ZG.vmeBusOffsetAddr = VME_HIGH_NIBBLES_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = 0;
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % offset (32 bits write)
                ZG.vmeBusOffsetAddr = VME_OFFSET_MSB_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU32    = 0;
                if(RegisterWrite32BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % data age adjust
                ZG.vmeBusOffsetAddr = VME_DATA_AGE_ADJUST_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = ZG.dataAge(axis);
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % disable P2 interrupt
                ZG.vmeBusOffsetAddr = VME_P2_INTERRUPT_MASK_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = 0;
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
            end
            
            % sample timer, rounded, write to base (first) channel of a measurement board
            ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber( ZG.numberOfAxes );
            ZG.vmeBusOffsetAddr = VME_SAMPLE_TIMER_REG + ZG.zygoAxisOffsetAddr( ZG.numberOfAxes );
            % period (sec)      = (n + 1) * 50 nsec  for 1 <= n <= 65535
            % sampleTimeCount,n = (unsigned int)(ZG.samplePeriod / 0.000000050 - 1.0  + 0.5);
            ZG.vmeBusDataU16   = cast((ZG.samplePeriod / 0.000000050 - 0.5), 'uint16');
            if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            
            % "axis reset" for all axes
            for(axis = 1:ZG.numberOfAxes)
                
                ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_COMMAND_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = hex2dec('0001');	% axis reset
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            end
            
            % wait for last reset complete
            ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber( ZG.numberOfAxes );
            ZG.vmeBusOffsetAddr = VME_STATUS_REG + ZG.zygoAxisOffsetAddr( ZG.numberOfAxes );
            loopCount = 0;
            statusUInt = hex2dec('0000');
            while(bitand(statusUInt , hex2dec('0010'))==0)
                
                % get position reset complete status
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                statusUInt =bitand( ZG.vmeBusDataU16 , hex2dec('0010'));
                if( loopCount >=  ZYGO_LOOP_CTRL_COUNT_MAX )
                    
                    % ZG.systemErrorCode = 51;
                    % strcpy(ZG.systemMessage,"Zygo cannot reset the last measurement board.");
                    printmsg('Error: Zygo cannot reset the last measurement board!');
                    zygo_fnc_out=ZYGO_ERROR; return
                end
                loopCount=loopCount+1;
                pause(0.002);
            end
            
            % enable VME interrupts, used only for errors
            for(axis = 1: ZG.numberOfAxes)
                ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_INTERRUPT_ENABLE_REG + ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = hex2dec('07FF');	% axis reset
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            end
            
            % initialise variables
            for(axis = 1:ZYGO_MAX_AXES)
                ZG.timeInt(axis)=0;
                ZG.timeIntPrev			(axis) = 0;
                ZG.timeIndex   			(axis) = 0;
                ZG.timeFirstInt			(axis) = 0;
                ZG.selectedAxes			(axis) = 0;
                ZG.selectedFreq			(axis) = 1;
                ZG.flagMeasurementNoSignal(axis) = 1;
                ZG.flagReferenceNoSignal 	(axis) = 1;
                ZG.flagMeasurementError  	(axis) = 1;
                ZG.flagReferenceError	  	(axis) = 1;
                ZG.flagOverFlowError	 	(axis) = 1;
                ZG.flagVelocityError	  	(axis) = 1;
            end
            
            % default values for environmental variables
%             ZG.temperatureDegC 		 		 = ZYGO_DEFAULT_TEMPERATURE;
%             ZG.pressureMmHg					 = ZYGO_DEFAULT_PRESSURE;
%             ZG.relativeHumidityPercent		 = ZYGO_DEFAULT_RELATIVE_HUMIDITY;
            ZG.retrospacingCompact2AxesHSPMIMm = ZYGO_RETROSPACING_COMPACT_2_AXES_HSPMI;
            ZG.wavelengthCompensatorLengthMm	 = ZYGO_WAVELENGTH_COMPENSATOR_LENGTH;
            
            % calculate conversion factors
            ZygoCalculateConversionFactors();
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out= ZygoAxisReset()
        try
            % "axis reset" for all axes
            for(axis = 1: axis <=ZG.numberOfAxes)
                ZG.vmeDeviceNumber  =ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_COMMAND_REG +ZG.zygoAxisOffsetAddr(axis);
                ZG.vmeBusDataU16    = hex2dec('0001');	% axis reset
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            end
            
            % wait for last reset complete
            ZG.vmeDeviceNumber  =ZG.zygoAxisDeviceNumber(ZG.numberOfAxes );
            ZG.vmeBusOffsetAddr = VME_STATUS_REG +ZG.zygoAxisOffsetAddr(ZG.numberOfAxes );
            loopCount = 0;
            statusUInt = hex2dec('0000');
            while(bitand(statusUInt , hex2dec('0010'))==0)
                % get position reset complete status
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                statusUInt =bitand(ZG.vmeBusDataU16 , hex2dec('0010'));
                if( loopCount >=  ZYGO_LOOP_CTRL_COUNT_MAX )
                    printmsg('Error: Zygo cannot reset the last measurement board');
                    zygo_fnc_out=ZYGO_ERROR; return;
                end
                loopCount=loopCount+1;
                pause(0.002);	% 2 ms delay
            end
            % reset time variables
            for(axis = 1: axis <=ZG.numberOfAxes)
                ZG.timeInt	 (axis) = 0;
                ZG.timeIntPrev (axis) = 0;
                ZG.timeIndex   (axis) = 0;
                ZG.timeFirstInt(axis) = 0;
            end
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=  ZygoUpdateControlRegisterTwo()
        try
            
            % control register 2 of all axes
            for(axis = 1: axis <= ZG.numberOfAxes)
                
                ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_CONTROL_02_REG + ZG.zygoAxisOffsetAddr(axis);
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                
                % mask out position direction sense, Kp, and Kv from the register data
                regUInt = bitand(ZG.vmeBusDataU16 , hex2dec('BF00'));  % 1011 1111 0000 0000
                
                % limit position direction sense to 1 bit, and limit Kp and Kv to only 3 bits for each of their values
                ZG.posDirectionSense(axis) = bitand(ZG.posDirectionSense(axis) , hex2dec('0001'));
                ZG.filterKP(axis) = bitand(ZG.filterKP(axis) , hex2dec('0007'));
                ZG.filterKV(axis) = bitand(ZG.filterKV(axis) , hex2dec('0007'));
                
                % combine Kp and Kv in the register data
                ZG.vmeBusDataU16 = regUInt + hex2dec('4000') * ZG.posDirectionSense(axis) + (ZG.filterKP(axis) * 16) +  ZG.filterKV(axis);
                
                if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            end
            
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=ZygoReadSampledPositionVelocityTime(axis)
        try
            % sampled position, 32 bits read
            ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber(axis);
            %             ZG.vmeBusOffsetAddr = VME_SAMPLED_POSITION_MSB_REG + ZG.zygoAxisOffsetAddr(axis);
            ZG.vmeBusOffsetAddr = VME_POSITION_MSB_REG + ZG.zygoAxisOffsetAddr(axis);
            
            
            
            if (RegisterRead32BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            ZG.positionInt(axis) = (ZG.vmeBusDataU32);
            
            % velocity, 32 bits raed
            ZG.vmeBusOffsetAddr = VME_VELOCITY_MSB_REG + ZG.zygoAxisOffsetAddr(axis);
            if(RegisterRead32BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            % ZG.velocity(axis) = (double)ZG.vmeBusData * ZYGO_POSITION_COUNT_TO_NANOMETRE;
            ZG.velocityInt(axis) = (ZG.vmeBusDataU32);
            
            % time, 32 bits read
            ZG.vmeBusOffsetAddr = VME_TIME_MSB_REG + ZG.zygoAxisOffsetAddr(axis);
            if(RegisterRead32BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            % ZG.time(axis) = (double)ZG.vmeBusData * ZYGO_TIME_COUNT_TO_SECOND; % 1 count = 25 nsec
            ZG.timeInt(axis) = (ZG.vmeBusDataU32);
            zygo_fnc_out= ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=ZygoForceExternalSample()
        try
            
            % get the base (first axis) address of the last measurement board
            axis =ZG.numberOfAxes-1;
            % write to command register to make a force external sample
            ZG.vmeDeviceNumber  =ZG.zygoAxisDeviceNumber(axis);
            ZG.vmeBusOffsetAddr = VME_COMMAND_REG +ZG.zygoAxisOffsetAddr(axis);
            ZG.vmeBusDataU16    =hex2dec('0100');	% force external sample
            if(RegisterWrite16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
            
            % wait for the external sample flag
            
            ZG.vmeBusOffsetAddr = VME_STATUS_REG +ZG.zygoAxisOffsetAddr(axis);
            statusUInt = hex2dec('0000');
            loopCount=0;
            while (bitand(statusUInt , hex2dec('0100'))==0)
                % get the status of external sample flag
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                statusUInt =bitand( ZG.vmeBusDataU16 , hex2dec('0100'));
                if( loopCount >=  ZYGO_LOOP_CTRL_COUNT_MAX )
                    % ZG.systemErrorCode = 51;
                    % strcpy(ZG.systemMessage,"Zygo cannot reset the last measurement board.");
                    printmsg('Error: Zygo cannot reset the last measurement board!');
                    zygo_fnc_out=ZYGO_ERROR; return
                end
                %                 pause(0.002);
                loopCount=loopCount+1;
            end
            
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=ZygoReadErrorStatusRegister()
        try
            for(axis = 1: ZG.numberOfAxes)
                % read error status register
                ZG.vmeDeviceNumber  =ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_ERROR_STATUS_REG +ZG.zygoAxisOffsetAddr(axis);
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                ZG.errorStatusReg(axis) =ZG.vmeBusDataU16;
                
                % set flags
                % measurement error: measurement signal missing, measurement signal dropout, or measurement signal glitch
                ZG.flagMeasurementError(axis) = 0;
                if(bitand(ZG.errorStatusReg(axis) , hex2dec('0008')) || bitand(ZG.errorStatusReg(axis) , hex2dec('0010')) || bitand(ZG.errorStatusReg(axis), hex2dec('0020')))
                    ZG.flagMeasurementError(axis) = 1;
                end
                
                % reference error: reference signal missing, or reference PLL error
                ZG.flagReferenceError(axis) = 0;
                if(bitand(ZG.errorStatusReg(axis) , hex2dec('0001')) || bitand(ZG.errorStatusReg(axis) , hex2dec('0002')))
                    ZG.flagReferenceError(axis) = 1;
                end
                
                % over flow error: 32-bit or 36-bit position overflow error
                ZG.flagOverFlowError(axis) = 0;
                if(bitand(ZG.errorStatusReg(axis) , hex2dec('0400')) || bitand(ZG.errorStatusReg(axis) , hex2dec('0200')))
                    ZG.flagOverFlowError(axis) = 1;
                end
                
                % velocity error: velocity error, user velocity error, or acceleration error
                ZG.flagVelocityError(axis) = 0;
                if(bitand(ZG.errorStatusReg(axis) , hex2dec('0040')) || bitand(ZG.errorStatusReg(axis) , hex2dec('0080')) || bitand(ZG.errorStatusReg(axis) , hex2dec('0100')))
                    ZG.flagVelocityError(axis) = 1;
                end
            end
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=ZygoReadStatusRegister()
        try
            for(axis = 1: ZG.numberOfAxes)
                % read status register
                ZG.vmeDeviceNumber  =ZG.zygoAxisDeviceNumber(axis);
                ZG.vmeBusOffsetAddr = VME_STATUS_REG +ZG.zygoAxisOffsetAddr(axis);
                if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
                ZG.statusRegister(axis) =ZG.vmeBusDataU16;
                % set flags
                % measurement signal from interferometer present (no signal = 1)
                ZG.flagMeasurementNoSignal(axis) = 1;
                if(bitand(ZG.statusRegister(axis) , hex2dec('0008')))
                    ZG.flagMeasurementNoSignal(axis) = 0;
                end
                
                % reference signal from laser head present (no signal = 1)
                ZG.flagReferenceNoSignal(axis) = 1;
                if(bitand(ZG.statusRegister(axis) , hex2dec('0001')))
                    ZG.flagReferenceNoSignal(axis) = 0;
                end
            end
            zygo_fnc_out=ZYGO_OK;
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end

    function zygo_fnc_out=ZygoCalculateConversionFactors()
        try
            
            % change of variables
            temp =ZG.temperatureDegC;
            pres =ZG.pressureMmHg;
            humi =ZG.relativeHumidityPercent;
            
            % water vapor pressure of saturated air
            pressureSatAir = 4.07859739 + 0.44301857 * temp + 0.00232093 * temp^2 + 0.00045785 * temp^3;
            
            % partial pressure of the water vapor in the air (mm Hg)
            partialPressure = ( humi * pressureSatAir ) / 100.00;
            
            % initial value of the refractive index is calculated by using Edlen's general formula
            ZG.initialRefractiveIndex = 1 + 3.83639 * 10^-7 * pres * ( 1 + pres * ( 0.817 - 0.0133 * temp ) * 10^-6 ) / ( 1 + 0.003661 * temp ) - 5.607943 *  10^-8 * partialPressure;
            
            % refractive index of air (relative)
            %ZG.localRefractiveIndex =ZG.initialRefractiveIndex; % +/- N * lambda_vac / ( 2048 * L)
            
            % determine wavelength in air
            ZG.initialLambda_F1 = ZYGO_LAMBDA_F1_VACUUM_VERTICAL   /ZG.initialRefractiveIndex;
            ZG.initialLambda_F2 = ZYGO_LAMBDA_F2_VACUUM_HORIZONTAL /ZG.initialRefractiveIndex;
            
            % psotion conversion factors: count to nano-metre
            ZG.positionF1Count2Nm =ZG.initialLambda_F1 / 2048;  % for two-pass interferometer
            ZG.positionF2Count2Nm =ZG.initialLambda_F2 / 2048;  % for two-pass interferometer
            
            % velocity conversion factors: count to nano-metre / sec
            ZG.velocityF1Count2NmPerSec = 40 * 10^6 *ZG.initialLambda_F1 / 2^34;
            ZG.velocityF2Count2NmPerSec = 40 * 10^6 *ZG.initialLambda_F2 / 2^34;
            
            % for compact 2-axis high stability plane mirror interferometer
            % tangent angle conversion factors: count to radians
            % note: angle = arctangent( N * conversion factor) = atan( N * conversion factor)  (rad)
            ZG.angleF1Count2TanQ =ZG.initialLambda_F1 / ( 2048 *ZG.retrospacingCompact2AxesHSPMIMm * 10^6 );
            ZG.angleF2Count2TanQ =ZG.initialLambda_F2 / ( 2048 *ZG.retrospacingCompact2AxesHSPMIMm * 10^6 );
            
            % for compact 2-axis high stability plane mirror interferometer
            % angular velocity
            ZG.angVelF1Count2TanQPerSec = 40 * 10^6 *ZG.initialLambda_F1 / ( 2^34 * ZG.retrospacingCompact2AxesHSPMIMm * 10^6 );
            
            ZG.angVelF2Count2TanQPerSec = 40 * 10^6 *ZG.initialLambda_F2 / (2^34* ZG.retrospacingCompact2AxesHSPMIMm * 10^6 );
        catch ME
            printmsg(ME.message)
            zygo_fnc_out=ZYGO_ERROR;
        end
    end
%% Zygo system functions
    function zygo_fnc_out= Initialise_system()
        
        
        checkFunctionCall = ZygoInitialize();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error Zygo Measurment System cannot be initialised!!!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        
        
        checkFunctionCall = ZygoGetDataAge();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to get Zygos Data Age!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        
        checkFunctionCall = ZygoRegisterInitialiseAxisReset();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to reset Zygos Axes!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        ZygoForceExternalSample()
        
        % initialise error flags
        % read error status register and status register
        checkFunctionCall = ZygoReadErrorStatusRegister();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to read Zygos Error Status Register!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        
        checkFunctionCall = ZygoReadStatusRegister();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to read Zygos Status Register!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        % testing of EEPROM read
        ZG.axisNumber = 1;
        ZG.eepromDataAddr = hex2dec('01');
        checkFunctionCall = ZygoEepromReadData();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to read Zygos EEPROM!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        
        printmsg('Zygo ZMI 2400 Laser Measurement System is initialised');
    end

    function  zygo_fnc_out= Quit_system()
        checkFunctionCall = 	ZygoOffline();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to Quit!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        printmsg ('System Quit successfully');
    end

    function  zygo_fnc_out=  AxisReset_system()
        checkFunctionCall = ZygoAxisReset();
        if(checkFunctionCall ~= ZYGO_OK)
            printmsg ('Error System fails to reset Zygos Axes!');
            zygo_fnc_out=ZYGO_ERROR;return
        end
        printmsg (' Axis Reset successfully');
        
    end

    function  zygo_fnc_out=  EnvDefault_system()
        %default values for environmental variables
        ZG.temperatureDegC 		 		 = ZYGO_DEFAULT_TEMPERATURE;
        ZG.pressureMmHg					 = ZYGO_DEFAULT_PRESSURE;
        ZG.relativeHumidityPercent		 = ZYGO_DEFAULT_RELATIVE_HUMIDITY;
        ZG.retrospacingCompact2AxesHSPMIMm = ZYGO_RETROSPACING_COMPACT_2_AXES_HSPMI;
        ZG.wavelengthCompensatorLengthMm	 = ZYGO_WAVELENGTH_COMPENSATOR_LENGTH;
        %calculate conversion factors
        ZygoCalculateConversionFactors();
        zygo_fnc_out=ZYGO_OK;
    end
    function zygo_fnc_out= ZygoReadVmeRegister()
        axis = ZG.axisNumber;
        %read a vme register or a offset location
        ZG.vmeDeviceNumber  = ZG.zygoAxisDeviceNumber(axis);
        ZG.vmeBusOffsetAddr =ZG.vmeBusRegisterAddr + ZG.zygoAxisOffsetAddr(axis);
        if(RegisterRead16BitData() ~= ZYGO_OK); zygo_fnc_out=ZYGO_ERROR; return;end
        ZG.vmeBusRegisterDataU16 = ZG.vmeBusDataU16;
        zygo_fnc_out= ZYGO_OK;
    end

    function zygo_fnc_out= Print_status()
        printmsg('=============================')
        printmsg(['Data Age Adjust=' num2str(ZG.dataAgeAdjust)])
        
        for(axis = 1: ZG.numberOfAxes)
            printmsg(['Axis ( ', num2str(axis),' )'])
            printmsg('=============================')
            if (ZG.flagMeasurementError(axis) == 1)
                printmsg('Measurement Error')
            else
                printmsg('Measurement OK')
            end
            
            if (ZG.flagReferenceError(axis) == 1)
                printmsg('Reference Error')
            else
                printmsg('Reference OK')
            end
            
            if (ZG.flagOverFlowError(axis)==1)
                
                printmsg('flag OverFlow Error')
            else
                printmsg('flag OverFlow OK')
            end
            
            if (ZG.flagVelocityError(axis)==1)
                
                printmsg('Velocity Error')
            else
                printmsg('Velocity OK')
            end
            if (ZG.flagMeasurementNoSignal(axis)==1)
                
                printmsg('Measurement No Signal Error')
            else
                printmsg('Measurement No Signal OK')
            end
            if (ZG.flagReferenceNoSignal(axis)==1)
                
                printmsg('Reference No Signal Error')
            else
                printmsg('Reference No Signal OK')
            end
            
            printmsg(['data age =' num2str(ZG.dataAge(axis))])
            
            ZG.axisNumber=axis;
            ZG.vmeBusRegisterAddr=VME_CONTROL_01_REG;
            ZygoReadVmeRegister();
            printmsg(['control reg1=' num2str(dec2bin(ZG.vmeBusRegisterDataU16))])
            
            ZG.vmeBusRegisterAddr=VME_CONTROL_02_REG;
            ZygoReadVmeRegister();
            printmsg(['control reg2=' num2str(dec2bin(ZG.vmeBusRegisterDataU16))])
            
            printmsg(['STATUS reg=' num2str(dec2bin(ZG.statusRegister(axis)))])
            
            printmsg(['ERROR_STATUS_REG=' num2str(dec2bin( ZG.errorStatusReg(axis)))])
            printmsg('=============================')
        end
        zygo_fnc_out= ZYGO_OK;
    end

    function zygo_fnc_out= check_status(axis)
        
        if (ZG.flagMeasurementError(axis) == 1) zygo_fnc_out= ZYGO_ERROR;return;end
        if (ZG.flagReferenceError(axis) == 1) zygo_fnc_out= ZYGO_ERROR;return;end
        if (ZG.flagOverFlowError(axis)==1) zygo_fnc_out= ZYGO_ERROR;return;end
        if (ZG.flagVelocityError(axis)==1) zygo_fnc_out= ZYGO_ERROR;return;end
        if (ZG.flagMeasurementNoSignal(axis)==1) zygo_fnc_out= ZYGO_ERROR;return;end
        if (ZG.flagReferenceNoSignal(axis)==1) zygo_fnc_out= ZYGO_ERROR;return;end
        zygo_fnc_out= ZYGO_OK;
    end

    function printmsg(msg)
        mytxt=get(handles.lst_sysmsg,'string');
        mytxt{numel(mytxt)+1}=msg;
        set(handles.lst_sysmsg,'string',mytxt);
        set(handles.lst_sysmsg,'Value',numel(mytxt));
        %         set(S.ls,'string',E)  % Now set the listbox string to the value in E.
        drawnow;
    end

end
