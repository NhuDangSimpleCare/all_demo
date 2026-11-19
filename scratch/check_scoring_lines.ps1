$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
for ($i = 4145; $i -le 4220; $i++) {
    Write-Host "$($i+1): $($content[$i])"
}
