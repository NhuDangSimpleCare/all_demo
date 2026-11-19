$client = New-Object System.Net.Sockets.TcpClient
$client.Connect("127.0.0.1", 8080)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)

$request = "GET /index.html HTTP/1.1`r`nHost: localhost:8080`r`nConnection: close`r`n`r`n"
$writer.Write($request)
$writer.Flush()

$response = $reader.ReadToEnd()
$client.Close()

Write-Host "HTTP Response length:" $response.Length
if ($response -match "HTTP/1.[01] 200 OK") {
    Write-Host "Status: 200 OK"
} else {
    Write-Host "Status NOT 200"
}

if ($response.Contains("downloadExcelTemplate") -and $response.Contains("openWorkflowStepModal")) {
    Write-Host "Verification: New interactive buttons found in served index.html!"
} else {
    Write-Host "Warning: Expected new elements not found in response."
}
