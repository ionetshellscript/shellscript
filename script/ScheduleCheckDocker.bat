@echo off
cd /d "%~dp0
:loop
echo Run task and back here for %time%

timeout /t 300
./CheckAndRestartDockerContainers.bat
goto loop