$lines = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\styles.css"
Write-Host "Total lines in styles.css:" $lines.Count
Write-Host "Last 20 lines:"
$lines | Select-Object -Last 20
