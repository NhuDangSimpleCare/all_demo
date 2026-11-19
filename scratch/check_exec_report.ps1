$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("function renderExecutiveReport")
if ($pos -ge 0) {
    Write-Host "FOUND renderExecutiveReport at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(1000, $content.Length - $pos))
}
