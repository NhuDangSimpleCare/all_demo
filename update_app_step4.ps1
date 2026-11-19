$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$rawLines = [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::UTF8)
[System.Collections.Generic.List[string]]$list = New-Object 'System.Collections.Generic.List[string]'
$list.AddRange([string[]]$rawLines)

# 1. Replace Markdown section 4 (Find index of "## 4. MA TRẬN PHÂN BỔ 8 NHÂN VIÊN")
$idx1 = -1
for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i] -match "## 4. MA TRẬN PHÂN BỔ 8 NHÂN VIÊN") {
        $idx1 = $i
        break
    }
}
if ($idx1 -ge 0) {
    # Find next section ("## 5. 5 ĐỀ XUẤT")
    $idx1End = -1
    for ($i = $idx1; $i -lt $list.Count; $i++) {
        if ($list[$i] -match "## 5\. 5 ĐỀ XUẤT") {
            $idx1End = $i
            break
        }
    }
    if ($idx1End -gt $idx1) {
        $newMd = @"
## 4. MA TRẬN PHÂN HẠNG TIỀM NĂNG & CAM KẾT SLA KHAI THÁC
| Phân Hạng | Số Lượng Lead | Doanh Thu Dự Kiến | Cam Kết SLA | Kịch Bản Khai Thác Khuyến Nghị |
| :--- | :--- | :--- | :--- | :--- |
| **P1 - Hot Leads** | 112 doanh nghiệp | 7.850.000.000 VNĐ | 15 Phút - 4 Giờ | Gọi điện trực tiếp & Khảo sát Demo giải pháp chuyên sâu |
| **P2 - Warm Leads** | 188 doanh nghiệp | 5.620.000.000 VNĐ | Trong vòng 24 Giờ | Gửi bộ tài liệu tính năng, case study ngành & khảo sát online |
| **P3 - Cold Leads** | 108 doanh nghiệp | 2.950.000.000 VNĐ | Trong vòng 48 Giờ | Nurturing tự động qua email marketing & webinar hàng tháng |
| **P4 - Non-fit (Loại trừ)** | 48 dự án | 0 VNĐ (Ảo) | Miễn trừ | Gửi thư cảm ơn tự động, giới thiệu đối tác ngoài hoặc lưu kho |

---
"@
        $countToRemove = $idx1End - $idx1
        $list.RemoveRange($idx1, $countToRemove)
        $newLines = $newMd -split "`r?`n"
        $list.InsertRange($idx1, $newLines)
        Write-Output "Replaced Markdown Section 4 at line $idx1"
    }
}

# 2. Replace renderScoringTable column 5
$idxRepAvatar = -1
for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i] -match 'class="rep-chip"') {
        $idxRepAvatar = $i
        break
    }
}
if ($idxRepAvatar -ge 0) {
    # Start is <td> before rep-chip
    $startTd = $idxRepAvatar - 1
    # End is </td> after rep-chip
    $endTd = -1
    for ($i = $idxRepAvatar; $i -lt $idxRepAvatar + 15; $i++) {
        if ($list[$i] -match "</td>") {
            $endTd = $i
            break
        }
    }
    if ($endTd -gt $startTd) {
        $newCol5 = @"
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
"@
        $count = $endTd - $startTd + 1
        $list.RemoveRange($startTd, $count)
        $newLines = $newCol5 -split "`r?`n"
        $list.InsertRange($startTd, $newLines)
        Write-Output "Replaced renderScoringTable Column 5 at line $startTd"
    }
}

# 3. Replace MỤC 8 in renderExecutiveReport
$idxMuc8 = -1
for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i] -match "<!-- MỤC 8: ĐỀ XUẤT PHÂN CÔNG") {
        $idxMuc8 = $i
        break
    }
}
if ($idxMuc8 -ge 0) {
    # Find next MỤC 9
    $idxMuc9 = -1
    for ($i = $idxMuc8; $i -lt $list.Count; $i++) {
        if ($list[$i] -match "<!-- MỤC 9: KIỂM SOÁT TRANH CHẤP") {
            $idxMuc9 = $i
            break
        }
    }
    if ($idxMuc9 -gt $idxMuc8) {
        $newMuc8 = @"
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

"@
        $count = $idxMuc9 - $idxMuc8
        $list.RemoveRange($idxMuc8, $count)
        $newLines = $newMuc8 -split "`r?`n"
        $list.InsertRange($idxMuc8, $newLines)
        Write-Output "Replaced MỤC 8 in renderExecutiveReport at line $idxMuc8"
    }
}

# 4. Replace openWorkflowStepModal steps 6-8
$idxStep6 = -1
for ($i = 0; $i -lt $list.Count; $i++) {
    if ($list[$i] -match "Bước 06 · Định Tuyến & Điều Phối 8 NVKD") {
        $idxStep6 = $i - 1
        break
    }
}
if ($idxStep6 -ge 0) {
    # Find closing of stepDetails
    $idxStepDetailsEnd = -1
    for ($i = $idxStep6; $i -lt $idxStep6 + 40; $i++) {
        if ($list[$i] -match "^\s*\}\;\s*$") {
            $idxStepDetailsEnd = $i
            break
        }
    }
    if ($idxStepDetailsEnd -gt $idxStep6) {
        $newSteps = @"
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
"@
        $count = $idxStepDetailsEnd - $idxStep6
        $list.RemoveRange($idxStep6, $count)
        $newLines = $newSteps -split "`r?`n"
        $list.InsertRange($idxStep6, $newLines)
        Write-Output "Replaced openWorkflowStepModal steps 6-8 at line $idxStep6"
    }
}

[System.IO.File]::WriteAllLines($path, $list, [System.Text.Encoding]::UTF8)
Write-Output "Replacement complete!"
