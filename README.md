<!--
Copyright Glen Knowles 2025.
Distributed under the Boost Software License, Version 1.0.
-->

# vscmd

Tool for switching command line environment between Visual Studio versions.

## Files are in res/scripts directory and include:
- EnvReset.bat - Generic tool to snapshot and restore environment variables.
- VsEnv.bat - Find Visual Studio version and switch environment to it.
- vs15.bat - Calls VsEnv to switch to VS2017.
- vs16.bat - Calls VsEnv to switch to VS2019.
- vs17.bat - Calls VsEnv to switch to VS2022 Preview.
