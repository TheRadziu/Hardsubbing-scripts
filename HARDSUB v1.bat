@echo off
set "handbreak=D:\Programy\Handbrake\HandBrakeCLI.exe"
SET "sciezka=%cd:\=\\%
IF exist "wtopione\*.mp4" GOTO :encode
IF not exist "wtopione\*.mp4" GOTO :createfolder
:createfolder
md "wtopione"
Echo (1a)Nie znaleziono folderu wyjsciowego wiec go stworzono.
GOTO :encode
:encode
Echo (1b)Folder juz istnieje. Rozpoczynam encoding.
FOR %%A IN (*.mkv, *.avi, *.mp4) DO (%handbreak% -i "%cd%\%%~A" -o "%cd%\wtopione\%%~nA.mp4" --preset="Normal" --srt-file "%sciezka%\\%%~nA.srt" --srt-codeset "UTF-8" --srt-burn)
GOTO :end
:end
IF not exist "wtopione\*.mp4" RD /Q "wtopione"
echo (2)Skonczono wszystkie zadania.
echo Wcisnij jakikolwiek klawisz aby zamknac to okno.
pause> nul