@echo off

echo This script will delete the list of files and folders from the the given directory.
setlocal

:: Get the script's directory
set SCRIPT_DIR=%~dp0

:: Check if the file exists
if exist "%SCRIPT_DIR%oldFilesAndFolders.txt" (
    del /f /q "%SCRIPT_DIR%oldFilesAndFolders.txt"
) 

endlocal 

set /p directory_to_check=Enter the folder loaction:
set /p days_old=Enter number of days old files and Folders to be deleted. ex. 5 days: 

python ListOldFilesAndFolders.py %directory_to_check% %days_old%

setlocal enabledelayedexpansion

:: Set the path to your text file containing the list of files/folders
set "file_list=%cd%\oldFilesAndFolders.txt"

:: Check if the file list exists
if not exist "%file_list%" (
    echo File "%file_list%" not found.
    pause
    exit /b
)
:: Delete files and folders listed in oldFilesAndFolders.txt
rem Read the list of files/folders from old.txt
for /f "delims=" %%a in (%file_list%) do (
  echo Deleting: %%a

  if exist "%%a\*" (
    rem It's a directory
    rd /s /q "%%a" 2>nul
		if not exist "%%a" (
			echo folder Deleted %%a.
  ) else (
		echo Deletion failed %%a.
  )
  ) else (
    rem It's a file
	del /s /q "%%a" 2>nul
		if not exist "%%a" (
			echo file Deleted %%a
			) else (
		echo Deletion failed %%a.
  )
  )
)

echo deletion of files and folders completed.

endlocal 


pause