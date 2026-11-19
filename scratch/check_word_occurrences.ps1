$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$matches = [regex]::Matches($content, '[a-zA-Z0-9_\.]*exportReportToWord[a-zA-Z0-9_\.]*')
foreach ($m in $matches) {
    Write-Host "Match: " $m.Value
}
