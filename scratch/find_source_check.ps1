$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw
$pos = $content.IndexOf("Kiểm tra nguồn dữ liệu")
if ($pos -ge 0) {
    Write-Host "Found at $pos"
    Write-Host $content.Substring($pos - 200, [Math]::Min(3000, $content.Length - $pos + 200))
}
