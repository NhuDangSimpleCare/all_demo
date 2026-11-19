$filePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# 1. Category Summaries (lines 2798-2815)
$content = $content.Replace('style="background:rgba(15,23,42,0.6);border:1px solid rgba(255,255,255,0.06);border-radius:10px;padding:12px 14px;"', 'style="background:#FFFFFF;border:1px solid #E2E8F0;border-radius:10px;padding:12px 14px;box-shadow:0 2px 8px rgba(0,0,0,0.03);"')
$content = $content.Replace('font-size:12.5px;font-weight:700;color:#F1F5F9;margin-bottom:8px;', 'font-size:12.5px;font-weight:700;color:#1E293B;margin-bottom:8px;')
$content = $content.Replace('<span style="color:#A78BFA;">${c.column}</span>', '<span style="color:#8B5CF6;">${c.column}</span>')
$content = $content.Replace('<span style="color:#CBD5E1;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${v.value}</span>', '<span style="color:#475569;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-weight:500;">${v.value}</span>')
$content = $content.Replace('<span style="color:var(--cyan);font-weight:600;">${v.count} (${v.percent}%)</span>', '<span style="color:#06B6D4;font-weight:700;">${v.count} (${v.percent}%)</span>')
$content = $content.Replace('style="background:rgba(255,255,255,0.06);height:4px;border-radius:2px;overflow:hidden;"', 'style="background:#E2E8F0;height:6px;border-radius:3px;overflow:hidden;"')
$content = $content.Replace('style="background:var(--primary);width:${v.percent}%;height:100%;"', 'style="background:linear-gradient(90deg, #FF2D87 0%, #FF9F0A 100%);width:${v.percent}%;height:100%;border-radius:3px;"')

# 2. KPI Section Parent Card (line 5228)
$content = $content.Replace('<div id="repSecKpi" class="card-enterprise" style="background:#0E1526; border:1px solid var(--border-main); border-radius:14px; padding:22px; margin-bottom:24px;">', '<div id="repSecKpi" class="card-enterprise" style="background:#FFFFFF; border:1px solid #E2E8F0; border-radius:14px; padding:22px; margin-bottom:24px; box-shadow:0 4px 16px rgba(0,0,0,0.03);">')
$content = $content.Replace('<h3 style="font-size:17px; font-weight:700; color:#FFFFFF; margin:0 0 3px 0;">Dashboard KPI kinh doanh</h3>', '<h3 style="font-size:17px; font-weight:700; color:#1E293B; margin:0 0 3px 0;">Dashboard KPI kinh doanh</h3>')
$content = $content.Replace('margin-bottom:20px; border-bottom:1px solid rgba(255,255,255,0.06); padding-bottom:14px;', 'margin-bottom:20px; border-bottom:1px solid #E2E8F0; padding-bottom:14px;')

# 3. Summary Callouts (lines 6821-6831)
$content = $content.Replace('<div style="background:#0E1526; border:1px solid var(--border-main); border-left:4px solid var(--${ds.summaryCallouts[0].accent === ''cyan'' ? ''cyan'' : ''warning''}); border-radius:10px; padding:14px 18px;">', '<div style="background:#FFFFFF; border:1px solid #E2E8F0; border-left:4px solid var(--${ds.summaryCallouts[0].accent === ''cyan'' ? ''cyan'' : ''warning''}); border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.03);">')
$content = $content.Replace('<div style="background:#0E1526; border:1px solid var(--border-main); border-left:4px solid var(--${ds.summaryCallouts[1].accent === ''warning'' ? ''warning'' : ''cyan''}); border-radius:10px; padding:14px 18px;">', '<div style="background:#FFFFFF; border:1px solid #E2E8F0; border-left:4px solid var(--${ds.summaryCallouts[1].accent === ''warning'' ? ''warning'' : ''cyan''}); border-radius:10px; padding:14px 18px; box-shadow:0 2px 8px rgba(0,0,0,0.03);">')
$content = $content.Replace('<div style="font-size:13.5px; color:#F1F5F9; line-height:1.6;">', '<div style="font-size:13.5px; color:#1E293B; line-height:1.6;">')

# 4. Datasource Section (lines 5355-5365)
$content = $content.Replace('<div id="repSecDatasource" class="card-enterprise" style="background:#0E1526; border:1px solid var(--border-main); border-radius:12px; padding:20px; margin-bottom:32px;">', '<div id="repSecDatasource" class="card-enterprise" style="background:#FFFFFF; border:1px solid #E2E8F0; border-radius:12px; padding:20px; margin-bottom:32px; box-shadow:0 2px 8px rgba(0,0,0,0.02);">')
$content = $content.Replace('<div style="background:#111827; border:1px solid var(--border-main); border-radius:8px; padding:12px 14px;">', '<div style="background:#F8FAFC; border:1px solid #E2E8F0; border-radius:8px; padding:12px 14px;">')

# 5. Review & Roster modals (lines 4414, 4500, 4715, 4733, 4938, 8277, 8504, 8779, 8783, 8873)
$content = $content.Replace('background:#0E1526;padding:8px 10px;', 'background:#F8FAFC;padding:8px 10px;')
$content = $content.Replace('color:#E2E8F0;margin-top:6px;background:#0E1526;', 'color:#1E293B;margin-top:6px;background:#F8FAFC;')
$content = $content.Replace('background:#0E1526;border:1px solid var(--border-main);padding:14px 16px;', 'background:#FFFFFF;border:1px solid #E2E8F0;padding:14px 16px;')
$content = $content.Replace('background:#111827;color:#FFFFFF;border:1px solid var(--border-main);', 'background:#FFFFFF;color:#1E293B;border:1.5px solid #CBD5E1;')
$content = $content.Replace('background:#0E1526;color:#FFF;', 'background:#FFFFFF;color:#1E293B;')
$content = $content.Replace('background:#0E1526; border:1px solid var(--border-main); padding:8px 12px;', 'background:#F8FAFC; border:1px solid #E2E8F0; padding:8px 12px;')
$content = $content.Replace('background:#0E1526; border:1px solid var(--border-main); border-radius:10px;', 'background:#FFFFFF; border:1px solid #E2E8F0; border-radius:10px;')
$content = $content.Replace('background:#0E1526; border:1px solid var(--border-main); padding:12px 14px;', 'background:#F8FAFC; border:1px solid #E2E8F0; padding:12px 14px;')

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done updating remaining app.js colors!"
