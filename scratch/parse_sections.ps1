$text = Get-Content -Path "scratch/step_3888_full.txt" -Raw
$sections = $text -split "(?m)^##\s+"
Write-Host "Total sections:" $sections.Count
$i = 0
foreach ($sec in $sections) {
    $firstLine = ($sec.Trim() -split "`r?`n")[0]
    Write-Host "Section $i : $firstLine"
    $i++
}
$sections | Out-File -FilePath "scratch/step_3888_sections.txt" -Encoding utf8
