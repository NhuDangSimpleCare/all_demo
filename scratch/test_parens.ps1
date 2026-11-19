$code = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$op = ($code -replace '[^(]', '').Length
$cp = ($code -replace '[^)]', '').Length
$ob = ($code -replace '[^\[]', '').Length
$cb = ($code -replace '[^\]]', '').Length
Write-Host "Parens: Open=$op, Close=$cp"
Write-Host "Brackets: Open=$ob, Close=$cb"
