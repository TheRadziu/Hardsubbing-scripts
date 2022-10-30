# Hardsubbing-scripts
Collection of scripts I made for my dad, back when TVs weren't smart enough to read subtitles.

## Differences
V1 - Uses HandBrake  
V2 - Uses HandBrake and converts UTF-8 w/o BOM to UTF-8 BOM  
V3 - Uses FFMPEG and can modify the size and font of the subtitles. Also comes with 3 preset colors of the subtitles: Transparent green, Yellow and White(default).

## Which one should I use?
I use V3 for everything and V1 in rare cases where ffmpeg fails to read some codecs.

## Setup
For V1 and V2 edit `set "handbreak=D:\Programy\Handbrake\HandBrakeCLI.exe"` with your location of HandBrakeCLI.exe.  
For V3 edit `set "ffmpeg="E:\Programy\FFMPEG\ffmpeg.exe""` with your location of ffmpeg.exe. You can also edit font size by editing `set rozmiar-napisow=18` and font by editing `set czcionka-napisow=Arial` 

## How to Use
Drop Hardsub vX.bat where video files with their subtitles are, then just execute the file. It'll hardsubs all of them one by one. Final files will be placed in `wtopione` subdir.
