$lines = Get-Content -Path "C:\Users\cong chua sofia\.gemini\antigravity\brain\bb1922cb-1ee3-4680-8b67-a8d197b5c314\.system_generated\logs\transcript.jsonl"
foreach ($line in $lines) {
    if ($line.Contains('"type":"USER_INPUT"')) {
        $json = $line | ConvertFrom-Json
        Write-Host "Step:" $json.step_index "Created:" $json.created_at
        if ($json.content) {
            Write-Host "Content preview:" ($json.content.Substring(0, [Math]::Min(150, $json.content.Length)))
        }
    }
}
