$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("handleSearchLeads")
if ($pos -ge 0) {
    Write-Host "FOUND handleSearchLeads in app.js at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(300, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND handleSearchLeads in app.js"
}
