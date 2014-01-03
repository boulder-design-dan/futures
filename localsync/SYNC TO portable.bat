@echo off
echo.

:: Define the variables for this project in localsync_vars.bat
:: Get the variables...
CALL localsync_vars.bat


:: Export the database, then sync the files

:: Generate a timestamp
SET myHour=%TIME:~0,1%
IF "%myHour%"==" " GOTO addzero
GOTO hourfine
:addzero
SET myHour=0%TIME:~1,1%
GOTO end
:hourfine
SET myHour=%TIME:~0,2%
:end

SET isodt=%date:~6,4%%date:~3,2%%date:~0,2%_%myHour%
SET "filename=D:\Web sites\%PROJECT_DIR%\db\%DB_NAME%_%isodt%.sql"

mysqldump -u %DB_USER% --password=%DB_PASS% %DB_NAME% > "%filename%"

echo Database export complete to %filename%

call "C:\Program Files (x86)\Beyond Compare 3\BCompare.exe" "@D:\www\%WEB_DIR%\localsync\syncscript_to.txt"

echo Files synched and ready

echo All is well in the world!
pause