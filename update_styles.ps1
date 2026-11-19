$filePath = "c:\Users\cong chua sofia\Downloads\AII_DEMO\styles.css"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# Find start and end indices
$startMarker = "/* 1. Panel Cards and Form Container Overrides */"
$endMarker = ".draft-textarea:focus {"

$idxStart = $content.IndexOf($startMarker)
if ($idxStart -ge 0) {
    $idxFocus = $content.IndexOf($endMarker, $idxStart)
    if ($idxFocus -ge 0) {
        $idxEnd = $content.IndexOf("}", $idxFocus) + 1
        $replacement = @"
/* 1. Panel Cards and Form Container Overrides */
.panel-card, .draft-card {
  background: #FFFFFF !important;
  border: 1px solid #E2E8F0 !important;
  color: #1E293B !important;
  border-radius: 12px !important;
  padding: 18px !important;
  margin-bottom: 16px !important;
}

.panel-card h3, .panel-card h4, .draft-card h3, .draft-card h4 {
  color: #1E293B !important;
}

/* 2. Light Theme Container Harmony */
[style*="background:#f8fafc"], [style*="background: #f8fafc"] {
  background: #F8FAFC !important;
  border-color: #E2E8F0 !important;
  color: #1E293B !important;
}
[style*="background:#f1f5f9"], [style*="background: #f1f5f9"] {
  background: #F1F5F9 !important;
  border-color: #CBD5E1 !important;
  color: #1E293B !important;
}
[style*="background:#fff"], [style*="background: #fff"],
[style*="background:#ffffff"], [style*="background: #ffffff"] {
  background: #FFFFFF !important;
  border-color: #E2E8F0 !important;
  color: #1E293B !important;
}

[style*="background:#fffbeb"], [style*="background: #fffbeb"],
[style*="background:#fef3c7"], [style*="background: #fef3c7"] {
  background: #FEF3C7 !important;
  border-color: #FCD34D !important;
  color: #92400E !important;
}

[style*="background:#eff6ff"], [style*="background: #eff6ff"],
[style*="background:#e0f2fe"], [style*="background: #e0f2fe"] {
  background: #E0F2FE !important;
  border-color: #BAE6FD !important;
  color: #0369A1 !important;
}

/* 3. Text color fixes inside cards */
[style*="color:#1e40af"], [style*="color: #1e40af"] {
  color: #1E40AF !important;
}

[style*="color:#64748b"], [style*="color: #64748b"] {
  color: #64748B !important;
}

[style*="color:#475569"], [style*="color: #475569"],
[style*="color:#334155"], [style*="color: #334155"],
[style*="color:#0f172a"], [style*="color: #0f172a"] {
  color: #1E293B !important;
}

[style*="color:#92400e"], [style*="color: #92400e"],
[style*="color:#b45309"], [style*="color: #b45309"] {
  color: #B45309 !important;
}

/* 4. Complete Button Contrast Fixes */
.btn-success, [class*="btn-success"] {
  background: #10B981 !important;
  border: 1px solid rgba(16, 185, 129, 0.4) !important;
  color: #FFFFFF !important;
  font-weight: 700 !important;
  box-shadow: 0 2px 8px rgba(16, 185, 129, 0.25) !important;
}
.btn-success:hover, [class*="btn-success"]:hover {
  background: #059669 !important;
  color: #FFFFFF !important;
}

.btn-outline, [class*="btn-outline"] {
  background: #FFFFFF !important;
  border: 1px solid #CBD5E1 !important;
  color: #334155 !important;
  font-weight: 600 !important;
}
.btn-outline:hover, [class*="btn-outline"]:hover {
  background: #F8FAFC !important;
  border-color: #FF2D87 !important;
  color: #FF2D87 !important;
}

.btn-primary, [class*="btn-primary"] {
  background: #FF2D87 !important;
  border: 1px solid #E91E78 !important;
  color: #FFFFFF !important;
  font-weight: 700 !important;
  box-shadow: 0 2px 10px rgba(255, 45, 135, 0.25) !important;
}
.btn-primary:hover, [class*="btn-primary"]:hover {
  background: #E91E78 !important;
  color: #FFFFFF !important;
}

.btn-warning, [class*="btn-warning"] {
  background: #FF9F0A !important;
  border: 1px solid #F59E0B !important;
  color: #FFFFFF !important;
  font-weight: 700 !important;
}
.btn-warning:hover, [class*="btn-warning"]:hover {
  background: #EA580C !important;
  color: #FFFFFF !important;
}

/* 5. Enterprise Tables & Data Tables */
.data-table {
  width: 100%;
  border-collapse: collapse;
  background: #FFFFFF !important;
  color: #1E293B !important;
}
.data-table th {
  background: #F8FAFC !important;
  color: #334155 !important;
  border-bottom: 2px solid #E2E8F0 !important;
  padding: 10px 14px !important;
  font-weight: 700 !important;
}
.data-table td {
  border-bottom: 1px solid #F1F5F9 !important;
  color: #1E293B !important;
  padding: 10px 14px !important;
}
.data-table tr:hover {
  background: #F8FAFC !important;
}

/* 6. Form Selects & Inputs */
.form-input, select.form-input, select, .ai-select {
  background: #FFFFFF !important;
  border: 1.5px solid #CBD5E1 !important;
  color: #1E293B !important;
  border-radius: 8px !important;
  padding: 8px 12px !important;
  font-size: 13px !important;
  outline: none !important;
}
select option, .ai-select option {
  background: #FFFFFF !important;
  color: #1E293B !important;
}
.form-input:focus, select:focus, .ai-select:focus {
  border-color: #FF2D87 !important;
  box-shadow: 0 0 0 3px rgba(255, 45, 135, 0.12) !important;
  outline: none !important;
}

/* 7. Textarea */
.draft-textarea {
  width: 100%;
  background: #FFFFFF !important;
  border: 1.5px solid #CBD5E1 !important;
  color: #1E293B !important;
  border-radius: 8px !important;
  padding: 12px !important;
  font-size: 13px !important;
  line-height: 1.6 !important;
  min-height: 90px !important;
}
.draft-textarea:focus {
  border-color: #FF2D87 !important;
  box-shadow: 0 0 0 3px rgba(255, 45, 135, 0.12) !important;
  outline: none !important;
}
"@
        $content = $content.Substring(0, $idxStart) + $replacement + $content.Substring($idxEnd)
        [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Successfully replaced Block 1!"
    }
} else {
    Write-Host "Start marker not found"
}
