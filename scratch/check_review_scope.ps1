$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("function reviewScopeWithAI")
if ($pos -ge 0) {
    Write-Host "FOUND at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(1200, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND"
}
