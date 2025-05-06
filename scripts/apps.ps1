# PowerShell script to install specified applications using winget
$apps = @(
    "JGraph.Draw",
    "Ditto.Ditto",
    "Git.Git",
    "icsharpcode.ILSpy",
    "Microsoft.AzureCLI",
    "Microsoft.PowerShell",
    "CodecGuide.K-LiteCodecPack.Standard",
    "Mega.MEGASync",
    "SoftFever.OrcaSlicer",
    "RamenSoftware.Windhawk",
    "Chocolatey.Chocolatey",
    "CatoNetworks.CatoClient",
    "Brave.Brave",
    "Fork.Fork",
    "FreeCAD.FreeCAD",
    "Spotify.Spotify",
    "Microsoft.PowerToys",
    "Microsoft.WSL",
    "Microsoft.VisualStudioCode",
    "JetBrains.Rider",
    "Rustlang.Rustup"
)

foreach ($app in $apps) {
    Write-Host "Installing $app..."
    winget install --id $app -e --silent --accept-package-agreements --accept-source-agreements
    if ($?) {
        Write-Host "$app installed successfully" -ForegroundColor Green
    } else {
        Write-Host "Failed to install $app" -ForegroundColor Red
    }
}
