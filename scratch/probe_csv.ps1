$client = New-Object System.Net.Http.HttpClient
try {
    $res = $client.GetAsync('http://localhost:8080/NamViet_DuLieuKhuyetThieu_TestDemo.csv').Result
    Write-Host "CSV Status Code: $($res.StatusCode)"
    Write-Host "Content Length: $($res.Content.Headers.ContentLength)"
    
    $resJson = $client.GetAsync('http://localhost:8080/NamViet_DuLieuKhuyetThieu_TestDemo.json').Result
    Write-Host "JSON Status Code: $($resJson.StatusCode)"
    Write-Host "Content Length: $($resJson.Content.Headers.ContentLength)"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
} finally {
    $client.Dispose()
}
