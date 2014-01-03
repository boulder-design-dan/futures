@echo off
echo.

:: Define the variables for this project in localsync_vars.bat
:: Get the variables...
CALL localsync_vars.bat

:: Import the project folder first, which includes the sql dump
set BEYCOMP_SCRIPT=D:\www\%WEB_DIR%\localsync\syncscript_from.txt
call "C:\Program Files (x86)\Beyond Compare 3\BCompare.exe" "@%BEYCOMP_SCRIPT%"
echo "File synching complete"

:: Find the last modified sql file in the db folder
set IMPORT_SOURCE_DIR=D:\Web sites\%PROJECT_DIR%\db\
setlocal
set srcDir=%IMPORT_SOURCE_DIR%
set lastSqlFile=
pushd "%srcDir%"
for /f "tokens=*" %%a in ('dir /b /od 2^>NUL *.sql') do set lastSqlFile=%%a
if "%lastSqlFile%"=="" goto :errorout
goto :doimport

:: If we could not get an import sql file then dont progress with the file sync and just shout
:errorout
set lastSqlFile=
echo "The most recent file was not found so the database import and file sync DID NOT go ahead and you will need to do it manually :-("
pause

:: Use the last modified SQL file to import changes
:doimport
echo "Importing SQL file %lastSqlFile%"
set "filename=%IMPORT_SOURCE_DIR%%lastSqlFile%"

mysql -u %DB_USER% --password=%DB_PASS% %DB_NAME% < "%filename%"

echo "Database import complete"
echo "All is well in the world!"
pause