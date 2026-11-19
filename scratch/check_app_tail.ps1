$lines = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
Write-Host "Total lines in app.js:" $lines.Count
Write-Host "Last 40 lines:"
$lines | Select-Object -Last 40
