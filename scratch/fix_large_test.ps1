$target = "c:\Users\cong chua sofia\Downloads\AII_DEMO\test_datasets\test_12_large_dataset.csv"
$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add("record_id,transaction_date,customer_name,service_tier,usage_hours,billed_amount,region")

$regions = @("Miền Bắc", "Miền Trung", "Miền Nam")
$tiers = @("Free Starter", "Professional SME", "Enterprise Cloud", "Dedicated Node")
$names = @("Hoàng Nam", "Bích Ngọc", "Quốc Bảo", "Thu Thủy", "Thanh Tùng", "Gia Huy", "Minh Tuấn", "Ánh Tuyết")

for ($i = 1; $i -le 2000; $i++) {
    $rId = "REC-" + $i.ToString("D5")
    $day = ($i % 28) + 1
    $date = "2026-04-" + $day.ToString("D2")
    $name = $names[$i % $names.Count] + " #" + ($i % 50)
    $tier = $tiers[$i % $tiers.Count]
    $hours = ($i * 7) % 350 + 10
    $billed = $hours * 125000
    $reg = $regions[$i % $regions.Count]

    $rowStr = '"' + $rId + '","' + $date + '","' + $name + '","' + $tier + '",' + $hours + ',' + $billed + ',"' + $reg + '"'
    $lines.Add($rowStr)
}

$utf8WithBom = New-Object System.Text.UTF8Encoding $true
[System.IO.File]::WriteAllText($target, [string]::Join("`r`n", $lines), $utf8WithBom)
Write-Host "test_12_large_dataset.csv created with $($lines.Count) lines!"
