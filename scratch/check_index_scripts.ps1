$html = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw
$scriptBlocks = [regex]::Matches($html, '<script>([\s\S]*?)<\/script>')
Write-Host "Found $($scriptBlocks.Count) inline script blocks in index.html"
$idx = 1
foreach ($sb in $scriptBlocks) {
    $code = $sb.Groups[1].Value
    $o = ($code -replace '[^{]', '').Length
    $c = ($code -replace '[^}]', '').Length
    $op = ($code -replace '[^(]', '').Length
    $cp = ($code -replace '[^)]', '').Length
    Write-Host "Block $idx - Braces: $o/$c, Parens: $op/$cp"
    $idx++
}
