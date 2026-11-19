$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# 1. Update downloadReportMarkdown Section 4 & 5
$targetMd = @'
## 4. MA TRẬN PHÂN BỔ 8 NHÂN VIÊN KINH DOANH & CAM KẾT SLA
| NVKD | Khu Vực | Ngành Trọng Điểm | Hạn Mức NS | Lead Được Giao | Tỷ Lệ Tải |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Nguyễn Minh Tuấn** | Hà Nội (MB) | Sản xuất & Bán buôn | ≤ 250M | 58 lead | 90,6% |
| **Trần Thu Hà** | Hà Nội (MB) | Dịch vụ & Bán lẻ | ≤ 150M | 54 lead | 84,4% |
| **Lê Hoàng Nam** | Bắc Ninh / Hải Dương | Chế tạo & Xuất nhập khẩu | ≤ 150M | 50 lead | 78,1% |
| **Phạm Quốc Bảo** | Đà Nẵng (MT) | Du lịch & Thương mại | ≤ 120M | 46 lead | 71,9% |
| **Vũ Thị Ngọc Ánh** | Khánh Hòa / Tây Nguyên | Nông sản & Dịch vụ | ≤ 100M | 42 lead | 65,6% |
| **Đặng Gia Huy** | TP.HCM (MN) | Bán lẻ chuỗi & F&B | ≤ 300M | 64 lead | 92,0% |
| **Bùi Mai Phương** | TP.HCM (MN) | Dịch vụ & Logistics | ≤ 200M | 60 lead | 88,2% |
| **Đỗ Văn Trọng** | Bình Dương / Đồng Nai | KCN & Kho vận | ≤ 200M | 56 lead | 87,5% |

---

## 5. 5 ĐỀ XUẤT KINH DOANH CHIẾN LƯỢC CHO NAM VIỆT SOFT
1. **Chuẩn hóa tiếp nhận & hợp nhất Golden Record tự động mỗi sáng thứ Hai** *(Ưu tiên Cao)*: Bắt buộc import lead qua AI Agent trước 8h30 sáng; không chuyển file thô cho NVKD.
2. **Thực thi nghiêm ngặt SLA 15 phút cho 112 Lead P1 (Hot Leads)** *(Ưu tiên Cao)*: Gọi ngay trong 15 phút; nếu quá 30 phút tự động chuyển cơ hội cho NVKD khác cùng địa bàn.
3. **Khai thác 100% Bản nháp tiếp cận AI sinh sẵn cho 84 hồ sơ thiếu thông tin** *(Ưu tiên Vừa)*: Dùng kịch bản Zalo 3 câu để khảo sát nhẹ nhàng, khôi phục ~30 cơ hội hợp lệ/tuần.
4. **Đào tạo NVKD nhận biết và chuyển hướng khéo léo 48 ca lệch sản phẩm** *(Ưu tiên Vừa)*: Kết nối đối tác uy tín cho các nhu cầu Core Banking/CAD, đồng thời bán chéo module ERP Nam Việt.
5. **Thiết lập giao ban điều phối tuần qua Bảng Audit Log cho Trưởng phòng KD** *(Ưu tiên Cao)*: Phê duyệt dứt điểm 14 ca vượt thẩm quyền trong vòng 4 giờ làm việc.
'@

$replaceMd = @'
## 4. MA TRẬN PHÂN HẠNG TIỀM NĂNG & CAM KẾT SLA KHAI THÁC
| Phân Hạng | Số Lượng Lead | Doanh Thu Dự Kiến | Cam Kết SLA | Kịch Bản Khai Thác Khuyến Nghị |
| :--- | :--- | :--- | :--- | :--- |
| **P1 - Hot Leads** | 112 doanh nghiệp | 7.850.000.000 VNĐ | 15 Phút - 4 Giờ | Gọi điện trực tiếp & Khảo sát Demo giải pháp chuyên sâu |
| **P2 - Warm Leads** | 188 doanh nghiệp | 5.620.000.000 VNĐ | Trong vòng 24 Giờ | Gửi bộ tài liệu tính năng, case study ngành & khảo sát online |
| **P3 - Cold Leads** | 108 doanh nghiệp | 2.950.000.000 VNĐ | Trong vòng 48 Giờ | Nurturing tự động qua email marketing & webinar hàng tháng |
| **P4 - Non-fit (Loại trừ)** | 48 dự án | 0 VNĐ (Ảo) | Miễn trừ | Gửi thư cảm ơn tự động, giới thiệu đối tác ngoài hoặc lưu kho |

---

## 5. 5 ĐỀ XUẤT KINH DOANH CHIẾN LƯỢC CHO NAM VIỆT SOFT
1. **Chuẩn hóa tiếp nhận & hợp nhất Golden Record tự động mỗi sáng thứ Hai** *(Ưu tiên Cao)*: Bắt buộc import lead qua AI Agent trước 8h30 sáng để làm sạch và khử trùng tự động.
2. **Thực thi nghiêm ngặt SLA phản hồi cho 112 Lead P1 (Hot Leads)** *(Ưu tiên Cao)*: Tiếp cận trong vòng 15 phút - 4 giờ để tối đa hóa tỷ lệ chốt hợp đồng trị giá cao.
3. **Khai thác 100% Bản nháp tiếp cận AI sinh sẵn cho 84 hồ sơ thiếu thông tin** *(Ưu tiên Vừa)*: Dùng kịch bản Zalo 3 câu để khảo sát nhẹ nhàng, khôi phục ~30 cơ hội hợp lệ/tuần.
4. **Nhận biết và chuyển hướng khéo léo 48 ca lệch sản phẩm** *(Ưu tiên Vừa)*: Kết nối đối tác uy tín cho các nhu cầu Core Banking/CAD, đồng thời bán chéo module ERP Nam Việt.
5. **Thiết lập giao ban điều phối tuần qua Bảng Audit Log cho Trưởng phòng KD** *(Ưu tiên Cao)*: Phê duyệt dứt điểm các ca rủi ro vượt thẩm quyền trong vòng 4 giờ làm việc.
'@

$content = $content.Replace($targetMd.Trim(), $replaceMd.Trim())
$content = $content.Replace($targetMd.Replace("`r`n", "`n").Trim(), $replaceMd.Replace("`r`n", "`n").Trim())

# 2. Update renderExecutiveReport Section 8 & 9
$targetExecSec8_9 = @'
    <!-- MỤC 8: ĐỀ XUẤT PHÂN CÔNG & CÂN BẰNG TẢI 8 NVKD -->
    <div class="doc-section">
      <div class="doc-section-title">
        <span>8.</span>
        <span>ĐỀ XUẤT PHÂN CÔNG & CÂN BẰNG TẢI CÔNG VIỆC 8 NVKD</span>
      </div>
      <p>
        Thuật toán phân công ưu tiên dựa trên 5 cấp độ: 
        <em>(1) Khách cũ CRM (+45đ) &rarr; (2) Đúng Khu vực/Tỉnh (+30đ) &rarr; (3) Đúng Ngành (+20đ) &rarr; (4) Đúng Chuyên môn (+20đ) &rarr; (5) Tải công việc còn trống (+15đ max)</em>.
      </p>
      <div class="table-responsive" style="margin:14px 0;">
        <table class="data-table">
          <thead>
            <tr>
              <th>Mã NVKD</th>
              <th>Họ Tên</th>
              <th>Khu Vực Phụ Trách</th>
              <th>Ngành Trọng Điểm</th>
              <th>Hạn Mức Ngân Sách</th>
              <th>Được Giao</th>
              <th>Tải Hiện Tại / Tuần</th>
              <th>Tỷ Lệ Tải</th>
            </tr>
          </thead>
          <tbody>
            ${res.repStats.map(r => {
              const totalActive = r.currentLoad + r.assignedCount;
              const pct = Math.round((totalActive / r.weeklyCapacity) * 100);
              return `
                <tr>
                  <td><code>${r.id}</code></td>
                  <td><strong>${r.name}</strong></td>
                  <td>${r.region}</td>
                  <td>${r.industries[0]}</td>
                  <td>&le; ${r.maxBudgetAuthority}M VNĐ</td>
                  <td><strong style="color:#ff477e;">${r.assignedCount}</strong> lead</td>
                  <td>${totalActive} / ${r.weeklyCapacity}</td>
                  <td>
                    <span class="pill ${pct > 90 ? "pill-hot" : pct > 70 ? "pill-warm" : "pill-normal"}">
                      ${pct}% ${pct > 100 ? "(Quá tải)" : ""}
                    </span>
                  </td>
                </tr>
              `;
            }).join("")}
          </tbody>
        </table>
      </div>
      <p style="font-size:13px;color:#64748b;">
        * Nhờ tích hợp điểm cộng tải công việc còn trống, không có tình trạng NVKD bị quá tải trong khi người khác ngồi không. Tải công việc toàn đội đạt mức cân bằng tối ưu.
      </p>
    </div>

    <!-- MỤC 9: KIỂM SOÁT TRANH CHẤP VÙNG MIỀN & VƯỢT THẨM QUYỀN -->
    <div class="doc-section">
      <div class="doc-section-title">
        <span>9.</span>
        <span>KIỂM SOÁT TRANH CHẤP VÙNG MIỀN & VƯỢT THẨM QUYỀN (RISK ESCALATION)</span>
      </div>
      <p>
        Hệ thống tự động kích hoạt cờ <code>requiresManagerApproval = true</code> và đưa vào Hàng đợi Trưởng phòng Kinh doanh nếu vi phạm 1 trong 3 điều kiện:
      </p>
      <ul style="margin:6px 0 12px 24px;line-height:1.7;">
        <li><strong>Tranh chấp vùng miền:</strong> Doanh nghiệp có từ 2 chi nhánh ở các miền khác nhau cùng đăng ký.</li>
        <li><strong>Chồng chéo sở hữu CRM:</strong> Khách cũ của NVKD miền này nhưng chi nhánh mới lại nằm ở địa bàn của NVKD miền khác.</li>
        <li><strong>Vượt thẩm quyền ngân sách (budget &gt; maxBudgetAuthority):</strong> Dự án quy mô lớn vượt trần hạn mức tự quyết của NVKD được đề xuất.</li>
      </ul>
      <div class="doc-highlight-box">
        Ghi nhận <strong>${m.managerEscalationsCount} trường hợp</strong> cần Trưởng phòng Kinh doanh xét duyệt trước khi chốt giao việc. Việc này ngăn chặn 100% rủi ro tranh chấp hoa hồng nội bộ và bảo đảm các dự án trọng điểm được NVKD cấp cao (Senior / Lead) phụ trách.
      </div>
    </div>
'@

$replaceExecSec8_9 = @'
    <!-- MỤC 8: MA TRẬN PHÂN LOẠI & THỨ TỰ ƯU TIÊN KHAI THÁC THỰC THỂ -->
    <div class="doc-section">
      <div class="doc-section-title">
        <span>8.</span>
        <span>MA TRẬN PHÂN LOẠI & THỨ TỰ ƯU TIÊN KHAI THÁC THỰC THỂ (PIPELINE EXECUTION)</span>
      </div>
      <p>
        Hệ thống phân cấp thứ tự ưu tiên tiếp cận dựa trên 4 phân hạng ICP chuẩn hóa kết hợp cam kết SLA thời gian thực:
      </p>
      <div class="table-responsive" style="margin:14px 0;">
        <table class="data-table">
          <thead>
            <tr>
              <th>Phân Hạng Lead</th>
              <th>Số Lượng Hồ Sơ</th>
              <th>Tỷ Trọng Pipeline</th>
              <th>Cam Kết SLA</th>
              <th>Phương Thức Tiếp Cận Khuyến Nghị</th>
              <th>Mức Độ Sẵn Sàng</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><span class="pill pill-hot">🔥 P1 - Hot Leads</span></td>
              <td><strong>204</strong> doanh nghiệp</td>
              <td>11.800.000.000 VNĐ (64,1%)</td>
              <td><strong style="color:#ef4444;">15 Phút - 4 Giờ</strong></td>
              <td>Gọi điện trực tiếp & Khảo sát Demo giải pháp chuyên sâu</td>
              <td><span class="pill pill-hot">Ưu tiên cao nhất</span></td>
            </tr>
            <tr>
              <td><span class="pill pill-warm">⚡ P2 - Warm Leads</span></td>
              <td><strong>188</strong> doanh nghiệp</td>
              <td>4.920.000.000 VNĐ (26,7%)</td>
              <td><strong style="color:#f59e0b;">Trong vòng 24 Giờ</strong></td>
              <td>Gửi bộ tài liệu tính năng, case study ngành & khảo sát online</td>
              <td><span class="pill pill-warm">Đang nuôi dưỡng</span></td>
            </tr>
            <tr>
              <td><span class="pill pill-normal">❄️ P3 - Cold Leads</span></td>
              <td><strong>108</strong> doanh nghiệp</td>
              <td>1.700.000.000 VNĐ (9,2%)</td>
              <td><strong style="color:#3b82f6;">Trong vòng 48 Giờ</strong></td>
              <td>Gửi email marketing tự động & mời tham dự webinar hàng tháng</td>
              <td><span class="pill pill-normal">Chăm sóc tự động</span></td>
            </tr>
            <tr>
              <td><span class="pill" style="background:#334155; color:#94a3b8;">🚫 P4 - Non-fit (Loại trừ)</span></td>
              <td><strong>38</strong> dự án</td>
              <td>0 VNĐ (Bẫy ngân sách ảo)</td>
              <td>Miễn trừ SLA</td>
              <td>Gửi thư cảm ơn tự động, giới thiệu đối tác ngoài hoặc lưu kho</td>
              <td><span class="pill" style="background:#334155; color:#94a3b8;">Đã loại trừ</span></td>
            </tr>
          </tbody>
        </table>
      </div>
      <p style="font-size:13px;color:#64748b;">
        * 100% hồ sơ sau khi qua Cổng 3 và Cổng 5 đều được định tuyến vào đúng luồng quy trình tác vụ tương ứng, triệt tiêu nguy cơ bỏ sót cơ hội kinh doanh.
      </p>
    </div>

    <!-- MỤC 9: KIỂM SOÁT TRANH CHẤP DỮ LIỆU & PHÊ DUYỆT CỔNG 5 (HUMAN REVIEW) -->
    <div class="doc-section">
      <div class="doc-section-title">
        <span>9.</span>
        <span>KIỂM SOÁT RỦI RO & PHÊ DUYỆT CỔNG 5 (HUMAN-IN-THE-LOOP AUDIT)</span>
      </div>
      <p>
        Hệ thống tự động kích hoạt cờ <code>requiresManagerApproval = true</code> và đưa vào Hàng đợi Trưởng phòng Kinh doanh nếu vi phạm 1 trong các điều kiện kiểm soát:
      </p>
      <ul style="margin:6px 0 12px 24px;line-height:1.7;">
        <li><strong>Chồng chéo lịch sử CRM:</strong> Khách hàng đã có giao dịch trước đó hoặc có chi nhánh đăng ký từ nhiều tỉnh thành khác nhau.</li>
        <li><strong>Vượt hạn mức ngân sách (> 200 triệu VNĐ):</strong> Dự án quy mô lớn cần phê duyệt cấp quản lý trước khi triển khai tiếp cận.</li>
        <li><strong>Dữ liệu khuyết thiếu trường trọng yếu:</strong> Hồ sơ thiếu ngân sách hoặc quy mô nhân sự cần phê duyệt kịch bản Zalo trước khi gửi.</li>
      </ul>
      <div class="doc-highlight-box">
        Ghi nhận <strong>${m.managerEscalationsCount} trường hợp</strong> cần Trưởng phòng Kinh doanh xét duyệt trước khi xác nhận quy trình. Việc này bảo đảm 100% kiểm soát chất lượng và an toàn thông tin doanh nghiệp.
      </div>
    </div>
'@

$content = $content.Replace($targetExecSec8_9.Trim(), $replaceExecSec8_9.Trim())
$content = $content.Replace($targetExecSec8_9.Replace("`r`n", "`n").Trim(), $replaceExecSec8_9.Replace("`r`n", "`n").Trim())

# Update Section 10 items
$content = $content.Replace("Yêu cầu 8 NVKD tuân thủ nghiêm ngặt SLA phản hồi trong 15 phút.", "Tuân thủ nghiêm ngặt SLA phản hồi trong 15 phút đến 4 giờ.")
$content = $content.Replace("để chỉ định NVKD chính thức, không để khách hàng phải chờ đợi phân công.", "để phê duyệt phương án tiếp cận chính thức, không để khách hàng phải chờ đợi lâu.")

# 3. Update executeReportAction
$oldExecAction = @'
window.executeReportAction = function(actionType) {
  if (actionType === 'reach_p1_leads') {
    showToast("🎯 <strong>Đã áp dụng Đề xuất 1:</strong> Giao việc tiếp cận Top 58 Doanh nghiệp P1 cho Tuấn, Phương, Trọng với SLA 15 phút!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-customers'), 800);
  } else if (actionType === 'expand_seminar') {
    showToast("🚀 <strong>Đã áp dụng Đề xuất 2:</strong> Lập kế hoạch mở rộng Hội thảo Chuyển đổi số Quý II/2026 (+20% ngân sách)!");
  } else if (actionType === 'zalo_incomplete_outreach' || actionType === 'send_18_zalo_drafts') {
    showToast("🛡️ <strong>Đã áp dụng Đề xuất 3:</strong> Kích hoạt tự động gửi tin Zalo Official Account thu thập dữ liệu khách hàng!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-review'), 800);
  } else if (actionType === 'rebalance_sales_load') {
    showToast("⚖️ <strong>Đã áp dụng Đề xuất 4:</strong> Tái cân bằng tải cho Đội Sales Miền Nam, điều chuyển tạm thời 2 NVKD hỗ trợ!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-sales'), 800);
  } else if (actionType === 'enforce_gate3_tax_check') {
    showToast("🔒 <strong>Đã áp dụng Đề xuất 5:</strong> Bật xác thực OTP SMS và API tra cứu Tổng Cục Thuế thời gian thực tại Cổng 3!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-import'), 800);
  } else if (actionType === 'offline_sales') {
    showToast("🎯 <strong>Đã áp dụng Đề xuất 1:</strong> Phân bổ 3 NVKD (Tuấn, Hạnh, Dũng) chuyên trách thị trường offline & tăng hạn mức lưu kho!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-sales'), 800);
  } else if (actionType === 'website_cro') {
    showToast("🚀 <strong>Đã áp dụng Đề xuất 2:</strong> Kích hoạt bộ combo bán chéo (NV-ERP + NV-CRM) và kịch bản tăng AOV lên > 650.000 VND!");
  } else if (actionType === 'fix_missing_channel') {
    showToast("🛡️ <strong>Đã áp dụng Đề xuất 3:</strong> AI Cổng 3 đã quét 20 dòng và gắn thẻ kênh thành công cho khoản 15.500.000 VND (Để trống)!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-import'), 800);
  } else if (actionType === 'search_campaign' || actionType === 'scale_search_ads') {
    showToast("🔍 <strong>Đã áp dụng Đề xuất 4:</strong> Tạm dừng từ khóa broad match chi phí cao; tăng ngân sách cho từ khóa chuyển đổi cao!");
  } else if (actionType === 'cost_negotiation') {
    showToast("📈 <strong>Đã áp dụng Đề xuất 5:</strong> Tạo dự thảo đàm phán chiết khấu bậc thang (Volume Rebate) giảm 4.2% giá vốn với nhà cung ứng!");
  } else {
    showToast("✅ <strong>Đã phê duyệt đề xuất:</strong> Hệ thống AI Agent đã kích hoạt tác vụ thành công!");
  }
};
'@

$newExecAction = @'
window.executeReportAction = function(actionType) {
  if (actionType === 'reach_p1_leads') {
    showToast("🎯 <strong>Đã áp dụng Đề xuất 1:</strong> Ưu tiên tiếp cận Top 58 Doanh nghiệp P1 với cam kết SLA 15 phút - 4 giờ!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-customers'), 800);
  } else if (actionType === 'expand_seminar') {
    showToast("🚀 <strong>Đã áp dụng Đề xuất 2:</strong> Lập kế hoạch mở rộng Hội thảo Chuyển đổi số Quý II/2026 (+20% ngân sách)!");
  } else if (actionType === 'zalo_incomplete_outreach' || actionType === 'send_18_zalo_drafts') {
    showToast("🛡️ <strong>Đã áp dụng Đề xuất 3:</strong> Kích hoạt tự động gửi tin Zalo Official Account thu thập dữ liệu khách hàng!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-review'), 800);
  } else if (actionType === 'rebalance_sales_load') {
    showToast("🎯 <strong>Đã áp dụng Đề xuất 4:</strong> Kích hoạt chiến dịch tiếp cận trọng điểm Miền Nam theo định ngạch SLA!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-customers'), 800);
  } else if (actionType === 'enforce_gate3_tax_check') {
    showToast("🔒 <strong>Đã áp dụng Đề xuất 5:</strong> Bật xác thực OTP SMS và API tra cứu Tổng Cục Thuế thời gian thực tại Cổng 3!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-import'), 800);
  } else if (actionType === 'offline_sales') {
    showToast("🎯 <strong>Đã áp dụng Đề xuất 1:</strong> Tối ưu hóa phân phối thị trường offline & tăng hạn mức lưu kho!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-customers'), 800);
  } else if (actionType === 'website_cro') {
    showToast("🚀 <strong>Đã áp dụng Đề xuất 2:</strong> Kích hoạt bộ combo bán chéo (NV-ERP + NV-CRM) và kịch bản tăng AOV lên > 650.000 VND!");
  } else if (actionType === 'fix_missing_channel') {
    showToast("🛡️ <strong>Đã áp dụng Đề xuất 3:</strong> AI Cổng 3 đã quét 20 dòng và gắn thẻ kênh thành công cho khoản 15.500.000 VND (Để trống)!");
    if (typeof switchNavSection === 'function') setTimeout(() => switchNavSection('sec-import'), 800);
  } else if (actionType === 'search_campaign' || actionType === 'scale_search_ads') {
    showToast("🔍 <strong>Đã áp dụng Đề xuất 4:</strong> Tạm dừng từ khóa broad match chi phí cao; tăng ngân sách cho từ khóa chuyển đổi cao!");
  } else if (actionType === 'cost_negotiation') {
    showToast("📈 <strong>Đã áp dụng Đề xuất 5:</strong> Tạo dự thảo đàm phán chiết khấu bậc thang (Volume Rebate) giảm 4.2% giá vốn với nhà cung ứng!");
  } else {
    showToast("✅ <strong>Đã phê duyệt đề xuất:</strong> Hệ thống AI Agent đã kích hoạt tác vụ thành công!");
  }
};
'@

$content = $content.Replace($oldExecAction.Trim(), $newExecAction.Trim())
$content = $content.Replace($oldExecAction.Replace("`r`n", "`n").Trim(), $newExecAction.Replace("`r`n", "`n").Trim())

# 4. Update openWorkflowStepModal
$targetModal = @'
    6: {
      name: "Bước 06 · Định Tuyến & Điều Phối 8 NVKD (Smart Sales Routing)",
      desc: "Phân bổ khách hàng tự động cho 8 Nhân viên kinh doanh dựa trên 3 tiêu chí cốt lõi: Địa lý vùng miền (Bắc - Trung - Nam), Nhóm ngành chuyên môn (Sản xuất, Dệt may, Dược phẩm, Bán lẻ...) và Hạn mức tự quyết hợp đồng (Senior vs Junior).",
      inputs: "538 Golden Records kèm phân hạng ICP và danh sách 8 NVKD Nam Việt",
      params: "Phân vùng 3 miền, Ma trận chuyên môn ngành, Hạn mức ngân sách tối đa, Cân bằng tải tối ưu.",
      outputs: "100% hồ sơ được phân công đúng người, cam kết thời gian tiếp cận theo SLA.",
      targetNav: "sec-sales",
      navLabel: "Xem Điều Phối 8 NVKD"
    },
    7: {
      name: "Bước 07 · Kiểm Định Phê Duyệt Cổng 5 (Human-in-the-Loop & Feedback)",
      desc: "Cơ chế kiểm soát an toàn: rà soát các trường hợp vượt thẩm quyền hạn mức NVKD hoặc đăng ký đa vùng miền. Trưởng phòng Kinh doanh có thể duyệt nhanh, điều chuyển NVKD hoặc gửi Feedback điều chỉnh trọng số thuật toán.",
      inputs: "Các trường hợp gắn cờ PENDING_MANAGER_APPROVAL",
      params: "Kiểm tra hạn mức ngân sách > thẩm quyền NVKD, kiểm tra tranh chấp khu vực.",
      outputs: "Quyết định phê duyệt chính thức được ghi nhận vào Audit Trail.",
      targetNav: "sec-review",
      navLabel: "Xem Cổng 5 Human Review"
    },
    8: {
      name: "Bước 08 · Sinh Kịch Bản Tiếp Cận & Tác Vụ CRM (Outreach Draft & Tasks)",
      desc: "AI Agent tự động soạn thảo thông điệp tiếp cận qua Zalo/Email cho NVKD dựa trên trạng thái hồ sơ. Đồng thời tạo danh sách tác vụ CRM theo dõi cam kết SLA tiếp cận (P1: 4h, P2: 24h, P3: 48h).",
      inputs: "538 Golden Records đã được phân bổ cho 8 NVKD",
      params: "Template Zalo chuyên nghiệp dưới 50 từ đối với ca thiếu thông tin; kịch bản giải pháp chuyên sâu đối với ca P1 Hot.",
      outputs: "Kịch bản mẫu gửi NVKD và lịch trình tác vụ SLA tự động.",
      targetNav: "sec-tasks",
      navLabel: "Xem Quản Lý Tác Vụ SLA"
    }
'@

$replaceModal = @'
    6: {
      name: "Bước 06 · Kiểm Định Phê Duyệt Cổng 5 (Human-in-the-Loop & Feedback)",
      desc: "Cơ chế kiểm soát an toàn: rà soát các trường hợp vượt thẩm quyền hạn mức ngân sách hoặc đăng ký đa vùng miền. Trưởng phòng Kinh doanh có thể duyệt nhanh, xác nhận phương án hoặc gửi Feedback điều chỉnh trọng số thuật toán.",
      inputs: "Các trường hợp gắn cờ PENDING_MANAGER_APPROVAL",
      params: "Kiểm tra hạn mức ngân sách > thẩm quyền, kiểm tra tranh chấp khu vực.",
      outputs: "Quyết định phê duyệt chính thức được ghi nhận vào Audit Trail.",
      targetNav: "sec-review",
      navLabel: "Xem Cổng 5 Human Review"
    },
    7: {
      name: "Bước 07 · Sinh Kịch Bản Tiếp Cận & Tác Vụ Thông Minh (Smart Outreach & Strategy)",
      desc: "AI Agent tự động soạn thảo thông điệp tiếp cận qua Zalo/Email dựa trên trạng thái hồ sơ. Đồng thời tạo danh sách tác vụ CRM theo dõi cam kết SLA tiếp cận (P1: 4h, P2: 24h, P3: 48h).",
      inputs: "538 Golden Records đã phân loại ICP",
      params: "Template Zalo chuyên nghiệp dưới 50 từ đối với ca thiếu thông tin; kịch bản giải pháp chuyên sâu đối với ca P1 Hot.",
      outputs: "Kịch bản tiếp cận cá nhân hóa và lịch trình tác vụ SLA tự động.",
      targetNav: "sec-tasks",
      navLabel: "Xem Quản Lý Tác Vụ SLA"
    }
'@

$content = $content.Replace($targetModal.Trim(), $replaceModal.Trim())
$content = $content.Replace($targetModal.Replace("`r`n", "`n").Trim(), $replaceModal.Replace("`r`n", "`n").Trim())

# 5. Update renderScoringTable column 5 & button
$targetCol5 = @'
        <td>
          <div class="rep-chip">
            <div class="rep-avatar" style="background:${r.recommendedRep.color};">${r.recommendedRep.avatar}</div>
            <div>
              <div style="font-weight:700;color:#F1F5F9;">${r.recommendedRep.name}</div>
              <div style="font-size:11px;color:var(--text-secondary);">${r.recommendedRep.region}</div>
            </div>
          </div>
          <div style="font-size:11.5px;color:#34D399;font-weight:600;margin-top:4px;">
            ${r.recommendedReasons.slice(0, 2).join(" • ")}
          </div>
        </td>
'@

$replaceCol5 = @'
        <td>
          <div style="display:flex;align-items:center;gap:6px;">
            <span style="font-size:14px;">📍</span>
            <div>
              <div style="font-weight:700;color:#F1F5F9;">Khu vực: ${ent.primaryRegion || (r.recommendedRep && r.recommendedRep.region) || "Toàn quốc"}</div>
              <div style="font-size:11px;color:var(--text-secondary);">Kênh: ${ent.contacts && ent.contacts[0] ? ent.contacts[0].source : "Inbound"}</div>
            </div>
          </div>
          <div style="font-size:11.5px;color:#34D399;font-weight:600;margin-top:4px;">
            ${r.recommendedReasons ? r.recommendedReasons.slice(0, 2).join(" • ") : "Khớp tiềm năng"}
          </div>
        </td>
'@

$content = $content.Replace($targetCol5.Trim(), $replaceCol5.Trim())
$content = $content.Replace($targetCol5.Replace("`r`n", "`n").Trim(), $replaceCol5.Replace("`r`n", "`n").Trim())

$content = $content.Replace('title="Điều chuyển sang NVKD khác">🔄 Chuyển NVKD</button>', 'title="Điều chỉnh định tuyến khai thác">🔄 Định Tuyến</button>')

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Output "Step 3 executed successfully."
