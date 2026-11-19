$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('filterByRepCard')
if ($pos -ge 0) {
    Write-Host "FOUND filterByRepCard at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(500, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND filterByRepCard"
}
