Clear-Host

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$lines = "
nodejs-lts
7-taskbar-tweaker
7zip.install
azure-cli
ditto.install
drawio
evernote
fiddler
FiraCode
foxitreader
git.install
git-fork
ilspy
kdiff3
keepass.install
linqpad
megasync
meld
microsoft-windows-terminal
neovim
paint.net
postman
powershell-core
powertoys
servicebusexplorer
sql-server-management-studio
telegram.install
tor-browser
totalcommander
vscode.install
WhatsApp
# spotify
yarn
" -split [System.Environment]::NewLine | Where-Object { -not $_.StartsWith('#') -and -not [System.String]::IsNullOrWhiteSpace($_) }

foreach ($item in $lines) {
    choco install $item.Trim() -y --ignorechecksum
}
