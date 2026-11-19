function Test-FileBalance($file) {
    $code = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    $curly = 0; $bracket = 0; $paren = 0
    for ($i = 0; $i -lt $code.Length; $i++) {
        $c = $code[$i]
        if ($c -eq '{') { $curly++ }
        elseif ($c -eq '}') { $curly-- }
        elseif ($c -eq '[') { $bracket++ }
        elseif ($c -eq ']') { $bracket-- }
        elseif ($c -eq '(') { $paren++ }
        elseif ($c -eq ')') { $paren-- }
    }
    Write-Output "$file => Curly: $curly, Bracket: $bracket, Paren: $paren"
}

Test-FileBalance "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
Test-FileBalance "c:\Users\cong chua sofia\Downloads\AII_DEMO\ai_engine.js"
