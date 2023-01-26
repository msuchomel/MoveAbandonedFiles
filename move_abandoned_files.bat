@echo off
REM ==============================================================
REM Purpose: Read CSV file, containing list of files to move.
REM    - File name is file_list.csv, in same location as this file
REM    - Column 1 is current path and file name
REM    - Column 2 is destination path
REM
REM  ** This process does not affect last accessed timestamp **
REM ==============================================================

set total=0
set count=0

set  "bar_perc=0%%  10%%  20%%  30%%  40%%  50%%  60%%  70%%  80%%  90%%  100%%"
set "bar_scale=|....|....|....|....|....|....|....|....|....|....|"

FOR /f "tokens=1,2 delims=" %%i in (file_list.csv) DO set /a total+=1
FOR /f "tokens=1,2 delims=" %%i in (file_list.csv) DO call :move_file "%%~i" "%%~j"
ECHO Finished
Pause >NUL

goto :EOF

:move_file
set /a count+=1
set /a perc=( count * 100 ) / total
set /a perc.bar=1 + (( count * 50 ) / total)
cls
echo:Moving file [%count%/%total%] %perc%%%
echo:
set /p "out=%bar_perc%" < nul & echo:
call set /p "out=%%bar_scale:~0,%perc.bar%%%" <nul & echo:
echo:

 REM Column 1 assigned to %%i, Column 2 assigned to %%j
 REM Quotes "%%i" are used in case path has space in it (common)

 REM Create directory folders if they don't exist
  xcopy /T %1 %2

 REM Move file into destination
  move %1 %2

)

goto :EOF