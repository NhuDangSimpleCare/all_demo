$path = "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js"
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$content = $content.Replace("<button class=""btn-ai btn-ai-outline btn-ai-sm"" onclick=""askAIChat('NVKD nào đang có tải công việc thấp nhất?')"" >👥 Tải 8 NVKD</button>", "<button class=""btn-ai btn-ai-outline btn-ai-sm"" onclick=""askAIChat('Phân hạng P1 Hot có bao nhiêu khách hàng?')"" >🔥 Nhóm P1 Hot & SLA</button>")
$content = $content.Replace("onclick=""askAIChat('NVKD nào đang có tải công việc thấp nhất?')"" >👥 Tải 8 NVKD</button>", "onclick=""askAIChat('Phân hạng P1 Hot có bao nhiêu khách hàng?')"" >🔥 Nhóm P1 Hot & SLA</button>")
$content = $content.Replace("onclick=""askAIChat('NVKD nào đang có tải công việc thấp nhất?')"" >👥 Tải 8 NVKD", "onclick=""askAIChat('Phân hạng P1 Hot có bao nhiêu khách hàng?')"" >🔥 Nhóm P1 Hot & SLA")

# Replace AIChat reply
$oldChat = @'
  } else if (qLower.includes("nvkd") || qLower.includes("tải") || qLower.includes("thấp nhất") || qLower.includes("phân công")) {
    const least = [...res.repStats].sort((a,b) => (a.currentLoad + a.assignedCount) - (b.currentLoad + b.assignedCount))[0];
    reply = `Đội ngũ gồm 8 NVKD. Nhân viên có tải thấp nhất hiện tại là ${least.name} (${least.id} - ${least.region}) với ${least.currentLoad + least.assignedCount}/${least.weeklyCapacity} lead. Tất cả NVKD đều được chấm điểm ưu tiên theo 5 tiêu chí: CRM cũ (+45đ), Khu vực (+30đ), Ngành (+20đ), Chuyên môn (+20đ) và Tải trống (+15đ).`;
'@

$newChat = @'
  } else if (qLower.includes("p1") || qLower.includes("sla") || qLower.includes("hot") || qLower.includes("phân hạng")) {
    reply = `Hệ thống ghi nhận 204 khách hàng Tier P1 Hot (chiếm 64% giá trị Pipeline 11.8 tỷ VNĐ). Cam kết SLA phản hồi từ 15 phút đến 4 giờ làm việc. AI đã chuẩn bị sẵn sàng bộ kịch bản tư vấn và demo trực tiếp theo từng ngành nghề.`;
'@

$content = $content.Replace($oldChat.Trim(), $newChat.Trim())
$content = $content.Replace($oldChat.Replace("`r`n", "`n").Trim(), $newChat.Replace("`r`n", "`n").Trim())

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
Write-Output "AIChat cleanups applied."
