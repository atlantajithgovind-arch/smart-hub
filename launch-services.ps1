$mysqlExe = "C:\Program Files\MySQL\MySQL Server 26.7\bin\mysqld.exe"
$mysqlData = "C:\Users\Hp\tools\mysql_data"
$javaExe = "C:\Users\Hp\tools\jdk21.0.12_12\bin\java.exe"
$backendDir = Join-Path $PSScriptRoot "backend"
$jarPath = Join-Path $backendDir "target\smart-backlog-clearance-portal-1.0.0.jar"

# Check if MySQL port 3307 is listening
$mysqlConn = Test-NetConnection -ComputerName 127.0.0.1 -Port 3307 -WarningAction SilentlyContinue
if (-not $mysqlConn.TcpTestSucceeded) {
    Write-Host "Starting MySQL on port 3307..."
    Start-Process -FilePath $mysqlExe -ArgumentList "--port=3307", "--datadir=$mysqlData" -WindowStyle Hidden
    Start-Sleep -Seconds 4
} else {
    Write-Host "MySQL already listening on port 3307."
}

# Check MySQL connection with mysql client
& "C:\Program Files\MySQL\MySQL Server 26.7\bin\mysql.exe" -u root -P 3307 -e "SELECT 1;"

# Check if Spring Boot port 8080 is listening
$bootConn = Test-NetConnection -ComputerName 127.0.0.1 -Port 8080 -WarningAction SilentlyContinue
if (-not $bootConn.TcpTestSucceeded) {
    Write-Host "Starting Spring Boot on port 8080..."
    $outLog = "$backendDir\spring-boot.log"
    $errLog = "$backendDir\spring-boot-err.log"
    Start-Process -FilePath $javaExe -ArgumentList "-jar", "`"$jarPath`"" -WorkingDirectory $backendDir -RedirectStandardOutput $outLog -RedirectStandardError $errLog -WindowStyle Hidden
    Start-Sleep -Seconds 12
} else {
    Write-Host "Spring Boot already listening on port 8080."
}

# Verify ports
$final3307 = Test-NetConnection -ComputerName 127.0.0.1 -Port 3307 -WarningAction SilentlyContinue
$final8080 = Test-NetConnection -ComputerName 127.0.0.1 -Port 8080 -WarningAction SilentlyContinue

Write-Host "MySQL (3307): $($final3307.TcpTestSucceeded)"
Write-Host "Spring Boot (8080): $($final8080.TcpTestSucceeded)"
