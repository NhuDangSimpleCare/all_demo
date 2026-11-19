$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
for ($i = 4280; $i -le 4330; $i++) {
    Write-Host "$($i+1): $($content[$i])"
}
