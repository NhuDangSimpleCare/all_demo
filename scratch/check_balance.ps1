$code = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$openBraces = ($code.ToCharArray() | Where-Object { $_ -eq '{' }).Count
$closeBraces = ($code.ToCharArray() | Where-Object { $_ -eq '}' }).Count
$openParens = ($code.ToCharArray() | Where-Object { $_ -eq '(' }).Count
$closeParens = ($code.ToCharArray() | Where-Object { $_ -eq ')' }).Count
$openBrackets = ($code.ToCharArray() | Where-Object { $_ -eq '[' }).Count
$closeBrackets = ($code.ToCharArray() | Where-Object { $_ -eq ']' }).Count

Write-Host "Braces { }: $openBraces open, $closeBraces close"
Write-Host "Parens ( ): $openParens open, $closeParens close"
Write-Host "Brackets [ ]: $openBrackets open, $closeBrackets close"

if ($openBraces -eq $closeBraces -and $openParens -eq $closeParens -and $openBrackets -eq $closeBrackets) {
    Write-Host "ALL BRACKETS AND PARENS ARE BALANCED PERFECTLY!"
} else {
    Write-Host "WARNING: Unbalanced brackets detected!"
}
