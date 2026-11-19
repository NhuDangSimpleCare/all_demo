$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw
$pos = $content.IndexOf("switchNavSection")
if ($pos -ge 0) {
    Write-Host "Found in index.html around pos $pos"
    $start = [Math]::Max(0, $pos - 100)
    Write-Host $content.Substring($start, [Math]::Min(1200, $content.Length - $start))
} else {
    Write-Host "Not found in index.html"
}
