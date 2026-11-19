$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw
$pos = $content.IndexOf("source-check-wrapper")
if ($pos -ge 0) {
    Write-Host "Found at $pos"
    $lineNum = ($content.Substring(0, $pos) -split "`r?`n").Count
    Write-Host "Line number: $lineNum"
    Write-Host $content.Substring($pos - 100, [Math]::Min(3500, $content.Length - $pos + 100))
} else {
    Write-Host "Not found"
}
