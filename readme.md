# Public repository

Enable high performance power plans for Windows 11:

``` pwsh
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
```

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

## Custom PowerShell profile

`PROFILE` is different for PowerShell and VS Code. Run in both environments:

``` pwsh
New-Item -ItemType HardLink -Target '.\scripts\Microsoft.PowerShell_profile.ps1' -Path $PROFILE
```

## Alacritty

``` pwsh
New-Item -ItemType HardLink -Target '.\configs\alacritty.toml' -Path "$Env:APPDATA\alacritty\alacritty.toml"
```
