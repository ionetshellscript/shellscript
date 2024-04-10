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

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e DEVICE_NAME="remote-gpu-node-03" -e DEVICE_ID=bdb2ac4d-35a2-4158-9cb2-9f5d15aee971 -e USER_ID=dcee5b04-9ced-4ff0-90fa-c845089865b9 -e OPERATING_SYSTEM="Windows" -e USEGPUS=true --pull always ionetcontainers/io-launch:v0.1


