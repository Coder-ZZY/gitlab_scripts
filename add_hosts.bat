@echo off
REM add_hosts.bat - 直接将指定条目添加到 Windows hosts，不做去重检查

:: 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please run this script as Administrator!
    pause
    exit /b
)

set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"

if not exist "%HOSTS%" (
    echo Hosts file not found: %HOSTS%
    pause
    exit /b 1
)

:: 备份
copy /y "%HOSTS%" "%HOSTS%.bak" >nul
echo Backup created: %HOSTS%.bak

:: 追加记录
>>"%HOSTS%" echo 10.220.150.44 www.c534.com
>>"%HOSTS%" echo 10.220.150.44 c534.com
>>"%HOSTS%" echo 10.220.150.44 gitlab.c534.com

echo Records added successfully!
pause
