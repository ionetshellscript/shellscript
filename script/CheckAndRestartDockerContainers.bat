@echo off
cd /d "%~dp0
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& { D:\Doc\ionet\script\CheckAndRestartDockerContainers.ps1 }"
pause
