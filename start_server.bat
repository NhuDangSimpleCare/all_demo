@echo off
chcp 65001 >nul
title NAM VIỆT — AI Sales Lead Agent Server
cd /d "%~dp0"

echo ===================================================================
echo             NAM VIỆT SOFT — AI SALES LEAD AGENT
echo                MÁY CHỦ CỤC BỘ (LOCAL SERVER)
echo ===================================================================
echo.
echo [*] Thư mục làm việc: %~dp0
echo [*] Địa chỉ truy cập: http://localhost:8080
echo [*] Tự động mở trình duyệt sau giây lát...
echo.
echo [!] Để dừng máy chủ: Nhấn phím Ctrl + C hoặc đóng cửa sổ này.
echo ===================================================================
echo.

:: Tự động mở trình duyệt sau 1.5 giây
start "" cmd /c "timeout /t 1 /nobreak >nul & start http://localhost:8080"

:: Khởi chạy máy chủ PowerShell
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0server.ps1"

if %errorlevel% neq 0 (
    echo.
    echo [LỖI] Không thể khởi chạy máy chủ. Vui lòng kiểm tra cổng 8080.
    pause
)
