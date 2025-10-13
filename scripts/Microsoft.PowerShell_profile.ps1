### Smart tab completion with Carapace ########################################

Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

### Custom prompt #############################################################

$symColor = 2
$script:first = $true

function prompt {
    $w = (Get-Location).Path
    $dt = Get-Date -Format 'HH:mm:ss'
    $width = $Host.UI.RawUI.WindowSize.Width - 1

    if ($script:first) {
        $script:first = $false
    }
    else {
        Write-Host "`e[38;5;72m$('─' * $width)`e[0m"
    }

    $pad = ' ' * ($width - $w.Length - $dt.Length)
    Write-Host ("`e[3m$w$pad$dt`e[0m")

    "`e[1;38;5;${symColor}m❯ `e[0m"
}

Set-PSReadLineOption -ContinuationPrompt "`e[1;38;5;6m⎸`e[0m"

Clear-Host
