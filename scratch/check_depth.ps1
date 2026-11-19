$lines = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$depth = 0
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    # Simple regex to strip strings and comments
    $stripped = $line -replace '`[^`]*`', '' -replace '"[^"]*"', '' -replace "'[^']*'", '' -replace '//.*$', ''
    $opens = ($stripped.ToCharArray() | Where-Object { $_ -eq '{' }).Count
    $closes = ($stripped.ToCharArray() | Where-Object { $_ -eq '}' }).Count
    $depth += ($opens - $closes)
    if ($depth -lt 0) {
        Write-Host "NEGATIVE DEPTH at line $($i+1): $line"
        break
    }
}
Write-Host "Final depth at end of file: $depth"
