function Get-CompressedDownload($package, [String] $dl_url)
{
    if($package.type -eq "zip")
    {
        #Filetype    
        $file = "$($package.name).zip"
    }
    elseif ($package.type -like "7z") 
    {
        #Filetype    
        $file = "$($package.name).7z"
    }
   
    Write-Host Downloading $package.name
    Invoke-WebRequest $dl_url -OutFile $file

    #Extract Zip    
    Write-Host Extracting release files

    if($package.type -eq "zip")
    {
        Expand-Archive $file -Force
    }
    elseif ($package.type -eq "7z") 
    {
        Start-Process "7z.exe"  -ArgumentList "x $($file)" -wait  
    }

    Write-Host Removing temp files
    Remove-Item $file -Force
}

function Install-MSI([string] $name, [string]$msiargs)
{
    #Checks Directory Config
    $startloc = "$($pwd)"
    Set-Location "$($pwd)\$($name)"
    $dircontents = Get-ChildItem

    #Sees if zipfile contains another sub-directory
    if ($dircontents.Attributes -like "Directory" -and $dircontents.Name -like "*$($name)*" ) 
    {
        Set-Location $dircontents.Name 
        $dircontents = Get-ChildItem
    }

    #Finds installer and runs
    $installer = Get-ChildItem | Where-Object { $_.name -like "*$($name)*"} | Where-Object { $_.Extension -like "*.msi*" -or $_.Extension -like "*.exe*" } 
    if($dircontents.Extension -like "*.exe*")
    {
        Write-Host "Installing $($installer.name), Please Wait"
        Start-Process "$($pwd)\$($installer.name)"  -ArgumentList "$($msiargs)" -wait
        $status = "$($name) Intalled by MSI"

    }
    elseif($dircontents.Extension -like "*.msi*")
    {
        #placeholder
    }
    else 
    {
        $status = "$($name) MSI not present"
    }
    Set-Location "$($startloc)"
    return $status
}
function Get-BundledDownload([String] $name, [String] $dl_url)
{
    #downloads raw exe files
    $exe = "$($name).exe"
    New-Item -Path "$($pwd)\" -Name "$($name)" -ItemType "directory" | Out-Null

    Write-Host Downloading $name
    Invoke-WebRequest $dl_url -OutFile "$($name)\$exe"

}
function Get-Package($package)
{
    if($package.scrapewebsite -eq $true)
    {
        #Parse vendor website for package based on filter
        $webresponse =  Invoke-WebRequest "$($package.url)" -useBasicParsing 
        if($null -eq $package.notfilter) 
        {
            $dl_url = $webresponse.Links | Where-Object "$($package.linkmember)" -Like "*$($package.likefilter)*"
        }     
        else 
        {
            $dl_url = $webresponse.Links | Where-Object "$($package.linkmember)" -Like "*$($package.likefilter)*" | Where-Object href -notlike "*$($package.notfilter)*"
        }

        if ($dl_url[0].href -notlike "*http*")
        {
            $dl_url[0].href = "$($package.url)\$($dl_url.href)"
        }
    }
    else 
    {
        $dl_url = "" | Select-Object Href
        $dl_url.href = "$($package.url)"
    }

    if ($null -ne $dl_url[1])
    {
        write-host "$($package.name) failed contact developer with the following error: More than 1 URL for $($package.name), See below table"
        write-output $dl_url | Format-Table
        $package.status = ("More than 1 URL in object")
        return #exit function
    }
    else 
    {
        #download the vendor URL
        if($package.type -eq "exe") 
        {
            Get-BundledDownload "$($package.name)" "$($dl_url.href)" 
        }         
        elseif ($package.type -eq "zip" -or $package.type -eq "7z") 
        {
            Get-CompressedDownload $package "$($dl_url.href)"
        }
        $package.status = "Downloaded"        
    } 
    return $package.status
}


function Get-GitPackage($package)
{
    # Check Latest Windows x64 release
    $releases = "https://api.github.com/repos/$($package.owner)/$($package.name)/releases"

    Write-Host Determining latest release of $package.name
    $webresponse = (Invoke-WebRequest $releases | ConvertFrom-Json)
    $download = $webresponse[0].assets[$($package.releasenum)].browser_download_url
    # $name = $webresponse[0].name
    $releasetype = $webresponse[0].assets[$($package.releasenum)].content_type

    if($releasetype -like "application/zip") 
    {
        $package.type = "zip"
        Get-CompressedDownload $package "$($download)"
        $package.status = "Downloaded"
    }         
    elseif ($releasetype -eq "application/octet-stream") 
    {
        $package.type = "exe"
        Get-BundledDownload "$($package.name)" "$($download)"
        $package.status = "Downloaded"
    } 
    else
    {
        write-host "$($package.name) failed contact developer with the following error: unknown release type $($releasetype), See below table"
        write-output $webresponse[0].assets | Format-Table
        $package.status = "Unknown release type"
        return $package.status
    }
    return $package.status
}

function Get-SansResources()
{
    $DesktopPath = [Environment]::GetFolderPath("desktop")

    $owner = "teamdfir"
    $name = "sift-saltstack"
    $apiurl = "https://api.github.com/repos"

    # Creates an object, for each of the relevant sans sift-saltstack trees
    $masterbranch = (Invoke-WebRequest "$($apiurl)/$($owner)/$($name)/branches/master"| ConvertFrom-Json)
    $sifttree = (Invoke-WebRequest $masterbranch.commit.commit.tree.url | ConvertFrom-Json).tree | Where-Object path -eq sift
    $filestree = (Invoke-WebRequest $sifttree.url | ConvertFrom-Json).tree | Where-Object path -eq files
    $sift2tree = (Invoke-WebRequest $filestree.url | ConvertFrom-Json).tree | Where-Object path -eq sift
    $resourcestree = (Invoke-WebRequest $sift2tree.url | ConvertFrom-Json).tree | Where-Object path -eq resources
    $imagestree = (Invoke-WebRequest $sift2tree.url | ConvertFrom-Json).tree | Where-Object path -eq images
    
    #Creates a tree oject from /sift/files/sift/resources where posters are located
    $posters = (Invoke-WebRequest $resourcestree.url| ConvertFrom-Json)[0].tree
    $images =  (Invoke-WebRequest $imagestree.url| ConvertFrom-Json)[0].tree

    #Creates the working directory
    New-Item -Path $DesktopPath -Name "SANS_Posters" -ItemType "directory"
    

    #Downloads the posters
    foreach ($poster in $posters)
    {
        $filename = $poster.path
        Start-BitsTransfer -source "https://raw.githubusercontent.com/$($owner)/$($name)/master/sift/files/sift/resources/$($filename)"
        Move-Item $filename "$($DesktopPath)\SANS_Posters"
    }
    
    #Downloads the images
    foreach ($image in $images)
    {
        $filename = $image.path
        Start-BitsTransfer -source "https://raw.githubusercontent.com/$($owner)/$($name)/master/sift/files/sift/images/$($filename)"
        Move-Item $filename "$($DesktopPath)\"
    }
  
}

function Restore-ForensicsMachine()
{
    #error  import error & =
    Import-Module ($Env:ProgramData)\Boxstarter.Winconfig\Boxstarter\Boxstarter.WinConfig\Boxstarter.WinConfig.psm1
    Set-WindowsExplorerOptions -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowHiddenFilesFoldersDrive
    Disable-BingSearch
    Disable-GameBarTips
    Disable-ComputerRestore -Drive ${Env:SystemDrive}  
}


Import-Module BitsTransfer

#Initialise the packages object
$packages=(Get-Content -Raw -Path .\packages.json | ConvertFrom-Json) 

#Initalise the screenlock object
$WShell = New-Object -com "Wscript.Shell"

# Tweak power options to prevent installs from timing out
& powercfg -change -monitor-timeout-ac 0 | Out-Null
& powercfg -change -monitor-timeout-dc 0 | Out-Null
& powercfg -change -disk-timeout-ac 0 | Out-Null
& powercfg -change -disk-timeout-dc 0 | Out-Null
& powercfg -change -standby-timeout-ac 0 | Out-Null
& powercfg -change -standby-timeout-dc 0 | Out-Null
& powercfg -change -hibernate-timeout-ac 0 | Out-Null
& powercfg -change -hibernate-timeout-dc 0 | Out-Null

#installs packages that require refreshenv
choco install boxstarter --yes
choco install python --yes
choco install python2 --yes

# Make `refreshenv` available right away, by defining the $env:ChocolateyInstall
# variable and importing the Chocolatey profile module.
# Note: Using `. $PROFILE` instead *may* work, but isn't guaranteed to.
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."   
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

# refreshenv is now an alias for Update-SessionEnvironment
# (rather than invoking refreshenv.cmd, the *batch file* for use with cmd.exe)
# This should make git.exe accessible via the refreshed $env:PATH, so that it
# can be called by name only.
refreshenv

#Restores explorer settings
Restore-ForensicsMachine

# Get the choco packages installed
foreach($package in $packages.ChocoPackages)
{
    #Stopsscreenlock betwen scripts
    $WShell.sendkeys("{SCROLLLOCK}")

    choco install $package.name $package.args --yes
    if($LASTEXITCODE -ne 0)
    {
        $package.status = "ERROR: Choco Install Failed"
    }
        
    else 
    {
        $package.status = "Installed with Choco"     
    }
}

# Installs Sans Posters & Wallpaper
Get-SansResources

# Allows Python env to be used and overwrites windows store default on Windows 1903+
Remove-Item "$($env:LOCALAPPDATA)\Microsoft\WindowsApps\python.exe"
Remove-Item "$($env:LOCALAPPDATA)\Microsoft\WindowsApps\python3.exe"



# Create a working directory for other executables then work there
New-Item -Path "C:\" -Name "NonChoco_Tools" -ItemType "directory"
Set-Location C:\NonChoco_Tools

# Start Getting and Installing other Executables
# Install Web Packages
foreach($package in $packages.WebPackages)
{
    $WShell.sendkeys("{SCROLLLOCK}")
    $package.status = Get-Package $package    
    if($package.ismsi -eq $true)
    {
        $package.status = Install-MSI  "$($package.name)" "$($package.msiargs)"
        Remove-Item "$($pwd)\$($package.name)" -Recurse -Force
    }

}

#Install Git Packages
foreach($package in $packages.GitPackages)
{
    $WShell.sendkeys("{SCROLLLOCK}")
    $package.status = Get-GitPackage $package
    if($package.ismsi -eq $true)
        {
            $package.status = Install-MSI  "$($package.name)" "$($package.msiargs)"
            Remove-Item "$($pwd)\$($package.name)" -Recurse -Force
        }
}

write-output $packages.GitPackages $packages.WebPackages $packages.ChocoPackages | Format-Table -property name,status





