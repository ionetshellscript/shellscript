@echo off
cd /d "%~dp0

:loop
echo Run task and back here for %time%
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& { ./CheckAndRestartDockerContainers.ps1 }"
timeout /t 300 /nobreak

goto loop