@ECHO OFF

::
:: Initial check.
:: Verify if the SDK is correctly configurated
::
IF "%OSDK%"=="" GOTO ErCfg

:: Goto Basic
:: Goto Dialog

::
:: Set the build parameters : Laby
:: Launch the compilation of files : Laby
::
SET OSDKLINK=
CALL osdk_config.bat
CALL %OSDK%\bin\make.bat %OSDKFILE%
%OSDK%\bin\MemMap.exe build\symbols build\map_laby.htm %OSDKNAME% %OSDK%\documentation\documentation.css

::
:: Same for Camp
::
CALL osdk_config_camp.bat
CALL %OSDK%\bin\make.bat %OSDKFILE%
%OSDK%\bin\MemMap.exe build\symbols build\map_camp.htm %OSDKNAME% %OSDK%\documentation\documentation.css

:Dialog

::
:: Same for Dialog
::
CALL osdk_config_dialog.bat
CALL %OSDK%\bin\make.bat %OSDKFILE%
%OSDK%\bin\MemMap.exe build\symbols build\map_dialog.htm %OSDKNAME% %OSDK%\documentation\documentation.css

:: Goto Tap2dsk

::
:: Same for CopyZeroPage
::
SET OSDKLINK=-B
CALL osdk_config_cpzerop.bat
CALL %OSDK%\bin\make.bat %OSDKFILE%
%OSDK%\bin\MemMap.exe build\symbols build\map_cpzerop.htm %OSDKNAME% %OSDK%\documentation\documentation.css
SET OSDKLINK=

:Basic

echo "combat.tap"
%OSDK%\bin\bas2tap -b2t1 combat.bas BUILD\combat.tap

echo "creation.tap"
%OSDK%\bin\bas2tap -b2t1 creation.bas BUILD\creation.tap

:: %OSDK%\bin\bas2tap -b2t1 camp.bas BUILD\camp.tap

echo "ville.tap"
%OSDK%\bin\bas2tap -b2t1 ville.bas BUILD\ville.tap

echo "L1King.tap"
%OSDK%\bin\bas2tap -b2t1 L1King.txt BUILD\L1King.tap

echo "TXTPER1.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER1.txt BUILD\TXTPER1.tap

echo "L2Dorne.tap"
%OSDK%\bin\bas2tap -b2t1 L2Dorne.txt BUILD\L2Dorne.tap

echo "TXTPER2.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER2.txt BUILD\TXTPER2.tap

echo "L3Storm.tap"
%OSDK%\bin\bas2tap -b2t1 L3Storm.txt BUILD\L3Storm.tap

echo "TXTPER3.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER3.txt BUILD\TXTPER3.tap

echo "L4HighGa.tap"
%OSDK%\bin\bas2tap -b2t1 L4HighGa.txt BUILD\L4HighGa.tap

echo "TXTPER4.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER4.txt BUILD\TXTPER4.tap

echo "L5Pike.tap"
%OSDK%\bin\bas2tap -b2t1 L5Pike.txt BUILD\L5Pike.tap

echo "TXTPER5.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER5.txt BUILD\TXTPER5.tap

echo "L6Eyrie.tap"
%OSDK%\bin\bas2tap -b2t1 L6Eyrie.txt BUILD\L6Eyrie.tap

echo "TXTPER6.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER6.txt BUILD\TXTPER6.tap

echo "L7Caster.tap"
%OSDK%\bin\bas2tap -b2t1 L7Caster.txt BUILD\L7Caster.tap

echo "TXTPER7.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER7.txt BUILD\TXTPER7.tap

echo "L8River.tap"
%OSDK%\bin\bas2tap -b2t1 L8River.txt BUILD\L8River.tap

echo "TXTPER8.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER8.txt BUILD\TXTPER8.tap

echo "L9Winter.tap"
%OSDK%\bin\bas2tap -b2t1 L9Winter.txt BUILD\L9Winter.tap

echo "TXTPER9.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER9.txt BUILD\TXTPER9.tap

echo "TXTPER10.tap"
%OSDK%\bin\bas2tap -b2t1 TXTPER10.txt BUILD\TXTPER10.tap

:: %OSDK%\bin\header -a0 GoT.mid BUILD\Got.tap $0600

echo "TIMGPERSOS.tap"
%OSDK%\bin\bas2tap -b2t1 Timgpersos.bas BUILD\TIMGPERSOS.tap

echo "TITEMS.tap"
%OSDK%\bin\bas2tap -b2t1 TItems.bas BUILD\TITEMS.tap

echo "TPRIX.tap"
%OSDK%\bin\bas2tap -b2t1 TPrix.bas BUILD\TPRIX.tap

echo "monstres.tap"
%OSDK%\bin\bas2tap -b2t1 monstres.bas BUILD\monstres.tap

:Tap2dsk

pause

:: %OSDK%\bin\tap2dsk -c19:1 -n"   Tyrann III" -i"DIR" BUILD/Z-LUWIN.tap BUILD/Z-WINT.tap BUILD/Z-MORMON.tap BUILD/Z-WINTER.tap BUILD/Z-NED.tap BUILD/Z-RODRIC.tap BUILD/creation.tap BUILD/Z-CASTRA.tap BUILD/Z-SHOP.tap BUILD/laby.tap BUILD/Z-CATELI.tap BUILD/Z-SORC.tap BUILD/Z-DWOLF.tap BUILD/Z-TYRION.tap BUILD/labyMaximus.tap BUILD/Z-Dragon.tap BUILD/Z-TYWIN.tap BUILD/Z-HIGHGA.tap BUILD/Z-WALL1.tap BUILD/Z-INTRO.tap BUILD/Z-WALL2.tap BUILD/Z-JAIME.tap BUILD/Z-WALL3.tap BUILD/T-IMG-P.TAP BUILD/TEAM.TAP BUILD/COMBAT.TAP BUILD\L4-Conflans.tap tyrann3.dsk

:: %OSDK%\bin\tap2dsk -n"   Tyrann III" -i"DIR" BUILD/Z-LUWIN.tap BUILD/Z-WINT.tap BUILD/Z-MORMON.tap BUILD/Z-WINTER.tap BUILD/Z-NED.tap BUILD/Z-RODRIC.tap BUILD/Z-CASTRA.tap BUILD/Z-SHOP.tap BUILD/Z-CATELI.tap BUILD/Z-SORC.tap BUILD/Z-DWOLF.tap BUILD/Z-TYRION.tap BUILD/Z-Dragon.tap BUILD/Z-TYWIN.tap BUILD/Z-HIGHGA.tap BUILD/Z-WALL1.tap BUILD/Z-INTRO.tap BUILD/Z-WALL2.tap BUILD/Z-JAIME.tap BUILD/Z-WALL3.tap t3_img.dsk

%OSDK%\bin\tap2dsk -n"   Tyrann III" -i"DIR" BUILD\TIMGPERSOS.tap BUILD\TITEMS.tap  BUILD\L1King.tap BUILD\TXTPER1.tap BUILD\L2Dorne.tap BUILD\TXTPER2.tap BUILD\L3Storm.tap BUILD\TXTPER3.tap BUILD\L4HighGa.tap BUILD\TXTPER4.tap BUILD\L5Pike.tap BUILD\TXTPER5.tap BUILD\L6Eyrie.tap BUILD\TXTPER6.tap BUILD\L7Caster.tap BUILD\TXTPER7.tap BUILD\L8River.tap BUILD\TXTPER8.tap BUILD\L9Winter.tap BUILD\TXTPER9.tap BUILD\TXTPER10.tap BUILD\TPRIX.tap BUILD\monstres.tap t3_data.dsk

%OSDK%\bin\tap2dsk -n"   Tyrann III" -i"DIR" BUILD/laby.tap BUILD\combat.tap BUILD\creation.tap BUILD\camp.tap BUILD\ville.tap BUILD\dialog.tap BUILD\cpzerop.tap t3_prog.dsk

pause

:: %OSDK%\bin\old2mfm t3_img.dsk
:: copy t3_img.dsk c:\Euphoric\disks
%OSDK%\bin\old2mfm t3_data.dsk
:: copy t3_data.dsk c:\Euphoric\disks
%OSDK%\bin\old2mfm t3_prog.dsk
:: copy t3_prog.dsk c:\Euphoric\disks

GOTO End


::
:: Outputs an error message
::
:ErCfg
ECHO == ERROR ==
ECHO The Oric SDK was not configured properly
ECHO You should have a OSDK environment variable setted to the location of the SDK
IF "%OSDKBRIEF%"=="" PAUSE
GOTO End


:End
pause
