$client = New-Object System.Net.Sockets.TcpClient
$client.Connect("127.0.0.1", 8080)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)

$request = "GET /styles.css HTTP/1.1`r`nHost: localhost:8080`r`nConnection: close`r`n`r`n"
$writer.Write($request)
$writer.Flush()

$response = $reader.ReadToEnd()
$client.Close()

Write-Host "styles.css HTTP Response length:" $response.Length
if ($response -match "HTTP/1.[01] 200 OK" -and $response.Contains("step-card-clickable")) {
    Write-Host "styles.css is served correctly with status 200 OK!"
} else {
    Write-Host "Error serving styles.css"
}
