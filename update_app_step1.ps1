$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# 1. Studio prompts
$content = $content.Replace("bẫy ảo và phân bổ 8 NVKD.", "phát hiện bẫy ảo và phân hạng tiềm năng P1-P4.")
$content = $content.Replace("<li>Phân bổ đồng đều tải công việc giữa 8 NVKD đảm bảo không ai vượt trần công suất.</li>", "<li>Phân loại chính xác mức độ ưu tiên P1-P4 và xác lập cam kết SLA khai thác theo từng nhóm khách hàng.</li>")
$content = $content.Replace("Điểm ICP phân bổ tải giữa 8 NVKD có đồng đều không?", "Điểm ICP phân loại mức độ tiềm năng như thế nào?")
$content = $content.Replace("giải quyết tranh chấp thẩm quyền giữa các NVKD phụ trách.", "phân loại ưu tiên và kiểm soát rủi ro Cổng 5.")
$content = $content.Replace("lọc trùng Golden Records, bẫy ngoài dải và tự động giao việc cho 8 NVKD.", "lọc trùng Golden Records, bẫy ngoài dải và tự động phân hạng tiềm năng theo SLA.")
$content = $content.Replace("<li>Cân bằng tải giữa 8 NVKD trên 3 miền Bắc - Trung - Nam, không vượt trần năng lực.</li>", "<li>Phân hạng mức độ tiềm năng P1-P4, gắn nhãn SLA và đề xuất kịch bản tiếp cận tối ưu.</li>")
$content = $content.Replace("kích hoạt lọc trùng Golden Record và phân công 8 NVKD.", "kích hoạt lọc trùng Golden Record và phân loại tiềm năng ICP.")

# 2. Feedback presets
$content = $content.Replace("giới hạn tối đa 65 lead/NVKD để đảm bảo 100% tuân thủ cam kết SLA 15 phút.", "siết chặt cam kết SLA 15 phút cho nhóm P1 Hot.")
$content = $content.Replace("Giới hạn tối đa 65 lead/NVKD", "Siết chặt cam kết SLA 15 phút cho nhóm P1 Hot")
$content = $content.Replace("Đã cập nhật lại ma trận 8 NVKD và 538 Golden Records.", "Đã cập nhật lại mô hình chấm điểm và phân hạng 538 Golden Records.")

# 3. Report executive text
$content = $content.Replace("Triệt tiêu Bẫy Ngân sách Ảo & Phân bổ 8 NVKD", "Triệt tiêu Bẫy Ngân sách Ảo & Phân Hạng Tiềm Năng")
$content = $content.Replace("phân bổ đúng người - đúng vùng - đúng tải cho toàn bộ đội ngũ 8 NVKD.", "xác lập thứ tự ưu tiên khai thác và cam kết SLA theo phân hạng P1-P4.")
$content = $content.Replace("không giao cho NVKD để ngăn ngừa lãng phí thời gian và công sức theo đuổi ảo.", "không đưa vào luồng chăm sóc để ngăn ngừa lãng phí thời gian và công sức theo đuổi ảo.")
$content = $content.Replace("NVKD chỉ cần 30 giây để duyệt và gửi tin nhắn khai thác bổ sung thông tin thay vì mất 20-30 phút tự soạn tay.", "bộ phận phụ trách chỉ cần 30 giây để duyệt và gửi tin nhắn khai thác bổ sung thông tin thay vì mất 20-30 phút tự soạn tay.")
$content = $content.Replace("<td>NVKD gọi ngay lập tức, ưu tiên đặt lịch demo trực tiếp.</td>", "<td>Liên hệ ngay lập tức, ưu tiên đặt lịch demo trực tiếp theo SLA 4 giờ.</td>")
$content = $content.Replace("<td>Gửi thư cảm ơn tự động, không chuyển vào danh bạ gọi của NVKD.</td>", "<td>Gửi thư cảm ơn tự động, bảo lưu hồ sơ và không đưa vào luồng bán hàng chính.</td>")
$content = $content.Replace("cho 8 NVKD!", "cho quy trình vận hành!")

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Output "Step 1 text replacements applied."
