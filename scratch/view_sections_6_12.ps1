$text = Get-Content -Path "scratch/dump_sections_out.txt" -Raw
$sections = $text -split "================================`r?`nSECTION "
for ($i = 1; $i -lt $sections.Count; $i++) {
    $secText = $sections[$i]
    $num = ($secText -split "`r?`n")[0]
    if ([int]$num -ge 6 -and [int]$num -le 12) {
        Write-Host ">>> SECTION $num"
        Write-Host $secText.Substring(0, [Math]::Min(1200, $secText.Length))
    }
}
