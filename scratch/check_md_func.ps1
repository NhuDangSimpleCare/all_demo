$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("function downloadReportMarkdown")
if ($pos -ge 0) {
    Write-Host "FOUND downloadReportMarkdown at $pos"
    Write-Host $content.Substring($pos, [Math]::Min(1200, $content.Length - $pos))
} else {
    Write-Host "NOT FOUND downloadReportMarkdown"
}
