@echo off
cd /d "%~dp0"
title EduTrack - Student Management System Server
echo =============================================================
echo   Starting EduTrack Full-Stack Server (Node.js + SQLite)
echo =============================================================

set NODE_EXEC=node
where node >nul 2>nul
if %errorlevel% neq 0 (
  if exist "%USERPROFILE%\AppData\Roaming\Antigravity\bin\agy-node.cmd" (
    set NODE_EXEC="%USERPROFILE%\AppData\Roaming\Antigravity\bin\agy-node.cmd"
  ) else (
    echo Error: Node.js runtime not found.
    pause
    exit /b 1
  )
)

echo Starting backend on http://localhost:3000 ...
timeout /t 1 /nobreak >nul
start "" http://localhost:3000
%NODE_EXEC% server/server.js
pause
