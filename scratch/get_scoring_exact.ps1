$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$start = 4148
$end = 4280
for ($i = $start; $i -le $end; $i++) {
    Write-Host "$($i+1): $($content[$i])"
}
