@echo off
cd /d "%~dp0"

set "JAVA_HOME=C:\Users\Hp\tools\jdk21.0.12_12"
set "M2_HOME=C:\Users\Hp\tools\apache-maven-3.9.6"
set "PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%PATH%"

echo Checking MySQL on port 3307...
powershell -NoProfile -Command "if (-not (Test-NetConnection -ComputerName 127.0.0.1 -Port 3307 -WarningAction SilentlyContinue).TcpTestSucceeded) { Start-Process 'C:\Program Files\MySQL\MySQL Server 26.7\bin\mysqld.exe' -ArgumentList '--port=3307','--datadir=C:\Users\Hp\tools\mysql_data' -WindowStyle Hidden; Start-Sleep -Seconds 4 }"

echo Checking Spring Boot on port 8080...
powershell -NoProfile -Command "if (-not (Test-NetConnection -ComputerName 127.0.0.1 -Port 8080 -WarningAction SilentlyContinue).TcpTestSucceeded) { Start-Process 'C:\Users\Hp\tools\jdk21.0.12_12\bin\java.exe' -ArgumentList '-jar','target\smart-backlog-clearance-portal-1.0.0.jar' -WorkingDirectory '%~dp0backend' -RedirectStandardOutput '%~dp0backend\spring-boot.log' -RedirectStandardError '%~dp0backend\spring-boot-err.log' -WindowStyle Hidden; Start-Sleep -Seconds 12 }"

echo Services started!
