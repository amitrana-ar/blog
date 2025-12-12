@echo off
echo === Clearing Edge Cache ===
rmdir /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
start msedge
