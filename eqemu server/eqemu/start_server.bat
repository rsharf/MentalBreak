@echo off
cls
start loginserver.exe
shared_memory.exe
ping -n 4 127.0.0.1 > nul
start world.exe
ping -n 2 127.0.0.1 > nul
start eqlaunch.exe zone
start ucs.exe
start queryserv.exe