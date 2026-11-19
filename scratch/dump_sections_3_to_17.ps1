$sections = (Get-Content -Path "scratch/step_3888_full_untruncated.txt" -Raw) -split "(?m)^##\s+"
for ($i = 3; $i -lt $sections.Count; $i++) {
    Write-Host "`n================================"
    Write-Host "SECTION $i"
    Write-Host "================================"
    $lines = $sections[$i].Trim() -split "`r?`n"
    foreach ($l in $lines) {
        Write-Host $l
    }
}
