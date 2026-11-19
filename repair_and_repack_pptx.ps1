Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$sourcePptx = 'c:\Users\cong chua sofia\Downloads\AII_DEMO\AI301_AI_AGENT_PITCH_DECK.pptx'
$tempDir = Join-Path $env:TEMP ('pptx_repair_' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $tempDir | Out-Null

Write-Host "1. Extracting existing PPTX..."
[System.IO.Compression.ZipFile]::ExtractToDirectory($sourcePptx, $tempDir)

Write-Host "2. Checking and repairing all XML files..."
Get-ChildItem -Path $tempDir -Recurse -File | ForEach-Object {
    $filePath = $_.FullName
    $ext = $_.Extension
    if ($ext -in @('.xml', '.rels')) {
        $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
        # Escape any unescaped '&' that is not part of a valid XML entity
        $repaired = [regex]::Replace($content, '&(?!(amp|lt|gt|quot|apos);)', '&amp;')
        if ($repaired -ne $content) {
            Write-Host ("   Repaired unescaped ampersands in: " + $_.Name)
            [System.IO.File]::WriteAllText($filePath, $repaired, [System.Text.Encoding]::UTF8)
        }
    }
}

Write-Host "3. Enhancing slideMaster1.xml with standard txStyles..."
$masterPath = Join-Path $tempDir "ppt\slideMasters\slideMaster1.xml"
if (Test-Path $masterPath) {
    $masterXml = [System.IO.File]::ReadAllText($masterPath, [System.Text.Encoding]::UTF8)
    if (-not $masterXml.Contains("<p:txStyles>")) {
        $txStyles = @'
  <p:txStyles>
    <p:titleStyle>
      <a:lvl1pPr algn="l">
        <a:defRPr sz="4000" kern="1200">
          <a:solidFill><a:schemeClr val="tx1"/></a:solidFill>
          <a:latin typeface="Segoe UI"/>
        </a:defRPr>
      </a:lvl1pPr>
    </p:titleStyle>
    <p:bodyStyle>
      <a:lvl1pPr marL="0" indent="0" algn="l">
        <a:defRPr sz="1600" kern="1200">
          <a:solidFill><a:schemeClr val="tx1"/></a:solidFill>
          <a:latin typeface="Segoe UI"/>
        </a:defRPr>
      </a:lvl1pPr>
    </p:bodyStyle>
    <p:otherStyle>
      <a:defPPr>
        <a:defRPr lang="vi-VN"/>
      </a:defPPr>
    </p:otherStyle>
  </p:txStyles>
</p:sldMaster>
'@
        $masterXml = $masterXml.Replace("</p:sldMaster>", $txStyles)
        [System.IO.File]::WriteAllText($masterPath, $masterXml, [System.Text.Encoding]::UTF8)
        Write-Host "   Added txStyles to slideMaster1.xml"
    }
}

Write-Host "4. Enhancing presentation.xml with defaultTextStyle..."
$presPath = Join-Path $tempDir "ppt\presentation.xml"
if (Test-Path $presPath) {
    $presXml = [System.IO.File]::ReadAllText($presPath, [System.Text.Encoding]::UTF8)
    if (-not $presXml.Contains("<p:defaultTextStyle>")) {
        $defStyle = @'
  <p:defaultTextStyle>
    <a:defPPr>
      <a:defRPr lang="vi-VN"/>
    </a:defPPr>
  </p:defaultTextStyle>
</p:presentation>
'@
        $presXml = $presXml.Replace("</p:presentation>", $defStyle)
        [System.IO.File]::WriteAllText($presPath, $presXml, [System.Text.Encoding]::UTF8)
        Write-Host "   Added defaultTextStyle to presentation.xml"
    }
}

Write-Host "5. Creating docProps/core.xml and docProps/app.xml..."
$docPropsDir = Join-Path $tempDir "docProps"
if (-not (Test-Path $docPropsDir)) {
    New-Item -ItemType Directory -Path $docPropsDir | Out-Null
}

$coreXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <dc:title>AI301 - AI Agent Pitch Deck - Cổng Quản Trị Khách Hàng B2B Nam Việt</dc:title>
  <dc:creator>Nhóm Đồ Án AI301</dc:creator>
  <cp:lastModifiedBy>Nhóm Đồ Án AI301</cp:lastModifiedBy>
  <cp:revision>1</cp:revision>
</cp:coreProperties>
'@
[System.IO.File]::WriteAllText((Join-Path $docPropsDir "core.xml"), $coreXml.Trim(), [System.Text.Encoding]::UTF8)

$appXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">
  <TotalTime>0</TotalTime>
  <Words>0</Words>
  <Application>Microsoft Office PowerPoint</Application>
  <PresentationFormat>Widescreen</PresentationFormat>
  <Paragraphs>0</Paragraphs>
  <Slides>15</Slides>
  <Notes>0</Notes>
  <HiddenSlides>0</HiddenSlides>
  <MMClips>0</MMClips>
  <ScaleCrop>false</ScaleCrop>
  <HeadingPairs><vt:vector size="4" baseType="variant"><vt:variant><vt:lpstr>Theme</vt:lpstr></vt:variant><vt:variant><vt:i4>1</vt:i4></vt:variant><vt:variant><vt:lpstr>Slide Titles</vt:lpstr></vt:variant><vt:variant><vt:i4>15</vt:i4></vt:variant></vt:vector></HeadingPairs>
  <TitlesOfParts><vt:vector size="16" baseType="lpstr"><vt:lpstr>NextGenAI</vt:lpstr><vt:lpstr>Slide 1</vt:lpstr><vt:lpstr>Slide 2</vt:lpstr><vt:lpstr>Slide 3</vt:lpstr><vt:lpstr>Slide 4</vt:lpstr><vt:lpstr>Slide 5</vt:lpstr><vt:lpstr>Slide 6</vt:lpstr><vt:lpstr>Slide 7</vt:lpstr><vt:lpstr>Slide 8</vt:lpstr><vt:lpstr>Slide 9</vt:lpstr><vt:lpstr>Slide 10</vt:lpstr><vt:lpstr>Slide 11</vt:lpstr><vt:lpstr>Slide 12</vt:lpstr><vt:lpstr>Slide 13</vt:lpstr><vt:lpstr>Slide 14</vt:lpstr><vt:lpstr>Slide 15</vt:lpstr></vt:vector></TitlesOfParts>
  <Company>Nam Việt Software</Company>
  <LinksUpToDate>false</LinksUpToDate>
  <SharedDoc>false</SharedDoc>
  <HyperlinksChanged>false</HyperlinksChanged>
  <AppVersion>16.0000</AppVersion>
</Properties>
'@
[System.IO.File]::WriteAllText((Join-Path $docPropsDir "app.xml"), $appXml.Trim(), [System.Text.Encoding]::UTF8)

# Update [Content_Types].xml to include docProps
$contentTypesPath = Join-Path $tempDir "[Content_Types].xml"
$ctXml = [System.IO.File]::ReadAllText($contentTypesPath, [System.Text.Encoding]::UTF8)
if (-not $ctXml.Contains("/docProps/core.xml")) {
    $ctInsert = @'
  <Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>
  <Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>
</Types>
'@
    $ctXml = $ctXml.Replace("</Types>", $ctInsert)
    [System.IO.File]::WriteAllText($contentTypesPath, $ctXml, [System.Text.Encoding]::UTF8)
    Write-Host "   Updated [Content_Types].xml"
}

# Update _rels/.rels to include docProps
$rootRelsPath = Join-Path $tempDir "_rels\.rels"
$rootRelsXml = [System.IO.File]::ReadAllText($rootRelsPath, [System.Text.Encoding]::UTF8)
if (-not $rootRelsXml.Contains("docProps/core.xml")) {
    $relInsert = @'
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>
  <Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>
</Relationships>
'@
    $rootRelsXml = $rootRelsXml.Replace("</Relationships>", $relInsert)
    [System.IO.File]::WriteAllText($rootRelsPath, $rootRelsXml, [System.Text.Encoding]::UTF8)
    Write-Host "   Updated _rels/.rels"
}

Write-Host "6. Validating every XML part before packaging..."
$hasXmlError = $false
Get-ChildItem -Path $tempDir -Recurse -File | ForEach-Object {
    if ($_.Extension -in @('.xml', '.rels')) {
        try {
            $doc = New-Object System.Xml.XmlDocument
            $doc.Load($_.FullName)
        } catch {
            $hasXmlError = $true
            Write-Host ("   ERROR IN " + $_.FullName + ": " + $_.Exception.Message) -ForegroundColor Red
        }
    }
}

if ($hasXmlError) {
    Write-Host "FATAL: XML validation failed. Aborting repack." -ForegroundColor Red
    exit 1
}

Write-Host "7. Repackaging into PPTX with STRICT FORWARD-SLASH (/) entry paths..."
$backupPptx = 'c:\Users\cong chua sofia\Downloads\AII_DEMO\AI301_AI_AGENT_PITCH_DECK.backup.pptx'
Copy-Item $sourcePptx $backupPptx -Force
Remove-Item $sourcePptx -Force

$zipStream = [System.IO.File]::Create($sourcePptx)
$archive = New-Object System.IO.Compression.ZipArchive($zipStream, [System.IO.Compression.ZipArchiveMode]::Create)

$allFiles = Get-ChildItem -Path $tempDir -Recurse -File
foreach ($file in $allFiles) {
    $relPath = $file.FullName.Substring($tempDir.Length).TrimStart('\', '/')
    # CRITICAL FIX: Convert Windows backslashes to forward slashes for OPC standard
    $entryName = $relPath.Replace('\', '/')
    
    $entry = $archive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
    $entryStream = $entry.Open()
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $entryStream.Write($bytes, 0, $bytes.Length)
    $entryStream.Close()
}

$archive.Dispose()
$zipStream.Close()

Remove-Item -Recurse -Force $tempDir

Write-Host "8. Verifying entries in the newly created PPTX..."
$verifyZip = [System.IO.Compression.ZipFile]::OpenRead($sourcePptx)
$backslashCount = 0
foreach ($entry in $verifyZip.Entries) {
    if ($entry.FullName.Contains('\')) {
        $backslashCount++
        Write-Host ("   WARNING: Entry still contains backslash: " + $entry.FullName) -ForegroundColor Yellow
    }
}
$totalEntries = $verifyZip.Entries.Count
$verifyZip.Dispose()

$finalSize = (Get-Item $sourcePptx).Length
Write-Host "DONE! File size: $finalSize bytes. Total entries: $totalEntries. Backslash entries: $backslashCount." -ForegroundColor Green
