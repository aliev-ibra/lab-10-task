@echo off
setlocal enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
set "TOOLS_DIR=%PROJECT_DIR%tools"

:: Find JDK
set "JAVA_HOME="
for /d %%i in ("%TOOLS_DIR%\jdk-*") do (
    set "JAVA_HOME=%%i"
    goto :FoundJDK
)
:FoundJDK

if "%JAVA_HOME%"=="" (
    echo Error: JDK not found in %TOOLS_DIR%.
    echo Please run setup_and_run.ps1 to install tools.
    exit /b 1
)

:: Find Maven
set "M2_HOME="
for /d %%i in ("%TOOLS_DIR%\apache-maven-*") do (
    set "M2_HOME=%%i"
    goto :FoundMaven
)
:FoundMaven

if "%M2_HOME%"=="" (
    echo Error: Maven not found in %TOOLS_DIR%.
    echo Please run setup_and_run.ps1 to install tools.
    exit /b 1
)

:: Set Path and Run
set "PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%PATH%"
mvn %*