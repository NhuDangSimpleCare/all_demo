node -c "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
if ($LASTEXITCODE -eq 0) {
    Write-Host "app.js syntax is 100% valid!"
} else {
    Write-Host "Syntax error in app.js"
}
