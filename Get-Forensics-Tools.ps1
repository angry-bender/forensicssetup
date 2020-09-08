function Get-ZippedDownload([String] $name, [String] $dl_url)
{
        $zip = "$name.zip"
    
        Write-Host Dowloading $name
        Invoke-WebRequest $dl_url -OutFile $zip
    
        Write-Host Extracting release files
        Expand-Archive $zip -Force
       
        # Removing temp files
        Remove-Item $zip -Force
}
function Get-CyLR
{
    # Download latest release from github
    $owner = "orlikoski"
    $repo = "CyLR"
    $file = "$repo.zip"

    $releases = "https://api.github.com/repos/$owner/$repo/releases"

    Write-Host Determining latest release of $repo
    $download = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].assets[2].browser_download_url
    $name = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].name
    $zip = "$name.zip"

    Write-Host Dowloading latest release of $name
    Invoke-WebRequest $download -Out $zip

    Write-Host Extracting release files
    Expand-Archive $zip -Force

    # Removing temp files
    Remove-Item $zip -Force
}
function Get-Dcode()
{
    $webresponse =  Invoke-WebRequest "https://www.digital-detective.net/dcode" -useBasicParsing 
    $dl_url = $webresponse.Links | where href -Like "*download*" | where href -notlike "*downloads*"

    Get-ZippedDownload "Dcode" $dl_url.href
}

function Get-SansPosters()
{
    $DesktopPath = [Environment]::GetFolderPath("CommonDesktopDirectory")

    $raw_url = "https://raw.githubusercontent.com/teamdfir/sift-saltstack/master/sift/files/sift/resources/"
    Start-BitsTransfer -source $raw_url"Evidence-of-Poster.pdf"
    Start-BitsTransfer -source $raw_url"Find-Evil-Poster.pdf"
    Start-BitsTransfer -source $raw_url"SANS-DFIR.pdf"
    Start-BitsTransfer -source $raw_url"Smartphone-Forensics-Poster.pdf"
    Start-BitsTransfer -source $raw_url"memory-forensics-cheatsheet.pdf"
    Start-BitsTransfer -source $raw_url"network-forensics-cheatsheet.pdf"
    Start-BitsTransfer -source $raw_url"sift-cheatsheet.pdf"
    Start-BitsTransfer -source $raw_url"windows-to-unix-cheatsheet.pdf"

    New-Item -Path $DesktopPath -Name "SANS_Posters" -ItemType "directory"
    
}

function Install-FTK
{
    Start-BitsTransfer -Source "https://ad-iso.s3.amazonaws.com/AD_Forensic_Tools_7.3.0.iso"
    Mount-DiskImage AD_Forensic_Tools_7.3.0.iso


}

Import-Module BitsTransfer

choco install sysinternals
choco install nirlauncher
choco install photorec
choco install plaso
choco install ericzimmermantools --pre 
choco install sleuthkit
choco install network-miner
choco install exiftoolgui

# Create a working directory for other executables
New-Item -Path "C:\" -Name "NonChoco_Tools" -ItemType "directory"
Set-Location C:\NonChoco_Tools

# Start Getting and Installing other Executables
Get-CyLR
Get-Dcode


