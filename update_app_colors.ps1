$filePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# 1. Update mapping meaning input & column strong (line 2735-2738)
$content = $content.Replace('<strong style="color:#FFFFFF;font-family:monospace;font-size:12.5px;">${m.originalColumn}</strong>', '<strong style="color:#1E293B;font-family:monospace;font-size:12.5px;">${m.originalColumn}</strong>')
$content = $content.Replace('style="padding:5px 8px;font-size:12px;background:rgba(15,23,42,0.7);border-radius:6px;width:100%;"', 'style="padding:6px 10px;font-size:12px;background:#FFFFFF;border:1.5px solid #CBD5E1;color:#1E293B;border-radius:6px;width:100%;"')

# 2. Update renderUniversalAnalytics (lines 2798-2815)
$oldCatBlock = @'
      catContainer.innerHTML = analytics.categorySummaries.map(c => `
        <div style="background:rgba(15,23,42,0.6);border:1px solid rgba(255,255,255,0.06);border-radius:10px;padding:12px 14px;">
          <div style="font-size:12.5px;font-weight:700;color:#F1F5F9;margin-bottom:8px;">
            Cột: <span style="color:#A78BFA;">${c.column}</span>
          </div>
          <div style="display:flex;flex-direction:column;gap:6px;">
            ${c.topValues.map(v => `
              <div style="display:flex;justify-content:space-between;align-items:center;font-size:11.5px;">
                <span style="color:#CBD5E1;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${v.value}</span>
                <span style="color:var(--cyan);font-weight:600;">${v.count} (${v.percent}%)</span>
              </div>
              <div style="background:rgba(255,255,255,0.06);height:4px;border-radius:2px;overflow:hidden;">
                <div style="background:var(--primary);width:${v.percent}%;height:100%;"></div>
              </div>
            `).join("")}
          </div>
        </div>
      `).join("");
'@

$newCatBlock = @'
      catContainer.innerHTML = analytics.categorySummaries.map(c => `
        <div style="background:#FFFFFF;border:1px solid #E2E8F0;border-radius:10px;padding:12px 14px;box-shadow:0 2px 8px rgba(0,0,0,0.03);">
          <div style="font-size:12.5px;font-weight:700;color:#1E293B;margin-bottom:8px;">
            Cột: <span style="color:#8B5CF6;">${c.column}</span>
          </div>
          <div style="display:flex;flex-direction:column;gap:6px;">
            ${c.topValues.map(v => `
              <div style="display:flex;justify-content:space-between;align-items:center;font-size:11.5px;">
                <span style="color:#475569;max-width:180px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;font-weight:500;">${v.value}</span>
                <span style="color:#06B6D4;font-weight:700;">${v.count} (${v.percent}%)</span>
              </div>
              <div style="background:#E2E8F0;height:6px;border-radius:3px;overflow:hidden;">
                <div style="background:linear-gradient(90deg, #FF2D87 0%, #FF9F0A 100%);width:${v.percent}%;height:100%;border-radius:3px;"></div>
              </div>
            `).join("")}
          </div>
        </div>
      `).join("");
'@

$content = $content.Replace($oldCatBlock.Replace("`r`n", "`n"), $newCatBlock.Replace("`r`n", "`n"))
$content = $content.Replace($oldCatBlock, $newCatBlock)

# 3. Update Dropdowns and Footer Metrics in Report HTML (lines 5240-5314)
$content = $content.Replace('id="repSelectDataset" onchange="onReportFilterChange()" style="background:#111827; border:1px solid var(--border-main); border-radius:6px; color:#F1F5F9; padding:5px 10px; font-size:12.5px; outline:none; font-weight:600;"', 'id="repSelectDataset" onchange="onReportFilterChange()" style="background:#FFFFFF; border:1.5px solid #CBD5E1; border-radius:8px; color:#1E293B; padding:6px 12px; font-size:12.5px; outline:none; font-weight:600;"')

$content = $content.Replace('id="repSelectPeriod" onchange="onReportFilterChange()" style="background:#111827; border:1px solid var(--border-main); border-radius:6px; color:#F1F5F9; padding:5px 10px; font-size:12.5px; outline:none;"', 'id="repSelectPeriod" onchange="onReportFilterChange()" style="background:#FFFFFF; border:1.5px solid #CBD5E1; border-radius:8px; color:#1E293B; padding:6px 12px; font-size:12.5px; outline:none; font-weight:600;"')

$content = $content.Replace('id="repFooterMetricsContainer" style="display:flex; justify-content:space-between; align-items:center; background:#111827; border:1px solid var(--border-main); border-radius:8px; padding:12px 18px; margin-top:10px; flex-wrap:wrap; gap:12px;"', 'id="repFooterMetricsContainer" style="display:flex; justify-content:space-between; align-items:center; background:#F8FAFC; border:1px solid #E2E8F0; border-radius:8px; padding:12px 18px; margin-top:10px; flex-wrap:wrap; gap:12px;"')

# 4. Chart 1 SVG Trend Line Grid and Labels (lines 6906-6955)
$content = $content.Replace("const txtFill = isLast ? '#34D399' : '#CBD5E1';", "const txtFill = isLast ? '#10B981' : '#64748B';")
$content = $content.Replace('stroke="rgba(255,255,255,0.06)" stroke-dasharray="3,3"', 'stroke="#E2E8F0" stroke-dasharray="3,3"')
$content = $content.Replace('stroke="rgba(255,255,255,0.1)"', 'stroke="#CBD5E1"')
$content = $content.Replace('fill="#94A3B8" font-size="10"', 'fill="#64748B" font-size="10"')

# 5. Chart 2 Donut SVG (lines 6985-7025)
$content = $content.Replace('<circle cx="50" cy="50" r="38" fill="none" stroke="#263247" stroke-width="14" />', '<circle cx="50" cy="50" r="38" fill="none" stroke="#E2E8F0" stroke-width="14" />')
$content = $content.Replace('color:#F1F5F9; font-weight:600;">${sl.name}</span>', 'color:#1E293B; font-weight:600;">${sl.name}</span>')
$content = $content.Replace('color:#F8FAFC;">${sl.val}</div>', 'color:#1E293B;">${sl.val}</div>')
$content = $content.Replace('color:#94A3B8;">${sl.pct}</div>', 'color:#64748B;">${sl.pct}</div>')
$content = $content.Replace('<div style="font-size:14px; font-weight:800; color:#FFFFFF;">${c2.centerVal}</div>', '<div style="font-size:14px; font-weight:800; color:#1E293B;">${c2.centerVal}</div>')
$content = $content.Replace('<div style="font-size:9.5px; color:#94A3B8;">${c2.centerLabel}</div>', '<div style="font-size:9.5px; color:#64748B; font-weight:600;">${c2.centerLabel}</div>')

# 6. Chart 4 Waterfall (lines 7068-7069)
$content = $content.Replace("const valColor = isNegative ? 'color:#C084FC;' : 'color:#34D399;'", "const valColor = isNegative ? 'color:#7C3AED;' : 'color:#059669;'")
$content = $content.Replace('const labelColor = isNegative ? ''style="color:#C084FC;"'' : '''';', 'const labelColor = isNegative ? ''style="color:#7C3AED; font-weight:600;"'' : '''';')

# 7. Footer Metrics Bar (line 7108)
$content = $content.Replace('<strong style="font-size:15px; color:#FFFFFF; margin-left:6px;">${ds.footerMetrics.val2}</strong>', '<strong style="font-size:15px; color:#1E293B; margin-left:6px;">${ds.footerMetrics.val2}</strong>')
$content = $content.Replace('<strong style="font-size:15px; color:#34D399; margin-left:6px;">${ds.footerMetrics.val1}</strong>', '<strong style="font-size:15px; color:#059669; margin-left:6px;">${ds.footerMetrics.val1}</strong>')

# 8. Deepdive Blocks (lines 7140-7183)
$content = $content.Replace('<div class="card-enterprise" style="background:#0E1526; border:1px solid var(--border-main); border-radius:12px; padding:20px; margin-bottom:18px;">', '<div class="card-enterprise" style="background:#FFFFFF; border:1px solid #E2E8F0; border-radius:12px; padding:20px; margin-bottom:18px; box-shadow:0 2px 8px rgba(0,0,0,0.02);">')
$content = $content.Replace('<div class="card-enterprise" style="background:#0E1526; border:1px solid var(--border-main); border-radius:12px; padding:20px;">', '<div class="card-enterprise" style="background:#FFFFFF; border:1px solid #E2E8F0; border-radius:12px; padding:20px; box-shadow:0 2px 8px rgba(0,0,0,0.02);">')
$content = $content.Replace('<h4 style="font-size:15px; font-weight:700; color:#FFFFFF; margin:0 0 12px 0;">', '<h4 style="font-size:15px; font-weight:700; color:#1E293B; margin:0 0 12px 0;">')
$content = $content.Replace('<div style="background:#111827; border:1px solid var(--border-main); border-radius:10px; padding:16px;">', '<div style="background:#F8FAFC; border:1px solid #E2E8F0; border-radius:10px; padding:16px;">')
$content = $content.Replace('<div style="font-size:13px; color:#CBD5E1; line-height:1.6;">', '<div style="font-size:13px; color:#475569; line-height:1.6;">')

# 9. Recommendation Action Cards (lines 7203-7213)
$content = $content.Replace('<h4 style="font-size:15px; font-weight:700; color:#FFFFFF; margin:0;">${r.title}</h4>', '<h4 style="font-size:15px; font-weight:700; color:#1E293B; margin:0;">${r.title}</h4>')
$content = $content.Replace('<div style="font-size:13px; color:#E2E8F0; line-height:1.6; margin-bottom:12px;">', '<div style="font-size:13px; color:#334155; line-height:1.6; margin-bottom:12px;">')
$content = $content.Replace('border-top:1px solid rgba(255,255,255,0.06); padding-top:10px;', 'border-top:1px solid #E2E8F0; padding-top:10px;')

# 10. Modals & Dialogs throughout app.js
$content = $content.Replace('style="background:#0E1526;border:1px solid var(--border-main);', 'style="background:#FFFFFF;border:1px solid #E2E8F0;box-shadow:0 2px 8px rgba(0,0,0,0.02);')
$content = $content.Replace('style="background:#111827;border:1px solid var(--border-main);', 'style="background:#F8FAFC;border:1px solid #E2E8F0;')
$content = $content.Replace('style="background:#111827;border:1px solid #1E293B;', 'style="background:#F8FAFC;border:1px solid #E2E8F0;')
$content = $content.Replace('style="background:#0E1526;padding:12px;border-radius:12px;border:1px solid var(--border-main);font-size:11.5px;color:#F1F5F9;"', 'style="background:#F8FAFC;padding:12px;border-radius:12px;border:1px solid #E2E8F0;font-size:11.5px;color:#1E293B;"')
$content = $content.Replace('style="display:grid;grid-template-columns:1fr 1fr;gap:12px;background:#0E1526;padding:16px;border-radius:10px;border:1px solid var(--border-main);margin-bottom:16px;font-size:13px;color:#F1F5F9;"', 'style="display:grid;grid-template-columns:1fr 1fr;gap:12px;background:#FFFFFF;padding:16px;border-radius:10px;border:1px solid #E2E8F0;margin-bottom:16px;font-size:13px;color:#1E293B;"')

[System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
Write-Host "Done updating app.js colors!"
