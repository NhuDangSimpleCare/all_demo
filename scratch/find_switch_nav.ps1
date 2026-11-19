$files = Get-ChildItem -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO" -Include *.html,*.js -Recurse
foreach ($f in $files) {
    $text = Get-Content -Path $f.FullName -Raw
    if ($text.Contains("function switchNavSection") -or $text.Contains("switchNavSection =") -or $text.Contains("switchNavSection(")) {
        Write-Host "Found in $($f.Name)"
        $lines = $text -split "`r?`n"
        for ($i=0; $i -lt $lines.Count; $i++) {
            if ($lines[$i] -match "switchNavSection") {
                Write-Host "   Line $($i+1): $($lines[$i].Trim())"
            }
        }
    }
}
