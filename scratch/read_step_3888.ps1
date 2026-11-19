$lines = Get-Content -Path "C:\Users\cong chua sofia\.gemini\antigravity\brain\bb1922cb-1ee3-4680-8b67-a8d197b5c314\.system_generated\logs\transcript.jsonl"
foreach ($line in $lines) {
    if ($line.Contains('"step_index":3888')) {
        $json = $line | ConvertFrom-Json
        $json.content | Out-File -FilePath "scratch/step_3888_full.txt" -Encoding utf8
        Write-Host "Exported step 3888"
        break
    }
}
