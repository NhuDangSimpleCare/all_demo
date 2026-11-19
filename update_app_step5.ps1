$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$content = $content.Replace("CSV - Bảng Phân Công & Tải 8 NVKD", "CSV - Bảng Phân Hạng Tiềm Năng & SLA")
$content = $content.Replace("538 Doanh nghiệp Golden Records · 8 NVKD", "538 Doanh nghiệp Golden Records · Phân Hạng ICP")
$content = $content.Replace("TỔNG QUAN TỐI ƯU HÓA LUỒNG LEAD & PHÂN BỔ 8 NVKD NAM VIỆT", "TỔNG QUAN TỐI ƯU HÓA LUỒNG LEAD & PHÂN HẠNG TIỀM NĂNG NAM VIỆT")
$content = $content.Replace('setBadge("badgeRoster", `8 NVKD`);', 'setBadge("badgeRoster", `538 Sạch`);')
$content = $content.Replace("để 8 NVKD không mất hàng chục giờ theo đuổi", "để không mất hàng chục giờ xử lý thủ công theo đuổi")
$content = $content.Replace("BẢNG CHẤM ĐIỂM ƯU TIÊN & PHÂN CÔNG 8 NVKD", "BẢNG CHẤM ĐIỂM ƯU TIÊN & PHÂN HẠNG ICP")
$content = $content.Replace("Hồ sơ đã chính thức phân công cho 8 NVKD và bắt đầu tính SLA.", "Hồ sơ đã chính thức xác nhận định tuyến và bắt đầu tính SLA.")
$content = $content.Replace("phân công sai địa bàn phụ trách của 8 NVKD.", "phân công sai địa bàn phụ trách.")
$content = $content.Replace("Phân bổ tự động cho 8 NVKD theo định ngạch đã cấu hình.", "Phân loại và định tuyến tự động theo phân hạng SLA đã cấu hình.")
$content = $content.Replace("(8) Phân công 8 NVKD,", "(8) Ma trận phân hạng & SLA,")
$content = $content.Replace("Quy tắc Điều phối 8 NVKD & Chuyển Trưởng phòng KD:", "Quy tắc Phân hạng & Chuyển Trưởng phòng KD:")
$content = $content.Replace("chấm điểm ưu tiên và phân bổ 8 NVKD.", "chấm điểm ưu tiên và phân loại tiềm năng ICP.")
$content = $content.Replace('"Tái cân bằng tải 8 NVKD"', '"Tái phân hạng tiềm năng & SLA"')

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)

# ai_engine.js
$enginePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\ai_engine.js"
$engineContent = [System.IO.File]::ReadAllText($enginePath, [System.Text.Encoding]::UTF8)
$engineContent = $engineContent.Replace("ĐỀ XUẤT 8 NVKD", "ĐỀ XUẤT ĐỊNH TUYẾN & PHÂN HẠNG")
$engineContent = $engineContent.Replace("Thống kê phân bổ theo 8 NVKD", "Thống kê phân bổ theo khu vực")
[System.IO.File]::WriteAllText($enginePath, $engineContent, [System.Text.Encoding]::UTF8)

Write-Output "Cleanups complete."
