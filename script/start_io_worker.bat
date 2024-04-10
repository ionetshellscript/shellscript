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
echo Stopping and removing all Docker containers...
echo Stopping and removing all running Docker containers...
for /f "tokens=1" %%i in ('docker container ls -q') do (
    docker container stop %%i
    docker container rm %%i
    echo Removed container %%i
)

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e DEVICE_NAME="devicename" -e DEVICE_ID=device_id -e USER_ID=user_id -e OPERATING_SYSTEM="Windows" -e USEGPUS=true --pull always ionetcontainers/io-launch:v0.1


