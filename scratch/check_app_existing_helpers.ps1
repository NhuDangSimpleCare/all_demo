$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw

$funcs = @("downloadReportDoc", "downloadReportMd", "downloadReportPdf", "exportLogsJson", "renderScoringTable", "renderSalesRosterAndLogsTab", "renderManagerApprovalTab")
foreach ($fn in $funcs) {
    $idx = $content.IndexOf("function $fn")
    if ($idx -lt 0) {
        $idx = $content.IndexOf("$fn =")
    }
    if ($idx -ge 0) {
        Write-Host "FOUND: $fn at position $idx"
        Write-Host $content.Substring($idx, [Math]::Min(300, $content.Length - $idx))
        Write-Host "--------------------------------"
    } else {
        Write-Host "NOT FOUND: $fn"
    }
}
