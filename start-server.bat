@echo off
title UPI Gateway Server
cd /d "%~dp0"
echo Starting UPI Gateway...
echo Open your browser at: http://127.0.0.1:8000/login
echo Press Ctrl+C to stop the server.
echo.
php artisan serve --host=127.0.0.1 --port=8000
pause
