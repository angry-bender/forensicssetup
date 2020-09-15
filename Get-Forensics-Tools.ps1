function Get-ZippedDownload([String] $name, [String] $dl_url)
{
    #Download Zip    
    $zip = "$($name).zip"
    
    Write-Host Downloading $name
    Invoke-WebRequest $dl_url -OutFile $zip

    #Extract Zip    
    Write-Host Extracting release files
    Expand-Archive $zip -Force
    
    Write-Host Removing temp files
    Remove-Item $zip -Force
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
    }
    elseif($dircontents.Extension -like "*.msi*")
    {
        #placeholder
    }
    else 
    {
        $Global:errorlog.add("$($name) : MSI not present") | Out-Null
    }
    Set-Location "$($startloc)"
}
function Get-BundledDownload([String] $name, [String] $dl_url)
{
    #downloads raw exe files
    $exe = "$($name).exe"
    New-Item -Path "$($pwd)\" -Name "$($name)" -ItemType "directory"

    Write-Host Downloading $name
    Invoke-WebRequest $dl_url -OutFile "$($name)\$exe"

}
function Get-Package([String] $name, [String] $url,[String] $linkmember,[String] $type,[string] $msiargs,[String] $likefilter,[String] $notfilter,[string] $scrapetest)
{
    if($scrapetest -like "*true*")
    {
        #Parse vendor website for package based on filter
        $webresponse =  Invoke-WebRequest "$($url)" -useBasicParsing 
        if($notfilter -eq "") 
        {
            $dl_url = $webresponse.Links | Where-Object "$($linkmember)" -Like "*$($likefilter)*"
        }     
        else 
        {
            $dl_url = $webresponse.Links | Where-Object "$($linkmember)" -Like "*$($likefilter)*" | Where-Object href -notlike "*$($notfilter)*"
        }

        if ($dl_url[0].href -notlike "*http*")
        {
            $dl_url[0].href = "$($url)\$($dl_url.href)"
        }
    }
    else 
    {
        $dl_url = "" | Select-Object Href
        $dl_url.href = "$($url)"
    }

    #tests for more than one URL
    if ($null -ne $dl_url[1])
    {
        write-host "$($name) failed contact developer with the following error: More than 1 URL for $($name), See below table"
        write-output $dl_url | Format-Table
        $Global:errorlog.add("$($name) : More than 1 URL in object") | Out-Null
        return #exit function
    }
    else 
    {
        #download the vendor URL
        if($type -eq "exe") 
        {
            Get-BundledDownload "$($name)" "$($dl_url.href)" 
        }         
        elseif ($type -eq "zip") 
        {
            Get-ZippedDownload "$($name)" "$($dl_url.href)" 
        }         
    } 
    Install-MSI  "$($name)" "$($msiargs)"
    Remove-Item "$($pwd)\$($name)" -Recurse -Force
}


function Get-CyLR
{
    # Check Latest Windows x64 release
    $owner = "orlikoski"
    $repo = "CyLR"
    $releases = "https://api.github.com/repos/$($owner)/$($repo)/releases"

    Write-Host Determining latest release of $repo
    $download = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].assets[2].browser_download_url
    $name = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].name
    $zip = "$($name).zip"

    #Download Latest Release
    Write-Host Downloading latest release of $name
    Invoke-WebRequest $download -Out $zip

    Write-Host Extracting release files
    Expand-Archive $zip -Force

    # Removing temp files
    Remove-Item $zip -Force
}

function Get-SansResources()
{
    $DesktopPath = [Environment]::GetFolderPath("desktop")

    $owner = "teamdfir"
    $repo = "sift-saltstack"
    $apiurl = "https://api.github.com/repos"

    # Creates an object, for each of the relevant sans sift-saltstack trees
    $masterbranch = (Invoke-WebRequest "$($apiurl)/$($owner)/$($repo)/branches/master"| ConvertFrom-Json)
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
        Start-BitsTransfer -source "https://raw.githubusercontent.com/$($owner)/$($repo)/master/sift/files/sift/resources/$($filename)"
        Move-Item $filename "$($DesktopPath)\SANS_Posters"
    }
    
    #Downloads the images
    foreach ($image in $images)
    {
        $filename = $image.path
        Start-BitsTransfer -source "https://raw.githubusercontent.com/$($owner)/$($repo)/master/sift/files/sift/images/$($filename)"
        Move-Item $filename "$($DesktopPath)\"
    }
  
}

#Init errorlog for printing at end of script
$Global:errorlog = New-Object collections.arraylist
$Global:errorlog.add("The Following packages have errors, please check the above output") | Out-Null

Import-Module BitsTransfer

# Get the choco packages installed
choco install sysinternals
choco install nirlauncher
choco install photorec
choco install plaso
choco install ericzimmermantools --pre 
choco install sleuthkit
choco install network-miner
choco install exiftoolgui
choco install python
choco install python2

# Create a working directory for other executables then work there
New-Item -Path "C:\" -Name "NonChoco_Tools" -ItemType "directory"
Set-Location C:\NonChoco_Tools

# Start Getting and Installing other Executables
# Get Package Syntax
# Get-Package name url linkmember type msiargs likefilter notfilter)
Get-CyLR
Get-Package "dcode" "https://www.digital-detective.net/dcode" "href" "zip" '/?' "download" "downloads" "true"
Get-Package "Arsenal" "https://arsenalrecon.com/downloads/" "outerHTML" "zip" "/silent" "button_0" "$null" "true"
Get-Package "Event Log Explorer" "https://eventlogxp.com/download/elex_setup.exe" "$null" "exe" '/silent' "null" "false"
Get-SansResources




