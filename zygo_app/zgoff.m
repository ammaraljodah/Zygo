clc
if ~isempty(timerfind)
stop(timerfind)
delete(timerfind)
end
a=instrfind;
if (isempty(a)==0)
    fclose(a);
    pause(1)
    delete(a);
    pause(1)
    clear a;
    pause(1)
end
disp('Zygo software communications are turned off successfully')