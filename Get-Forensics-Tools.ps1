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

function Get-Standalone-Download([String] $url, [String] $name)
{
        $file="$(name).zip"
        $download = "$(url)"
        $name = $file.Split(".")[0]
        $zip = "$name.zip"
        $dir = "$name"
    
        Write-Host Dowloading latest release
        Invoke-WebRequest $download -Out $zip
    
        Write-Host Extracting release files
        Expand-Archive $zip -Force
    
        # Cleaning up target dir
        Remove-Item $name -Recurse -Force -ErrorAction SilentlyContinue 
    
        # Moving from temp dir to target dir
        Move-Item $dir\$name -Destination $name -Force
    
        # Removing temp files
        Remove-Item $zip -Force
        Remove-Item $dir -Recurse -Force
    }
}

function Install-FTK
{
    Invoke-WebRequest https://ad-iso.s3.amazonaws.com/AD_Forensic_Tools_7.3.0.iso
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
Get-Standalone-Download "DCode" "https://www.digital-detective.net/download/download.php?downcode=ae2znu5994j1lforlh03"

# Get SANS Posters
$raw_url = "https://raw.githubusercontent.com/teamdfir/sift-saltstack/master/sift/files/sift/resources/"
Start-BitsTransfer -source $raw_url"Evidence-of-Poster.pdf" -des
Start-BitsTransfer -source $raw_url"Find-Evil-Poster.pdf"
Start-BitsTransfer -source $raw_url"SANS-DFIR.pdf"
Start-BitsTransfer -source $raw_url"Smartphone-Forensics-Poster.pdf"
Start-BitsTransfer -source $raw_url"memory-forensics-cheatsheet.pdf"
Start-BitsTransfer -source $raw_url"network-forensics-cheatsheet.pdf"
Start-BitsTransfer -source $raw_url"sift-cheatsheet.pdf"
Start-BitsTransfer -source $raw_url"windows-to-unix-cheatsheet.pdf"