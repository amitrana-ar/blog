@echo off
echo === Clearing Chrome Cache ===
rmdir /s /q "%LocalAppData%\Google\Chrome\User Data\Profile 1\Cache" >nul 2>&1
start chrome
