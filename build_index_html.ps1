# ==============================================================================
# SCRIPT TO ASSEMBLE 3-PAGE INDEX.HTML WITH REFERENCE IMAGE AESTHETIC
# ==============================================================================

$raw = [System.IO.File]::ReadAllText("c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html.bak", [System.Text.Encoding]::UTF8)

function Extract-Section($html, $id) {
    $startIdx = $html.IndexOf("id=`"$id`"")
    if ($startIdx -lt 0) { return "" }
    $openTag = $html.LastIndexOf("<section", $startIdx)
    $endTag = $html.IndexOf("</section>", $startIdx)
    if ($endTag -lt 0) { return "" }
    $endTag += "</section>".Length
    return $html.Substring($openTag, $endTag - $openTag)
}

$secOverview  = Extract-Section $raw "sec-overview"
$secImport    = Extract-Section $raw "sec-import"
$secAgent     = Extract-Section $raw "sec-agent"
$secCustomers = Extract-Section $raw "sec-customers"
$secTasks     = Extract-Section $raw "sec-tasks"
$secReview    = Extract-Section $raw "sec-review"
$secReports   = Extract-Section $raw "sec-reports"
$secLogs      = Extract-Section $raw "sec-logs"

# Extract Modals & Demo Bar
$demoStart = $raw.IndexOf('<div class="demo-mode-bar"')
$demoEnd   = $raw.IndexOf('<!-- APPLICATION SCRIPTS -->')
$modalsAndDemo = if ($demoStart -gt 0 -and $demoEnd -gt $demoStart) {
    $raw.Substring($demoStart, $demoEnd - $demoStart)
} else { "" }

$sb = New-Object System.Text.StringBuilder

# 1. HTML HEAD & START OF APP SHELL
[void]$sb.AppendLine('<!DOCTYPE html>')
[void]$sb.AppendLine('<html lang="vi" data-theme="white">')
[void]$sb.AppendLine('<head>')
[void]$sb.AppendLine('  <meta charset="UTF-8" />')
[void]$sb.AppendLine('  <meta name="viewport" content="width=device-width, initial-scale=1.0" />')
[void]$sb.AppendLine('  <title>NAM VIỆT AI — Universal Data Intelligence & Enterprise AI Agent</title>')
[void]$sb.AppendLine('  <!-- Google Fonts: Inter & Be Vietnam Pro -->')
[void]$sb.AppendLine('  <link rel="preconnect" href="https://fonts.googleapis.com" />')
[void]$sb.AppendLine('  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />')
[void]$sb.AppendLine('  <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,600&family=Inter:wght@300;400;500;600;700;800;900&family=JetBrains+Mono:wght@400;500;700&display=swap" rel="stylesheet" />')
[void]$sb.AppendLine('  <!-- Tailwind CSS CDN -->')
[void]$sb.AppendLine('  <script src="https://cdn.tailwindcss.com"></script>')
[void]$sb.AppendLine('  <script>')
[void]$sb.AppendLine('    tailwind.config = {')
[void]$sb.AppendLine('      corePlugins: { preflight: false },')
[void]$sb.AppendLine('      theme: {')
[void]$sb.AppendLine('        extend: {')
[void]$sb.AppendLine('          colors: {')
[void]$sb.AppendLine('            appDark: "#F8FAFC",')
[void]$sb.AppendLine('            surface: "#FFFFFF",')
[void]$sb.AppendLine('            surfaceElevated: "#FFFFFF",')
[void]$sb.AppendLine('            borderMain: "#E2E8F0",')
[void]$sb.AppendLine('            primaryIndigo: "#FF2A85",')
[void]$sb.AppendLine('            aiPurple: "#A855F7",')
[void]$sb.AppendLine('            cyanAccent: "#0EA5E9",')
[void]$sb.AppendLine('            successGreen: "#10B981",')
[void]$sb.AppendLine('            warningAmber: "#FFA500",')
[void]$sb.AppendLine('            dangerRose: "#EF4444"')
[void]$sb.AppendLine('          }')
[void]$sb.AppendLine('        }')
[void]$sb.AppendLine('      }')
[void]$sb.AppendLine('    }')
[void]$sb.AppendLine('  </script>')
[void]$sb.AppendLine('  <!-- Lucide Icons CDN -->')
[void]$sb.AppendLine('  <script src="https://unpkg.com/lucide@latest"></script>')
[void]$sb.AppendLine('  <!-- SheetJS for Excel/CSV parsing -->')
[void]$sb.AppendLine('  <script src="https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"></script>')
[void]$sb.AppendLine('  <!-- App Stylesheet & Theme White -->')
[void]$sb.AppendLine('  <link rel="stylesheet" href="styles.css" />')
[void]$sb.AppendLine('  <link rel="stylesheet" href="theme_white.css" />')
[void]$sb.AppendLine('</head>')
[void]$sb.AppendLine('<body>')
[void]$sb.AppendLine('  <!-- Toast Notification Container -->')
[void]$sb.AppendLine('  <div id="toastContainer" class="toast-container"></div>')
[void]$sb.AppendLine('  <!-- APPLICATION SHELL -->')
[void]$sb.AppendLine('  <div class="app-shell" id="appShell">')

# 2. SIDEBAR
[void]$sb.AppendLine(@'
    <!-- ==================================================================
         SIDEBAR NAVIGATION
         ================================================================== -->
    <aside class="app-sidebar" id="appSidebar">
      <!-- Brand Header -->
      <div class="sidebar-header">
        <a href="javascript:void(0)" onclick="switchPage(1)" class="sidebar-brand-box">
          <div class="sidebar-brand-icon">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 2L2 7l10 5 10-5-10-5z"></path>
              <path d="M2 17l10 5 10-5"></path>
              <path d="M2 12l10 5 10-5"></path>
            </svg>
          </div>
          <div class="sidebar-brand-text">
            <div class="sidebar-brand-title">
              <span>NAM VIỆT AI</span>
              <span class="sidebar-brand-badge">SaaS V2.4</span>
            </div>
            <span class="sidebar-brand-sub">Universal Data Intelligence</span>
          </div>
        </a>
        <button type="button" class="sidebar-collapse-btn" onclick="toggleSidebar()" title="Thu gọn / Mở rộng Sidebar">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>
      </div>

      <!-- Navigation Items -->
      <nav class="sidebar-nav">
        <div class="sidebar-nav-group-title">ĐIỀU HƯỚNG 3 TRANG</div>

        <div class="sidebar-nav-item active" id="sidebarNavPage1" onclick="switchPage(1)" title="Trang 1: Giới Thiệu Sản Phẩm & Định Hướng Phân Tích">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
              <polyline points="9 22 9 12 15 12 15 22"></polyline>
            </svg>
          </div>
          <span class="sidebar-nav-label">01 · Giới Thiệu & Định Hướng</span>
          <span class="sidebar-nav-pill" style="background:#FFE8F2; color:#FF2A85;">P1</span>
        </div>

        <div class="sidebar-nav-item" id="sidebarNavPage2" onclick="switchPage(2)" title="Trang 2: Luồng Phân Tích AI Agent & Cổng Tiếp Nhận">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
            </svg>
          </div>
          <span class="sidebar-nav-label">02 · Luồng Phân Tích Agent</span>
          <span class="sidebar-nav-pill" style="background:#FEF3C7; color:#D97706;">P2</span>
        </div>

        <div class="sidebar-nav-item" id="sidebarNavPage3" onclick="switchPage(3)" title="Trang 3: Dashboard KPI & Báo Cáo Điều Hành">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="3" width="7" height="7"></rect>
              <rect x="14" y="3" width="7" height="7"></rect>
              <rect x="14" y="14" width="7" height="7"></rect>
              <rect x="3" y="14" width="7" height="7"></rect>
            </svg>
          </div>
          <span class="sidebar-nav-label">03 · Dashboard KPI & Báo Cáo</span>
          <span class="sidebar-nav-pill" style="background:#E0F2FE; color:#0284C7;">P3</span>
        </div>

        <div class="sidebar-nav-group-title">CHI TIẾT NGHIỆP VỤ</div>

        <div class="sidebar-nav-item" id="navItemImport" onclick="switchNavSection('sec-import')" title="Nạp Dữ Liệu & Cổng 3">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
              <polyline points="17 8 12 3 7 8"></polyline>
              <line x1="12" y1="3" x2="12" y2="15"></line>
            </svg>
          </div>
          <span class="sidebar-nav-label">Nạp Dữ Liệu & Cổng 3</span>
          <span class="sidebar-nav-pill">Cổng 3</span>
        </div>

        <div class="sidebar-nav-item" id="navItemAgent" onclick="switchNavSection('sec-agent')" title="Quy Trình AI Agent (7 Bước)">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
            </svg>
          </div>
          <span class="sidebar-nav-label">Quy Trình AI Agent</span>
          <span class="sidebar-nav-pill">7 Bước</span>
        </div>

        <div class="sidebar-nav-item" id="navItemOverview" onclick="switchNavSection('sec-overview')" title="Tổng Quan & KPI">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="3" width="7" height="7"></rect>
              <rect x="14" y="3" width="7" height="7"></rect>
              <rect x="14" y="14" width="7" height="7"></rect>
              <rect x="3" y="14" width="7" height="7"></rect>
            </svg>
          </div>
          <span class="sidebar-nav-label">Tổng Quan & KPI</span>
        </div>

        <div class="sidebar-nav-item" id="navItemCustomers" onclick="switchNavSection('sec-customers')" title="Khách Hàng (538 Golden Records)">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
              <circle cx="9" cy="7" r="4"></circle>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
            </svg>
          </div>
          <span class="sidebar-nav-label">Khách Hàng (Golden Records)</span>
          <span class="sidebar-nav-pill" id="badgeGoldenCount">538</span>
        </div>

        <div class="sidebar-nav-item" id="navItemTasks" onclick="switchNavSection('sec-tasks')" title="Quản Lý Tác Vụ SLA CRM">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="9 11 12 14 22 4"></polyline>
              <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path>
            </svg>
          </div>
          <span class="sidebar-nav-label">Quản Lý Tác Vụ SLA</span>
          <span class="sidebar-nav-pill warning">4h SLA</span>
        </div>

        <div class="sidebar-nav-item" id="navItemReview" onclick="switchNavSection('sec-review')" title="Human Review (Cổng 5 Phê Duyệt)">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
            </svg>
          </div>
          <span class="sidebar-nav-label">Human Review (Cổng 5)</span>
          <span class="sidebar-nav-pill warning">Duyệt</span>
        </div>

        <div class="sidebar-nav-item" id="navItemReports" onclick="switchNavSection('sec-reports')" title="Báo Cáo Điều Hành & Xuất Bản">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
              <polyline points="14 2 14 8 20 8"></polyline>
              <line x1="16" y1="13" x2="8" y2="13"></line>
              <line x1="16" y1="17" x2="8" y2="17"></line>
              <polyline points="10 9 9 9 8 9"></polyline>
            </svg>
          </div>
          <span class="sidebar-nav-label">Báo Cáo Điều Hành & Xuất</span>
        </div>

        <div class="sidebar-nav-item" id="navItemLogs" onclick="switchNavSection('sec-logs')" title="Nhật Ký Thực Thi (Audit Log)">
          <div class="sidebar-nav-icon">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="4 17 10 11 4 5"></polyline>
              <line x1="12" y1="19" x2="20" y2="19"></line>
            </svg>
          </div>
          <span class="sidebar-nav-label">Nhật Ký Thực Thi (Audit Log)</span>
        </div>
      </nav>

      <!-- Sidebar Status Footer -->
      <div class="sidebar-footer">
        <div class="sidebar-status-box">
          <div class="sidebar-status-indicator">
            <span class="status-dot-pulse"></span>
            <span>Hệ thống: <strong>Online</strong></span>
          </div>
          <span id="sidebarDatasetCount" style="color:var(--cyan); font-weight:700;">700 hồ sơ</span>
        </div>
        <div style="font-size:11px; color:var(--text-muted); display:flex; justify-content:space-between;">
          <span id="sidebarDatasetName">Nam Việt Leads</span>
          <span>Port 8080</span>
        </div>
      </div>
    </aside>
'@)

# 3. TOPBAR
[void]$sb.AppendLine(@'
    <!-- ==================================================================
         MAIN CONTENT AREA
         ================================================================== -->
    <main class="app-main">
      <!-- TOPBAR -->
      <header class="app-topbar">
        <div class="topbar-left">
          <button type="button" class="sidebar-collapse-btn" onclick="toggleSidebar()" title="Đóng/Mở Sidebar">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="3" y1="12" x2="21" y2="12"></line>
              <line x1="3" y1="6" x2="21" y2="6"></line>
              <line x1="3" y1="18" x2="21" y2="18"></line>
            </svg>
          </button>
          <div class="topbar-breadcrumbs">
            <a href="javascript:void(0)" onclick="switchPage(1)">Nam Việt AI</a>
            <span class="divider">/</span>
            <span class="current" id="topbarCurrentViewTitle">01 · Giới Thiệu & Định Hướng Phân Tích</span>
          </div>
        </div>

        <!-- CENTER: 3 PROMINENT PAGE TABS MATCHING REFERENCE DESIGN -->
        <div class="top-page-tabs">
          <button type="button" class="page-tab-btn active" id="pageTabBtn1" onclick="switchPage(1)">
            <span class="tab-num">1</span>
            <span>Giới Thiệu & Định Hướng</span>
          </button>
          <button type="button" class="page-tab-btn" id="pageTabBtn2" onclick="switchPage(2)">
            <span class="tab-num">2</span>
            <span>Luồng Phân Tích Agent</span>
          </button>
          <button type="button" class="page-tab-btn" id="pageTabBtn3" onclick="switchPage(3)">
            <span class="tab-num">3</span>
            <span>Dashboard KPI & Báo Cáo</span>
          </button>
        </div>

        <div class="topbar-right">
          <!-- Live Status Badge -->
          <div class="topbar-status-badge" id="topbarStatusBadgeContainer">
            <span class="badge-dot" id="topbarStatusDot"></span>
            <span id="topbarAgentStatusText">AI Agent: Sẵn sàng</span>
          </div>

          <!-- Quick Action Buttons -->
          <button type="button" class="btn-ai btn-ai-outline btn-ai-sm" id="topbarDemoModeBtn" onclick="toggleDemoMode()" title="Khởi động / Thoát chế độ thuyết trình demo">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <polygon points="5 3 19 12 5 21 5 3"></polygon>
            </svg>
            <span id="topbarDemoModeBtnText">Demo Mode</span>
          </button>

          <button type="button" class="btn-ai btn-ai-secondary btn-ai-sm" onclick="confirmResetModal()" title="Đặt lại trạng thái ban đầu có hộp thoại xác nhận">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M23 4v6h-6"></path>
              <path d="M1 20v-6h6"></path>
              <path d="M3.51 9a9 9 0 0 1 14.85-3.36L23 10M1 14l4.64 4.36A9 9 0 0 0 20.49 15"></path>
            </svg>
            <span>Reset</span>
          </button>

          <!-- Orange START button from reference image -->
          <button type="button" class="btn-start-orange" id="topbarRunAgentBtn" onclick="triggerRunAiPipeline(); switchPage(3);" title="Kích hoạt toàn bộ quy trình AI Agent">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" id="topbarRunAgentIcon">
              <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
            </svg>
            <span id="topbarRunAgentText">START · Chạy Pipeline</span>
          </button>

          <!-- White DOWNLOAD pill button from reference image -->
          <button type="button" class="btn-download-pill" onclick="downloadReportDoc()" title="Tải báo cáo điều hành Word">
            <span>DOWNLOAD</span>
            <span class="arrow-pink">⬇</span>
          </button>
        </div>
      </header>

      <!-- SCROLLABLE CANVAS -->
      <div class="app-canvas" id="appCanvas">
'@)

# 4. PAGE 1: HERO SHOWCASE, DOMAINS, PILLARS, CTA
[void]$sb.AppendLine(@'
        <!-- ==============================================================
             PAGE 1: GIỚI THIỆU SẢN PHẨM & ĐỊNH HƯỚNG PHÂN TÍCH
             ============================================================== -->
        <div id="pageIntro" class="app-page-section active">
          <!-- 1. HERO SHOWCASE CARD (EXACT FIDELITY TO REFERENCE IMAGE) -->
          <div class="hero-art-card">
            <!-- Left Column: Branding, Title, Description & Action -->
            <div class="hero-art-left">
              <!-- Mini Nav Menu matching reference image -->
              <div class="hero-art-nav-preview">
                <span>HOME</span>
                <span>ABOUT US</span>
                <span>SERVICE</span>
                <span>CONTACT</span>
                <span style="margin-left:auto; color:#222736;">NAM VIỆT AI ENTERPRISE</span>
              </div>

              <!-- Main Display Title with Pink Script -->
              <div class="hero-display-title">
                NAM VIỆT AI
                <span class="hero-script-pink">Data Intelligence</span>
              </div>

              <!-- Subtitle Description -->
              <p class="hero-art-desc">
                Hệ sinh thái AI Agent doanh nghiệp thế hệ mới: Tiếp nhận, kiểm định và khai phá dữ liệu đa nguồn từ Bán lẻ đa kênh, B2B Leads, Marketing/ROAS đến Tài chính và Vận hành. Tự động hóa tiền kiểm định, phân loại schema thông minh và tổng hợp báo cáo điều hành chuẩn C-Level.
              </p>

              <!-- Action Button Row with Orange Start Pill and Pink Plus -->
              <div class="hero-art-actions">
                <button type="button" class="btn-start-orange" onclick="switchPage(2)" title="Bắt đầu khám phá luồng phân tích AI Agent">
                  <span>START</span>
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                </button>

                <div class="art-floating-plus" style="position:static; cursor:pointer;" onclick="switchPage(2)" title="Khám phá ngay">+</div>
              </div>

              <!-- Decorative Dots Row -->
              <div class="hero-dots-row">
                <span class="hero-dot-pink"></span>
                <span class="hero-dot-pink" style="opacity:0.7;"></span>
                <span class="hero-dot-pink" style="opacity:0.4;"></span>
                <span class="hero-dot-gray"></span>
                <span class="hero-dot-gray"></span>
              </div>

              <!-- Social / Verification Icons -->
              <div style="display:flex; gap:12px; margin-top:14px; color:#94A3B8; font-size:16px;">
                <span title="Bảo mật cấp doanh nghiệp">🔒</span>
                <span title="Xử lý thời gian thực">⚡</span>
                <span title="Phân tích không ảo giác">🛡️</span>
                <span title="Chuẩn hóa ISO/IEC">✓</span>
              </div>
            </div>

            <!-- Right Column: Slate Navy Container with Floating Widgets & Download Button -->
            <div class="hero-art-right">
              <!-- Top Pink Globe Icon Badge -->
              <div style="display:flex; justify-content:center; position:relative; z-index:2;">
                <div style="width:48px; height:48px; border-radius:50%; background:#FF2A85; display:flex; align-items:center; justify-content:center; color:#FFFFFF; font-size:22px; box-shadow:0 8px 24px rgba(255,42,133,0.45);">
                  🌐
                </div>
              </div>

              <!-- Mini Calendar Widget matching image -->
              <div class="art-widget-calendar">
                <div class="art-cal-header">MONTH 2026</div>
                <div class="art-cal-grid" style="font-weight:800; color:#222736; margin-bottom:4px;">
                  <span>SU</span><span>MO</span><span>TU</span><span>WE</span><span>TH</span><span>FR</span><span>SA</span>
                </div>
                <div class="art-cal-grid">
                  <span>1</span><span>2</span><span>3</span><span>4</span>
                  <span class="art-cal-day-active">5</span>
                  <span>6</span><span>7</span>
                  <span>8</span><span>9</span><span>10</span><span>11</span><span>12</span><span>13</span><span>14</span>
                </div>
              </div>

              <!-- Floating Shield Badge (Orange) -->
              <div class="art-floating-shield" title="An Toàn & Bảo Mật Dữ Liệu">
                <span style="color:#FFA500; font-size:24px;">🛡️</span>
              </div>

              <!-- Floating Wifi Badge (Orange Gradient) -->
              <div class="art-floating-wifi" title="Kết Nối & Đồng Bộ Dữ Liệu Thời Gian Thực">
                <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M5 12.55a11 11 0 0 1 14.08 0"></path>
                  <path d="M1.42 9a16 16 0 0 1 21.16 0"></path>
                  <path d="M8.53 16.11a6 6 0 0 1 6.95 0"></path>
                  <line x1="12" y1="20" x2="12.01" y2="20"></line>
                </svg>
              </div>

              <!-- Floating Mail Badge (Pink Round) -->
              <div class="art-floating-mail" title="Tự Động Sinh Kịch Bản & Thông Báo">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                  <polyline points="22,6 12,13 2,6"></polyline>
                </svg>
              </div>

              <!-- Floating Cloud Badge (White Round Purple Border) -->
              <div class="art-floating-cloud" title="Điện Toán Đám Mây & Xuất Dữ Liệu">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#A855F7" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M17.5 19H9a7 7 0 1 1 6.71-9h1.79a4.5 4.5 0 1 1 0 9Z"></path>
                  <polyline points="12 13 12 9"></polyline>
                  <polyline points="9 11 12 8 15 11"></polyline>
                </svg>
              </div>

              <!-- Bottom Download Button Pill matching image -->
              <div style="display:flex; justify-content:flex-end; position:relative; z-index:2; margin-top:16px;">
                <button type="button" class="btn-download-pill" onclick="downloadReportDoc()" title="Tải hồ sơ nghiệm thu báo cáo Word">
                  <span>DOWNLOAD</span>
                  <span class="arrow-pink">⬇</span>
                </button>
              </div>
            </div>
          </div>

          <!-- 2. HƯỚNG PHÂN TÍCH DỮ LIỆU ĐA NGÀNH (5 UNIVERSAL DATA DOMAINS) -->
          <div style="margin-bottom: 32px;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:18px;">
              <div>
                <h2 style="font-size:22px; font-weight:900; color:#222736; display:flex; align-items:center; gap:8px;">
                  <span style="color:#FF2A85;">✦</span> 5 Hướng Phân Tích Dữ Liệu Đa Ngành Của NAM VIỆT AI
                </h2>
                <p style="font-size:13px; color:#64748B; margin-top:2px;">
                  Hệ thống linh hoạt tiếp nhận và trích xuất thông tin chuyên sâu cho từng bài toán nghiệp vụ cụ thể
                </p>
              </div>
              <button type="button" class="btn-ai btn-ai-outline btn-ai-sm" onclick="switchPage(2)">
                Xem Luồng Phân Tích ➔
              </button>
            </div>

            <div class="domain-cards-grid">
              <!-- Domain 1: Retail Omnichannel -->
              <div class="domain-card">
                <div>
                  <div class="domain-card-header">
                    <div class="domain-card-icon" style="background:rgba(16,185,129,0.12); color:#10B981;">🛒</div>
                    <span style="font-size:11px; font-weight:800; padding:2px 8px; border-radius:99px; background:#ECFDF5; color:#10B981;">THƯƠNG MẠI</span>
                  </div>
                  <div class="domain-card-title">Bán Lẻ Đa Kênh (Omnichannel Retail)</div>
                  <p class="domain-card-desc">
                    Phân tích đa chiều theo Website, Cửa Hàng và Đối Tác; đo lường chi phí giá vốn (COGS), biên lợi nhuận ròng và xác định kênh tăng trưởng chủ lực.
                  </p>
                  <div class="domain-card-metrics">
                    <span>● <strong>Chỉ số:</strong> Doanh thu, Chi phí giá vốn, Lợi nhuận gộp</span>
                    <span>● <strong>Mục tiêu:</strong> Tối ưu đóng góp doanh thu theo kênh</span>
                  </div>
                </div>
                <button type="button" class="btn-ai btn-ai-primary btn-ai-sm" style="width:100%; justify-content:center;" onclick="switchPage(2)">
                  Khám Phá Luồng Này ➔
                </button>
              </div>

              <!-- Domain 2: B2B Lead Intelligence -->
              <div class="domain-card">
                <div>
                  <div class="domain-card-header">
                    <div class="domain-card-icon" style="background:rgba(255,42,133,0.12); color:#FF2A85;">🏢</div>
                    <span style="font-size:11px; font-weight:800; padding:2px 8px; border-radius:99px; background:#FFE8F2; color:#FF2A85;">B2B LEADS</span>
                  </div>
                  <div class="domain-card-title">B2B Lead Intelligence & ICP Scoring</div>
                  <p class="domain-card-desc">
                    Tiền kiểm định hồ sơ doanh nghiệp, tra cứu đối chiếu MST, chuẩn hóa số điện thoại, khử 162 cuộc gọi trùng và phân hạng tiềm năng theo ICP 4 cấp.
                  </p>
                  <div class="domain-card-metrics">
                    <span>● <strong>Chỉ số:</strong> 538 Golden Records, Tỷ lệ sạch 100%</span>
                    <span>● <strong>Mục tiêu:</strong> Khử trùng lặp & ưu tiên Lead hạng A (P1)</span>
                  </div>
                </div>
                <button type="button" class="btn-ai btn-ai-primary btn-ai-sm" style="width:100%; justify-content:center;" onclick="switchPage(2)">
                  Khám Phá Luồng Này ➔
                </button>
              </div>

              <!-- Domain 3: Marketing & Campaign -->
              <div class="domain-card">
                <div>
                  <div class="domain-card-header">
                    <div class="domain-card-icon" style="background:rgba(14,165,233,0.12); color:#0EA5E9;">📈</div>
                    <span style="font-size:11px; font-weight:800; padding:2px 8px; border-radius:99px; background:#E0F2FE; color:#0EA5E9;">MARKETING</span>
                  </div>
                  <div class="domain-card-title">Marketing & Tối Ưu Chiến Dịch (ROAS)</div>
                  <p class="domain-card-desc">
                    Đánh giá hiệu quả chiến dịch Google Search, Facebook, TikTok; phân tích chi phí thu hút khách hàng (CAC) và tối ưu hóa ngân sách chuyển đổi.
                  </p>
                  <div class="domain-card-metrics">
                    <span>● <strong>Chỉ số:</strong> Chi phí / Lead, ROAS, Tỷ lệ chuyển đổi đơn</span>
                    <span>● <strong>Mục tiêu:</strong> Cắt giảm lãng phí ngân sách ads</span>
                  </div>
                </div>
                <button type="button" class="btn-ai btn-ai-primary btn-ai-sm" style="width:100%; justify-content:center;" onclick="switchPage(2)">
                  Khám Phá Luồng Này ➔
                </button>
              </div>

              <!-- Domain 4: Finance & Cost Control -->
              <div class="domain-card">
                <div>
                  <div class="domain-card-header">
                    <div class="domain-card-icon" style="background:rgba(245,158,11,0.12); color:#F59E0B;">💰</div>
                    <span style="font-size:11px; font-weight:800; padding:2px 8px; border-radius:99px; background:#FEF3C7; color:#D97706;">TÀI CHÍNH</span>
                  </div>
                  <div class="domain-card-title">Tài Chính & Kiểm Soát Chi Phí</div>
                  <p class="domain-card-desc">
                    Phân tích cơ cấu OPEX, cảnh báo sớm vượt hạn mức ngân sách, theo dõi dòng tiền và tỷ suất hoàn vốn đầu tư trên từng danh mục sản phẩm.
                  </p>
                  <div class="domain-card-metrics">
                    <span>● <strong>Chỉ số:</strong> Chi phí vận hành, Biên EBITDA, Dòng tiền</span>
                    <span>● <strong>Mục tiêu:</strong> Bảo vệ biên lợi nhuận an toàn</span>
                  </div>
                </div>
                <button type="button" class="btn-ai btn-ai-primary btn-ai-sm" style="width:100%; justify-content:center;" onclick="switchPage(2)">
                  Khám Phá Luồng Này ➔
                </button>
              </div>

              <!-- Domain 5: Operations & SLA -->
              <div class="domain-card">
                <div>
                  <div class="domain-card-header">
                    <div class="domain-card-icon" style="background:rgba(168,85,247,0.12); color:#A855F7;">⚙️</div>
                    <span style="font-size:11px; font-weight:800; padding:2px 8px; border-radius:99px; background:#F3E8FF; color:#9333EA;">VẬN HÀNH</span>
                  </div>
                  <div class="domain-card-title">Vận Hành & Giám Sát SLA Quy Trình</div>
                  <p class="domain-card-desc">
                    Đo lường thời gian xử lý hồ sơ, giám sát cam kết SLA 4 giờ, phát hiện các điểm nghẽn quy trình và cảnh báo nguy cơ trễ hạn xử lý.
                  </p>
                  <div class="domain-card-metrics">
                    <span>● <strong>Chỉ số:</strong> Cam kết SLA 4h, Tỷ lệ trễ hạn, Năng suất</span>
                    <span>● <strong>Mục tiêu:</strong> Tối ưu hóa chu trình tiếp cận</span>
                  </div>
                </div>
                <button type="button" class="btn-ai btn-ai-primary btn-ai-sm" style="width:100%; justify-content:center;" onclick="switchPage(2)">
                  Khám Phá Luồng Này ➔
                </button>
              </div>
            </div>
          </div>

          <!-- 3. TRỤ CỘT NĂNG LỰC CỦA AGENT -->
          <div style="background:#FFFFFF; border:1px solid #E2E8F0; border-radius:24px; padding:32px; margin-bottom:32px; box-shadow:0 8px 30px rgba(0,0,0,0.03);">
            <h3 style="font-size:18px; font-weight:800; color:#222736; margin-bottom:20px; display:flex; align-items:center; gap:8px;">
              <span style="color:#FFA500;">★</span> 4 Trụ Cột Năng Lực Cốt Lõi Của NAM VIỆT AI
            </h3>
            <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap:20px;">
              <div style="border-left:3px solid #FF2A85; padding-left:14px;">
                <h4 style="font-size:14.5px; font-weight:800; color:#222736; margin-bottom:4px;">Universal Ingestion</h4>
                <p style="font-size:12.5px; color:#64748B; line-height:1.6;">Tiếp nhận mọi tệp dữ liệu bảng Excel/CSV, không ép buộc schema, tự động nhận dạng cấu trúc cột và kiểu dữ liệu.</p>
              </div>
              <div style="border-left:3px solid #FFA500; padding-left:14px;">
                <h4 style="font-size:14.5px; font-weight:800; color:#222736; margin-bottom:4px;">Explainable Reasoning</h4>
                <p style="font-size:12.5px; color:#64748B; line-height:1.6;">Minh bạch lý do phân tích, hiển thị công thức tính toán và căn cứ đưa ra đề xuất hành động.</p>
              </div>
              <div style="border-left:3px solid #0EA5E9; padding-left:14px;">
                <h4 style="font-size:14.5px; font-weight:800; color:#222736; margin-bottom:4px;">Zero-Hallucination Guardrails</h4>
                <p style="font-size:12.5px; color:#64748B; line-height:1.6;">Cơ chế kiểm soát an toàn Cổng 5 Human-in-the-loop, tuyệt đối không tự bịa đặt hay làm biến dạng dữ liệu gốc.</p>
              </div>
              <div style="border-left:3px solid #10B981; padding-left:14px;">
                <h4 style="font-size:14.5px; font-weight:800; color:#222736; margin-bottom:4px;">Instant C-Level Export</h4>
                <p style="font-size:12.5px; color:#64748B; line-height:1.6;">Xuất bản báo cáo hoàn chỉnh sang file Word (.doc), Markdown (.md) và PDF in ấn chỉ với một cú nhấp chuột.</p>
              </div>
            </div>
          </div>

          <!-- 4. BOTTOM CALL TO ACTION BANNER -->
          <div style="background:linear-gradient(135deg, #222736 0%, #171A24 100%); border-radius:24px; padding:32px 36px; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:20px; box-shadow:0 14px 40px rgba(34,39,54,0.18);">
            <div>
              <h3 style="font-size:20px; font-weight:900; color:#FFFFFF; margin-bottom:6px;">Sẵn Sàng Trải Nghiệm Luồng Phân Tích Thực Tế?</h3>
              <p style="font-size:13.5px; color:#94A3B8; margin:0;">
                Xem chi tiết quy trình 7 bước, nạp file tại Cổng 3 và kích hoạt AI Agent xử lý trực tiếp.
              </p>
            </div>
            <button type="button" class="btn-start-orange" style="font-size:14px; padding:12px 28px;" onclick="switchPage(2)">
              <span>Sang Trang 2: Luồng Phân Tích AI Agent</span>
              <span>➔</span>
            </button>
          </div>
        </div>
'@)

# 5. PAGE 2: PIPELINE, GATE 3, RAW TABLE, AUDIT LOG
[void]$sb.AppendLine(@'
        <!-- ==============================================================
             PAGE 2: LUỒNG PHÂN TÍCH AI AGENT & CỔNG TIẾP NHẬN ĐA NGUỒN
             ============================================================== -->
        <div id="pagePipeline" class="app-page-section">
          <!-- Page 2 Header Banner -->
          <div class="card-enterprise" style="margin-bottom:20px; padding:20px 24px;">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
              <div>
                <h2 style="font-size:22px; font-weight:900; color:#222736; display:flex; align-items:center; gap:10px;">
                  <span style="color:#FFA500;">⚡</span> 02 · Quy Trình Phân Tích AI Agent & Cổng Tiếp Nhận Đa Nguồn
                </h2>
                <p style="font-size:13px; color:#64748B; margin-top:3px;">
                  Theo dõi luồng xử lý tự động 7 bước từ làm sạch, khử trùng, chấm điểm đến kịch bản khai thác
                </p>
              </div>
              <div style="display:flex; gap:8px;">
                <button type="button" class="btn-ai btn-ai-outline btn-ai-sm" onclick="switchPage(1)">❮ Trang 1</button>
                <button type="button" class="btn-start-orange" style="font-size:12px; padding:8px 18px;" onclick="triggerRunAiPipeline(); switchPage(3);">Chạy Pipeline & Xem KPI (Trang 3) ➔</button>
              </div>
            </div>
          </div>
'@)

[void]$sb.AppendLine($secAgent)
[void]$sb.AppendLine($secImport)
[void]$sb.AppendLine($secLogs)

[void]$sb.AppendLine(@'
          <!-- Page 2 Footer CTA Banner -->
          <div style="background:linear-gradient(135deg, #222736 0%, #171A24 100%); border-radius:24px; padding:28px 32px; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:16px; margin-top:24px;">
            <div>
              <h3 style="font-size:18px; font-weight:800; color:#FFFFFF; margin-bottom:4px;">Đã Kiểm Tra Xong Nguồn Dữ Liệu?</h3>
              <p style="font-size:13px; color:#94A3B8; margin:0;">Kích hoạt AI Agent để tự động hóa toàn bộ 7 bước và chuyển sang Dashboard KPI điều hành.</p>
            </div>
            <button type="button" class="btn-start-orange" style="font-size:13px; padding:10px 24px;" onclick="triggerRunAiPipeline(); switchPage(3);">
              <span>⚡ Kích Hoạt & Xem Dashboard KPI (Trang 3)</span>
              <span>➔</span>
            </button>
          </div>
        </div>
'@)

# 6. PAGE 3: DASHBOARD KPI, CHARTS, SPECIALIZED ANALYSIS, ACTION RECOMMENDATIONS, GOLDEN RECORDS
[void]$sb.AppendLine(@'
        <!-- ==============================================================
             PAGE 3: PHÂN TÍCH DỮ LIỆU & DASHBOARD KPI
             ============================================================== -->
        <div id="pageDashboard" class="app-page-section">
          <!-- Page 3 Header Banner -->
          <div class="card-enterprise" style="margin-bottom:20px; padding:20px 24px;">
            <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px;">
              <div>
                <h2 style="font-size:22px; font-weight:900; color:#222736; display:flex; align-items:center; gap:10px;">
                  <span style="color:#FF2A85;">📊</span> 03 · Báo Cáo Kinh Doanh & Dashboard KPI Điều Hành
                </h2>
                <p style="font-size:13px; color:#64748B; margin-top:3px;">
                  Số liệu trực quan hóa động tính toán chính xác 100% theo tệp dữ liệu nạp vào và kỳ báo cáo
                </p>
              </div>
              <div style="display:flex; gap:8px;">
                <button type="button" class="btn-ai btn-ai-outline btn-ai-sm" onclick="switchPage(2)">❮ Trang 2: Luồng Phân Tích</button>
                <button type="button" class="btn-download-pill" onclick="downloadReportDoc()"><span>DOWNLOAD WORD</span> <span class="arrow-pink">⬇</span></button>
              </div>
            </div>
          </div>
'@)

[void]$sb.AppendLine($secReports)
[void]$sb.AppendLine($secOverview)
[void]$sb.AppendLine($secCustomers)
[void]$sb.AppendLine($secReview)
[void]$sb.AppendLine($secTasks)

[void]$sb.AppendLine('        </div>')
[void]$sb.AppendLine('      </div> <!-- appCanvas -->')
[void]$sb.AppendLine('    </main>')
[void]$sb.AppendLine('  </div> <!-- appShell -->')

# 7. MODALS, DEMO BAR, SCRIPTS
[void]$sb.AppendLine($modalsAndDemo)

[void]$sb.AppendLine(@'
  <!-- APPLICATION SCRIPTS -->
  <script src="universal_data_engine.js"></script>
  <script src="mock_data.js"></script>
  <script src="ai_engine.js"></script>
  <script src="app.js"></script>

  <script>
    // Initialize Lucide icons on load
    document.addEventListener("DOMContentLoaded", () => {
      if (window.lucide) lucide.createIcons();
    });

    // 3-Page Switcher
    window.switchPage = function(pageNum) {
      const pageMap = {
        1: 'pageIntro',
        2: 'pagePipeline',
        3: 'pageDashboard'
      };
      const titleMap = {
        1: '01 · Giới Thiệu Sản Phẩm & Định Hướng Phân Tích',
        2: '02 · Luồng Phân Tích AI Agent & Cổng Tiếp Nhận',
        3: '03 · Báo Cáo Kinh Doanh & Dashboard KPI Điều Hành'
      };

      document.querySelectorAll('.app-page-section').forEach(el => el.classList.remove('active'));
      const targetPage = document.getElementById(pageMap[pageNum]);
      if (targetPage) targetPage.classList.add('active');

      for (let i = 1; i <= 3; i++) {
        const tabBtn = document.getElementById(`pageTabBtn${i}`);
        if (tabBtn) {
          if (i === pageNum) tabBtn.classList.add('active');
          else tabBtn.classList.remove('active');
        }
      }

      document.querySelectorAll('.sidebar-nav-item').forEach(el => el.classList.remove('active'));
      const sbItem = document.getElementById(`sidebarNavPage${pageNum}`);
      if (sbItem) sbItem.classList.add('active');

      const breadcrumb = document.getElementById('topbarCurrentViewTitle');
      if (breadcrumb) breadcrumb.textContent = titleMap[pageNum] || `Trang ${pageNum}`;

      const canvas = document.getElementById('appCanvas');
      if (canvas) canvas.scrollTop = 0;

      if (pageNum === 3) {
        if (typeof window.syncTopKpiWithActiveDataset === 'function') {
          window.syncTopKpiWithActiveDataset();
        }
        if (typeof window.renderExecutiveReport === 'function') {
          window.renderExecutiveReport(window.AppState ? window.AppState.pipelineResult : null);
        }
      }
    };

    // Navigation Router (Backwards Compatible)
    window.switchNavSection = function(sectionId) {
      if (sectionId === 'sec-intro' || sectionId === 'page1') {
        window.switchPage(1);
        return;
      }
      if (sectionId === 'sec-import' || sectionId === 'sec-agent' || sectionId === 'sec-logs' || sectionId === 'page2') {
        window.switchPage(2);
        setTimeout(() => {
          const el = document.getElementById(sectionId);
          if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }, 120);
        return;
      }
      window.switchPage(3);
      setTimeout(() => {
        const el = document.getElementById(sectionId);
        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }, 120);
    };

    // Sidebar Toggle
    window.toggleSidebar = function() {
      const sb = document.getElementById('appSidebar');
      if (sb) sb.classList.toggle('collapsed');
    };

    // Modal Controls
    window.closeCommonModal = function() {
      const modal = document.getElementById('commonModal');
      if (modal) modal.classList.remove('open');
    };

    // Quick Trigger for AI Pipeline
    window.triggerRunAiPipeline = function() {
      const statusText = document.getElementById('topbarAgentStatusText');
      if (statusText) statusText.textContent = "AI Agent: Đang xử lý...";
      showToast("⚡ <strong>AI Agent đang xử lý toàn bộ quy trình 7 bước...</strong>");
      
      setTimeout(() => {
        if (typeof window.executePipeline === 'function') {
          window.executePipeline();
        }
        if (statusText) statusText.textContent = "AI Agent: Sẵn sàng (538 Golden Records)";
        showToast("✅ <strong>Xử lý hoàn tất!</strong> Đã tạo 538 Golden Records và hoàn tất quy trình phân tích.");
        window.switchPage(3);
      }, 500);
    };

    // Demo Mode Controller
    const demoSteps = [
      { id: 'page1', title: '1. Giới Thiệu Sản Phẩm & Định Hướng Phân Tích', badge: 'BƯỚC 1/5' },
      { id: 'sec-import', title: '2. Nạp Dữ Liệu Thô & Kiểm Định Cổng 3', badge: 'BƯỚC 2/5' },
      { id: 'sec-agent', title: '3. Quy Trình Thực Thi AI Agent 7 Bước', badge: 'BƯỚC 3/5' },
      { id: 'sec-reports', title: '4. Dashboard KPI & Biểu Đồ Trực Quan', badge: 'BƯỚC 4/5' },
      { id: 'sec-customers', title: '5. Khám Phá Golden Records & Xuất Báo Cáo', badge: 'BƯỚC 5/5' }
    ];
    let currentDemoIndex = 0;

    window.startDemoMode = function() {
      currentDemoIndex = 0;
      const bar = document.getElementById('demoModeBar');
      if (bar) bar.style.display = 'flex';
      applyDemoStep();
      showToast("🚀 <strong>Đã kích hoạt Demo Mode!</strong> Sử dụng thanh điều hướng bên dưới để demo trước giảng viên.");
    };

    window.exitDemoMode = function() {
      const bar = document.getElementById('demoModeBar');
      if (bar) bar.style.display = 'none';
      showToast("Đã thoát chế độ Demo.");
    };

    window.nextDemoStep = function() {
      if (currentDemoIndex < demoSteps.length - 1) {
        currentDemoIndex++;
        applyDemoStep();
      } else {
        showToast("🎉 Đã hoàn thành toàn bộ kịch bản trình chiếu demo!");
      }
    };

    window.prevDemoStep = function() {
      if (currentDemoIndex > 0) {
        currentDemoIndex--;
        applyDemoStep();
      }
    };

    function applyDemoStep() {
      const step = demoSteps[currentDemoIndex];
      const badge = document.getElementById('demoStepBadge');
      const title = document.getElementById('demoStepTitle');
      if (badge) badge.textContent = step.badge;
      if (title) title.textContent = step.title;
      switchNavSection(step.id);
    }
  </script>
</body>
</html>
'@)

[System.IO.File]::WriteAllText("c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html", $sb.ToString(), [System.Text.Encoding]::UTF8)
Write-Host "Successfully written index.html! Size: $((Get-Item 'c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html').Length) bytes"
