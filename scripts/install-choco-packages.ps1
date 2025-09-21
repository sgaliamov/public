Clear-Host

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$lines = "
nodejs-lts
7-taskbar-tweaker
7zip.install
fiddler
foxitreader
kdiff3
linqpad
meld
neovim
paint.net
postman
powershell-core
powertoys
servicebusexplorer
sql-server-management-studio
telegram.install
WhatsApp
# spotify
yarn
" -split [System.Environment]::NewLine | Where-Object { -not $_.StartsWith('#') -and -not [System.String]::IsNullOrWhiteSpace($_) }

foreach ($item in $lines) {
    choco install $item.Trim() -y --ignorechecksum
}
