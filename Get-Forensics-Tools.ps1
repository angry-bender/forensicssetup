function Get-GitHub-Latest-Release([String] $repo)
{
    # Download latest dotnet/codeformatter release from github

    $file = "$(repo).zip"

    $releases = "https://api.github.com/repos/$repo/releases"

    Write-Host Determining latest release
    $tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name

    $download = "https://github.com/$repo/releases/download/$tag/$file"
    $name = $file.Split(".")[0]
    $zip = "$name-$tag.zip"
    $dir = "$name-$tag"

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

function Get-Standalone-Download([String] $url)


choco install sysinternals
choco install nirlauncher
choco install photorec
choco install plaso
choco install ericzimmermantools --pre 
choco install sleuthkit
choco install network-miner
choco install exiftoolgui
Get-GitHub-Latest-Release "CyLR"


https://www.digital-detective.net/download/download.php?downcode=ae2znu5994j1lforlh03