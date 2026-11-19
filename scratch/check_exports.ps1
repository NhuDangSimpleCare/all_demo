$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
Write-Host "Contains exportReportToWord:" ($content.Contains("exportReportToWord"))
Write-Host "Contains exportReportToMarkdown:" ($content.Contains("exportReportToMarkdown"))
