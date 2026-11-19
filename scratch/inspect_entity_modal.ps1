$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('function openEntityDetailModal')
if ($pos -lt 0) { $pos = $content.IndexOf('openEntityDetailModal =') }
if ($pos -ge 0) {
    Write-Host $content.Substring($pos, [Math]::Min(1200, $content.Length - $pos))
}
