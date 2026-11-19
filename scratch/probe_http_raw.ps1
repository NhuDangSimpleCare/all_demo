$client = New-Object System.Net.Sockets.TcpClient
$client.Connect("127.0.0.1", 8080)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$writer.Write("GET / HTTP/1.1`r`nHost: localhost:8080`r`nConnection: close`r`n`r`n")
$writer.Flush()
$reader = New-Object System.IO.StreamReader($stream)
$response = $reader.ReadToEnd()
$reader.Close()
$writer.Close()
$client.Close()

Write-Host "Response length: $($response.Length)"
if ($response.Contains("Kiểm tra nguồn dữ liệu") -and $response.Contains("Bối cảnh doanh nghiệp") -and $response.Contains("Trao đổi yêu cầu với AI")) {
    Write-Host "SUCCESS: The new sections 'Kiểm tra nguồn dữ liệu', 'Bối cảnh doanh nghiệp', 'Trao đổi yêu cầu với AI' are LIVE on http://localhost:8080/!"
} else {
    Write-Host "WARNING: Target text not found in response."
}
