:: Copyright Glen Knowles 2021 - 2025.
:: Distributed under the Boost Software License, Version 1.0.

:: VsCmd version 2025.1
@echo off
call EnvReset restore
call EnvReset snapshot

setlocal
set vscmd.desc=%1
set vscmd.cd=%cd%
set vscmd.where=Microsoft Visual Studio\Installer\vswhere.exe
set vscmd.where=%ProgramFiles(x86)%\%vscmd.where%
set vscmd.wherecmd="%vscmd.where%" -latest -products ^
  Microsoft.VisualStudio.Product.Enterprise ^
  Microsoft.VisualStudio.Product.Professional ^
  Microsoft.VisualStudio.Product.Community ^
  Microsoft.VisualStudio.Product.BuildTools ^
  %2 %3 %4 %5 %6 %7 %8 %9
for /f "usebackq tokens=1* delims=: " %%i in (`%%vscmd.wherecmd%%`) do (
    if "%%i" == "installationPath" (
        set vscmd.install=%%j
    ) else if "%%i" == "isPrerelease" (
        set vscmd.preview=%%j
    )
)
set vscmd.devcmd=%vscmd.install%\Common7\Tools\VsDevCmd.bat

:next_arg
if "%~2" == "-prerelease" (
    if %vscmd.preview% == 0 (
        set vscmd.devcmd=
    )
)
shift
if "%~2" neq "" goto :next_arg

if not exist "%vscmd.devcmd%" (
    endlocal
    call EnvReset rollback
    echo Unable to find %vscmd.desc%
    goto :eof
)
endlocal && call "%vscmd.devcmd%" -arch=x64 -host_arch=x64 && cd %vscmd.cd%
call EnvReset commit
goto :eof
