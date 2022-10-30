@echo off
goto :Start
<!-- : Begin batch script
:Start
set "handbreak=D:\Programy\Handbrake\HandBrakeCLI.exe"
SET "sciezka=%cd:\=\\%
IF exist "wtopione\*.mp4" GOTO :encode
IF not exist "wtopione\*.mp4" GOTO :createfolder
:createfolder
md "wtopione"
Echo (1a)Nie znaleziono folderu wyjsciowego wiec go stworzono.
GOTO :encode
:encode
Echo (1b)Folder juz istnieje. 
FOR %%A IN (*.srt) DO (cscript //nologo "%~f0?.wsf" "%%~A")
Echo (2)Poprawiono UTF-8 w/o BOM na UTF-8 BOM.
Echo (3)Rozpoczynam encoding.
FOR %%A IN (*.mkv, *.avi, *.mp4) DO (
	%handbreak% --verbose=0 -i "%cd%\%%~A" -o "%cd%\wtopione\%%~nA.mp4" --preset="Normal" --srt-file "%sciezka%\\%%~nA.srt" --srt-codeset "UTF-8" --srt-burn
)
GOTO :end
:end
IF not exist "wtopione\*.mp4" RD /Q "wtopione"
echo (4)Skonczono wszystkie zadania.
echo Wcisnij jakikolwiek klawisz aby zamknac to okno.
pause> nul
exit /B
----- Begin wsf script --->
<package>
<job>
  <reference object="ADODB.Stream" />
  <object id="stmANSI" progId="ADODB.Stream" />
  <object id="stmUTF8" progId="ADODB.Stream" />
  <object id="stmNoBOM" progid="ADODB.Stream" />
  <script language="VBScript">
    Option Explicit
	Dim PlikNapisow
    PlikNapisow = Wscript.Arguments.Item(0)

    With stmANSI
      .Open
      .Type = adTypeBinary
      .LoadFromFile PlikNapisow
      .Type = adTypeText
      .LineSeparator = adCRLF
      .Charset = "UTF-8" 'Same as Windows-1252.
      With stmUTF8
        .Open
        .Type = adTypeText
        .LineSeparator = adLF
        .CharSet = "UTF-8"

        'Use Line operations to obtain LineSeparator action.
        Do Until stmANSI.EOS
          .WriteText stmANSI.ReadText(adReadLine), adWriteLine
        Loop
        stmANSI.Close

        'Skip over UTF-8 BOM.
        .Position = 0 'Enable Type change.
        .Type = adTypeBinary
        .Position =  0'UTF-8 BOM is in positions 0 through 2.

        With stmNoBOM
          .Open
          .Type = adTypeBinary
          stmUTF8.CopyTo stmNoBOM
          stmUTF8.Close

          .SaveToFile PlikNapisow, adSaveCreateOverWrite
          .Close
        End With
      End With
    End With
  </script>
</job>
</package>