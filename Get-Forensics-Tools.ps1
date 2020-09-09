function Get-ZippedDownload([String] $name, [String] $dl_url)
{
    #Download Zip    
    $zip = "$($name).zip"
    
    Write-Host Downloading $name
    Invoke-WebRequest $dl_url -OutFile $zip

    #Extract Zip    
    Write-Host Extracting release files
    Expand-Archive $zip -Force
       
    # Removing temp files
    Remove-Item $zip -Force
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
function Get-Dcode()
{
    #check for the latest version
    $webresponse =  Invoke-WebRequest "https://www.digital-detective.net/dcode" -useBasicParsing 
    $dl_url = $webresponse.Links | Where-Object href -Like "*download*" | Where-Object href -notlike "*downloads*"

    Get-ZippedDownload "Dcode" $dl_url.href
}

function Get-SansResources()
{
    $DesktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")

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

# Create a working directory for other executables then work there
New-Item -Path "C:\" -Name "NonChoco_Tools" -ItemType "directory"
Set-Location C:\NonChoco_Tools

# Start Getting and Installing other Executables
Get-CyLR
Get-Dcode
Get-SansResources




