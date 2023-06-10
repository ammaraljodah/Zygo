function out=count2Nm(temp,pres,humi)
ZYGO_LAMBDA_F1_VACUUM_VERTICAL      =	632.991501; 	% nm 
ZYGO_LAMBDA_F2_VACUUM_HORIZONTAL	=	632.991528; 	% nm	
		
% ZYGO_DEFAULT_TEMPERATURE        =	20		% Deg C
% ZYGO_DEFAULT_PRESSURE           =	760		% mm Hg
% ZYGO_DEFAULT_RELATIVE_HUMIDITY  =	50		% %
% 		
	% water vapor pressure of saturated air
	pressureSatAir = 4.07859739 + 0.44301857 * temp + 0.00232093 * temp^2 + 0.00045785 * temp^3;
		
	% partial pressure of the water vapor in the air (mm Hg)
	partialPressure = ( humi * pressureSatAir ) / 100.00;
	
	% initial value of the refractive index is calculated by using Edlen's general formula
	initialRefractiveIndex = 1 + 3.83639 * 10e-7 * pres * ( 1 + pres * ( 0.817 - 0.0133 * temp ) * 10e-6 ) / ( 1 + 0.003661 * temp ) - 5.607943 * 10e-8 * partialPressure;

	% refractive index of air (relative)
	% pZg->localRefractiveIndex = pZg->initialRefractiveIndex; % +/- N * lambda_vac / ( 2048 * L)
	
	% determine wavelength in air
	initialLambda_F1 = ZYGO_LAMBDA_F1_VACUUM_VERTICAL   / initialRefractiveIndex; 
	initialLambda_F2 = ZYGO_LAMBDA_F2_VACUUM_HORIZONTAL / initialRefractiveIndex;  
	
	% psotion conversion factors: count to nano-metre
	positionF1Count2Nm = initialLambda_F1 / 2048;  % for two-pass interferometer
	positionF2Count2Nm = initialLambda_F2 / 2048;  % for two-pass interferometer   
    
   out=positionF1Count2Nm;
end