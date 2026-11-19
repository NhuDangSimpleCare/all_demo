$filePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# 1. Quick Test Suite toolbar (lines 810-814)
$content = $content.Replace('style="background: rgba(15, 23, 42, 0.6); border: 1px solid rgba(255,255,255,0.06); border-radius: 12px; padding: 14px 16px; margin-bottom: 20px;"', 'style="background: #FFFFFF; border: 1px solid #E2E8F0; border-radius: 12px; padding: 14px 16px; margin-bottom: 20px; box-shadow: 0 2px 8px rgba(0,0,0,0.03);"')
$content = $content.Replace('color: #F1F5F9; display: flex; align-items: center; gap: 8px;', 'color: #1E293B; display: flex; align-items: center; gap: 8px;')

# 2. Schema Type Distribution (line 905)
$content = $content.Replace('id="schemaTypeDist" style="font-size: 15px; color:#F1F5F9;"', 'id="schemaTypeDist" style="font-size: 15px; color:#1E293B;"')

# 3. Source check wrapper and subcards
$content = $content.Replace('border: 1px solid rgba(255,255,255,0.08); border-radius: 14px;">', 'border: 1px solid #E2E8F0; border-radius: 14px; background: #FFFFFF; box-shadow: 0 4px 16px rgba(0,0,0,0.03);">')
$content = $content.Replace('<h3 style="font-size: 19px; font-weight: 700; color: #FFFFFF;', '<h3 style="font-size: 19px; font-weight: 700; color: #1E293B;')

# Subcard backgrounds
$content = $content.Replace('style="background: #0E1526; border: 1px solid var(--border-main); border-radius: 12px; padding: 20px 22px; margin-bottom: 18px;"', 'style="background: #FFFFFF; border: 1px solid #E2E8F0; border-radius: 12px; padding: 20px 22px; margin-bottom: 18px; box-shadow: 0 1px 3px rgba(0,0,0,0.02);"')
$content = $content.Replace('style="background: #0E1526; border: 1px solid var(--border-main); border-radius: 12px; padding: 20px 22px;"', 'style="background: #FFFFFF; border: 1px solid #E2E8F0; border-radius: 12px; padding: 20px 22px; box-shadow: 0 1px 3px rgba(0,0,0,0.02);"')

# Subcard titles & labels
$content = $content.Replace('<h4 style="font-size: 15px; font-weight: 700; color: #FFFFFF; margin: 0 0 3px 0;">', '<h4 style="font-size: 15px; font-weight: 700; color: #1E293B; margin: 0 0 3px 0;">')
$content = $content.Replace('color: #E2E8F0; margin-bottom: 6px;', 'color: #334155; margin-bottom: 6px;')
$content = $content.Replace('color: #E2E8F0; margin-bottom: 5px;', 'color: #334155; margin-bottom: 5px;')

# Inputs & Textareas in Source Check
$content = $content.Replace('style="background: #111827; border: 1.5px solid #10B981; border-radius: 8px; color: #F8FAFC; font-size: 13.5px; padding: 10px 14px; width: 100%; box-shadow: 0 0 0 1px rgba(16,185,129,0.25); outline: none; transition: border-color 0.2s;"', 'style="background: #FFFFFF; border: 1.5px solid #10B981; border-radius: 8px; color: #1E293B; font-size: 13.5px; padding: 10px 14px; width: 100%; box-shadow: 0 0 0 1px rgba(16,185,129,0.25); outline: none; transition: border-color 0.2s;"')

$content = $content.Replace('style="background: #111827; border: 1px solid #1E293B; border-radius: 8px; color: #F1F5F9; font-size: 13px; padding: 9px 12px; width: 100%; resize: vertical; outline: none;"', 'style="background: #FFFFFF; border: 1.5px solid #CBD5E1; border-radius: 8px; color: #1E293B; font-size: 13px; padding: 9px 12px; width: 100%; resize: vertical; outline: none;"')

$content = $content.Replace('style="background: #111827; border: 1px solid #1E293B; border-radius: 8px; color: #F1F5F9; font-size: 13px; line-height: 1.6; padding: 9px 12px; width: 100%; resize: vertical; outline: none;"', 'style="background: #FFFFFF; border: 1.5px solid #CBD5E1; border-radius: 8px; color: #1E293B; font-size: 13px; line-height: 1.6; padding: 9px 12px; width: 100%; resize: vertical; outline: none;"')

$content = $content.Replace('style="background: #111827; border: 1px solid #1E293B; border-radius: 8px; color: #F1F5F9; font-size: 12.5px; padding: 8px 12px; width: 100%; resize: vertical; outline: none;"', 'style="background: #FFFFFF; border: 1.5px solid #CBD5E1; border-radius: 8px; color: #1E293B; font-size: 12.5px; padding: 8px 12px; width: 100%; resize: vertical; outline: none;"')

# Amber alert bar
$content = $content.Replace('style="background: rgba(245, 158, 11, 0.12); border: 1px solid rgba(245, 158, 11, 0.35); border-left: 3.5px solid #F59E0B; padding: 10px 14px; border-radius: 6px; font-size: 12.5px; color: #FDE68A; margin-bottom: 18px;"', 'style="background: rgba(245, 158, 11, 0.08); border: 1px solid rgba(245, 158, 11, 0.3); border-left: 3.5px solid #F59E0B; padding: 10px 14px; border-radius: 6px; font-size: 12.5px; color: #B45309; margin-bottom: 18px;"')

# Sub-headings h5
$content = $content.Replace('style="font-size: 13.5px; font-weight: 700; color: #F1F5F9; margin: 0 0 6px 0;"', 'style="font-size: 13.5px; font-weight: 700; color: #1E293B; margin: 0 0 6px 0;"')
$content = $content.Replace('style="font-size: 13.5px; font-weight: 700; color: #F1F5F9; margin: 0 0 8px 0;"', 'style="font-size: 13.5px; font-weight: 700; color: #1E293B; margin: 0 0 8px 0;"')
$content = $content.Replace('style="font-size: 13.5px; font-weight: 700; color: #F1F5F9; margin: 0 0 12px 0;"', 'style="font-size: 13.5px; font-weight: 700; color: #1E293B; margin: 0 0 12px 0;"')

# Text & lists
$content = $content.Replace('id="aiUnderstandText" style="font-size: 13px; color: #CBD5E1; line-height: 1.6; margin: 0;"', 'id="aiUnderstandText" style="font-size: 13px; color: #475569; line-height: 1.6; margin: 0;"')
$content = $content.Replace('id="aiSuggestedPerspectives" style="margin: 0; padding-left: 18px; font-size: 13px; color: #CBD5E1; line-height: 1.6;"', 'id="aiSuggestedPerspectives" style="margin: 0; padding-left: 18px; font-size: 13px; color: #475569; line-height: 1.6;"')

# 4. Pipeline Meta Box (line 1309)
$content = $content.Replace('style="background:rgba(17,24,39,0.7); border:1px solid var(--border-main); border-radius:var(--radius-md); padding:16px 20px; min-width:240px; display:flex; flex-direction:column; gap:8px;"', 'style="background:#F8FAFC; border:1px solid #E2E8F0; border-radius:var(--radius-md); padding:16px 20px; min-width:240px; display:flex; flex-direction:column; gap:8px;"')
$content = $content.Replace('<div style="font-size:14px; font-weight:800; color:#FFFFFF; display:flex; align-items:center; gap:8px;">', '<div style="font-size:14px; font-weight:800; color:#1E293B; display:flex; align-items:center; gap:8px;">')
$content = $content.Replace('border-top:1px solid #1E293B; padding-top:8px;', 'border-top:1px solid #E2E8F0; padding-top:8px;')

# 5. Overview Spline & Donut Text
$content = $content.Replace('style="font-size:18px; font-weight:800; color:#FFFFFF;" id="kpiRevenueNum"', 'style="font-size:18px; font-weight:800; color:#1E293B;" id="kpiRevenueNum"')
$content = $content.Replace('style="font-size:24px; font-weight:900; color:#FFFFFF;" id="donutCenterPct"', 'style="font-size:24px; font-weight:900; color:#1E293B;" id="donutCenterPct"')
$content = $content.Replace('<strong style="color:#FFFFFF;" id="legendCompleted">', '<strong style="color:#1E293B;" id="legendCompleted">')
$content = $content.Replace('<strong style="color:#FFFFFF;" id="legendShipped">', '<strong style="color:#1E293B;" id="legendShipped">')
$content = $content.Replace('<strong style="color:#FFFFFF;" id="legendProcessing">', '<strong style="color:#1E293B;" id="legendProcessing">')
$content = $content.Replace('<strong style="color:#FFFFFF;" id="legendCanceled">', '<strong style="color:#1E293B;" id="legendCanceled">')

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done updating index.html colors!"
