$code = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$o = ($code -replace '[^{]', '').Length
$c = ($code -replace '[^}]', '').Length
Write-Host "Open: $o, Close: $c"
if ($o -eq $c) {
    Write-Host "PERFECTLY BALANCED!"
} else {
    Write-Host "MISMATCH DETECTED: Diff = $($o - $c)"
}
