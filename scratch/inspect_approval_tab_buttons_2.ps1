$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf('function renderManagerApprovalTab')
if ($pos -ge 0) {
    Write-Host $content.Substring($pos + 3200, [Math]::Min(1500, $content.Length - ($pos + 3200)))
}
