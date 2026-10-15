@echo off
title Smart Backlog Clearance Portal Launcher
echo ======================================================================
echo           SMART BACKLOG CLEARANCE PORTAL - LOCAL LAUNCHER
echo ======================================================================

set "JAVA_HOME=C:\Users\Hp\tools\jdk21.0.12_12"
set "M2_HOME=C:\Users\Hp\tools\apache-maven-3.9.6"
set "PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%PATH%"

echo [1/2] Ensuring MySQL daemon is running on port 3307...
start /B "" "C:\Program Files\MySQL\MySQL Server 26.7\bin\mysqld.exe" --port=3307 --datadir="C:\Users\Hp\tools\mysql_data"

timeout /t 3 /nobreak >nul

echo [2/2] Starting Spring Boot application on port 8080...
cd /d "%~dp0backend"
call mvn spring-boot:run
pause
