#DEV Note - Insiders build as at APR2021 is just wsl --install, check again on next major Win10 Release, or check https://docs.microsoft.com/en-us/windows/wsl/install-win10

Set-Location c:\

#Install Linux Kernel for WSL2, and use WSL2
Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi -UseBasicParsing
C:\wsl_update_x64.msi /passive
wsl --set-default-version 2

#Install Ubuntu 1804 (2004 not scriptable or passable, see (winget-cli Issue #117)
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing

Rename-Item ./Ubuntu.appx ./Ubuntu.zip
Expand-Archive ./Ubuntu.zip ./Ubuntu


Set-Location ./Ubuntu

.\ubuntu1804.exe

$userenv = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("PATH", $userenv + ";C:\Ubuntu", "User")
