:: Copyright Glen Knowles 2021 - 2025.
:: Distributed under the Boost Software License, Version 1.0.
@echo off
call EnvReset restore
call EnvReset snapshot

setlocal
set vscmd_cd=%cd%
set vscmd_where=Microsoft Visual Studio\Installer\vswhere.exe
set vscmd_where=%ProgramFiles(x86)%\%vscmd_where%
set vscmd_wherecmd="%vscmd_where%" -latest -products ^
  Microsoft.VisualStudio.Product.Enterprise ^
  Microsoft.VisualStudio.Product.Professional ^
  Microsoft.VisualStudio.Product.Community ^
  Microsoft.VisualStudio.Product.BuildTools ^
  %2 %3 %4 %5 %6 %7 %8 %9
for /f "usebackq tokens=1* delims=: " %%i in (`%%vscmd_wherecmd%%`) do (
    if "%%i" == "installationPath" (
        set vscmd_install=%%j
    ) else if "%%i" == "isPrerelease" (
        set vscmd_preview=%%j
    )
)
set vscmd_devcmd=%vscmd_install%\Common7\Tools\VsDevCmd.bat

if not exist "%vscmd_devcmd%" (
    endlocal
    call EnvReset rollback
    echo Unable to find %1
    goto :eof
)
endlocal && call "%vscmd_devcmd%" -arch=x64 -host_arch=x64 && cd %vscmd_cd%
call EnvReset commit
goto :eof
