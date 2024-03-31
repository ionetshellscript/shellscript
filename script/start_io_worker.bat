@echo off
echo Waiting for Docker to start...
:waitfordocker
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker is not ready. Waiting...
    timeout /t 5 >nul
    goto waitfordocker
)

echo Docker is ready.
:: stop và remove các docker đang chạy
echo Stopping and removing all Docker containers...
echo Stopping and removing all running Docker containers...
for /f "tokens=1" %%i in ('docker container ls -q') do (
    docker container stop %%i
    docker container rm %%i
    echo Removed container %%i
)

echo Running new Docker container...
:: cài đặt giá trị các biến
set DEVICE_NAME=gpu-node-01
set DEVICE_ID=03eb7c90-a9bd-4f60-8b8d-04db93957c24
set USER_ID=dcee5b04-9ced-4ff0-90fa-c845089865b9

:: Sử dụng các biến trong lệnh docker run
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e DEVICE_NAME="%DEVICE_NAME%" -e DEVICE_ID="%DEVICE_ID%" -e USER_ID="%USER_ID%" -e OPERATING_SYSTEM="Windows" -e USEGPUS=true --pull always ionetcontainers/io-launch:v0.1

pause

