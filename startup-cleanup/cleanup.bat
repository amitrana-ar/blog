@echo off
echo === Cleaning Temp Files ===
del /s /f /q %temp%\* >nul 2>&1
for /d %%x in (%temp%\*) do rd /s /q "%%x" >nul 2>&1

echo === Cleaning Prefetch Files ===
del /s /f /q C:\Windows\Prefetch\* >nul 2>&1

echo Temp and Prefetch files cleaned successfully.
exit
