$content = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw
$matches = [regex]::Matches($content, '(<button[^>]*>|<a[^>]*class="[^"]*btn[^"]*"[^>]*>)')
Write-Host "Total button-like elements in index.html:" $matches.Count

$onclickMatches = [regex]::Matches($content, 'onclick="([^"]+)"')
Write-Host "Total onclick handlers:" $onclickMatches.Count

$report = @()
foreach ($m in $onclickMatches) {
    $report += $m.Groups[1].Value
}
$report | Sort-Object -Unique | Out-File -FilePath "scratch/unique_onclicks.txt" -Encoding utf8
Write-Host "Unique onclicks written to scratch/unique_onclicks.txt"
