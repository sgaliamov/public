Clear-Host

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$lines = Get-Content "$PSScriptRoot/choco-packages" | Where-Object { -not $_.StartsWith('#') }

foreach ($item in $lines) {
    choco install $item -y --ignorechecksum
}
