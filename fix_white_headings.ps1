$filePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

$content = $content.Replace('<span style="font-size: 19px; font-weight: 800; color: #FFFFFF;">Cổng 3 · Universal Data Validation & Intelligent Schema Detection</span>', '<span style="font-size: 19px; font-weight: 800; color: #1E293B;">Cổng 3 · Universal Data Validation & Intelligent Schema Detection</span>')

$content = $content.Replace('<h4 style="font-size: 16px; font-weight: 800; color: #FFFFFF; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`r`n                    <span>🔍 AI SCHEMA DETECTION & DATA PROFILING</span>', '<h4 style="font-size: 16px; font-weight: 800; color: #1E293B; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`r`n                    <span>🔍 AI SCHEMA DETECTION & DATA PROFILING</span>')

$content = $content.Replace('<h4 style="font-size: 16px; font-weight: 800; color: #FFFFFF; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`n                    <span>🔍 AI SCHEMA DETECTION & DATA PROFILING</span>', '<h4 style="font-size: 16px; font-weight: 800; color: #1E293B; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`n                    <span>🔍 AI SCHEMA DETECTION & DATA PROFILING</span>')

$content = $content.Replace('<h4 style="font-size: 16px; font-weight: 800; color: #FFFFFF; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`r`n                    <span>📊 TỔNG QUAN PHÂN TÍCH THỐNG KÊ (UNIVERSAL ANALYTICS)</span>', '<h4 style="font-size: 16px; font-weight: 800; color: #1E293B; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`r`n                    <span>📊 TỔNG QUAN PHÂN TÍCH THỐNG KÊ (UNIVERSAL ANALYTICS)</span>')

$content = $content.Replace('<h4 style="font-size: 16px; font-weight: 800; color: #FFFFFF; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`n                    <span>📊 TỔNG QUAN PHÂN TÍCH THỐNG KÊ (UNIVERSAL ANALYTICS)</span>', '<h4 style="font-size: 16px; font-weight: 800; color: #1E293B; display: flex; align-items: center; gap: 8px; margin: 0 0 3px 0;">`n                    <span>📊 TỔNG QUAN PHÂN TÍCH THỐNG KÊ (UNIVERSAL ANALYTICS)</span>')

$content = $content.Replace('id="universalAnalyticsCard" style="padding: 20px 22px; margin-bottom: 24px; border: 1px solid rgba(255,255,255,0.08); border-radius: 14px; display: none;"', 'id="universalAnalyticsCard" style="padding: 20px 22px; margin-bottom: 24px; border: 1px solid #E2E8F0; border-radius: 14px; background:#FFFFFF; box-shadow:0 4px 16px rgba(0,0,0,0.03); display: none;"')

$content = $content.Replace('id="scoringCurrentPageNum" style="font-size:12.5px; font-weight:700; color:#FFFFFF; padding:0 8px;"', 'id="scoringCurrentPageNum" style="font-size:12.5px; font-weight:700; color:#1E293B; padding:0 8px;"')

$content = $content.Replace('<h4 style="font-size:14px; font-weight:700; color:#FFFFFF; margin-bottom:8px;">Vòng Lặp Feedback & Điều Chỉnh Trực Tiếp</h4>', '<h4 style="font-size:14px; font-weight:700; color:#1E293B; margin-bottom:8px;">Vòng Lặp Feedback & Điều Chỉnh Trực Tiếp</h4>')

$content = $content.Replace('<h3 id="commonModalTitle" style="font-size:16px; font-weight:700; color:#FFFFFF;">Chi Tiết</h3>', '<h3 id="commonModalTitle" style="font-size:16px; font-weight:700; color:#1E293B;">Chi Tiết</h3>')

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done fixing white headings in index.html!"
