$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$functions = [regex]::Matches($content, 'function\s+([a-zA-Z0-9_]+)\s*\(') | ForEach-Object { $_.Groups[1].Value }
$functions | Sort-Object -Unique | Out-File -FilePath "scratch/app_functions.txt" -Encoding utf8
Write-Host "Total functions in app.js: " $functions.Count
