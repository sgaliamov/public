# https://support.microsoft.com/en-us/windows/virus-and-threat-protection-in-the-windows-security-app-1362f4cd-d71a-b52a-0b66-c2820032b65e
# # Remove everything (paths, processes, extensions, IPs)
# $pref = Get-MpPreference
# foreach ($x in $pref.ExclusionPath)      { Remove-MpPreference -ExclusionPath $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionProcess)   { Remove-MpPreference -ExclusionProcess $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionExtension) { Remove-MpPreference -ExclusionExtension $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionIpAddress) { Remove-MpPreference -ExclusionIpAddress $x -ErrorAction SilentlyContinue }

$executions = @(
    "$home\.cargo\bin\*",
    "$home\.rustup\toolchains\*",
    "$home\AppData\Local\JetBrains\*",
    "C:\Program Files\LLVM\bin\*"
)
foreach ($path in $executions) {
    if (Test-Path $path) {
        Add-MpPreference -ExclusionProcess $path -Force
    }
    else {
        Write-Warning "Process path pattern not found: $path"
    }
}

$programs = @(
    "alacritty.exe",
    "dotnet.exe",
    "ms-teams.exe",
    "pwsh.exe",
    "wsl.exe"
)

foreach ($program in $programs) {
    $cmd = Get-Command $program -ErrorAction SilentlyContinue
    if ($cmd -and $cmd.Source -and (Test-Path $cmd.Source)) {
        Add-MpPreference -ExclusionProcess $cmd.Source -Force
    }
    else {
        Write-Warning "Program not found on PATH (skipped process exclusion): $program"
    }
}

$paths = @(
    "$home\.cargo",
    "$home\.rustup",
    "$home\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe",
    "$home\AppData\Local\Fork\current\Fork.exe",
    "$home\AppData\Local\JetBrains",
    "$home\AppData\Local\PowerToys\PowerToys.exe",
    "$home\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    "$home\projects",
    "$home\work",
    "C:\Program Files\Ditto\Ditto.exe",
    "C:\Program Files\JetBrains",
    "C:\Program Files\JetBrains\ETW Host\16\JetBrains.Etw.Collector.Host.exe",
    "C:\Program Files\Microsoft Visual Studio",
    "C:\Program Files\Windhawk\windhawk.exe",
    "C:\Program Files\dotnet",
    "C:\Program Files\dotnet\dotnet.exe"
)
foreach ($path in $paths) {
    if (Test-Path $path) {
        Add-MpPreference -ExclusionPath $path -Force
    }
    else {
        Write-Warning "File/Folder not found (skipped path exclusion): $path"
    }
}

$exts = @(
    ".c",
    ".cc",
    ".cpp",
    ".crate",
    ".cs",
    ".csproj",
    ".d",
    ".fs",
    ".fsproj",
    ".h",
    ".hpp",
    ".js",
    ".json",
    ".jsx",
    ".log",
    ".md",
    ".pdb",
    ".rs",
    ".toml",
    ".ts",
    ".tsx",
    ".txt",
    ".xml",
    ".yaml",
    ".yml"
)

foreach ($ext in $exts) {
    Add-MpPreference -ExclusionExtension $ext -Force
}

Update-MpSignature
