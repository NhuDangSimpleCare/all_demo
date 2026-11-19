$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("function renderAllViews")
if ($pos -ge 0) {
    Write-Host "FOUND renderAllViews at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(1200, $content.Length - $pos))
}
