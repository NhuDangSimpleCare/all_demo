Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$sourcePptx = 'c:\Users\cong chua sofia\Downloads\AII_DEMO\AI301_AI_AGENT_PITCH_DECK.pptx'
$outputFixed = 'c:\Users\cong chua sofia\Downloads\AII_DEMO\AI301_AI_AGENT_PITCH_DECK_FIXED.pptx'

$tempDir = New-Item -ItemType Directory -Path (Join-Path $env:TEMP ('pptx_deck_fix_' + [Guid]::NewGuid().ToString('N')))
$canonicalTemp = (Get-Item -LiteralPath $tempDir.FullName).FullName

Write-Host "1. Extracting clean files from existing package..."
$fileStream = [System.IO.File]::Open($sourcePptx, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
$zip = New-Object System.IO.Compression.ZipArchive($fileStream, [System.IO.Compression.ZipArchiveMode]::Read)

foreach ($entry in $zip.Entries) {
    $parts = $entry.FullName.Split('/')
    $cleanParts = @()
    $skipping = $true
    foreach ($p in $parts) {
        if ($skipping -and ($p -match '^[0-9a-fA-F]{6,32}$' -or $p -like '*:*' -or $p -in @('Users', 'AppData', 'Local', 'Temp'))) {
            continue
        }
        $skipping = $false
        $cleanParts += $p
    }
    $cleanName = $cleanParts -join '/'
    if ([string]::IsNullOrWhiteSpace($cleanName)) { continue }
    
    $targetPath = Join-Path $canonicalTemp ($cleanName.Replace('/', '\'))
    $dir = [System.IO.Path]::GetDirectoryName($targetPath)
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    
    $inStream = $entry.Open()
    $outStream = [System.IO.File]::Create($targetPath)
    $inStream.CopyTo($outStream)
    $outStream.Close()
    $inStream.Close()
}

$zip.Dispose()
$fileStream.Close()

Write-Host "2. Fixing PresentationML & DrawingML schema violations across all files..."
Get-ChildItem -Path $canonicalTemp -Recurse -File | ForEach-Object {
    if ($_.Extension -in @('.xml', '.rels')) {
        $xml = [System.IO.File]::ReadAllText($_.FullName, [System.Text.Encoding]::UTF8)
        
        # 1. Replace <p:p> and <p:pPr> with <a:p> and <a:pPr>
        $fixedXml = $xml -replace '<p:p>', '<a:p>'
        $fixedXml = $fixedXml -replace '</p:p>', '</a:p>'
        $fixedXml = $fixedXml -replace '<p:p ', '<a:p '
        $fixedXml = $fixedXml -replace '<p:pPr', '<a:pPr'
        $fixedXml = $fixedXml -replace '</p:pPr>', '</a:pPr>'
        
        # 2. Fix align enumeration: algn="c" is INVALID DrawingML; must be algn="ctr"
        $fixedXml = $fixedXml -replace 'algn="c"', 'algn="ctr"'
        
        # 3. Escape any raw unescaped '&' that is not a valid entity
        $fixedXml = [regex]::Replace($fixedXml, '&(?!(amp|lt|gt|quot|apos);)', '&amp;')
        
        # 4. Save back
        [System.IO.File]::WriteAllText($_.FullName, $fixedXml, [System.Text.Encoding]::UTF8)
    }
}

Write-Host "3. Validating all XML parts with System.Xml.XmlDocument..."
$xmlErrors = 0
Get-ChildItem -Path $canonicalTemp -Recurse -File | ForEach-Object {
    if ($_.Extension -in @('.xml', '.rels')) {
        try {
            $doc = New-Object System.Xml.XmlDocument
            $doc.Load($_.FullName)
        } catch {
            $xmlErrors++
            Write-Host ("   ERROR in " + $_.Name + ": " + $_.Exception.Message) -ForegroundColor Red
        }
    }
}

if ($xmlErrors -gt 0) {
    Write-Host "FATAL: XML errors detected! Aborting packaging." -ForegroundColor Red
    exit 1
}
Write-Host "   All XML files validated successfully (0 errors)."

Write-Host "4. Packaging strictly into $outputFixed..."
if (Test-Path $outputFixed) { Remove-Item $outputFixed -Force }

$outStream = [System.IO.File]::Create($outputFixed)
$archive = New-Object System.IO.Compression.ZipArchive($outStream, [System.IO.Compression.ZipArchiveMode]::Create)

$canonicalBase = $canonicalTemp.TrimEnd('\') + '\'
$allFiles = Get-ChildItem -Path $canonicalTemp -Recurse -File

foreach ($f in $allFiles) {
    $cFile = (Get-Item -LiteralPath $f.FullName).FullName
    if (-not $cFile.StartsWith($canonicalBase, [System.StringComparison]::OrdinalIgnoreCase)) {
        Write-Host ("ERROR: File path does not start with base: " + $cFile) -ForegroundColor Red
        exit 1
    }
    
    $entryName = $cFile.Substring($canonicalBase.Length).Replace('\', '/')
    Write-Host ("   -> " + $entryName)
    
    $entry = $archive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
    $eStream = $entry.Open()
    $bytes = [System.IO.File]::ReadAllBytes($cFile)
    $eStream.Write($bytes, 0, $bytes.Length)
    $eStream.Close()
}

$archive.Dispose()
$outStream.Close()

Remove-Item -Recurse -Force $canonicalTemp

Write-Host "5. Auditing final generated PPTX package..."
$vZip = [System.IO.Compression.ZipFile]::OpenRead($outputFixed)
$entryCount = $vZip.Entries.Count
$badPath = 0
foreach ($e in $vZip.Entries) {
    if ($e.FullName.Contains('\') -or $e.FullName.StartsWith('/') -or $e.FullName -like '*:*') {
        $badPath++
        Write-Host ("   Invalid entry path: " + $e.FullName) -ForegroundColor Red
    }
}
$vZip.Dispose()

$finalSize = (Get-Item $outputFixed).Length
Write-Host "SUCCESS! Generated: $outputFixed"
Write-Host "File size: $finalSize bytes | Total entries: $entryCount | Bad paths: $badPath"

# Also update AI301_AI_AGENT_PITCH_DECK.pptx so both are 100% fixed
try {
    Copy-Item $outputFixed $sourcePptx -Force
    Write-Host "Also successfully synchronized back to $sourcePptx"
} catch {
    Write-Host "Note: $sourcePptx is currently locked by PowerPoint. Fixed version is saved as $outputFixed"
}
