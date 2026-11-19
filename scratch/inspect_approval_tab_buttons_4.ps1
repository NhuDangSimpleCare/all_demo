$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('function renderManagerApprovalTab')
if ($pos -ge 0) {
    Write-Host $content.Substring($pos + 5600, [Math]::Min(1200, $content.Length - ($pos + 5600)))
}
