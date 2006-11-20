rem This contains all of the common variables used in all batch files
set STARTDIR=%CD%

echo off
cls

rem Default wxWidgets root directory
set WXVER=2.7.2

echo What version of wxWidgets are you building (Default = %WXVER%)?
set /P WXVER=
set DEVPAKDIR=devpaks_%WXVER%

set WXWIN=c:\wxMSW-%WXVER%

echo In what directory is wxWidgets located (Default = %WXWIN%)?
set /P WXWIN=

set WXCODE=\wxCode
echo In what directory are the wxCode components located (Default = %WXCODE%)?
set /P WXCODE=

rem This is a work around for getting colons to work for gsar
rem gsar doesn't like the colon in the directory name (e.g. c:\)
rem so we'll write it to a file, then use gsar to turn the single
rem colons into double colons. This is saved to the variable
rem %whatever%_GSAR
echo set WXWIN_GSAR=%WXWIN%> temp123.bat
gsar -s:: -r:::: -o temp123.bat
call temp123.bat
del temp123.bat

echo set DEVPAKDIR_GSAR=%DEVPAKDIR%> temp123.bat
gsar -s:: -r:::: -o temp123.bat
call temp123.bat
del temp123.bat

rem The path needs to point to where your mingw32-make executable lives
path=c:\Progra~1\Dev-Cpp\bin;%path%

echo on
