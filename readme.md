# Public repository

## Chocolatey packages

``` pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sgaliamov/public/master/scripts/install-choco-packages.ps1'))
```

## Oh my Posh

Put in `$PROFILE`:

``` pwsh
oh-my-posh init pwsh --config "https://raw.githubusercontent.com/sgaliamov/public/master/configs/ohmyposh.yaml" | Invoke-Expression
```
