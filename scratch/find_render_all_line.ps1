$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$lineNum = 0
for ($i = 0; $i -lt $content.Count; $i++) {
    if ($content[$i] -match '^function renderAllViews\(') {
        $lineNum = $i + 1
        Write-Host "Found renderAllViews at line $lineNum"
        for ($j = $i - 2; $j -le $i + 25; $j++) {
            Write-Host "$($j+1): $($content[$j])"
        }
        break
    }
}
