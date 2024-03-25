# Public repository

## Chocolatey packages

``` pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sgaliamov/public/master/scripts/install-choco-packages.ps1'))
```

## [Oh My Posh](https://ohmyposh.dev/)

Install:

``` pwsh
choco install oh-my-posh
```

Add into `$PROFILE`:

``` pwsh
oh-my-posh init pwsh --config "https://raw.githubusercontent.com/sgaliamov/public/master/configs/alpha.omp.yaml" | Invoke-Expression
```

## To do

1. use <https://ohmyposh.dev/docs/configuration/colors#defining-a-palette>.
