# ==============================================================================
# SCRIPT TẠO TỆP DỮ LIỆU THÔ CHƯA QUA XỬ LÝ ĐỂ CHẠY THỬ HỆ THỐNG AI AGENT (NAM VIỆT)
# Tên tệp xuất: NamViet_DuLieuTho_TestDemo_ChuaXuLy.csv
# Định dạng: CSV chuẩn UTF-8 có BOM (tương thích 100% Microsoft Excel & Website Localhost)
# ==============================================================================

$targetPath = Join-Path $PSScriptRoot "NamViet_DuLieuTho_TestDemo_ChuaXuLy.csv"

$leads = @(
    # --- NHÓM 1: TRÙNG LẶP ĐA NGUỒN (CROSS-CHANNEL DUPLICATES & KHỬ TRÙNG) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-001"
        CreatedAt = "2026-11-15 08:30"
        Source = "Hội thảo Logistics & Kho vận 2026"
        CompanyName = "  Công ty Cổ phần Vận tải Biển Đông  "
        TaxCode = "0314455667"
        ContactName = "Trần Văn Khôi"
        Role = "Trưởng phòng Kho vận"
        Phone = "0903112233"
        Email = "khoi.tran@biendonglogistics.vn"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "140"
        Budget = "180"
        Need = "Cần phần mềm quản lý kho hàng WMS tại TP.HCM và Bình Dương, quét mã vạch barcode xuất nhập tồn theo lô thời gian thực."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-002"
        CreatedAt = "2026-11-15 14:15"
        Source = "Website namvietsoft.vn"
        CompanyName = "Biển Đông Shipping JSC (Chi nhánh)"
        TaxCode = ""
        ContactName = "Lê Thị Mỹ Dung"
        Role = "Kế toán trưởng"
        Phone = "+84 903 112 233"
        Email = "dung.le@biendonglogistics.vn"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "Bình Dương"
        Employees = "150"
        Budget = "95 triệu"
        Need = "Muốn tìm phần mềm kế toán tự động đối chiếu công nợ vận tải và hóa đơn điện tử tích hợp kho WMS."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-003"
        CreatedAt = "2026-11-16 09:20"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "CTCP Vận Tải Biển Đông"
        TaxCode = "0314455667"
        ContactName = "Nguyễn Quốc Cường"
        Role = "Giám đốc Vận hành (COO)"
        Phone = "0903.112.233"
        Email = "cuong.nq@biendonglogistics.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "145 nhân sự"
        Budget = "260"
        Need = "Cần triển khai giải pháp ERP quản lý toàn diện từ đơn hàng vận tải, kho bãi đến kế toán tài chính trong Quý 1/2027."
    },

    # --- NHÓM 2: BẪY SẢN PHẨM LỆCH DẢI / NGOÀI PHẠM VI (NON-FIT TRAPS) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-004"
        CreatedAt = "2026-11-15 10:00"
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
        LeadId = "LD-RAW-005"
        CreatedAt = "2026-11-15 11:30"
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
        Need = "Mua phần mềm thiết kế 3D dựng hình kiến trúc thời gian thực thay thế AutoCAD và Maya, tích hợp hệ thống render farm đồ họa."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-006"
        CreatedAt = "2026-11-16 10:45"
        Source = "Hội thảo Công nghiệp 4.0"
        CompanyName = "Công ty Cổ phần Tự động hóa Bán dẫn VietChip"
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
        Need = "Cần phần mềm mô phỏng vi mạch bán dẫn và hệ thống điều khiển nhúng SCADA cánh tay robot lắp ráp linh kiện chip."
    },

    # --- NHÓM 3: HỒ SƠ THIẾU THÔNG TIN BAN ĐẦU (INCOMPLETE DATA - CỔNG CẢI TIẾN & DRAFT) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-007"
        CreatedAt = "2026-11-15 15:10"
        Source = "Website namvietsoft.vn"
        CompanyName = "  Xưởng Nội thất Gỗ An Phát  "
        TaxCode = ""
        ContactName = "Anh Hùng"
        Role = "Chủ xưởng"
        Phone = "0945678910"
        Email = "hung.anphatwood@gmail.com"
        Industry = "Bất động sản & Nội thất"
        Region = ""
        Province = ""
        Employees = "0"
        Budget = "0"
        Need = "Đang đau đầu vì thất thoát ván gỗ trong kho và tính lương công nhân theo ca kíp hay bị nhầm. Cần Nam Việt tư vấn gấp giải pháp."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-008"
        CreatedAt = "2026-11-15 17:30"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "Hệ thống Nha khoa & Thẩm mỹ BrightSmile"
        TaxCode = ""
        ContactName = "Chị Thảo"
        Role = "Quản lý phòng khám"
        Phone = "0938111222"
        Email = "thao.ql@brightsmile.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "35"
        Budget = "0"
        Need = "Cần phần mềm CRM nhắc lịch tái khám tự động qua SMS/Zalo cho khách hàng, quản lý telesale và hoa hồng tư vấn viên cho 4 chi nhánh."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-009"
        CreatedAt = "2026-11-16 08:50"
        Source = "Website namvietsoft.vn"
        CompanyName = "Nhà phân phối Thiết bị Điện Minh Khang"
        TaxCode = ""
        ContactName = "Anh Tùng"
        Role = "Quản lý kinh doanh"
        Phone = "0919888777"
        Email = "tung.minhkhang@outlook.com"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "50"
        Budget = "0"
        Need = "Muốn quản lý công nợ đại lý cấp 2, theo dõi bảo hành theo mã serial và cho nhân viên thị trường lên đơn hàng trên điện thoại."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-010"
        CreatedAt = "2026-11-16 11:20"
        Source = "Hội thảo Nông nghiệp Công nghệ cao"
        CompanyName = "Công ty TNHH Thực phẩm Sạch Đà Lạt Farm"
        TaxCode = ""
        ContactName = "Nguyễn Thị Bích Ngọc"
        Role = "Phó Giám đốc"
        Phone = "0962345678"
        Email = "ngoc@dalatfarm.vn"
        Industry = "Dịch vụ & F&B"
        Region = "Miền Trung"
        Province = "Lâm Đồng"
        Employees = "65"
        Budget = "0"
        Need = "Quan tâm phần mềm quản lý chuỗi 6 cửa hàng nông sản sạch POS kết hợp quản lý kho lạnh theo hạn sử dụng lô/date."
    },

    # --- NHÓM 4: TRANH CHẤP VÙNG MIỀN & VƯỢT THẨM QUYỀN (CỔNG 5 - TRƯỞNG PHÒNG KD DUYỆT) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-011"
        CreatedAt = "2026-11-15 09:10"
        Source = "Hội thảo Dệt may Việt Nam 2026"
        CompanyName = "Công ty Cổ phần May mặc & Xuất khẩu Tân Bình"
        TaxCode = "0107778899"
        ContactName = "Lê Hoàng Yến"
        Role = "Phó Tổng Giám đốc Vận hành"
        Phone = "0977665544"
        Email = "yen.lh@tanbinhgarment.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "420"
        Budget = "380"
        Need = "Trụ sở đăng ký tại Hà Nội (Miền Bắc) nhưng toàn bộ 2 xưởng dệt may 420 công nhân đặt tại Bình Dương (Miền Nam). Cần ERP quản lý kế hoạch sản xuất, kho vải và chấm công ca kíp."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-012"
        CreatedAt = "2026-11-15 15:40"
        Source = "Website namvietsoft.vn"
        CompanyName = "Tập đoàn Xây dựng & Cơ điện Hòa Bình Minh"
        TaxCode = "0103344556"
        ContactName = "Lê Trọng Tấn"
        Role = "Tổng Giám đốc (CEO)"
        Phone = "0912888999"
        Email = "tan.lt@hoabinhminhmep.vn"
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "520"
        Budget = "650"
        Need = "Ngân sách lớn 650 Triệu VNĐ. Cần triển khai ERP quản lý tiến độ 14 dự án công trình cơ điện, kiểm soát dòng tiền, quyết toán vật tư và quản lý 500 nhân sự kỹ sư."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-013"
        CreatedAt = "2026-11-16 13:30"
        Source = "Chiến dịch Email B2B"
        CompanyName = "Công ty Cổ phần Thương mại Điện tử Bách Khoa"
        TaxCode = "0104455661"
        ContactName = "Nguyễn Thanh Phong"
        Role = "Giám đốc Bán hàng"
        Phone = "0904332211"
        Email = "phong.nt@bachkhoatrade.vn"
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "110"
        Budget = "86"
        Need = "Có văn phòng đại diện tại TP.HCM và trụ sở chính Hà Nội, muốn triển khai hệ thống CRM quản lý đa kênh và nhân sự HRM liên vùng."
    },

    # --- NHÓM 5: KHÁCH HÀNG CŨ TRONG CRM (CRM HISTORY MATCHING - TRÁNH CƯỚP KHÁCH) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-014"
        CreatedAt = "2026-11-15 10:20"
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
        Need = "Khách hàng cũ đã từng ký HĐ NV-KETOAN với NVKD Phạm Quốc Bảo. Nay mở rộng thêm phân xưởng bao bì thứ 2, cần đầu tư thêm NV-ERP để quản lý kế hoạch sản xuất và kho hạt nhựa WMS."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-015"
        CreatedAt = "2026-11-15 13:40"
        Source = "Hội thảo Chuyển đổi số Mekong"
        CompanyName = "Công ty Cổ phần Dược phẩm Mekong"
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
        Need = "Khách hàng CRM cũ từng làm việc với NVKD Đặng Gia Huy. Cần nâng cấp hệ thống DMS phân phối thuốc và quản lý 60 trình dược viên theo định vị GPS."
    },

    # --- NHÓM 6: CÁC CA DOANH NGHIỆP CHUẨN PHÂN BỔ 5 SẢN PHẨM & 8 NVKD (CÂN BẰNG TẢI 3 MIỀN) ---
    [PSCustomObject]@{
        LeadId = "LD-RAW-016"
        CreatedAt = "2026-11-15 08:45"
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
        Need = "Cần triển khai phần mềm NV-ERP quản lý định mức BOM, kế hoạch sản xuất gia công cơ khí chính xác và tính giá thành chi tiết cho 220 công nhân."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-017"
        CreatedAt = "2026-11-15 09:30"
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
        Need = "Cần phần mềm NV-CRM chuyên sâu giáo dục: quản lý phễu phụ huynh đăng ký khóa học, phân bổ học viên thử việc cho tư vấn viên và nhắc đóng học phí tự động."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-018"
        CreatedAt = "2026-11-15 10:15"
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
        Need = "Triển khai phần mềm NV-HRM xếp lịch làm việc chia ca kíp xoay vòng cho 300 nhân viên phục vụ/bếp tại 12 nhà hàng, tính lương lũy tiến theo doanh thu bàn."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-019"
        CreatedAt = "2026-11-15 11:00"
        Source = "Hội thảo Bán lẻ Đa kênh 2026"
        CompanyName = "Công ty Cổ phần Chuỗi Thực phẩm Xanh GreenMart"
        TaxCode = "0105544332"
        ContactName = "Hoàng Thu Trang"
        Role = "Giám đốc Điều hành"
        Phone = "0989123456"
        Email = "trang.ht@greenmart.vn"
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "190"
        Budget = "240"
        Need = "Triển khai giải pháp NV-CRM & POS tích hợp thẻ thành viên tích điểm, xuất hóa đơn điện tử tự động và đồng bộ kho hàng 18 siêu thị mini."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-020"
        CreatedAt = "2026-11-15 11:45"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty TNHH Nhựa Kỹ thuật Tân Á Châu"
        TaxCode = "0201122338"
        ContactName = "Vũ Mạnh Hùng"
        Role = "Kế toán trưởng"
        Phone = "0918223344"
        Email = "hung.vm@tanachauplastic.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hải Phòng"
        Employees = "115"
        Budget = "85"
        Need = "Cần phần mềm NV-KETOAN chuyên sâu sản xuất: phân bổ chi phí gián tiếp, tính giá thành thành phẩm theo từng lô ép nhựa và xuất báo cáo tài chính chuẩn TT88/TT200."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-021"
        CreatedAt = "2026-11-15 14:00"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty CP Logistics & Kho bãi Miền Tây Trans"
        TaxCode = "0318899112"
        ContactName = "Trịnh Quốc Huy"
        Role = "Giám đốc Vận hành"
        Phone = "0908778899"
        Email = "huy.tq@mientaytrans.vn"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "Long An"
        Employees = "95"
        Budget = "120"
        Need = "Cần phần mềm NV-WMS quản lý 2 kho trung chuyển hàng nông sản tại Long An: quản lý vị trí bin-location, quét barcode mã QR qua PDA cầm tay."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-022"
        CreatedAt = "2026-11-15 14:40"
        Source = "Hội thảo Doanh nghiệp Trẻ Khánh Hòa"
        CompanyName = "Công ty TNHH Du lịch & Khách sạn Biển Xanh Nha Trang"
        TaxCode = "0403344556"
        ContactName = "Phan Thùy Linh"
        Role = "Giám đốc Vận hành"
        Phone = "0905445566"
        Email = "linh.pt@blueoceanhotel.vn"
        Industry = "Dịch vụ & F&B"
        Region = "Miền Trung"
        Province = "Khánh Hòa"
        Employees = "75"
        Budget = "65"
        Need = "Cần phần mềm NV-CRM chăm sóc khách hàng lưu trú, quản lý đặt phòng hội nghị và gửi tin nhắn chúc mừng sinh nhật ưu đãi qua Zalo OA."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-023"
        CreatedAt = "2026-11-15 15:20"
        Source = "Chiến dịch Facebook Ads Tháng 11"
        CompanyName = "Công ty TNHH Cung ứng Nhân lực & Giáo dục Quốc tế Thái Bình Dương"
        TaxCode = "0109988112"
        ContactName = "Lê Hồng Quang"
        Role = "Trưởng phòng Đào tạo"
        Phone = "0984112233"
        Email = "quang.lh@pacificedu.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "60"
        Budget = "75"
        Need = "Cần phần mềm NV-HRM chấm công vân tay, tính lương KPI cho giảng viên bản ngữ và quản lý hồ sơ du học sinh."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-024"
        CreatedAt = "2026-11-15 16:00"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty CP Chế biến Thủy hải sản Cà Mau Seafood"
        TaxCode = "0319988223"
        ContactName = "Nguyễn Văn Được"
        Role = "Giám đốc Kế hoạch"
        Phone = "0919223344"
        Email = "duoc.nv@camauseafood.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Nam"
        Province = "Cà Mau"
        Employees = "280"
        Budget = "290"
        Need = "Cần phần mềm NV-ERP tích hợp quản lý thu mua tôm cá nguyên liệu theo trọng lượng, cân điện tử kết nối máy tính, quản lý kho cấp đông WMS và kế toán xuất khẩu."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-025"
        CreatedAt = "2026-11-15 16:45"
        Source = "Hội thảo Chuyển đổi số Doanh nghiệp Đà Nẵng"
        CompanyName = "Công ty CP Dược & Thiết bị Y tế Miền Trung"
        TaxCode = "0405566778"
        ContactName = "Trần Bích Phương"
        Role = "Kế toán trưởng"
        Phone = "0905889900"
        Email = "phuong.tb@mientrungpharma.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Trung"
        Province = "Đà Nẵng"
        Employees = "90"
        Budget = "90"
        Need = "Cần phần mềm NV-KETOAN tích hợp hóa đơn điện tử và báo cáo công nợ nhà thuốc theo hạn mức tín dụng 30-60 ngày."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-026"
        CreatedAt = "2026-11-16 08:15"
        Source = "Chiến dịch Zalo Ads B2B"
        CompanyName = "Công ty TNHH Phân phối Nước giải khát Hưng Thịnh"
        TaxCode = "0108877119"
        ContactName = "Đỗ Cao Thắng"
        Role = "Giám đốc Thương mại"
        Phone = "0978998877"
        Email = "thang.dc@hungthinhbeverage.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "130"
        Budget = "115"
        Need = "Cần hệ thống NV-CRM & Quản lý bán hàng cho 35 NVKD thị trường đi tuyến, giám sát đơn hàng đại lý nước giải khát theo ngày."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-027"
        CreatedAt = "2026-11-16 09:00"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty TNHH Cà phê Ban Mê Gold"
        TaxCode = "0406677889"
        ContactName = "H'Hen Niê"
        Role = "Quản lý Trang trại & Nhà xưởng"
        Phone = "0905123789"
        Email = "hhen@banmegold.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Trung"
        Province = "Đắk Lắk"
        Employees = "110"
        Budget = "130"
        Need = "Cần phần mềm NV-ERP quản lý sơ chế cà phê, theo dõi độ ẩm hạt rang xay và xuất khẩu theo tiêu chuẩn UTZ/Fairtrade."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-028"
        CreatedAt = "2026-11-16 09:45"
        Source = "Hội chợ Thương mại Quốc tế Cần Thơ"
        CompanyName = "Hợp tác xã Nông sản Vàng Hậu Giang"
        TaxCode = "0315566771"
        ContactName = "Lê Hoàng Phúc"
        Role = "Chủ nhiệm HTX"
        Phone = "0939887766"
        Email = "phuc.lh@nongsanvang.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "Hậu Giang"
        Employees = "40"
        Budget = "55"
        Need = "Cần phần mềm NV-KETOAN đơn giản dễ dùng cho hợp tác xã nông sản, xuất hóa đơn điện tử cho siêu thị thu mua."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-029"
        CreatedAt = "2026-11-16 10:30"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty CP Thép Xây dựng Việt Ý (Chi nhánh Hải Dương)"
        TaxCode = "0102233449"
        ContactName = "Nguyễn Văn Toàn"
        Role = "Trưởng phòng Vật tư"
        Phone = "0982334455"
        Email = "toan.nv@vietyisaosteel.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hải Dương"
        Employees = "190"
        Budget = "210"
        Need = "Cần phần mềm NV-WMS quản lý kho bãi sắt thép nặng cuộn/cây, quản lý xe tải vào cân xuất hàng và đối chiếu phiếu cân tự động."
    },
    [PSCustomObject]@{
        LeadId = "LD-RAW-030"
        CreatedAt = "2026-11-16 11:15"
        Source = "Hội thảo Giải pháp Quản trị Nhân sự 2026"
        CompanyName = "Tập đoàn Bán lẻ Thời trang V-Fashion Group"
        TaxCode = "0317788990"
        ContactName = "Bùi Thu Thủy"
        Role = "Trưởng ban Tiền lương & Phúc lợi (C&B)"
        Phone = "0903998811"
        Email = "thuy.bt@vfashion.vn"
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "260"
        Budget = "160"
        Need = "Cần phần mềm NV-HRM chuyên sâu tính thưởng KPI doanh số cho 45 cửa hàng thời trang, quản lý đơn xin nghỉ phép qua ứng dụng di động."
    }
)

# Chuyển đổi danh sách sang chuỗi CSV chuẩn RFC-4180
$csvHeader = '"Mã Lead","Thời Gian Đăng Ký","Nguồn Tiếp Nhận","Tên Doanh Nghiệp","Mã Số Thuế","Người Liên Hệ","Chức Vụ","Số Điện Thoại","Email","Ngành Nghề","Khu Vực","Tỉnh Thành","Quy Mô Nhân Sự","Ngân Sách Dự Kiến (Triệu VNĐ)","Nhu Cầu Chi Tiết"'

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add($csvHeader)

foreach ($r in $leads) {
    # Xử lý an toàn dấu nháy kép bên trong chuỗi
    $safeNeed = $r.Need -replace '"', '""'
    $safeComp = $r.CompanyName -replace '"', '""'
    $safeContact = $r.ContactName -replace '"', '""'
    $safeSource = $r.Source -replace '"', '""'
    $safeRole = $r.Role -replace '"', '""'

    $rowStr = '"{0}","{1}","{2}","{3}","{4}","{5}","{6}","{7}","{8}","{9}","{10}","{11}","{12}","{13}","{14}"' -f `
        $r.LeadId, $r.CreatedAt, $safeSource, $safeComp, $r.TaxCode, $safeContact, $safeRole, `
        $r.Phone, $r.Email, $r.Industry, $r.Region, $r.Province, $r.Employees, $r.Budget, $safeNeed

    $lines.Add($rowStr)
}

$fullContent = [string]::Join("`r`n", $lines)

# Ghi tệp với Encoding UTF-8 có BOM để Microsoft Excel tiếng Việt không bị lỗi font
$utf8WithBom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText($targetPath, $fullContent, $utf8WithBom)

Write-Host "==================================================================" -ForegroundColor Green
Write-Host "✅ ĐÃ TẠO THÀNH CÔNG TỆP DỮ LIỆU THÔ CHƯA XỬ LÝ ĐỂ CHẠY THỬ!" -ForegroundColor Cyan
Write-Host " Đường dẫn tệp: $targetPath" -ForegroundColor Yellow
Write-Host " Tổng số dòng: $($lines.Count) (gồm 1 dòng tiêu đề và $($leads.Count) hồ sơ khách hàng thô)" -ForegroundColor White
Write-Host " Đặc tính kỹ thuật: CSV chuẩn UTF-8 with BOM, tương thích 100% Excel & Web" -ForegroundColor Gray
Write-Host "==================================================================" -ForegroundColor Green
