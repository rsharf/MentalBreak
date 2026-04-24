@echo off
cd /d "D:\app ideas\MentalBreak\eqemu server\eqemu"
echo Starting Login Server...
start loginserver.exe
timeout /t 3 >nul

echo Starting World Server (with Shared Memory)...
shared_memory.exe
start world.exe
timeout /t 5 >nul

echo Starting Zone Server...
start zone.exe
echo "EQEmu Startup Sequence Initiated."
