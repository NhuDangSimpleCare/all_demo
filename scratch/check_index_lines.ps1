$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw

function findLine($str) {
    $idx = $content.IndexOf($str)
    if ($idx -ge 0) {
        $lineNum = ($content.Substring(0, $idx) -split "`r?`n").Count
        Write-Host "Found '$str' around line $lineNum"
    } else {
        Write-Host "NOT FOUND: '$str'"
    }
}

findLine('id="navItemOverview"')
findLine('class="topbar-status-badge"')
findLine('id="universalFileInput"')
findLine('01 · Tiền Kiểm Định Cổng 3')
findLine('id="leadSearchInput"')
findLine('id="salesRosterGrid"')
findLine('id="taskTableBody"')
findLine('id="btnDownloadReportDoc"')
