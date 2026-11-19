$appJs = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$aiEngine = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\ai_engine.js" -Raw
$universalEngine = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\universal_data_engine.js" -Raw
$indexHtml = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw

$allJs = $appJs + "`n" + $aiEngine + "`n" + $universalEngine + "`n" + $indexHtml

$onclicks = Get-Content -Path "scratch/unique_onclicks.txt"
foreach ($oc in $onclicks) {
    if ($oc -match '^([a-zA-Z0-9_]+)\(') {
        $fnName = $matches[1]
        if ($allJs -notmatch "(function\s+$fnName\s*\(|window\.$fnName\s*=|$fnName\s*:\s*function|const\s+$fnName\s*=|let\s+$fnName\s*=|var\s+$fnName\s*=)") {
            Write-Host "MISSING FUNCTION: $fnName (from onclick: $oc)"
        } else {
            Write-Host "EXISTS: $fnName"
        }
    }
}
