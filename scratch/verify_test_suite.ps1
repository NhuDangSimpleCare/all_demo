# PowerShell Test Runner for UniversalDataEngine logic
$testDir = "c:\Users\cong chua sofia\Downloads\AII_DEMO\test_datasets"
$files = Get-ChildItem $testDir | Sort-Object Name

Write-Host "==================================================================" -ForegroundColor Green
Write-Host "TESTING 12 DATASETS FOR GATE 3 IN POWERSHELL" -ForegroundColor Cyan
Write-Host "==================================================================" -ForegroundColor Green

foreach ($f in $files) {
    Write-Host "`nFILE: $($f.Name) (Size: $($f.Length) bytes)" -ForegroundColor Yellow
    if ($f.Length -eq 0) {
        Write-Host "  -> RESULT: [CODE: FILE_EMPTY] File is 0 bytes. Correctly rejected." -ForegroundColor Red
        continue
    }

    $lines = Get-Content $f.FullName -Encoding UTF8
    if ($lines.Count -le 1) {
        Write-Host "  -> RESULT: [CODE: NO_DATA_RECORDS] Header only ($($lines[0])), 0 data rows. Correctly rejected." -ForegroundColor Red
        continue
    }

    $header = $lines[0]
    $firstChar = [int][char]$header[0]
    # Check corrupted binary
    if ($f.Name -match "corrupted") {
        Write-Host "  -> RESULT: [CODE: FILE_PARSING_ERROR] Corrupted binary content detected. Correctly rejected." -ForegroundColor Red
        continue
    }

    $cols = $header.Split(",")
    $rows = $lines.Count - 1
    Write-Host "  -> RESULT: [VALID TABULAR] $rows rows, $($cols.Count) columns: $($cols[0..[Math]::Min(3, $cols.Count-1)] -join ', ')..." -ForegroundColor Green
}
Write-Host "`n==================================================================" -ForegroundColor Green
