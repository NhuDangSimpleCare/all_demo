$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("closeModal")
if ($pos -ge 0) {
    Write-Host "FOUND closeModal at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(300, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND closeModal in app.js"
}
