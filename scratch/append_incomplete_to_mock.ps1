$leadsJson = Get-Content 'c:\Users\cong chua sofia\Downloads\AII_DEMO\NamViet_DuLieuKhuyetThieu_TestDemo.json' -Raw | ConvertFrom-Json

$jsItems = [System.Collections.Generic.List[string]]::new()
foreach ($l in $leadsJson) {
    $cSize = if ($l.Employees -and $l.Employees -ne "0" -and $l.Employees -ne "") { $l.Employees } else { "0" }
    $bMill = if ($l.Budget -and $l.Budget -ne "0" -and $l.Budget -ne "") { $l.Budget } else { "0" }
    
    $itemStr = @"
  {
    lead_id: $($l.LeadId | ConvertTo-Json),
    created_at: $($l.CreatedAt | ConvertTo-Json),
    source: $($l.Source | ConvertTo-Json),
    company_name: $($l.CompanyName | ConvertTo-Json),
    tax_code: $($l.TaxCode | ConvertTo-Json),
    contact_name: $($l.ContactName | ConvertTo-Json),
    role: $($l.Role | ConvertTo-Json),
    phone: $($l.Phone | ConvertTo-Json),
    email: $($l.Email | ConvertTo-Json),
    industry: $($l.Industry | ConvertTo-Json),
    region: $($l.Region | ConvertTo-Json),
    province: $($l.Province | ConvertTo-Json),
    company_size: $($cSize | ConvertTo-Json),
    budget_million: $($bMill | ConvertTo-Json),
    requirement: $($l.Need | ConvertTo-Json),
    expected_flag: $($l.ExpectedFlag | ConvertTo-Json),
    missing_note: $($l.MissingNote | ConvertTo-Json)
  }
"@
    $jsItems.Add($itemStr)
}

$jsArray = "`r`n`r`n// ============================================================================`r`n" +
           "// 25 CA DỮ LIỆU KHUYẾT THIẾU KIỂM THỬ AI AGENT & LUẬT ZERO HALLUCINATION`r`n" +
           "// ============================================================================`r`n" +
           "window.INCOMPLETE_LEADS_25 = [`r`n" +
           [string]::Join(",`r`n", $jsItems) +
           "`r`n];`r`n"

$mockPath = 'c:\Users\cong chua sofia\Downloads\AII_DEMO\mock_data.js'
[System.IO.File]::AppendAllText($mockPath, $jsArray, [System.Text.Encoding]::UTF8)
Write-Host "Appended window.INCOMPLETE_LEADS_25 to mock_data.js successfully!"
