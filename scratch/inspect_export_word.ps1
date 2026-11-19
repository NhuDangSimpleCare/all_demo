$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$pos = $content.IndexOf("function exportReportToWord")
if ($pos -ge 0) {
    Write-Host $content.Substring($pos, [Math]::Min(600, $content.Length - $pos))
} else {
    Write-Host "Not function exportReportToWord, finding other..."
    $pos2 = $content.IndexOf("exportReportToWord")
    Write-Host $content.Substring($pos2, [Math]::Min(600, $content.Length - $pos2))
}
