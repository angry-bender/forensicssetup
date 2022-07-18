echo "there may be a small delay, please wait at least 3 Minutes"
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

oh-my-posh font install CascadiaCode

Add-Content $PROFILE 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\hotstick.minimal.omp.json" | Invoke-Expression'
. $PROFILE

Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::Ok
$MessageboxTitle = "Note"
$Messageboxbody = "Windoows store cannot be scripted (winget-cli Issue #117), too keep terminal up to date you need to go through this process. Click `Get` on the following page, you do NOT need an account, just exit every time"
$MessageIcon = [System.Windows.MessageBoxImage]::Information
[System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
[system.Diagnostics.Process]::Start("msedge","https://aka.ms/terminal")



$ButtonType = [System.Windows.MessageBoxButton]::Ok
$Messageboxbody = 'Complete, now open terminal => settings => open JSON, then add "fontFace": "Cascadia Code PL" after installing the font in this directory'
[System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)

echo 'REMINDER: Open terminal => settings => open JSON, then add "fontFace": "Cascadia Cove NF" after installing the font in this directory'
