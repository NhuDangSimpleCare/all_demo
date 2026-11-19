# ==============================================================================
# SCRIPT TẠO TỆP DỮ LIỆU KHUYẾT THIẾU ĐỂ KIỂM THỬ AI AGENT & HỆ THỐNG
# Tên tệp: NamViet_DuLieuKhuyetThieu_TestDemo.csv & .json
# Thiết kế: Phản ánh trung thực các dạng khuyết thiếu thực tế B2B:
#   - WAITING_INFO (Khuyết Ngân sách, Quy mô, MST, Tỉnh thành)
#   - INVALID_LEAD (Khuyết toàn bộ liên hệ SĐT/Email, spam)
#   - ENTITY RESOLUTION (2 mảnh khuyết ghép thành 1 Golden Record hoàn chỉnh)
#   - READY_TO_ASSIGN (Ca đối chứng chuẩn 12 trường)
#   - Bẫy dữ liệu dị biệt (Chuỗi 'N/A', '0', định dạng số điện thoại lạ, tiếng lóng)
# ==============================================================================

$csvPath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\NamViet_DuLieuKhuyetThieu_TestDemo.csv"
$jsonPath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\NamViet_DuLieuKhuyetThieu_TestDemo.json"

$leads = @(
    # =========================================================================
    # NHÓM 1: CA WAITING_INFO (Khuyết thông tin phân loại -> AI sinh Zalo hỏi khéo < 50 từ)
    # =========================================================================
    [PSCustomObject]@{
        LeadId = "LD-MISS-001"
        CreatedAt = "2026-11-19 08:15"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty TNHH Cơ Khí Chính Xác Tân Phát"
        TaxCode = ""
        ContactName = "Nguyễn Văn Tuấn"
        Role = "Chủ xưởng"
        Phone = "0908123456"
        Email = "tuan.tp@tanphatmech.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Nam"
        Province = "Bình Dương"
        Employees = ""
        Budget = ""
        Need = "Tìm phần mềm quản lý phân xưởng cơ khí, kiểm soát tiến độ gia công và vật tư phôi thép tránh thất thoát."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Thiếu Ngân sách, Quy mô nhân sự, Mã số thuế"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-002"
        CreatedAt = "2026-11-19 08:45"
        Source = "Hội thảo Chuyển đổi số Y Dược 2026"
        CompanyName = "Hệ thống Nhà thuốc Phục Hưng"
        TaxCode = ""
        ContactName = "Dược sĩ Lan"
        Role = "Chủ chuỗi nhà thuốc"
        Phone = "0918345678"
        Email = "lan.phuchungpharma@gmail.com"
        Industry = "Giáo dục & Y tế"
        Region = ""
        Province = ""
        Employees = "35"
        Budget = ""
        Need = "Cần phần mềm quản lý 5 điểm bán thuốc, liên thông cổng Dược Quốc gia và xuất hóa đơn điện tử tự động."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Thiếu Ngân sách, Tỉnh thành, Khu vực, Mã số thuế"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-003"
        CreatedAt = "2026-11-19 09:10"
        Source = "Chiến dịch Email Marketing B2B"
        CompanyName = "Công ty Cổ phần Vận tải & Kho vận Miền Tây"
        TaxCode = "1801234567"
        ContactName = "Nguyễn Văn Hùng"
        Role = "Trưởng phòng Điều vận"
        Phone = ""
        Email = "hung.trans@mientaylog.com"
        Industry = "Logistics & Kho vận"
        Region = "Miền Nam"
        Province = "Cần Thơ"
        Employees = ""
        Budget = "120"
        Need = "Quản lý điều vận đội xe 25 đầu kéo container và quản lý kho hàng trung chuyển hàng hải sản xuất khẩu."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Có Email công ty nhưng thiếu Số điện thoại, thiếu Quy mô nhân sự"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-004"
        CreatedAt = "2026-11-19 09:30"
        Source = "Facebook Ads Khách Hàng Doanh Nghiệp"
        CompanyName = "Gốm Sứ Mỹ Nghệ Bát Tràng An Viên"
        TaxCode = ""
        ContactName = "Chị Hương"
        Role = ""
        Phone = "0934567890"
        Email = ""
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = ""
        Budget = ""
        Need = "Quan tâm muốn dùng thử phần mềm kế toán và bán hàng online."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Thiếu Ngân sách, Quy mô, Chức vụ, Email, Mã số thuế. Nhu cầu chung chung"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-005"
        CreatedAt = "2026-11-19 10:00"
        Source = "Google Search Ads B2B"
        CompanyName = "Công ty CP Thương mại Dịch vụ Tổng hợp Đại Dương"
        TaxCode = "0105678912"
        ContactName = "Anh Tuấn"
        Role = ""
        Phone = "0971234890"
        Email = "tuan.daiduong@gmail.com"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "40"
        Budget = "95"
        Need = "Cần chuyên viên liên hệ trực tiếp để tư vấn giải pháp chuyển đổi số."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Có Ngân sách 95M & Quy mô 40 nhưng Nhu cầu mơ hồ, thiếu Chức vụ"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-006"
        CreatedAt = "2026-11-19 10:20"
        Source = "Zalo OA Nam Việt Software"
        CompanyName = "Chuỗi Cà phê & Trà Sữa The Daily Cup"
        TaxCode = ""
        ContactName = "Trần Minh Đăng"
        Role = "Giám đốc Vận hành (COO)"
        Phone = "0909887766"
        Email = "dang.tran@dailycup.vn"
        Industry = "Dịch vụ & F&B"
        Region = ""
        Province = ""
        Employees = "65"
        Budget = "80"
        Need = "Cần giải pháp quản lý chấm công định vị GPS nhân viên part-time và quản lý định lượng nguyên vật liệu pha chế."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Thiếu Tỉnh thành & Khu vực (chưa xác định để chia NVKD), thiếu Mã số thuế"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-007"
        CreatedAt = "2026-11-19 10:45"
        Source = "Website namvietsoft.vn"
        CompanyName = "Xưởng In Bao Bì Offset Quang Minh"
        TaxCode = ""
        ContactName = "Bác Minh"
        Role = "Chủ xưởng"
        Phone = "0988665544"
        Email = ""
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hải Dương"
        Employees = "0"
        Budget = "0"
        Need = "Quản lý đơn hàng in ấn và hao hụt nguyên liệu giấy cuộn."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Ngân sách và Quy mô điền số 0 (khuyết thiếu thực tế), thiếu Email và MST"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-008"
        CreatedAt = "2026-11-19 11:00"
        Source = "Chiến dịch Email Marketing B2B"
        CompanyName = "Công ty TNHH Thiết bị Y Tế Nam An"
        TaxCode = "0316789012"
        ContactName = "Lê Phương Thảo"
        Role = ""
        Phone = ""
        Email = "thao.le@namanmed.com.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = ""
        Budget = "180"
        Need = "Cần phần mềm quản lý hạn sử dụng trang thiết bị y tế và hồ sơ thầu vật tư bệnh viện."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Thiếu Số điện thoại (chỉ có Email), thiếu Quy mô nhân sự và Chức vụ"
    },

    # =========================================================================
    # NHÓM 2: CA INVALID_LEAD (Thiếu hoàn toàn thông tin liên hệ Phone/Email -> Loại bỏ)
    # =========================================================================
    [PSCustomObject]@{
        LeadId = "LD-MISS-009"
        CreatedAt = "2026-11-19 11:15"
        Source = "Form đăng ký khảo sát trực tuyến"
        CompanyName = "Công ty TNHH Đầu tư & Phát triển Công nghệ Tân Á"
        TaxCode = "0109988776"
        ContactName = "Nguyễn Hải Đăng"
        Role = "Trưởng phòng Mua hàng"
        Phone = ""
        Email = ""
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "80"
        Budget = "200"
        Need = "Cần báo giá gấp hệ thống phần mềm ERP quản lý vật tư công trình."
        ExpectedFlag = "INVALID_LEAD"
        MissingNote = "MẤT TOÀN BỘ LIÊN HỆ: Cả Phone và Email đều trống -> Bắt buộc gắn cờ INVALID_LEAD"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-010"
        CreatedAt = "2026-11-19 11:30"
        Source = "Form Website Ẩn Danh"
        CompanyName = ""
        TaxCode = ""
        ContactName = "Khách vãng lai"
        Role = ""
        Phone = ""
        Email = ""
        Industry = ""
        Region = ""
        Province = ""
        Employees = ""
        Budget = ""
        Need = "Cho xem demo phần mềm nhân sự giá rẻ nhất."
        ExpectedFlag = "INVALID_LEAD"
        MissingNote = "Lead rác/spam: Không tên công ty, không SĐT, không Email"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-011"
        CreatedAt = "2026-11-19 11:45"
        Source = "Google Ads Form Lỗi"
        CompanyName = "Tập đoàn Xây dựng Địa Ốc Hưng Thịnh Phát"
        TaxCode = ""
        ContactName = "Người đại diện"
        Role = ""
        Phone = "---"
        Email = "N/A"
        Industry = "Bất động sản & Nội thất"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "250"
        Budget = "450"
        Need = "Tìm kiếm giải pháp ERP quản trị tiến độ dự án bất động sản."
        ExpectedFlag = "INVALID_LEAD"
        MissingNote = "Bẫy chuỗi rác: Phone là '---' và Email là 'N/A' (chuẩn hóa về null -> INVALID_LEAD)"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-012"
        CreatedAt = "2026-11-19 12:00"
        Source = "Website namvietsoft.vn"
        CompanyName = "test company dev"
        TaxCode = "0000000000"
        ContactName = "test"
        Role = "tester"
        Phone = "none"
        Email = "test@test"
        Industry = "Dịch vụ & F&B"
        Region = ""
        Province = ""
        Employees = "1"
        Budget = "1"
        Need = "asdfghjk 123456 test form lead"
        ExpectedFlag = "INVALID_LEAD"
        MissingNote = "Lead rác từ môi trường thử nghiệm / bot quét"
    },

    # =========================================================================
    # NHÓM 3: CA HỢP NHẤT HỒ SƠ KHUYẾT THIẾU (Entity Resolution & Enrichment)
    # Hai lead khuyết chéo nhau từ 1 công ty -> Gộp thành 1 Golden Record hoàn chỉnh!
    # =========================================================================
    [PSCustomObject]@{
        LeadId = "LD-MISS-013"
        CreatedAt = "2026-11-19 13:10"
        Source = "Hội thảo Công nghiệp Thép Hải Phòng"
        CompanyName = "Công ty Cổ phần Thép Việt Nhật"
        TaxCode = "0201122334"
        ContactName = "Vũ Tuấn Kiệt"
        Role = "Phó Giám đốc Kỹ thuật"
        Phone = "0904556677"
        Email = ""
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hải Phòng"
        Employees = "220"
        Budget = ""
        Need = "Cần module quản lý bảo trì bảo dưỡng thiết bị máy cán thép tự động."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Mảnh A: Có Phone PGĐ Kiệt + Quy mô 220, nhưng KHUYẾT Email và Ngân sách"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-014"
        CreatedAt = "2026-11-19 14:20"
        Source = "Website namvietsoft.vn"
        CompanyName = "Viet Nhat Steel JSC (Nhà máy Hải Phòng)"
        TaxCode = "0201122334"
        ContactName = "Nguyễn Mai Chi"
        Role = "Kế toán trưởng"
        Phone = ""
        Email = "chi.nm@vietnhatsteel.com.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hải Phòng"
        Employees = ""
        Budget = "380"
        Need = "Doanh nghiệp đã phê duyệt ngân sách 380 Triệu trong Quý 1/2027 để triển khai phân hệ Tài chính Kế toán và Kho."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Mảnh B: Trùng MST 0201122334, có Email Kế toán Chi + Ngân sách 380M, nhưng KHUYẾT Phone và Quy mô"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-015"
        CreatedAt = "2026-11-19 13:30"
        Source = "Triển lãm Y Dược Cần Thơ"
        CompanyName = "Công ty CP Dược Phẩm Á Âu (Chi nhánh Tây Nam Bộ)"
        TaxCode = ""
        ContactName = "Trần Quốc Bảo"
        Role = "Trưởng đại diện Chi nhánh"
        Phone = "0939112233"
        Email = "bao.tq@aaupharma.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "Cần Thơ"
        Employees = "45"
        Budget = ""
        Need = "Cần quản lý trình dược viên thị trường đi tuyến bằng định vị GPS trên điện thoại."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Mảnh C: Khuyết MST và Ngân sách, nhưng có corporate domain @aaupharma.vn"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-016"
        CreatedAt = "2026-11-19 15:00"
        Source = "Chiến dịch Email Marketing B2B"
        CompanyName = "Công ty Cổ phần Dược Phẩm Á Âu (Trụ sở chính)"
        TaxCode = "0309988771"
        ContactName = "Phạm Thu Thủy"
        Role = "Giám đốc Công nghệ Thông tin (CIO)"
        Phone = ""
        Email = "thuy.pt@aaupharma.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "320"
        Budget = "280"
        Need = "Triển khai hệ thống CRM quản lý nhà thuốc và chuỗi phân phối dược phẩm toàn quốc."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Mảnh D: Trùng tên miền corporate domain @aaupharma.vn -> Hợp nhất với Mảnh C"
    },

    # =========================================================================
    # NHÓM 4: CA ĐẦY ĐỦ ĐỐI CHỨNG (READY_TO_ASSIGN - 100% Đầy đủ 12 trường ICP)
    # =========================================================================
    [PSCustomObject]@{
        LeadId = "LD-MISS-017"
        CreatedAt = "2026-11-19 09:00"
        Source = "Hội thảo Dệt may Việt Nam 2026"
        CompanyName = "Công ty Cổ phần May mặc & Thời trang Thăng Long"
        TaxCode = "0101234567"
        ContactName = "Phạm Thu Hà"
        Role = "Giám đốc Nhân sự"
        Phone = "0913222333"
        Email = "ha.pt@thanglonggarment.vn"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "450"
        Budget = "350"
        Need = "Cần triển khai gấp phân hệ HRM chấm công ca kíp vân tay cho 450 công nhân may và tính lương sản phẩm tự động."
        ExpectedFlag = "READY_TO_ASSIGN"
        MissingNote = "ĐẦY ĐỦ 100%: 12 trường chuẩn, đúng chuẩn ICP B2B Nam Việt, sẵn sàng giao ngay NVKD"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-018"
        CreatedAt = "2026-11-19 09:40"
        Source = "Website namvietsoft.vn"
        CompanyName = "Công ty TNHH Phân Phối Hóa Chất Sài Gòn"
        TaxCode = "0312456789"
        ContactName = "Lê Hoàng Long"
        Role = "Trưởng phòng Kinh doanh"
        Phone = "0908776655"
        Email = "long.lh@sgchem.vn"
        Industry = "Thương mại & Phân phối"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = "85"
        Budget = "140"
        Need = "Cần phần mềm NV-CRM quản lý đơn hàng B2B hóa chất, theo dõi công nợ khách hàng và nhắc tái ký hợp đồng tự động."
        ExpectedFlag = "READY_TO_ASSIGN"
        MissingNote = "ĐẦY ĐỦ 100%: Đầy đủ thông tin, ngân sách 140M phù hợp NV-CRM"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-019"
        CreatedAt = "2026-11-19 10:15"
        Source = "Hội chợ Xây dựng Vietbuild Đà Nẵng"
        CompanyName = "Công ty Cổ phần Cơ Khí Xây Dựng Đà Nẵng"
        TaxCode = "0400567890"
        ContactName = "Nguyễn Quốc Dũng"
        Role = "Tổng Giám đốc"
        Phone = "0905333444"
        Email = "dung.nq@danangmech.vn"
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Trung"
        Province = "Đà Nẵng"
        Employees = "160"
        Budget = "240"
        Need = "Cần phần mềm quản lý kế hoạch sản xuất gia công kết cấu thép nhà tiền chế và quản lý hồ sơ nghiệm thu vật tư."
        ExpectedFlag = "READY_TO_ASSIGN"
        MissingNote = "ĐẦY ĐỦ 100%: Đúng địa bàn Miền Trung, khớp NVKD Phạm Quốc Bảo"
    },

    # =========================================================================
    # NHÓM 5: CA BẪY DỮ LIỆU DỊ BIỆT (Text traps, định dạng lạ, tiếng lóng)
    # =========================================================================
    [PSCustomObject]@{
        LeadId = "LD-MISS-020"
        CreatedAt = "2026-11-19 11:10"
        Source = "Facebook Ads Khách Hàng Doanh Nghiệp"
        CompanyName = "Cơ sở Chế biến Hải sản Đông Lạnh Cô Tô"
        TaxCode = "chưa có (hộ cá thể)"
        ContactName = "Anh Tuân"
        Role = "Chủ hộ kinh doanh"
        Phone = "0942111222"
        Email = "tuan.coto@gmail.com"
        Industry = "Sản xuất & Chế biến"
        Region = "Miền Bắc"
        Province = "Quảng Ninh"
        Employees = "chưa tính thời vụ"
        Budget = "0"
        Need = "Cần phần mềm theo dõi tồn kho đông lạnh tôm mực và công nợ bạn thuyền."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Bẫy dữ liệu text: MST 'hộ cá thể', Quy mô 'chưa tính thời vụ', Ngân sách '0' -> Chuẩn hóa null"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-021"
        CreatedAt = "2026-11-19 11:35"
        Source = "Zalo OA Nam Việt Software"
        CompanyName = "Chuỗi Cửa Hàng Thời Trang Eva Boutique"
        TaxCode = "N/A"
        ContactName = "Chị Thúy"
        Role = "Quản lý chuỗi"
        Phone = "(+84) 93.888.9999"
        Email = "eva.boutique.hanoi@gmail.com"
        Industry = "Bán lẻ & Chuỗi"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "18 nhân sự bán hàng"
        Budget = "tầm 50-70 củ"
        Need = "Muốn quản lý tồn kho quần áo theo màu sắc, size số cho 4 cửa hàng và bán hàng đa kênh Shopee/Tiktok."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Bẫy SĐT có format lạ (+84, dấu chấm), Ngân sách dùng tiếng lóng '50-70 củ' -> AI cần chuẩn hóa số"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-022"
        CreatedAt = "2026-11-19 14:05"
        Source = "Website namvietsoft.vn"
        CompanyName = "   Công ty TNHH Năng Lượng Xanh GreenSolar   "
        TaxCode = "0315556677"
        ContactName = "Hoàng Trọng Nghĩa"
        Role = "Kỹ sư trưởng"
        Phone = "0903-456-789"
        Email = "nghia.ht@greensolar.vn"
        Industry = "Xây dựng & Kỹ thuật"
        Region = "Miền Nam"
        Province = "TP.HCM"
        Employees = ""
        Budget = ""
        Need = "Cần phần mềm theo dõi lịch bảo dưỡng tấm pin mặt trời và theo dõi hợp đồng cung ứng điện mặt trời áp mái."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "Tên công ty có khoảng trắng thừa, SĐT có gạch nối, KHUYẾT Ngân sách và Quy mô"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-023"
        CreatedAt = "2026-11-19 14:40"
        Source = "Hội thảo Giáo dục Kỷ nguyên Số"
        CompanyName = "Hệ thống Trường Mầm Non Song Ngữ Wonderland"
        TaxCode = ""
        ContactName = "Cô Trang"
        Role = "Hiệu trưởng"
        Phone = "0989123789"
        Email = "trang.wonderland@gmail.com"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Bắc"
        Province = "Hà Nội"
        Employees = "32 giáo viên"
        Budget = ""
        Need = "Quản lý điểm danh học sinh mầm non, thu học phí và gửi thông báo sổ liên lạc điện tử cho phụ huynh."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "KHUYẾT Ngân sách dự kiến và Mã số thuế"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-024"
        CreatedAt = "2026-11-19 15:20"
        Source = "Google Search Ads B2B"
        CompanyName = "Phòng Khám Đa Khoa Quốc Tế An Tâm"
        TaxCode = "0318999888"
        ContactName = ""
        Role = "Bộ phận Lễ tân & Chăm sóc khách hàng"
        Phone = "0915667788"
        Email = "cskh@antamclinic.vn"
        Industry = "Giáo dục & Y tế"
        Region = "Miền Nam"
        Province = "Đồng Nai"
        Employees = ""
        Budget = "260"
        Need = "Triển khai phần mềm quản lý hồ sơ bệnh án điện tử EMR và nhắc lịch hẹn tái khám tự động qua SMS/Zalo."
        ExpectedFlag = "WAITING_INFO"
        MissingNote = "KHUYẾT Tên người liên hệ cụ thể (chỉ có bộ phận), KHUYẾT Quy mô nhân sự"
    },
    [PSCustomObject]@{
        LeadId = "LD-MISS-025"
        CreatedAt = "2026-11-19 15:45"
        Source = "Website namvietsoft.vn"
        CompanyName = "Nguyễn Văn Nam (Cá nhân)"
        TaxCode = ""
        ContactName = "Nguyễn Văn Nam"
        Role = "Tự do"
        Phone = "0900000000"
        Email = "nam.nguyen999@yahoo.com"
        Industry = "Dịch vụ & F&B"
        Region = ""
        Province = ""
        Employees = ""
        Budget = ""
        Need = "Xin tài liệu tham khảo tính năng phần mềm kế toán."
        ExpectedFlag = "INVALID_LEAD"
        MissingNote = "SĐT ảo '0900000000', không có pháp nhân doanh nghiệp, nhu cầu không mua hàng -> Gắn cờ INVALID_LEAD"
    }
)

# Tạo nội dung CSV chuẩn UTF-8 có BOM
$lines = [System.Collections.Generic.List[string]]::new()
$header = '"Mã Lead","Thời Gian Đăng Ký","Nguồn Tiếp Nhận","Tên Doanh Nghiệp","Mã Số Thuế","Người Liên Hệ","Chức Vụ","Số Điện Thoại","Email","Ngành Nghề","Khu Vực","Tỉnh Thành","Quy Mô Nhân Sự","Ngân Sách Dự Kiến (Triệu VNĐ)","Nhu Cầu Chi Tiết","Trạng Thái Kỳ Vọng","Ghi Chú Khuyết Thiếu"'
$lines.Add($header)

foreach ($r in $leads) {
    $safeNeed = ($r.Need -replace '"', '""')
    $safeComp = ($r.CompanyName -replace '"', '""')
    $safeContact = ($r.ContactName -replace '"', '""')
    $safeSource = ($r.Source -replace '"', '""')
    $safeRole = ($r.Role -replace '"', '""')
    $safeNote = ($r.MissingNote -replace '"', '""')

    $rowStr = '"{0}","{1}","{2}","{3}","{4}","{5}","{6}","{7}","{8}","{9}","{10}","{11}","{12}","{13}","{14}","{15}","{16}"' -f `
        $r.LeadId, $r.CreatedAt, $safeSource, $safeComp, $r.TaxCode, $safeContact, $safeRole, `
        $r.Phone, $r.Email, $r.Industry, $r.Region, $r.Province, $r.Employees, $r.Budget, $safeNeed, $r.ExpectedFlag, $safeNote

    $lines.Add($rowStr)
}

$fullContent = [string]::Join("`r`n", $lines)
$utf8WithBom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText($csvPath, $fullContent, $utf8WithBom)

# Xuất thêm tệp JSON chuẩn hóa
$jsonContent = $leads | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText($jsonPath, $jsonContent, [System.Text.Encoding]::UTF8)

Write-Host "==================================================================" -ForegroundColor Green
Write-Host "DA TAO THANH CONG BO TEP DU LIEU KHUYET THIEU DE TEST AI AGENT!" -ForegroundColor Cyan
Write-Host " TEP CSV (Excel & Web): $csvPath" -ForegroundColor Yellow
Write-Host " TEP JSON (API & Prompt): $jsonPath" -ForegroundColor Yellow
Write-Host " Tong so ca: $($leads.Count) leads" -ForegroundColor White
Write-Host "==================================================================" -ForegroundColor Green
