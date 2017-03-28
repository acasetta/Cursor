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
@"%CURSOR_ROOT%\vendor\clink\clink_x%architecture%.exe" inject --quiet --profile "%CURSOR_ROOT%\config"

:: Add Visual Studio Developer Environment
@if exist "%VS150COMNTOOLS%" (
    @call "%VS150COMNTOOLS%VsDevCmd.bat"
)

:: Prepare for msysgit
:: I do not even know, copypasted from their .bat
@set PLINK_PROTOCOL=ssh
@if not defined TERM set TERM=cygwin

:: Check if msysgit is installed
@if exist "%ProgramFiles%\Git" (
    set "GIT_INSTALL_ROOT=%ProgramFiles%\Git"
) else if exist "%ProgramFiles(x86)%\Git" (
    set "GIT_INSTALL_ROOT=%ProgramFiles(x86)%\Git"
) else if exist "%CMDER_ROOT%\vendor" (
    set "GIT_INSTALL_ROOT=%CMDER_ROOT%\vendor\msysgit"
)

:: Add git to the path
@if defined GIT_INSTALL_ROOT (
    set "PATH=%GIT_INSTALL_ROOT%\bin;%GIT_INSTALL_ROOT%\share\vim\vim74;%GIT_INSTALL_ROOT%\usr\bin;%PATH%"
    :: define SVN_SSH so we can use git svn with ssh svn repositories
    if not defined SVN_SSH set "SVN_SSH=%GIT_INSTALL_ROOT:\=\\%\\bin\\ssh.exe"
)

:: Enhance Path
@set rootDir=%CD%
@set PATH=%CURSOR_ROOT%\bin;%PATH%;%CURSOR_ROOT%

:: Enhance Subversion from command line
@set SVN_EDITOR="C:\Program Files (x86)\Notepad++\notepad++.exe"

:: Add aliases
@doskey /macrofile=%CURSOR_ROOT%\config\aliases

:: cd into users homedir
:: Set home path
@if not defined HOME set HOME=%USERPROFILE%
@cd /d "%HOME%"
@cls
@echo Welcome to Cursor!
