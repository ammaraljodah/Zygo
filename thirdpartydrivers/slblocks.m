function blkStruct = slblocks

%SLBLOCKS Defines the Simulink library block representation
%   for Simulink Real-Time third party add on libraries.

%   Copyright 2006-2014 The MathWorks, Inc.

  blkStruct(1).Name = '';
  blkStruct(1).OpenFcn = '';
  blkStruct(1).MaskInitialization = '';

  basedir = fileparts(which('mxpcinterrupt'));
  searchdirs = {fullfile(basedir, 'thirdpartydrivers\*xpcblocks.m'),  ...
      fullfile(basedir, 'thirdpartydrivers\*xpcblocks.p'), ...
      fullfile(basedir, 'thirdpartydrivers\*xpcblocks.mlx')};
  
  sgbase = fileparts( which( 'speedgoat_supported' ) );
  if ~strcmp( sgbase, [basedir, '\thirdpartydrivers'] )  % if SG not in thirdpartydrivers
      sgdirs = {fullfile( sgbase, '*xpcblocks.m'),  ...
                fullfile( sgbase, '*xpcblocks.p'), ...
                fullfile( sgbase, '*xpcblocks.mlx')};
      list = [dir( searchdirs{1} ), dir( searchdirs{2} ), dir( searchdirs{3} ), ...
              dir( sgdirs{1} ), dir( sgdirs{2} ), dir( sgdirs{3} ) ];
  else
      list = [dir( searchdirs{1} ), dir( searchdirs{2} ), dir( searchdirs{3} )];
  end
  if length(list) >= 1 
    for idx = 1:length(list)
      [~, file, ~] = fileparts( list(idx).name );
      try
        Browser(idx) = feval( file ); %#ok<*AGROW>
        % add an Simulink Real-Time specific decoration to position this
        % in the list when alphabatized.
        if ~strcmp( Browser(idx).Library, '' )
          Browser(idx).Name = ['Simulink Real-Time: ', Browser(idx).Name];
          blkStruct(idx).Name = Browser(idx).Name;
          blkStruct(idx).OpenFcn = Browser(idx).Library;
          blkStruct(idx).MaskInitialization = '';
        end
      catch ME
        msg = sprintf( 'Simulink Real-Time: Error ''%s'' while adding third party library from %s', ME.message, file );
        disp( msg );
        disp( 'If the function wasn''t found, did you remember to ''rehash toolbox''?');
      end
    end
  else
    Browser(1).Library = '';
    Browser(1).Name    = '';
    Browser(1).IsFlat  = 0;
  end

  % the scanner for 'simulink' uses Browser(N) in the first element
  % of blkStruct.
  % The scanner for 'simulink3' uses blkStruct(N)
  blkStruct(1).Browser = Browser;
