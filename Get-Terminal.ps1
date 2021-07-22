echo "there may be a small delay, please wait at least a minute"
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

Add-PoshGitToProfile

Add-Content $PROFILE 'Import-Module oh-my-posh'
Add-Content $PROFILE 'Set-PoshPrompt -Theme hotstick.minimal'


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

echo 'REMINDER: Open terminal => settings => open JSON, then add "fontFace": "Cascadia Code PL" after installing the font in this directory'
