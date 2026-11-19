$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('function filterByRepCard')
if ($pos -lt 0) { $pos = $content.IndexOf('filterByRepCard =') }
if ($pos -ge 0) {
    Write-Host "Definition found at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(300, $content.Length - $pos))
} else {
    Write-Host "FUNCTION filterByRepCard IS NOT DEFINED!"
}
