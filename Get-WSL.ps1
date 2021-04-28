#Install WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
#Restart

Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::YesNo
$MessageboxTitle = "Shutdown?"
$Messageboxbody = "For WSL to install, would you like to restart? You cannot continue to install WSL ubuntu without a restart"
$MessageIcon = [System.Windows.MessageBoxImage]::Information
$result = [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
if($result -eq "Yes")
{
    [system.Diagnostics.Process]::Start('cmd.exe /c "shutdown -r -t 00 -f"')
}
