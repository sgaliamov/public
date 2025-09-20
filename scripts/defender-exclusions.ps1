# # Remove everything (paths, processes, extensions, IPs)
# $pref = Get-MpPreference
# foreach ($x in $pref.ExclusionPath)      { Remove-MpPreference -ExclusionPath $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionProcess)   { Remove-MpPreference -ExclusionProcess $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionExtension) { Remove-MpPreference -ExclusionExtension $x -ErrorAction SilentlyContinue }
# foreach ($x in $pref.ExclusionIpAddress) { Remove-MpPreference -ExclusionIpAddress $x -ErrorAction SilentlyContinue }

# https://support.microsoft.com/en-us/windows/virus-and-threat-protection-in-the-windows-security-app-1361f4cd-d71a-b52a-0b66-c2820032b65e

# In process exclusions:
# C:\MyProcess\* will exclude files opened by all processes, located in C:\MyProcess, or any subfolders of C:\MyProcess

$executions = @(
    "$home\.cargo\bin\*",
    "$home\.rustup\toolchains\*",
    "$home\AppData\Local\JetBrains\*"
    "C:\Program Files\LLVM\bin\*"
)
foreach ($path in $executions) {
    Add-MpPreference -ExclusionProcess $path -Force
}

# It's recommended that you use the full path and file name to exclude a specific process.
# This makes it less likely that malware could use the same filename as a trusted and excluded process and evade detection.
$programs = @(
    "alacritty.exe",
    "code.exe",
    "dotnet.exe",
    "ms-teams.exe",
    "pwsh.exe",
    "wsl.exe"
)

foreach ($program in $programs) {
    $path = Get-Command $program | Select-Object -ExpandProperty Source
    Add-MpPreference -ExclusionProcess $path -Force
}

# Folders and files exclusions
$paths = @(
    "$home\.cargo",
    "$home\.rustup",
    "$home\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe",
    "$home\AppData\Local\Fork\current\Fork.exe",
    "$home\AppData\Local\JetBrains",
    "$home\AppData\Local\PowerToys\PowerToys.exe",
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
    Add-MpPreference -ExclusionPath $path -Force
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
    ".ps1",
    ".psm1",
    ".rs"
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

& "$Env:ProgramFiles\Windows Defender\MpCmdRun.exe" -SignatureUpdate
