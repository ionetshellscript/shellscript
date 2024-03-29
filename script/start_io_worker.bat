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
set DEVICE_NAME=your_device_name
set DEVICE_ID=your_device_id
set USER_ID=your_user_id

:: Sử dụng các biến trong lệnh docker run
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e DEVICE_NAME="%DEVICE_NAME%" -e DEVICE_ID="%DEVICE_ID%" -e USER_ID="%USER_ID%" -e OPERATING_SYSTEM="Windows" -e USEGPUS=true --pull always ionetcontainers/io-launch:v0.1

pause

