:: Init Script for cmd.exe
:: Sets some nice defaults
:: Created as part of cmder project


:: Setting  prompt style
@for /f "tokens=2 delims=:." %%x in ('chcp') do @set cp=%%x
:: The slow part
:: World without Unicode is a sad world
@chcp 65001>nul
:: It has to be lambda, I already made a logo
:: @prompt $E[1;32;40m$P $_$E[1;30;40mλ $E[0m
:: @prompt $E[1;32;40m$P $_$E[1;30;40m$G: $E[0m
@prompt $E[1;32;40m$P$S{git}$S$_$E[1;30;40m$G:$S$E[0m

@chcp %cp%>nul


:: Pick right version of clink
@if "%PROCESSOR_ARCHITECTURE%"=="x86" (
    set architecture=86
) else (
    set architecture=64
)


:: Run clink
@%CURSOR_ROOT%\vendor\clink\clink_x%architecture%.exe inject --quiet --profile %CURSOR_ROOT%\config

:: Prepare for msysgit
:: I do not even know, copypasted from their .bat
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=cygwin

:: Enhance Path
@set rootDir=%CD%
@set git_install_root=C:\Users\acasetta\AppData\Local\GitHub\PortableGit_054f2e797ebafd44a30203088cd3d58663c627ef
@set PATH=%PATH%;%git_install_root%\bin;%git_install_root%\mingw\bin;%git_install_root%\cmd

:: Enhance Subversion from command line
@set SVN_EDITOR="C:\Program Files (x86)\Notepad++\notepad++.exe"

:: Add aliases
@doskey /macrofile=%CURSOR_ROOT%\config\aliases

:: cd into users homedir
:: @cd /d "%HOME%"

:: @echo Welcome to cmder!