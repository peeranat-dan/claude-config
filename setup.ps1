$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dest = Join-Path $env:USERPROFILE '.claude'

New-Item -ItemType Directory -Force -Path "$Dest\hooks" | Out-Null

Copy-Item "$RepoDir\statusline-command.sh" "$Dest\statusline-command.sh" -Force
Copy-Item "$RepoDir\hooks\block-env-access.js" "$Dest\hooks\block-env-access.js" -Force

$settings = Get-Content "$RepoDir\settings.json" -Raw
$settings = $settings -replace [regex]::Escape('/Users/YOUR_USERNAME'), $env:USERPROFILE.Replace('\', '/')
$settings | Set-Content "$Dest\settings.json" -NoNewline

Write-Host "Done. Files copied to $Dest"
