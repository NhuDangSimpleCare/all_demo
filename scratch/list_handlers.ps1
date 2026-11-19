$c = Get-Content 'c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html' -Raw
$pattern = 'onclick="([^"]+)"'
$matches = [regex]::Matches($c, $pattern)
$handlers = @{}
foreach ($m in $matches) {
    $h = $m.Groups[1].Value
    $handlers[$h] = $true
}
$handlers.Keys | Sort-Object | ForEach-Object {
    Write-Host $_
}
