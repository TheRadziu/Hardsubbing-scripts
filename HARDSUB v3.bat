@echo off
:::::::::::::::: Konfiguracja wtapianych napisów ::::::::::::::::
:: Dostępne kolory napisow do wyboru: zolty, zielony-transparent, bialy
set kolor-napisow=bialy
set rozmiar-napisow=18
set czcionka-napisow=Arial
:: Lokacja zainstalowanego/wypakowanego pliku ffmpeg
set "ffmpeg="E:\Programy\FFMPEG\ffmpeg.exe""
:::::::::::::::: Nie ruszać nic poniżej ::::::::::::::::
title Wtapianie napisow 3.0 by Radziu - FFMPEG
setlocal enableextensions
set liczba_plikow=0
for %%x in (*.mkv, *.avi, *.mp4) do set /a liczba_plikow+=1
endlocal && set liczba_plikow=%liczba_plikow%
SET "sciezka=%cd:\=\\%
IF exist "%cd%\wtopione\" echo (1)Rozpoczynam wtapianie napisow. & GOTO :encode
IF not exist "%cd%\wtopione\" GOTO :createfolder
:createfolder
md "wtopione"
Echo (1)Nie znaleziono folderu wyjsciowego wiec go stworzono.
echo (2)Rozpoczynam wtapianie napisow.
GOTO :encode
:encode
IF %kolor-napisow% == zielony-transparent (
	set kolor-napisow-param=,PrimaryColour=^&HAA00FF00
) 
IF %kolor-napisow% == zolty (
	set kolor-napisow-param=,PrimaryColour=^&H00FFFF
)
IF %kolor-napisow% == bialy (
	set kolor-napisow-param=
)
setlocal enableextensions ENABLEDELAYEDEXPANSION
set /a aktualny_plik=0
FOR %%A IN (*.mkv, *.avi, *.mp4) DO (SET /A aktualny_plik=aktualny_plik+1
echo Przetwarzam plik !aktualny_plik! z %liczba_plikow% ( %%~A ^)
%ffmpeg% -hide_banner -v fatal -nostats -i "%cd%\%%~A" -c:v libx264 -crf 20 -preset medium -c:a aac -movflags +faststart -vf subtitles="%%~nA.srt:force_style='FontName=%czcionka-napisow%,FontSize=%rozmiar-napisow%%kolor-napisow-param%'" "%cd%\wtopione\%%~nA.mp4"
)
endlocal
GOTO :end
:end
IF not exist "wtopione\*.mp4" RD /Q "wtopione"
echo ZAKONCZONO WSZYSTKIE ZADANIA!
echo Wcisnij jakikolwiek klawisz aby zamknac to okno.
pause> nul