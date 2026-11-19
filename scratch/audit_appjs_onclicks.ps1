$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$matches = [regex]::Matches($content, 'onclick=\\"([a-zA-Z0-9_]+)\(')
$htmlMatches = [regex]::Matches($content, "onclick=['""]([a-zA-Z0-9_]+)\(")

$allOnclicks = @()
foreach ($m in $matches) { $allOnclicks += $m.Groups[1].Value }
foreach ($m in $htmlMatches) { $allOnclicks += $m.Groups[1].Value }

$uniqueOnclicks = $allOnclicks | Sort-Object -Unique

Write-Host "Total unique onclicks called in app.js templates: $($uniqueOnclicks.Count)"
foreach ($fn in $uniqueOnclicks) {
    $hasDef = ($content -match "function\s+$fn\s*\(" -or $content -match "window\.$fn\s*=" -or $content -match "$fn\s*=\s*function")
    if (-not $hasDef) {
        Write-Host ">>> MISSING FUNCTION IN APP.JS: $fn"
    } else {
        Write-Host "EXISTS: $fn"
    }
}
