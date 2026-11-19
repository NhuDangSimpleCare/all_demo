$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# 1. Update chart4 in leads700
$target1 = @'
    chart4: {
      title: "Hiệu quả Phân bổ cho 8 NVKD",
      subtitle: "Độ lệch tải & Số lượng Golden Records tiếp quản",
      badgeText: "538 Golden Records · Phân bổ thông minh cân bằng tải",
      note: "8 NVKD theo phân bổ thực tế. Thanh tím biểu thị ca khiếu nại/escalation Cổng 5.",
      bars: [
        { label: "Tuấn (MB - Lead 1)", width: "88%", val: "+68 hồ sơ (88.5M avg)", color: "emerald" },
        { label: "Trọng (MB - P1)", width: "82%", val: "+64 hồ sơ (74.2M avg)", color: "emerald" },
        { label: "Phương (MN - Lead 2)", width: "79%", val: "+62 hồ sơ (68.0M avg)", color: "emerald" },
        { label: "Thắng (MN - P1)", width: "74%", val: "+58 hồ sơ (61.5M avg)", color: "emerald" },
        { label: "Mai (MT - Lead 3)", width: "61%", val: "+48 hồ sơ (50.0M avg)", color: "emerald" },
        { label: "Hạnh (MN - P2)", width: "54%", val: "+42 hồ sơ (45.0M avg)", color: "emerald" },
        { label: "Escalation Cổng 5", width: "18%", val: "-14 ca chuyển Trưởng phòng", color: "purple" }
      ]
    },
'@

$replace1 = @'
    chart4: {
      title: "Cơ Cấu Phân Loại Mức Độ Tiềm Năng (ICP Tiering)",
      subtitle: "Số lượng Golden Records & Tỷ trọng Pipeline theo hạng P1 - P4",
      badgeText: "538 Golden Records · Đã phân loại tiềm năng P1 - P4",
      note: "P1 Hot và P2 Warm chiếm 71.4% tổng số hồ sơ đạt chuẩn.",
      bars: [
        { label: "Tier P1 (Doanh nghiệp Lớn & Vừa)", width: "100%", val: "216 hồ sơ (11.8B)", color: "emerald" },
        { label: "Tier P2 (Doanh nghiệp SME)", width: "78%", val: "168 hồ sơ (4.9B)", color: "emerald" },
        { label: "Tier P3 (Hộ kinh doanh / Startup)", width: "42%", val: "91 hồ sơ (1.7B)", color: "emerald" },
        { label: "Tier P4 (Non-fit Lệch SP)", width: "29%", val: "63 hồ sơ (Loại trừ)", color: "purple" }
      ]
    },
'@

$content = $content.Replace($target1.Trim(), $replace1.Trim())
$content = $content.Replace($target1.Replace("`r`n", "`n").Trim(), $replace1.Replace("`r`n", "`n").Trim())

# 2. Update recommendation 4 in leads700
$targetRec4 = @'
      {
        num: 4,
        title: "Tái cân bằng tải cho Đội Sales Miền Nam (Hiện đang quá tải 112%)",
        badge: "CÂN BẰNG TẢI",
        accent: "warning",
        evidence: `📊 <strong>Căn cứ biểu đồ:</strong> Biểu đồ Đóng góp Pipeline theo Vùng ghi nhận Miền Nam chiếm <strong>6.820.000.000 VND</strong>, tuy nhiên chỉ có 3 NVKD (Phương, Thắng, Hạnh) tiếp quản 212 hồ sơ, vượt định ngạch tải tiêu chuẩn 112%.`,
        action: `<strong>Hành động cụ thể:</strong> Điều chuyển tạm thời 2 NVKD Miền Trung (hoặc bổ sung 1 NVKD từ chi nhánh Hà Nội) để hỗ trợ chăm sóc các lead Tier P2 tại Bình Dương và Đồng Nai; áp dụng bộ lọc tự động phân chia theo quận/huyện.`,
        goal: `<strong>Mục tiêu:</strong> Hạ tỷ lệ quá tải Miền Nam về dưới 90%, duy trì SLA phản hồi < 20 phút.`,
        btnText: "⚖️ Điều Chuyển Định Ngạch Sales Miền Nam",
        actionCode: "rebalance_sales_load"
      },
'@

$replaceRec4 = @'
      {
        num: 4,
        title: "Tối ưu hóa Lộ trình Khai thác Thị trường Miền Nam (Chiếm 41% Pipeline)",
        badge: "CHIẾN LƯỢC VÙNG",
        accent: "emerald",
        evidence: `📊 <strong>Căn cứ biểu đồ:</strong> Biểu đồ Đóng góp Pipeline theo Vùng ghi nhận Miền Nam chiếm <strong>6.820.000.000 VND</strong>, với hơn 212 hồ sơ chất lượng cao tập trung tại các KCN trọng điểm.`,
        action: `<strong>Hành động cụ thể:</strong> Tập trung triển khai chiến dịch tiếp cận các khu công nghiệp trọng điểm tại Bình Dương, Đồng Nai và TP.HCM; áp dụng bộ kịch bản giải pháp NV-ERP chuyên sâu theo ngành nghề.`,
        goal: `<strong>Mục tiêu:</strong> Nâng cao tỷ lệ chuyển đổi tại Miền Nam lên > 35%, duy trì SLA phản hồi < 20 phút.`,
        btnText: "🎯 Triển Khai Chiến Dịch Tiếp Cận Miền Nam",
        actionCode: "rebalance_sales_load"
      },
'@

$content = $content.Replace($targetRec4.Trim(), $replaceRec4.Trim())
$content = $content.Replace($targetRec4.Replace("`r`n", "`n").Trim(), $replaceRec4.Replace("`r`n", "`n").Trim())

# 3. Update chart4 in lead_scoring
$targetScoring = @'
    chart4: {
      title: "Phân bổ Golden Records cho NVKD",
      subtitle: "Phân chia theo năng lực & địa bàn",
      badgeText: "15 Golden Records phân bổ cho Top Sales",
      note: "NVKD Tuấn và Phương tiếp quản các ca P1 giá trị cao nhất.",
      bars: [
        { label: "Tuấn (MB)", width: "100%", val: "+4 hồ sơ (950M)", color: "emerald" },
        { label: "Phương (MN)", width: "85%", val: "+3 hồ sơ (800M)", color: "emerald" },
        { label: "Trọng (MB)", width: "70%", val: "+3 hồ sơ (650M)", color: "emerald" },
        { label: "Thắng (MN)", width: "60%", val: "+3 hồ sơ (480M)", color: "emerald" },
        { label: "Mai (MT)", width: "40%", val: "+2 hồ sơ (240M)", color: "emerald" }
      ]
    },
'@

$replaceScoring = @'
    chart4: {
      title: "Phân bổ Pipeline Theo Quy Mô Doanh Nghiệp",
      subtitle: "Giá trị hợp đồng tiềm năng theo quy mô lao động",
      badgeText: "15 Golden Records phân loại theo quy mô",
      note: "Nhóm > 100 nhân sự chiếm tỷ trọng ngân sách lớn nhất.",
      bars: [
        { label: "Quy mô > 200 nhân sự", width: "100%", val: "+4 hồ sơ (950M)", color: "emerald" },
        { label: "Quy mô 100 - 200 nhân sự", width: "84%", val: "+3 hồ sơ (800M)", color: "emerald" },
        { label: "Quy mô 50 - 100 nhân sự", width: "68%", val: "+3 hồ sơ (650M)", color: "emerald" },
        { label: "Quy mô 20 - 50 nhân sự", width: "50%", val: "+3 hồ sơ (480M)", color: "emerald" },
        { label: "Quy mô < 20 nhân sự", width: "25%", val: "+2 hồ sơ (240M)", color: "emerald" }
      ]
    },
'@

$content = $content.Replace($targetScoring.Trim(), $replaceScoring.Trim())
$content = $content.Replace($targetScoring.Replace("`r`n", "`n").Trim(), $replaceScoring.Replace("`r`n", "`n").Trim())

# 4. Text replacements in deepdive and actions
$content = $content.Replace('cho 8 NVKD.', 'xử lý thủ công.')
$content = $content.Replace('cho các NVKD kinh nghiệm nhất (Tuấn, Phương, Trọng) nhằm tối đa hóa tỷ lệ chốt hợp đồng trị giá cao.', 'với bộ giải pháp chuyên sâu nhằm tối đa hóa tỷ lệ chốt hợp đồng trị giá cao.')
$content = $content.Replace('giao cho 3 Top NVKD (Tuấn, Phương, Trọng) gọi điện thoại và gửi email demo trực tiếp trong vòng 24h;', 'giao cho đội ngũ chuyên viên kinh doanh liên hệ trực tiếp trong vòng 24h;')
$content = $content.Replace('title: "Tập trung NVKD kinh nghiệm tiếp cận 6 ca P1 trong 24 giờ",', 'title: "Tập trung tiếp cận 6 ca P1 giá trị cao trong 24 giờ",')
$content = $content.Replace('Gán SLA 15 phút cho Tuấn và Phương gọi điện thoại trực tiếp tư vấn giải pháp.', 'Gán SLA 15 phút liên hệ trực tiếp tư vấn giải pháp cho lãnh đạo doanh nghiệp.')

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Output "Step 2 executed successfully."
