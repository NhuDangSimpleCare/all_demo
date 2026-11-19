# ==============================================================================
# BỘ SINH DỮ LIỆU THÔ CHƯA QUA XỬ LÝ (RAW UNPROCESSED LEADS) - CÔNG TY NAM VIỆT
# Quy mô: 700 hồ sơ khách hàng tiềm năng/tuần theo đúng bài toán thực tế
# Đặc trưng dữ liệu thô:
# 1. Trùng lặp cùng doanh nghiệp: Nhiều người đăng ký, tên viết tắt, alias chi nhánh
# 2. Bẫy ngân sách ảo (Lệch sản phẩm): Ngân sách khủng nhưng đòi Core Banking, 3D AutoCAD...
# 3. Hồ sơ thiếu thông tin ban đầu: Thiếu MST, ngân sách "0", thiếu tỉnh thành
# 4. Khách cũ CRM: Đã có lịch sử liên hệ để kiểm tra chống phân công trùng NVKD
# 5. Lỗi định dạng thô: Khoảng trắng thừa, số điện thoại nhiều kiểu (+84, 09xx, chấm, gạch)
# ==============================================================================

$targetFile700 = Join-Path $PSScriptRoot "NamViet_DuLieuTho_ChuaXuLy_700Leads.csv"
$targetFile50  = Join-Path $PSScriptRoot "NamViet_DuLieuTho_50Ca_ChuaXuLy.csv"

# Danh sách 20 ca mẫu cốt lõi (Core Scenarios)
$coreLeads = @(
    [PSCustomObject]@{
        LeadId = "LD-001"
        CreatedAt = "2026-11-09 09:15"
        Source = "Hội thảo Chuyển đổi số SME 2026"
        CompanyName = "  Công ty Cổ phần Logistics Á Châu  "
        TaxCode = "0314455667"
        ContactName = "Trần Văn Khôi"
        Role = "Trưởng phòng Kho vận"
        Phone = "0903112233"
        Email = "khoi.tran@achaulogistics.vn"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "140"
        Budget = "180"
        Need = "Cần phần mềm quản lý 3 kho hàng tại TP.HCM và Bình Dương, quét mã vạch barcode xuất nhập tồn theo lô thời gian thực."
    },
    [PSCustomObject]@{
        LeadId = "LD-002"
        CreatedAt = "2026-11-10 14:20"
        Source = "Website namvietsoft.vn"
        CompanyName = "ACL - CTCP Tiếp Vận Á Châu"
        TaxCode = ""
        ContactName = "Lê Thị Mỹ Dung"
        Role = "Kế toán trưởng"
        Phone = "+84 908 998 877"
        Email = "dung.le@achaulogistics.vn"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "Bình Dương"
        Employees = "150"
        Budget = "95 triệu"
        Need = "Muốn tìm phần mềm kế toán tự động đối chiếu công nợ vận chuyển và tích hợp hóa đơn điện tử với kho hàng."
    },
    [PSCustomObject]@{
        LeadId = "LD-003"
        CreatedAt = "2026-11-11 08:40"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "Á Châu Logistics (ACL Corp)"
        TaxCode = "0314455667"
        ContactName = "Nguyễn Quốc Cường"
        Role = "Giám đốc Vận hành (COO)"
        Phone = "0912.334.455"
        Email = "cuong.nq@achaulogistics.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "145 nhân sự"
        Budget = "260"
        Need = "Triển khai hệ thống ERP đồng bộ từ đơn hàng vận tải, kho WMS đến kế toán công nợ cho toàn công ty trong Quý 4."
    },
    [PSCustomObject]@{
        LeadId = "LD-004"
        CreatedAt = "2026-11-09 11:05"
        Source = "Hội thảo Công nghiệp 4.0 Bắc Ninh"
        CompanyName = "Công ty TNHH Cơ khí Chính xác Sao Việt"
        TaxCode = "0108877665"
        ContactName = "Phạm Văn Dũng"
        Role = "Giám đốc Nhà máy"
        Phone = "0988776655"
        Email = "dung.pv@saovietmech.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Bắc Ninh"
        Employees = "220"
        Budget = "350"
        Need = "Quản lý định mức nguyên vật liệu (BOM), kế hoạch sản xuất, kho vật tư và chấm công ca kíp cho nhà máy 220 công nhân."
    },
    [PSCustomObject]@{
        LeadId = "LD-005"
        CreatedAt = "2026-11-10 16:45"
        Source = "Website namvietsoft.vn"
        CompanyName = "  SaoViet Precision Mech Co., Ltd  "
        TaxCode = "0108877665"
        ContactName = "Đỗ Hoàng Yến"
        Role = "Trưởng phòng Mua hàng Chi nhánh Nam"
        Phone = " 0977665544 "
        Email = "yen.dh@saovietmech.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Nam"
        Province = "Bình Dương"
        Employees = "220"
        Budget = "320 triệu"
        Need = "Cần phần mềm quản lý mua hàng, phê duyệt đơn đặt hàng và tồn kho vật tư cơ khí cho chi nhánh Bình Dương & trụ sở Bắc Ninh."
    },
    [PSCustomObject]@{
        LeadId = "LD-006"
        CreatedAt = "2026-11-10 09:30"
        Source = "Chiến dịch Google Search Ads B2B"
        CompanyName = "Tập đoàn Đầu tư Tài chính & Ngân hàng Số FinViet"
        TaxCode = "0109998887"
        ContactName = "Vũ Đình Trọng"
        Role = "Giám đốc Công nghệ (CTO)"
        Phone = "0913555666"
        Email = "trong.vd@finvietbank.vn"
        Industry = "Dịch vụ & F&B"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "650"
        Budget = "2500"
        Need = "Cần xây dựng hệ thống Core Banking xử lý 50.000 giao dịch/giây và sàn giao dịch tài sản số Blockchain tích hợp eKYC ngân hàng."
    },
    [PSCustomObject]@{
        LeadId = "LD-007"
        CreatedAt = "2026-11-10 10:15"
        Source = "Website namvietsoft.vn"
        CompanyName = "Studio Kiến trúc & Đồ họa 3D RenderMax"
        TaxCode = "0317778889"
        ContactName = "Lâm Bảo Châu"
        Role = "Giám đốc Sáng tạo"
        Phone = "0909444555"
        Email = "chau@rendermax.vn"
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "45"
        Budget = "900 triệu"
        Need = "Mua phần mềm thiết kế 3D dựng hình kiến trúc thời gian thực thay thế AutoCAD và hệ thống render farm đồ họa."
    },
    [PSCustomObject]@{
        LeadId = "LD-008"
        CreatedAt = "2026-11-11 10:00"
        Source = "Hội thảo Chuyển đổi số SME 2026"
        CompanyName = "Công ty Cổ phần Tự động hóa Công nghiệp VietChip"
        TaxCode = "0106665554"
        ContactName = "Ngô Quang Huy"
        Role = "Trưởng ban R&D"
        Phone = "0983222111"
        Email = "huy.nq@vietchip.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "180"
        Budget = "1800"
        Need = "Cần phần mềm mô phỏng thiết kế vi mạch bán dẫn và điều khiển nhúng SCADA trực tiếp cho cánh tay robot sản xuất chip."
    },
    [PSCustomObject]@{
        LeadId = "LD-009"
        CreatedAt = "2026-11-10 15:10"
        Source = "Website namvietsoft.vn"
        CompanyName = "  Xưởng Nội thất Gỗ An Phát  "
        TaxCode = ""
        ContactName = "Anh Hùng"
        Role = "Chủ doanh nghiệp"
        Phone = "0945678910"
        Email = "hung.anphatwood@gmail.com"
        Industry = "Bất động sản & Nội thất"
        Region = ""
        Province = ""
        Employees = "0"
        Budget = "0"
        Need = "Đang rất đau đầu vì thất thoát ván gỗ trong kho và tính lương công nhân theo sản phẩm/ca kíp hay bị nhầm. Cần tư vấn gấp giải pháp."
    },
    [PSCustomObject]@{
        LeadId = "LD-010"
        CreatedAt = "2026-11-10 17:30"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "Hệ thống Nha khoa & Thẩm mỹ BrightSmile"
        TaxCode = ""
        ContactName = "Chị Thảo"
        Role = "Quản lý vận hành"
        Phone = "0938111222"
        Email = "thao.ql@brightsmile.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "35"
        Budget = "0"
        Need = "Cần phần mềm CRM nhắc lịch tái khám tự động cho khách hàng, quản lý telesale và hoa hồng tư vấn viên cho 4 cơ sở."
    },
    [PSCustomObject]@{
        LeadId = "LD-011"
        CreatedAt = "2026-11-11 09:05"
        Source = "Website namvietsoft.vn"
        CompanyName = "Nhà phân phối Điện máy & Gia dụng Minh Khang"
        TaxCode = ""
        ContactName = "Anh Tùng"
        Role = ""
        Phone = "0919888777"
        Email = "tung.minhkhang@outlook.com"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "50"
        Budget = "0"
        Need = "Muốn quản lý công nợ đại lý cấp 2, theo dõi tồn kho theo serial bảo hành và lên đơn hàng trên điện thoại cho 15 sale thị trường."
    },
    [PSCustomObject]@{
        LeadId = "LD-012"
        CreatedAt = "2026-11-11 11:20"
        Source = "Hội thảo Nông nghiệp Công nghệ cao Đà Lạt"
        CompanyName = "Công ty TNHH Thực phẩm Sạch Đà Lạt Fresh"
        TaxCode = ""
        ContactName = "Nguyễn Thị Bích Ngọc"
        Role = "Phó Giám đốc"
        Phone = "0962345678"
        Email = "ngoc@dalatfresh.vn"
        Industry = "Dịch vụ & F&B"
        Region = "Miền Trung"
        Province = "Lâm Đồng"
        Employees = "65"
        Budget = "0"
        Need = "Quan tâm phần mềm quản lý chuỗi cửa hàng POS kết hợp quản lý kho lạnh theo hạn sử dụng date."
    },
    [PSCustomObject]@{
        LeadId = "LD-013"
        CreatedAt = "2026-11-10 13:40"
        Source = "Hội thảo Chuyển đổi số SME 2026"
        CompanyName = "Công ty CP Dược phẩm Mekong"
        TaxCode = "0309988776"
        ContactName = "Trương Mỹ Lan"
        Role = "Giám đốc Kinh doanh"
        Phone = "0907654321"
        Email = "lan.tm@mekongpharma.com.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "Cần Thơ"
        Employees = "160"
        Budget = "210"
        Need = "Quản lý đội ngũ 60 trình dược viên (DMS/CRM), đặt hàng tại nhà thuốc và kiểm soát tồn kho lô/date thuốc."
    },
    [PSCustomObject]@{
        LeadId = "LD-014"
        CreatedAt = "2026-11-11 08:15"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "  Mekong Pharma JSC  "
        TaxCode = ""
        ContactName = "Phan Thanh Hải"
        Role = "Trưởng phòng Nhân sự"
        Phone = "+84-907-654-999"
        Email = "hai.pt@mekongpharma.com.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "160"
        Budget = "85"
        Need = "Cần thêm phân hệ chấm công GPS cho trình dược viên đi thị trường và tính lương KPI tự động."
    },
    [PSCustomObject]@{
        LeadId = "LD-015"
        CreatedAt = "2026-11-09 14:00"
        Source = "Hội thảo Bán lẻ Đa kênh 2026"
        CompanyName = "Công ty Cổ phần Chuỗi Thực phẩm Xanh GreenMart"
        TaxCode = "0105544332"
        ContactName = "Hoàng Thu Trang"
        Role = "Giám đốc Điều hành (CEO)"
        Phone = "0989123456"
        Email = "trang.ht@greenmart.vn"
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "190"
        Budget = "240"
        Need = "Triển khai phần mềm POS bán hàng, tích điểm thành viên CRM và quản lý kho trung tâm cho 18 siêu thị mini tại Hà Nội."
    },
    [PSCustomObject]@{
        LeadId = "LD-016"
        CreatedAt = "2026-11-09 15:30"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty Cổ phần Tập đoàn Xây dựng & Cơ điện Hòa Bình Minh"
        TaxCode = "0103344556"
        ContactName = "Lê Trọng Tấn"
        Role = "Phó Tổng Giám đốc"
        Phone = "0912888999"
        Email = "tan.lt@hoabinhminhmep.vn"
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "380"
        Budget = "620"
        Need = "Cần triển khai ERP quản lý dự án xây dựng, kiểm soát dự toán vật tư công trình, kế toán dòng tiền và nhân sự cho 380 nhân viên."
    },
    [PSCustomObject]@{
        LeadId = "LD-017"
        CreatedAt = "2026-11-10 08:50"
        Source = "Hội thảo Công nghiệp Miền Trung"
        CompanyName = "Công ty TNHH Sản xuất Bao bì Nhựa Hoàng Gia"
        TaxCode = "0401122334"
        ContactName = "Đoàn Văn Hậu"
        Role = "Giám đốc Điều hành"
        Phone = "0905111333"
        Email = "hau.dv@hoanggiapack.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Trung"
        Province = "Đà Nẵng"
        Employees = "130"
        Budget = "195"
        Need = "Cần hệ thống ERP quản lý lệnh sản xuất bao bì, kiểm soát hao hụt hạt nhựa, quản lý kho WMS và kế toán giá thành tại KCN Hòa Khánh."
    },
    [PSCustomObject]@{
        LeadId = "LD-018"
        CreatedAt = "2026-11-10 11:25"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "Hệ thống Anh ngữ Quốc tế StarLight Edu"
        TaxCode = "0402233445"
        ContactName = "Trần Thanh Tâm"
        Role = "Giám đốc Tuyển sinh"
        Phone = "0935666777"
        Email = "tam.tt@starlightedu.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Trung"
        Province = "Đà Nẵng"
        Employees = "85"
        Budget = "110"
        Need = "Cần phần mềm CRM quản lý học viên tiềm năng từ Facebook/Website, phân chia lead cho tư vấn viên và quản lý thu học phí 6 trung tâm."
    },
    [PSCustomObject]@{
        LeadId = "LD-019"
        CreatedAt = "2026-11-11 09:40"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty Cổ phần Chuỗi Nhà hàng Lẩu Nướng Sakura"
        TaxCode = "0316677889"
        ContactName = "Nguyễn Hải Đăng"
        Role = "Giám đốc Nhân sự (HRD)"
        Phone = "0902888333"
        Email = "dang.nh@sakurafnb.vn"
        Industry = "Dịch vụ & F&B"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "310"
        Budget = "145"
        Need = "Cần phần mềm HRM xếp lịch ca kíp linh hoạt cho nhân viên part-time/full-time tại 12 nhà hàng, chấm công nhận diện khuôn mặt và tính lương tự động."
    },
    [PSCustomObject]@{
        LeadId = "LD-020"
        CreatedAt = "2026-11-11 10:50"
        Source = "Hội thảo Chuyển đổi số SME 2026"
        CompanyName = "Công ty TNHH Vật liệu Xây dựng & Nội thất Kiến Việt"
        TaxCode = "0315566778"
        ContactName = "Võ Thành Trung"
        Role = "Giám đốc Kinh doanh"
        Phone = "0918777666"
        Email = "trung.vt@kienvietinterior.vn"
        Industry = "Bất động sản & Nội thất"
        Region = "Miền Nam"
        Province = "Đồng Nai"
        Employees = "95"
        Budget = "135"
        Need = "Quản lý báo giá thi công nội thất, theo dõi tiến độ hợp đồng CRM và quản lý công nợ nhà thầu, kế toán vật tư."
    }
)

# Danh sách mở rộng để sinh đủ 700 hồ sơ khách hàng tuần
$allRows = [System.Collections.Generic.List[PSCustomObject]]::new()
foreach ($item in $coreLeads) {
    $allRows.Add($item)
}

$sourcesList = @(
    "Hội thảo Chuyển đổi số SME 2026",
    "Website namvietsoft.vn",
    "Chiến dịch Facebook Ads Tháng 11",
    "Hội thảo Bán lẻ Đa kênh 2026",
    "Chiến dịch Google Search Ads B2B",
    "Triển lãm Vietnam SME Expo 2026"
)

$baseCompanyProfiles = @(
    @{ Name = "Thực phẩm Việt Hương"; Alias = "VietHuong Food"; Domain = "viethuongfood.vn"; Ind = "Sản xuất & Chế biến"; Reg = "Miền Nam"; Prov = "Bình Dương" },
    @{ Name = "Thương mại Điện tử Bách Khoa"; Alias = "BK Ecom JSC"; Domain = "bkecom.vn"; Ind = "Thương mại & Phân phối"; Reg = "Miền Bắc"; Prov = "Hà Nội" },
    @{ Name = "Vận tải Biển Đông"; Alias = "BienDong Logistics"; Domain = "biendongtrans.vn"; Ind = "Logistics & Kho vận"; Reg = "Miền Bắc"; Prov = "Hải Phòng" },
    @{ Name = "Dệt may Thời trang Ánh Dương"; Alias = "AnhDuong Garment"; Domain = "anhduongtex.vn"; Ind = "Sản xuất & Chế biến"; Reg = "Miền Trung"; Prov = "Đà Nẵng" },
    @{ Name = "Chuỗi Cà phê & Trà LaVi"; Alias = "LaVi Coffee & Tea"; Domain = "lavifnb.vn"; Ind = "Dịch vụ & F&B"; Reg = "Miền Nam"; Prov = "TP.HCM" },
    @{ Name = "Phân phối Dược & Thiết bị Y tế Tâm An"; Alias = "TamAn Pharma Med"; Domain = "tamanmed.vn"; Ind = "Thương mại & Phân phối"; Reg = "Miền Bắc"; Prov = "Hà Nội" },
    @{ Name = "Kỹ thuật Công trình & Nội thất Phú Gia"; Alias = "PhuGia Construction"; Domain = "phugiacons.vn"; Ind = "Xây dựng & Kỹ thuật"; Reg = "Miền Nam"; Prov = "Đồng Nai" },
    @{ Name = "Học viện Kỹ năng NextGen"; Alias = "NextGen Academy"; Domain = "nextgenedu.vn"; Ind = "Giáo dục & Y tế"; Reg = "Miền Bắc"; Prov = "Hà Nội" },
    @{ Name = "Nông sản Xuất khẩu Cao Nguyên"; Alias = "Highland Agro Export"; Domain = "highlandagro.vn"; Ind = "Sản xuất & Chế biến"; Reg = "Miền Trung"; Prov = "Đắk Lắk" },
    @{ Name = "Siêu thị Mẹ & Bé KidSmile"; Alias = "KidSmile Mart"; Domain = "kidsmile.vn"; Ind = "Bán lẻ & Chuỗi"; Reg = "Miền Nam"; Prov = "TP.HCM" },
    @{ Name = "Cơ điện Lạnh & Chiếu sáng Vĩnh Phát"; Alias = "VinhPhat MEP"; Domain = "vinhphatmep.vn"; Ind = "Xây dựng & Kỹ thuật"; Reg = "Miền Nam"; Prov = "TP.HCM" },
    @{ Name = "Nhựa Gia dụng & Công nghiệp Tân Á"; Alias = "Tan A Plastic"; Domain = "tanaplastic.vn"; Ind = "Sản xuất & Chế biến"; Reg = "Miền Bắc"; Prov = "Hưng Yên" },
    @{ Name = "Phân phối Thiết bị Điện Minh Quang"; Alias = "MinhQuang Electric"; Domain = "minhquang.vn"; Ind = "Thương mại & Phân phối"; Reg = "Miền Trung"; Prov = "Thừa Thiên Huế" },
    @{ Name = "Nhà hàng Hải sản Biển Xanh"; Alias = "BlueSea Seafood"; Domain = "blueseafnb.vn"; Ind = "Dịch vụ & F&B"; Reg = "Miền Trung"; Prov = "Khánh Hòa" }
)

$prefixes = @("Công ty TNHH", "Công ty Cổ phần", "CTCP", "Doanh nghiệp Tư nhân", "Tập đoàn SME", "  Công ty TNHH", "CTCP  ")

$needTemplates = @(
    @{ Text = "Cần phần mềm ERP quản lý mua hàng, sản xuất và kế toán tổng hợp cho doanh nghiệp vừa."; MinB = 120; MaxB = 280; Complete = $true },
    @{ Text = "Muốn triển khai CRM quản lý đội ngũ sale thị trường, chăm sóc khách hàng và theo dõi công nợ."; MinB = 50; MaxB = 140; Complete = $true },
    @{ Text = "Đang tìm giải pháp HRM chấm công ca kíp nhận diện khuôn mặt, tính lương KPI và hồ sơ nhân sự."; MinB = 40; MaxB = 110; Complete = $true },
    @{ Text = "Cần quản lý kho mã vạch WMS, kiểm soát tồn kho đa điểm và tích hợp kế toán xuất hóa đơn."; MinB = 65; MaxB = 180; Complete = $true },
    @{ Text = "Cần tư vấn phần mềm quản lý bán hàng và tồn kho nhưng chưa rõ chi phí và gói sản phẩm phù hợp."; MinB = 0; MaxB = 0; Complete = $false },
    @{ Text = "Muốn đổi phần mềm kế toán và quản trị nhân sự vì hiện tại đang làm sổ sách Excel hay bị nhầm lẫn."; MinB = 0; MaxB = 0; Complete = $false },
    @{ Text = "Tìm đối tác thiết kế đồ họa 3D AutoCAD hoặc xây dựng sàn giao dịch tài sản số Core Banking quốc tế."; MinB = 800; MaxB = 2200; Complete = $true; NonFit = $true }
)

$namesList = @("Anh Tuấn", "Chị Lan", "Anh Minh", "Chị Hương", "Anh Khoa", "Chị Mai", "Anh Đức", "Chị Trang", "Anh Hoàng", "Chị Linh", "Anh Dũng", "Chị Thảo", "Anh Phong", "Chị Ngọc", "Anh Hùng", "Chị Yến")
$rolesList = @("Giám đốc", "Trưởng phòng Kinh doanh", "Kế toán trưởng", "Trưởng phòng Nhân sự", "Quản lý Kho", "Chủ doanh nghiệp", "Phó Giám đốc", "Trưởng phòng Mua hàng")

for ($i = $coreLeads.Count + 1; $i -le 700; $i++) {
    $leadId = "LD-" + ($i.ToString().PadLeft(3, '0'))
    $day = 9 + ($i % 3)
    $hour = 8 + ($i % 10)
    $min = ($i * 7) % 60
    $createdAt = "2026-11-$($day.ToString().PadLeft(2,'0')) $($hour.ToString().PadLeft(2,'0')):$($min.ToString().PadLeft(2,'0'))"
    
    $src = $sourcesList[$i % $sourcesList.Count]
    
    # 22% hồ sơ là đăng ký trùng doanh nghiệp dưới tên viết tắt / alias / người khác cùng cty
    $isDup = ($i % 5 -eq 0)
    $baseIdx = if ($isDup) { ($i - 1) % $baseCompanyProfiles.Count } else { $i % $baseCompanyProfiles.Count }
    $baseComp = $baseCompanyProfiles[$baseIdx]
    $compNum = if ($isDup) { [math]::Floor(($i - 1) / 5) } else { $i }

    $prefix = $prefixes[$i % $prefixes.Count]
    $compName = if ($isDup) {
        if ($i % 2 -eq 0) { "  $($baseComp.Alias) #$compNum (Chi nhánh)  " } else { "$($baseComp.Alias) #$compNum" }
    } else {
        "$prefix $($baseComp.Name) #$compNum"
    }

    # Phân bổ tỷ lệ: ~6% bẫy ảo non-fit, ~18% thiếu thông tin, còn lại là lead chuẩn SME
    $tplIdx = $i % $needTemplates.Count
    if ($i % 17 -eq 0) {
        $tplIdx = 6 # Bẫy ảo Non-fit
    } elseif ($i % 6 -eq 0) {
        $tplIdx = if ($i % 2 -eq 0) { 4 } else { 5 } # Thiếu thông tin
    } else {
        $tplIdx = $i % 4
    }
    $tpl = $needTemplates[$tplIdx]

    $budgetVal = if ($tpl.Complete) {
        $baseB = $tpl.MinB + (($i * 13) % ($tpl.MaxB - $tpl.MinB + 1))
        # Một số dòng để chữ "triệu", một số dòng để số thuần
        if ($i % 3 -eq 0) { "$baseB triệu" } elseif ($i % 5 -eq 0) { "$baseB tr" } else { "$baseB" }
    } else {
        if ($i % 2 -eq 0) { "0" } else { "" }
    }

    $empVal = if ($tpl.Complete) {
        $baseE = 20 + (($i * 17) % 230)
        if ($i % 4 -eq 0) { "$baseE nhân sự" } else { "$baseE" }
    } else {
        if ($i % 3 -eq 0) { "0" } else { "" }
    }

    $taxVal = if ($tpl.Complete) {
        "010" + ((1000000 + $compNum).ToString().Substring(1))
    } else {
        ""
    }

    # Định dạng điện thoại thô
    $cleanPhone = "09" + ((10000000 + $compNum * 11 + ($i % 9)).ToString().Substring(0, 8))
    $phoneVal = switch ($i % 4) {
        0 { "+84 " + $cleanPhone.Substring(1, 3) + " " + $cleanPhone.Substring(4, 3) + " " + $cleanPhone.Substring(7) }
        1 { $cleanPhone.Substring(0, 4) + "." + $cleanPhone.Substring(4, 3) + "." + $cleanPhone.Substring(7) }
        2 { " $cleanPhone " }
        default { $cleanPhone }
    }

    $contactVal = $namesList[$i % $namesList.Count]
    $roleVal = if ($tpl.Complete) { $rolesList[$i % $rolesList.Count] } else { if ($i % 2 -eq 0) { "Đại diện" } else { "" } }
    $cleanDomain = $baseComp.Domain.Replace(".vn", "")
    $emailVal = "contact$i@$cleanDomain-$compNum.vn"
    
    $provVal = if ($tpl.Complete) { $baseComp.Prov } else { if ($i % 2 -eq 0) { $baseComp.Prov } else { "" } }
    $regVal = if ($tpl.Complete) { $baseComp.Reg } else { if ($i % 2 -eq 0) { $baseComp.Reg } else { "" } }

    $allRows.Add([PSCustomObject]@{
        LeadId = $leadId
        CreatedAt = $createdAt
        Source = $src
        CompanyName = $compName
        TaxCode = $taxVal
        ContactName = $contactVal
        Role = $roleVal
        Phone = $phoneVal
        Email = $emailVal
        Industry = $baseComp.Ind
        Region = $regVal
        Province = $provVal
        Employees = $empVal
        Budget = $budgetVal
        Need = $tpl.Text
    })
}

# Hàm xuất CSV có UTF-8 BOM
function Export-CsvWithBom($rows, $path) {
    $headers = @(
        "Mã Lead", "Thời Gian Đăng Ký", "Nguồn Tiếp Nhận", "Tên Doanh Nghiệp",
        "Mã Số Thuế", "Người Liên Hệ", "Chức Vụ", "Số Điện Thoại", "Email",
        "Ngành Nghề", "Khu Vực", "Tỉnh Thành", "Quy Mô Nhân Sự",
        "Ngân Sách Dự Kiến (Triệu VNĐ)", "Nhu Cầu Chi Tiết"
    )

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine(($headers | ForEach-Object { "`"$_`"" }) -join ",")

    foreach ($r in $rows) {
        $line = @(
            $r.LeadId,
            $r.CreatedAt,
            $r.Source,
            $r.CompanyName,
            $r.TaxCode,
            $r.ContactName,
            $r.Role,
            $r.Phone,
            $r.Email,
            $r.Industry,
            $r.Region,
            $r.Province,
            $r.Employees,
            $r.Budget,
            $r.Need
        ) | ForEach-Object {
            $escaped = ($_ -replace '"', '""')
            "`"$escaped`""
        }
        [void]$sb.AppendLine($line -join ",")
    }

    # Ghi file với UTF-8 BOM
    $utf8WithBom = New-Object System.Text.UTF8Encoding($true)
    [System.IO.File]::WriteAllText($path, $sb.ToString(), $utf8WithBom)
    Write-Host "[THÀNH CÔNG] Đã tạo file: $path ($($rows.Count) dòng)" -ForegroundColor Green
}

# 1. Xuất file đầy đủ 700 Leads tuần
Export-CsvWithBom -rows $allRows -path $targetFile700

# 2. Xuất file gọn 50 Leads để kiểm tra nhanh
Export-CsvWithBom -rows ($allRows | Select-Object -First 50) -path $targetFile50
