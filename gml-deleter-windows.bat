@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Checking if Docker is installed
docker -v >nul 2>&1
if %errorLevel% == 0 (
    echo [Gml] Docker is installed
) else (
    echo [Gml] Docker is not installed, removal is impossible
    exit /b 1
)

REM Checking if docker-compose.yml file exists
if exist docker-compose.yml (
    echo [Gml] docker-compose.yml check - Success
) else (
    echo [Gml] docker-compose.yml does not exist
    exit /b 1
)
  
docker-compose down

docker rmi ghcr.io/gamervii-net/gml.web.skin.service:master
docker rmi ghcr.io/gamervii-net/gml.web.api:master
docker rmi gml-web-frontend-image
docker rmi quay.io/minio/minio:RELEASE.2024-05-01T01-11-10Z-cpuv1
docker rmi filebrowser/filebrowser:v2.27.0

rmdir /s /q frontend

del docker-compose.yml

pause