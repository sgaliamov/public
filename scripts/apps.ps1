# probably need to run in pwsh core:
# winget install Microsoft.PowerShell

$apps = @(
    "winget install Microsoft.DotNet.SDK.9",
    "winget install Microsoft.DotNet.SDK.10",
    "Alacritty.Alacritty",
    "Brave.Brave",
    "CatoNetworks.CatoClient",
    "Chocolatey.Chocolatey",
    "CodecGuide.K-LiteCodecPack.Standard",
    "Ditto.Ditto",
    "Fork.Fork",
    "FreeCAD.FreeCAD",
    "Git.Git",
    "JGraph.Draw",
    "JetBrains.Rider",
    "Mega.MEGASync",
    "Microsoft.AzureCLI",
    "Microsoft.PowerToys",
    "Microsoft.VisualStudioCode",
    "Microsoft.WSL",
    "RamenSoftware.Windhawk",
    "Rustlang.Rustup", # needs build tools first
    "SoftFever.OrcaSlicer",
    "Spotify.Spotify",
    "icsharpcode.ILSpy"
)

foreach ($app in $apps) {
    Write-Host "Installing $app..."
    winget install --id $app -e --silent --accept-package-agreements --accept-source-agreements
    if ($?) {
        Write-Host "$app installed successfully" -ForegroundColor Green
    }
    else {
        Write-Host "Failed to install $app" -ForegroundColor Red
    }
}

