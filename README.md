<!--
Copyright Glen Knowles 2025.
Distributed under the Boost Software License, Version 1.0.
-->

# vscmd

Scripts for switching command line environment between Visual Studio versions.

Copy script files from res/scripts to somewhere in the Windows PATH to make
them available and then run the vs* scripts to switch between Visual Studio
environments.

If VS2019, VS2022, and the VS2022 Preview are installed using it may
(depending on the exact versions) look like:

~~~ console
C:>vs17
**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.14.5
** Copyright (c) 2025 Microsoft Corporation
**********************************************************************

C:>vs16
**********************************************************************
** Visual Studio 2019 Developer Command Prompt v16.11.48
** Copyright (c) 2021 Microsoft Corporation
**********************************************************************

C:>vs17pre
**********************************************************************
** Visual Studio 2022 Developer Command Prompt v17.14.5-pre.1.0
** Copyright (c) 2025 Microsoft Corporation
**********************************************************************

C:>vs15
Unable to find "Visual Studio 2017"
~~~

## vs* scripts

| Script      | Action                                    |
| :---------- | :---------------------------------------- |
| vs15.bat    | Calls VsCmd to switch to VS2017.          |
| vs16.bat    | Calls VsCmd to switch to VS2019.          |
| vs17.bat    | Calls VsCmd to switch to VS2022.          |
| vs17pre.bat | Calls VsCmd to switch to VS2022 Preview.  |
| vs18pre.bat | Calls VsCmd to switch to VS2026 Insiders. |

The vs*.bat files are extremely simple, make more as needed.

# VsCmd.bat version 2025.2
Find Visual Studio version and switch environment to it.

Uses [vswhere.exe](https://github.com/microsoft/vswhere) to find the install
directory and runs the VsDevCmd.bat found there to change the environment.
EnvReset.bat (see below) is used around the call to VsDevCmd.bat to restore and
snapshot the changes.

# EnvReset.bat version 2019.1
Saves and restores the environment variables by applying (and deleting)
saved undo rules, if any. Undo rules are saved as EnvReset* environment
variables.

Additional commands exist to generate undo rules:

| Command        | Description                                      |
| :------------- | :----------------------------------------------- |
| restore        | Apply and remove undo rules if present.          |
| snapshot       | Mark before state.                               |
| commit         | Saves diff from current to before as undo rules. |
| rollback       | Clear before state markers.                      |
| ?, /?, or help | Show this message and exit.                      |

Example usage:

~~~ console
EnvReset snapshot
VsDevCmd
EnvReset commit
... do stuff
EnvReset restore
~~~

In the above example, if VsDevCmd had failed you would call
"EnvReset rollback" to clean up and not save the undo rules.
