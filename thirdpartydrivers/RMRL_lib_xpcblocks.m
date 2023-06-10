function out = RMRL_MONASH_lib_xpcblocks
% <name>_xpcblocks Returns a structure that describes an entry
% to be added to the Simulink browser.
%
%   Each instance of this file returns one library to be added to
%   the browser.  You can have multiple instances of this file, each
%   with its own name, ending in xpcblocks.m.
%
%   Copy this file under a new name, <yourname>xpcblocks.m
%   and fill in the library name in Library and the descriptive
%   text that the Simulink browser will display in Name.
%   For example, if your library is named 'mylib.mdl'
%   you would need:
%
%   out.Library = 'mylib';
%   out.Name    = 'My Super IO Library';
%   out.IsFlat  = 0;
%
%   in a copy of this file that might be named myxpcblocks.m.
%   To avoid collisions between different providers of custom
%   libraries, please select a name that is unique, such as
%   your company name or library name.
%
%   You will need to execute a 'rehash toolbox' after
%   adding your new file to the thirdparty directory
%   before it will be found.
%
%   The routine that calls this function adds the string
%   'Simulink Real-Time: ' to Name so that the Simulink browser
%   will show 'Simulink Real-Time: My Super IO Library' under the
%   standard Simulink Real-Time entry in the browser.
%
%   If both Library and Name are empty strings, then nothing
%   gets displayed for this entry in the Simulink browser.
  
% Copyright 2006 The MathWorks, Inc.

  out.Library = 'RMRL_lib';
  out.Name    = 'RMRL_Lib Blockset';
  out.IsFlat  = 0;
  