$client = New-Object System.Net.Sockets.TcpClient
$client.Connect("127.0.0.1", 8080)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)

$request = "GET /app.js HTTP/1.1`r`nHost: localhost:8080`r`nConnection: close`r`n`r`n"
$writer.Write($request)
$writer.Flush()

$response = $reader.ReadToEnd()
$client.Close()

Write-Host "app.js HTTP Response length:" $response.Length
if ($response -match "HTTP/1.[01] 200 OK" -and $response.Contains("downloadExcelTemplate") -and $response.Contains("filterByRepCard")) {
    Write-Host "app.js is served correctly with status 200 OK!"
} else {
    Write-Host "Error serving app.js"
}
