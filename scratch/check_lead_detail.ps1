$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('openLeadDetailModal')
if ($pos -ge 0) {
    Write-Host "FOUND openLeadDetailModal at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(1000, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND openLeadDetailModal"
    $matches = [regex]::Matches($content, 'open[A-Za-z0-9_]*Modal')
    foreach ($m in $matches) {
        Write-Host "Found modal func: " $m.Value
    }
}
