$r1 = Invoke-WebRequest -Uri "http://localhost:8080/NamViet_DuLieuKhuyetThieu_TestDemo.csv" -UseBasicParsing
Write-Host "CSV Status: $($r1.StatusCode), Length: $($r1.RawContentLength)"

$r2 = Invoke-WebRequest -Uri "http://localhost:8080/NamViet_DuLieuKhuyetThieu_TestDemo.json" -UseBasicParsing
Write-Host "JSON Status: $($r2.StatusCode), Length: $($r2.RawContentLength)"
