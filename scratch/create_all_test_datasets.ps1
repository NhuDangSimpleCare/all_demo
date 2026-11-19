# ==============================================================================
# SCRIPT TẠO 12 BỘ TEST DATASET CHO UNIVERSAL DATA VALIDATION & SCHEMA DETECTION
# ==============================================================================

$targetDir = "c:\Users\cong chua sofia\Downloads\AII_DEMO\test_datasets"
if (!(Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir | Out-Null
}

$utf8WithBom = New-Object System.Text.UTF8Encoding $true

# ------------------------------------------------------------------------------
# TEST 1: B2B LEAD DATA (Chuẩn 12 trường B2B)
# ------------------------------------------------------------------------------
$t1 = @"
company_name,tax_code,contact_name,role,email,phone,province,industry,employees,budget,need,source
"Công ty Cổ phần Cơ khí Tân Bình","0311223344","Nguyễn Văn An","Giám đốc Kỹ thuật","an.nv@tanbinhmech.vn","0903112233","TP.HCM","Sản xuất & Chế biến",140,180,"Cần phần mềm quản lý kho WMS và sản xuất ERP","Website"
"Tập đoàn Dược phẩm Á Đông","0104455667","Lê Thị Hoa","Trưởng phòng C&B","hoa.le@adongpharma.com","0912334455","Hà Nội","Giáo dục & Y tế",280,220,"Cần hệ thống HRM chấm công và quản lý nhân sự đa chi nhánh","Hội thảo Y Dược 2026"
"Công ty TNHH Vận tải Biển Xanh","0400889900","Phạm Quốc Dũng","Trưởng phòng Điều vận","dung.pq@blueoceantrans.vn","0905445566","Đà Nẵng","Logistics & Kho vận",85,120,"Quản lý đội xe và chi phí nhiên liệu công nợ","Google Ads"
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_01_b2b_lead.csv"), $t1, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 2: SALES DATA (Dữ liệu bán hàng)
# ------------------------------------------------------------------------------
$t2 = @"
order_id,order_date,product,quantity,revenue,region
"ORD-2026-001","2026-04-01","Áo sơ mi Oxford Nam",15,4500000,"Miền Bắc"
"ORD-2026-002","2026-04-02","Quần âu Slimfit",8,3200000,"Miền Nam"
"ORD-2026-003","2026-04-02","Giày da công sở Oxford",4,4800000,"Miền Trung"
"ORD-2026-004","2026-04-03","Thắt lưng da bò cao cấp",20,6000000,"Miền Nam"
"ORD-2026-005","2026-04-04","Áo khoác Blazer Nam",5,4250000,"Miền Bắc"
"ORD-2026-006","2026-04-05","Ví cầm tay da thật",12,3600000,"Miền Nam"
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_02_sales_data.csv"), $t2, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 3: HR DATA (Dữ liệu nhân sự & lương)
# ------------------------------------------------------------------------------
$t3 = @"
employee_id,employee_name,department,position,salary,hire_date
"NV-001","Trần Đình Trọng","Phòng Kỹ Thuật (R&D)","Kỹ sư trưởng",28000000,"2022-03-15"
"NV-002","Nguyễn Mai Phương","Phòng Kinh Doanh B2B","Trưởng nhóm Sales",22000000,"2023-01-10"
"NV-003","Lê Hoàng Nam","Phòng Marketing","Chuyên viên SEO/Ads",16500000,"2023-08-01"
"NV-004","Phạm Thị Thúy","Phòng Nhân Sự (HR)","Chuyên viên C&B",15000000,"2024-02-20"
"NV-005","Vũ Minh Quân","Phòng Kế Toán","Kế toán tổng hợp",18500000,"2021-11-05"
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_03_hr_data.csv"), $t3, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 4: MARKETING DATA (Dữ liệu chiến dịch quảng cáo)
# ------------------------------------------------------------------------------
$t4 = @"
campaign_id,campaign_name,impressions,clicks,conversions,cost
"CMP-FB-01","Facebook Ads Chuyển Đổi Tháng 4",125000,4500,185,15200000
"CMP-GG-02","Google Search Từ Khóa ERP B2B",85000,6200,310,24500000
"CMP-ZL-03","Zalo OA Tiếp Cận Doanh Nghiệp SME",45000,2100,95,7800000
"CMP-TT-04","TikTok Ads Video Demo Quản Lý Kho",240000,8900,140,18600000
"CMP-EM-05","Email Marketing Tri Ân Khách Cũ",18000,1450,88,2500000
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_04_marketing_data.csv"), $t4, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 5: FINANCE DATA (Dữ liệu tài chính - sổ quỹ)
# ------------------------------------------------------------------------------
$t5 = @"
transaction_id,transaction_date,category,amount,account
"TX-901","2026-04-01","Thu tiền khách hàng phần mềm",85000000,"TK VCB Doanh Nghiệp"
"TX-902","2026-04-02","Chi thanh toán hạ tầng Cloud AWS",-14500000,"TK Techcombank"
"TX-903","2026-04-03","Chi tiền thuê mặt bằng văn phòng",-35000000,"TK VCB Doanh Nghiệp"
"TX-904","2026-04-04","Thu phí duy trì bản quyền năm",42000000,"TK MB Bank"
"TX-905","2026-04-05","Chi tạm ứng công tác phí NVKD",-8000000,"Quỹ tiền mặt"
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_05_finance_data.csv"), $t5, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 6: EMPTY FILE (Tệp rỗng 0 byte)
# ------------------------------------------------------------------------------
[System.IO.File]::WriteAllBytes((Join-Path $targetDir "test_06_empty_file.csv"), [byte[]]@())

# ------------------------------------------------------------------------------
# TEST 7: HEADER ONLY (Chỉ có tiêu đề, 0 dòng dữ liệu)
# ------------------------------------------------------------------------------
$t7 = "order_id,order_date,customer_name,total_amount,payment_status`r`n"
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_07_header_only.csv"), $t7, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 8: CORRUPTED FILE (Tệp nhị phân hỏng / không đọc được)
# ------------------------------------------------------------------------------
$corruptedBytes = [byte[]]@(0xFF, 0xFE, 0x00, 0x00, 0xDE, 0xAD, 0xBE, 0xEF, 0x12, 0x34, 0x56, 0x78)
[System.IO.File]::WriteAllBytes((Join-Path $targetDir "test_08_corrupted_file.csv"), $corruptedBytes)

# ------------------------------------------------------------------------------
# TEST 9: UNKNOWN DATASET (Tệp dữ liệu không có từ khóa nghiệp vụ đặc thù)
# ------------------------------------------------------------------------------
$t9 = @"
feature_alpha,feature_beta,metric_gamma,cluster_id,flag_x
0.854,12.4,98.2,"Group-A",1
0.432,8.9,45.6,"Group-B",0
0.912,15.1,112.5,"Group-A",1
0.125,4.2,22.8,"Group-C",0
0.781,11.8,87.4,"Group-A",1
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_09_unknown_dataset.csv"), $t9, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 10: MIXED DATA TYPES (Cột chứa hỗn hợp chữ và số)
# ------------------------------------------------------------------------------
$t10 = @"
item_id,item_name,price_or_note,rating
"IT-01","Chuột không dây Logitech",250000,4.8
"IT-02","Bàn phím cơ DareU","Đang cập nhật giá",4.5
"IT-03","Tai nghe gaming Kingston",850000,4.9
"IT-04","Lót chuột công thái học","Hàng tặng kèm",5.0
"IT-05","Đế tản nhiệt Laptop",180000,4.2
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_10_mixed_data_types.csv"), $t10, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 11: DUPLICATE DATA (Chứa các dòng trùng lặp 100%)
# ------------------------------------------------------------------------------
$t11 = @"
customer_code,full_name,phone_number,city
"KH-101","Nguyễn Thị Mai","0908112233","Hà Nội"
"KH-102","Trần Quốc Dũng","0912445566","Đà Nẵng"
"KH-101","Nguyễn Thị Mai","0908112233","Hà Nội"
"KH-103","Lê Hoàng Nam","0933778899","TP.HCM"
"KH-101","Nguyễn Thị Mai","0908112233","Hà Nội"
"@
[System.IO.File]::WriteAllText((Join-Path $targetDir "test_11_duplicate_data.csv"), $t11, $utf8WithBom)

# ------------------------------------------------------------------------------
# TEST 12: LARGE DATASET (2,000 dòng kiểm thử hiệu năng)
# ------------------------------------------------------------------------------
$largeLines = [System.Collections.Generic.List[string]]::new()
$largeLines.Add("record_id,transaction_date,customer_name,service_tier,usage_hours,billed_amount,region")

$regions = @("Miền Bắc", "Miền Trung", "Miền Nam")
$tiers = @("Free Starter", "Professional SME", "Enterprise Cloud", "Dedicated Node")
$names = @("Hoàng Nam", "Bích Ngọc", "Quốc Bảo", "Thu Thủy", "Thanh Tùng", "Gia Huy", "Minh Tuấn", "Ánh Tuyết")

for ($i = 1; $i -le 2000; $i++) {
    $rId = "REC-{0:D5}" -f $i
    $day = ($i % 28) + 1
    $date = "2026-04-{0:D2}" -f $day
    $name = $names[$i % $names.Count] + " #" + ($i % 50)
    $tier = $tiers[$i % $tiers.Count]
    $hours = ($i * 7) % 350 + 10
    $billed = $hours * 125000
    $reg = $regions[$i % $regions.Count]

    $largeLines.Add('"{0}","{1}","{2}","{3}",{4},{5},"{6}"' -f $rId, $date, $name, $tier, $hours, $billed, $reg)
}

[System.IO.File]::WriteAllText((Join-Path $targetDir "test_12_large_dataset.csv"), [string]::Join("`r`n", $largeLines), $utf8WithBom)

Write-Host "==================================================================" -ForegroundColor Green
Write-Host "DA TAO THANH CONG TOAN BO 12 BO DATASET KIEM THU CUA CONG 3!" -ForegroundColor Cyan
Write-Host "Thu muc: $targetDir" -ForegroundColor Yellow
Get-ChildItem $targetDir | Select-Object Name, Length | Format-Table -AutoSize
Write-Host "==================================================================" -ForegroundColor Green
