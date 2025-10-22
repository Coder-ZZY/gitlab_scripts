@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
:: Windows hosts 文件路径
set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts

:: 要添加的记录
set ENTRIES=(
"10.220.150.44 www.c534.com"
"10.220.150.44 c534.com"
"10.220.150.44 gitlab.c534.com"
)

:: 遍历每条记录
for %%L in ( "10.220.150.44 www.c534.com" "10.220.150.44 c534.com" "10.220.150.44 gitlab.c534.com" ) do (
    for /f "tokens=1,2" %%a in ("%%~L") do (
        set "IP=%%a"
        set "DOMAIN=%%b"

        :: 检查域名是否已存在
        findstr /r /c:"[[:space:]]!DOMAIN!\([[:space:]]\|$\)" "%HOSTS_FILE%" >nul
        if errorlevel 1 (
            echo 🔧 添加: !IP! !DOMAIN!
            echo !IP! !DOMAIN!>> "%HOSTS_FILE%"
        ) else (
            echo ✅ 已存在: !DOMAIN!
        )
    )
)

echo ✅ 操作完成！
pause
