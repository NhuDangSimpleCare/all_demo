$port = 8080
$root = $PSScriptRoot
if (-not $root) { $root = Get-Location }

try {
    $listener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback, $port)
    $listener.Start()
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] May chu dang chay tai: http://localhost:$port" -ForegroundColor Cyan
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Thu muc: $root" -ForegroundColor DarkGray
} catch {
    Write-Host "[LOI] Khong the mo cong ${port}: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Vui long dong cac ung dung dang dung cong $port roi thu lai." -ForegroundColor Yellow
    exit 1
}

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".csv"  = "text/csv; charset=utf-8"
    ".xlsx" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ".xls"  = "application/vnd.ms-excel"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".png"  = "image/png"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
    ".ttf"  = "font/ttf"
}

try {
    while ($true) {
        $client = $listener.AcceptTcpClient()
        try {
            $stream = $client.GetStream()
            $reader = New-Object System.IO.StreamReader($stream, [System.Text.Encoding]::ASCII, $false, 1024, $true)
            $requestLine = $reader.ReadLine()
            if ($requestLine) {
                $parts = $requestLine.Split(" ")
                $rawPath = if ($parts.Length -ge 2) { $parts[1] } else { "/" }
                
                # Doc het cac header
                while ($true) {
                    $line = $reader.ReadLine()
                    if ([string]::IsNullOrEmpty($line)) { break }
                }

                $urlPath = [System.Uri]::UnescapeDataString(($rawPath -split "\?")[0])
                if ($urlPath -eq "/" -or [string]::IsNullOrEmpty($urlPath)) {
                    $urlPath = "/index.html"
                }
                $safeRel = $urlPath.TrimStart("/").Replace("/", "\")
                $filePath = Join-Path $root $safeRel

                if ((Test-Path $filePath) -and -not (Get-Item $filePath).PSIsContainer) {
                    $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
                    $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }
                    $bytes = [System.IO.File]::ReadAllBytes($filePath)
                    $header = "HTTP/1.1 200 OK`r`nContent-Type: $contentType`r`nContent-Length: $($bytes.Length)`r`nAccess-Control-Allow-Origin: *`r`nConnection: close`r`n`r`n"
                    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
                    $stream.Write($headerBytes, 0, $headerBytes.Length)
                    $stream.Write($bytes, 0, $bytes.Length)
                    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 200 OK  $urlPath" -ForegroundColor Green
                } else {
                    $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
                    $header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain; charset=utf-8`r`nContent-Length: $($msg.Length)`r`nConnection: close`r`n`r`n"
                    $headerBytes = [System.Text.Encoding]::ASCII.GetBytes($header)
                    $stream.Write($headerBytes, 0, $headerBytes.Length)
                    $stream.Write($msg, 0, $msg.Length)
                    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 404 FAIL $urlPath" -ForegroundColor Yellow
                }
            }
        } catch {
            # Bo qua loi ngat ket noi client
        } finally {
            $client.Close()
        }
    }
} finally {
    $listener.Stop()
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Da dung may chu." -ForegroundColor Gray
}
