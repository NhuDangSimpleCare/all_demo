# Complete 15-Slide Presentation Deck Generator for AI301 Project (Nam Viet AI Agent)
Add-Type -AssemblyName System.IO.Compression.FileSystem

$outputPptx = "c:\Users\cong chua sofia\Downloads\AII_DEMO\AI301_AI_AGENT_PRESENTATION.pptx"
$tempDir = Join-Path $env:TEMP ("pptx_deck_" + [Guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tempDir | Out-Null

$relsDir = Join-Path $tempDir "_rels"
New-Item -ItemType Directory -Path $relsDir | Out-Null

$pptDir = Join-Path $tempDir "ppt"
New-Item -ItemType Directory -Path $pptDir | Out-Null
$pptRelsDir = Join-Path $pptDir "_rels"
New-Item -ItemType Directory -Path $pptRelsDir | Out-Null
$pptSlidesDir = Join-Path $pptDir "slides"
New-Item -ItemType Directory -Path $pptSlidesDir | Out-Null
$pptSlidesRelsDir = Join-Path $pptSlidesDir "_rels"
New-Item -ItemType Directory -Path $pptSlidesRelsDir | Out-Null
$pptLayoutsDir = Join-Path $pptDir "slideLayouts"
New-Item -ItemType Directory -Path $pptLayoutsDir | Out-Null
$pptLayoutsRelsDir = Join-Path $pptLayoutsDir "_rels"
New-Item -ItemType Directory -Path $pptLayoutsRelsDir | Out-Null
$pptMastersDir = Join-Path $pptDir "slideMasters"
New-Item -ItemType Directory -Path $pptMastersDir | Out-Null
$pptMastersRelsDir = Join-Path $pptMastersDir "_rels"
New-Item -ItemType Directory -Path $pptMastersRelsDir | Out-Null
$pptThemeDir = Join-Path $pptDir "theme"
New-Item -ItemType Directory -Path $pptThemeDir | Out-Null

# 1. [Content_Types].xml
$sbContentTypes = [System.Text.StringBuilder]::new()
[void]$sbContentTypes.AppendLine('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
[void]$sbContentTypes.AppendLine('<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">')
[void]$sbContentTypes.AppendLine('  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>')
[void]$sbContentTypes.AppendLine('  <Default Extension="xml" ContentType="application/xml"/>')
[void]$sbContentTypes.AppendLine('  <Override PartName="/ppt/presentation.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"/>')
[void]$sbContentTypes.AppendLine('  <Override PartName="/ppt/slideMasters/slideMaster1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideMaster+xml"/>')
[void]$sbContentTypes.AppendLine('  <Override PartName="/ppt/slideLayouts/slideLayout1.xml" ContentType="application/vnd.openxmlformats-officedocument.presentationml.slideLayout+xml"/>')
[void]$sbContentTypes.AppendLine('  <Override PartName="/ppt/theme/theme1.xml" ContentType="application/vnd.openxmlformats-officedocument.theme+xml"/>')
for ($i = 1; $i -le 15; $i++) {
    [void]$sbContentTypes.AppendLine("  <Override PartName=`"/ppt/slides/slide$i.xml`" ContentType=`"application/vnd.openxmlformats-officedocument.presentationml.slide+xml`"/>")
}
[void]$sbContentTypes.AppendLine('</Types>')
[System.IO.File]::WriteAllText((Join-Path $tempDir "[Content_Types].xml"), $sbContentTypes.ToString(), [System.Text.Encoding]::UTF8)

# 2. _rels/.rels
$rootRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="ppt/presentation.xml"/>
</Relationships>
'@
[System.IO.File]::WriteAllText((Join-Path $relsDir ".rels"), $rootRels, [System.Text.Encoding]::UTF8)

# 3. ppt/presentation.xml
$sbPres = [System.Text.StringBuilder]::new()
[void]$sbPres.AppendLine('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
[void]$sbPres.AppendLine('<p:presentation xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">')
[void]$sbPres.AppendLine('  <p:sldMasterIdLst>')
[void]$sbPres.AppendLine('    <p:sldMasterId id="2147483648" r:id="rId1"/>')
[void]$sbPres.AppendLine('  </p:sldMasterIdLst>')
[void]$sbPres.AppendLine('  <p:sldIdLst>')
for ($i = 1; $i -le 15; $i++) {
    $sldId = 255 + $i
    $relId = "rId" + ($i + 1)
    [void]$sbPres.AppendLine("    <p:sldId id=`"$sldId`" r:id=`"$relId`"/>")
}
[void]$sbPres.AppendLine('  </p:sldIdLst>')
[void]$sbPres.AppendLine('  <p:sldSz cx="12192000" cy="6858000" type="screen16x9"/>')
[void]$sbPres.AppendLine('  <p:notesSz cx="6858000" cy="9144000"/>')
[void]$sbPres.AppendLine('</p:presentation>')
[System.IO.File]::WriteAllText((Join-Path $pptDir "presentation.xml"), $sbPres.ToString(), [System.Text.Encoding]::UTF8)

# 4. ppt/_rels/presentation.xml.rels
$sbPresRels = [System.Text.StringBuilder]::new()
[void]$sbPresRels.AppendLine('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
[void]$sbPresRels.AppendLine('<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">')
[void]$sbPresRels.AppendLine('  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="slideMasters/slideMaster1.xml"/>')
for ($i = 1; $i -le 15; $i++) {
    $relId = "rId" + ($i + 1)
    [void]$sbPresRels.AppendLine("  <Relationship Id=`"$relId`" Type=`"http://schemas.openxmlformats.org/officeDocument/2006/relationships/slide`" Target=`"slides/slide$i.xml`"/>")
}
[void]$sbPresRels.AppendLine('</Relationships>')
[System.IO.File]::WriteAllText((Join-Path $pptRelsDir "presentation.xml.rels"), $sbPresRels.ToString(), [System.Text.Encoding]::UTF8)

# 5. Master, Layout, Theme
$masterXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sldMaster xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">
  <p:cSld>
    <p:bg><p:bgRef idx="1001"><a:schemeClr val="bg1"/></p:bgRef></p:bg>
    <p:spTree>
      <p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>
      <p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>
    </p:spTree>
  </p:cSld>
  <p:clrMap bg1="lt1" tx1="dk1" bg2="lt2" tx2="dk2" accent1="accent1" accent2="accent2" accent3="accent3" accent4="accent4" accent5="accent5" accent6="accent6" hlink="hlink" folHlink="folHlink"/>
  <p:sldLayoutIdLst><p:sldLayoutId id="2147483649" r:id="rId1"/></p:sldLayoutIdLst>
</p:sldMaster>
'@
[System.IO.File]::WriteAllText((Join-Path $pptMastersDir "slideMaster1.xml"), $masterXml, [System.Text.Encoding]::UTF8)

$masterRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme" Target="../theme/theme1.xml"/>
</Relationships>
'@
[System.IO.File]::WriteAllText((Join-Path $pptMastersRelsDir "slideMaster1.xml.rels"), $masterRels, [System.Text.Encoding]::UTF8)

$layoutXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<p:sldLayout xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main" type="blank" preserve="1">
  <p:cSld name="Blank">
    <p:spTree>
      <p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>
      <p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>
    </p:spTree>
  </p:cSld>
  <p:clrMapOvr><a:masterClrMapping/></p:clrMapOvr>
</p:sldLayout>
'@
[System.IO.File]::WriteAllText((Join-Path $pptLayoutsDir "slideLayout1.xml"), $layoutXml, [System.Text.Encoding]::UTF8)

$layoutRels = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideMaster" Target="../slideMasters/slideMaster1.xml"/>
</Relationships>
'@
[System.IO.File]::WriteAllText((Join-Path $pptLayoutsRelsDir "slideLayout1.xml.rels"), $layoutRels, [System.Text.Encoding]::UTF8)

$themeXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<a:theme xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" name="VisionUI">
  <a:themeElements>
    <a:clrScheme name="VisionUI">
      <a:dk1><a:srgbClr val="FFFFFF"/></a:dk1>
      <a:lt1><a:srgbClr val="060B28"/></a:lt1>
      <a:dk2><a:srgbClr val="CBD5E1"/></a:dk2>
      <a:lt2><a:srgbClr val="0F172A"/></a:lt2>
      <a:accent1><a:srgbClr val="00D4FF"/></a:accent1>
      <a:accent2><a:srgbClr val="01B574"/></a:accent2>
      <a:accent3><a:srgbClr val="7928CA"/></a:accent3>
      <a:accent4><a:srgbClr val="FF0080"/></a:accent4>
      <a:accent5><a:srgbClr val="FFB547"/></a:accent5>
      <a:accent6><a:srgbClr val="E31A1A"/></a:accent6>
      <a:hlink><a:srgbClr val="00D4FF"/></a:hlink>
      <a:folHlink><a:srgbClr val="7928CA"/></a:folHlink>
    </a:clrScheme>
    <a:fontScheme name="ModernFonts">
      <a:majorFont><a:latin typeface="Segoe UI"/><a:ea typeface=""/><a:cs typeface=""/></a:majorFont>
      <a:minorFont><a:latin typeface="Segoe UI"/><a:ea typeface=""/><a:cs typeface=""/></a:minorFont>
    </a:fontScheme>
    <a:fmtScheme name="Office">
      <a:fillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:fillStyleLst>
      <a:lnStyleLst><a:ln w="9525"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:ln><a:ln w="25400"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:ln><a:ln w="38100"><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:ln></a:lnStyleLst>
      <a:effectStyleLst><a:effectLst/><a:effectLst/><a:effectLst/></a:effectStyleLst>
      <a:bgFillStyleLst><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill><a:solidFill><a:schemeClr val="phClr"/></a:solidFill></a:bgFillStyleLst>
    </a:fmtScheme>
  </a:themeElements>
</a:theme>
'@
[System.IO.File]::WriteAllText((Join-Path $pptThemeDir "theme1.xml"), $themeXml, [System.Text.Encoding]::UTF8)

function Escape-Xml([string]$text) {
    if ([string]::IsNullOrEmpty($text)) { return "" }
    return $text.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace('"', "&quot;").Replace("'", "&apos;")
}

function Build-ShapeXml {
    param(
        [int]$id,
        [string]$name,
        [long]$x,
        [long]$y,
        [long]$cx,
        [long]$cy,
        [string]$bgFill = "",
        [string]$borderColor = "",
        [int]$borderWidth = 12700,
        [int]$radius = 0,
        [array]$paragraphs = @()
    )

    $spXml = [System.Text.StringBuilder]::new()
    [void]$spXml.AppendLine("      <p:sp>")
    [void]$spXml.AppendLine("        <p:nvSpPr>")
    [void]$spXml.AppendLine("          <p:cNvPr id=`"$id`" name=`"$name`"/>")
    [void]$spXml.AppendLine("          <p:cNvSpPr><a:spLocks noGrp=`"1`"/></p:cNvSpPr>")
    [void]$spXml.AppendLine("          <p:nvPr/>")
    [void]$spXml.AppendLine("        </p:nvSpPr>")
    [void]$spXml.AppendLine("        <p:spPr>")
    [void]$spXml.AppendLine("          <a:xfrm>")
    [void]$spXml.AppendLine("            <a:off x=`"$x`" y=`"$y`"/>")
    [void]$spXml.AppendLine("            <a:ext cx=`"$cx`" cy=`"$cy`"/>")
    [void]$spXml.AppendLine("          </a:xfrm>")

    if ($radius -gt 0) {
        [void]$spXml.AppendLine("          <a:prstGeom prst=`"roundRect`">")
        [void]$spXml.AppendLine("            <a:avLst><a:gd name=`"adj`" fmla=`"val $radius`"/></a:avLst>")
        [void]$spXml.AppendLine("          </a:prstGeom>")
    } else {
        [void]$spXml.AppendLine("          <a:prstGeom prst=`"rect`"><a:avLst/></a:prstGeom>")
    }

    if (![string]::IsNullOrEmpty($bgFill)) {
        [void]$spXml.AppendLine("          <a:solidFill><a:srgbClr val=`"$bgFill`"/></a:solidFill>")
    } else {
        [void]$spXml.AppendLine("          <a:noFill/>")
    }

    if (![string]::IsNullOrEmpty($borderColor)) {
        [void]$spXml.AppendLine("          <a:ln w=`"$borderWidth`"><a:solidFill><a:srgbClr val=`"$borderColor`"/></a:solidFill></a:ln>")
    } else {
        [void]$spXml.AppendLine("          <a:ln><a:noFill/></a:ln>")
    }

    [void]$spXml.AppendLine("        </p:spPr>")
    [void]$spXml.AppendLine("        <p:txBody>")
    [void]$spXml.AppendLine("          <a:bodyPr vert=`"horz`" lIns=`"160000`" tIns=`"160000`" rIns=`"160000`" bIns=`"160000`"/>")
    [void]$spXml.AppendLine("          <a:lstStyle/>")

    foreach ($p in $paragraphs) {
        $pText = Escape-Xml $p.Text
        $pSize = if ($p.Size) { $p.Size } else { 1100 }
        $pColor = if ($p.Color) { $p.Color } else { "FFFFFF" }
        $pBold = if ($p.Bold) { " b=`"1`"" } else { "" }
        $pAlign = if ($p.Align) { $p.Align } else { "l" }
        $pSpace = if ($p.SpacingBefore) { "<a:spcBef><a:spcPts val=`"$($p.SpacingBefore)`"/></a:spcBef>" } else { "" }

        [void]$spXml.AppendLine("          <p:p>")
        [void]$spXml.AppendLine("            <p:pPr algn=`"$pAlign`">$pSpace</p:pPr>")
        [void]$spXml.AppendLine("            <a:r>")
        [void]$spXml.AppendLine("              <a:rPr lang=`"vi-VN`" sz=`"$pSize`"$pBold>")
        [void]$spXml.AppendLine("                <a:solidFill><a:srgbClr val=`"$pColor`"/></a:solidFill>")
        [void]$spXml.AppendLine("                <a:latin typeface=`"Segoe UI`"/>")
        [void]$spXml.AppendLine("              </a:rPr>")
        [void]$spXml.AppendLine("              <a:t>$pText</a:t>")
        [void]$spXml.AppendLine("            </a:r>")
        [void]$spXml.AppendLine("          </p:p>")
    }

    [void]$spXml.AppendLine("        </p:txBody>")
    [void]$spXml.AppendLine("      </p:sp>")
    return $spXml.ToString()
}

function Create-SlideXml {
    param(
        [int]$slideNum,
        [string]$category,
        [string]$title,
        [string]$subtitle,
        [array]$cards, # Array of hash: @{ Title=""; Badge=""; Color="00D4FF"; Items=@(); X=0; Y=0; W=0; H=0 }
        [bool]$isHero = $false
    )

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
    [void]$sb.AppendLine('<p:sld xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:p="http://schemas.openxmlformats.org/presentationml/2006/main">')
    [void]$sb.AppendLine('  <p:cSld>')
    [void]$sb.AppendLine('    <p:bg><p:bgPr><a:solidFill><a:srgbClr val="060B28"/></a:solidFill></p:bgPr></p:bg>')
    [void]$sb.AppendLine('    <p:spTree>')
    [void]$sb.AppendLine('      <p:nvGrpSpPr><p:cNvPr id="1" name=""/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>')
    [void]$sb.AppendLine('      <p:grpSpPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="0" cy="0"/><a:chOff x="0" y="0"/><a:chExt cx="0" cy="0"/></a:xfrm></p:grpSpPr>')

    $shapeId = 2

    if ($isHero) {
        # Hero layout for Slide 1
        $heroBadge = @(
            @{ Text = $category; Size = 1300; Color = "00D4FF"; Bold = $true; Align = "c" }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "HeroBadge" -x 1200000 -y 800000 -cx 9792000 -cy 500000 -bgFill "0B1437" -borderColor "00D4FF" -borderWidth 15000 -radius 8000 -paragraphs $heroBadge))

        $heroTitle = @(
            @{ Text = $title; Size = 2800; Color = "FFFFFF"; Bold = $true; Align = "c"; SpacingBefore = 200 },
            @{ Text = $subtitle; Size = 1400; Color = "CBD5E1"; Bold = $false; Align = "c"; SpacingBefore = 600 },
            @{ Text = "ĐỀ TÀI SỐ 02: AI AGENT TRONG QUY TRÌNH TIẾP NHẬN & PHÂN TÍCH LEAD (NAM VIỆT SOFT)"; Size = 1200; Color = "00D4FF"; Bold = $true; Align = "c"; SpacingBefore = 600 }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "HeroTitle" -x 1000000 -y 1500000 -cx 10192000 -cy 2200000 -paragraphs $heroTitle))

        # 3 Hero Feature Badges
        $b1 = @(
            @{ Text = "⚡ 700 LEADS/TUẦN"; Size = 1300; Color = "00D4FF"; Bold = $true; Align = "c" },
            @{ Text = "Tự động hóa 3 kênh tiếp nhận"; Size = 1000; Color = "94A3B8"; Align = "c"; SpacingBefore = 200 }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Stat1" -x 1200000 -y 4000000 -cx 2900000 -cy 1400000 -bgFill "0F172A" -borderColor "00D4FF" -radius 8000 -paragraphs $b1))

        $b2 = @(
            @{ Text = "💎 538 GOLDEN RECORDS"; Size = 1300; Color = "01B574"; Bold = $true; Align = "c" },
            @{ Text = "Khử sạch 162 cuộc gọi trùng lặp"; Size = 1000; Color = "94A3B8"; Align = "c"; SpacingBefore = 200 }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Stat2" -x 4646000 -y 4000000 -cx 2900000 -cy 1400000 -bgFill "0F172A" -borderColor "01B574" -radius 8000 -paragraphs $b2))

        $b3 = @(
            @{ Text = "🛡️ CHỐNG 48 BẪY ẢO"; Size = 1300; Color = "FFB547"; Bold = $true; Align = "c" },
            @{ Text = "Triệt tiêu 12,8 tỷ ngân sách ảo"; Size = 1000; Color = "94A3B8"; Align = "c"; SpacingBefore = 200 }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Stat3" -x 8092000 -y 4000000 -cx 2900000 -cy 1400000 -bgFill "0F172A" -borderColor "FFB547" -radius 8000 -paragraphs $b3))

        $footer = @(
            @{ Text = "NHÓM NGHIÊN CỨU AI301 · NỀN TẢNG GOOGLE ANTIGRAVITY AGENT WORKSPACE · VISION UI LOCALHOST 8080"; Size = 900; Color = "64748B"; Align = "c" }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Footer" -x 1000000 -y 5900000 -cx 10192000 -cy 400000 -paragraphs $footer))

    } else {
        # Standard Slide Header
        $hdr = @(
            @{ Text = $category.ToUpper(); Size = 1000; Color = "00D4FF"; Bold = $true }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Category" -x 600000 -y 380000 -cx 11000000 -cy 280000 -paragraphs $hdr))

        $ttl = @(
            @{ Text = $title; Size = 2000; Color = "FFFFFF"; Bold = $true },
            @{ Text = $subtitle; Size = 1100; Color = "94A3B8"; Bold = $false; SpacingBefore = 200 }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "TitleSubtitle" -x 600000 -y 680000 -cx 11000000 -cy 900000 -paragraphs $ttl))

        # Render Cards
        foreach ($c in $cards) {
            $cardPars = [System.Collections.ArrayList]::new()
            
            # Card Title & Badge
            $titleText = if ($c.Badge) { "[$($c.Badge)] $($c.Title)" } else { $c.Title }
            [void]$cardPars.Add(@{ Text = $titleText; Size = 1250; Color = $c.Color; Bold = $true })

            if ($c.Subtitle) {
                [void]$cardPars.Add(@{ Text = $c.Subtitle; Size = 950; Color = "94A3B8"; Bold = $false; SpacingBefore = 100 })
            }

            foreach ($item in $c.Items) {
                [void]$cardPars.Add(@{ Text = "• " + $item; Size = 1000; Color = "F8FAFC"; Bold = $false; SpacingBefore = 250 })
            }

            $bColor = if ($c.Border) { $c.Border } else { "1E293B" }
            [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "Card" -x $c.X -y $c.Y -cx $c.W -cy $c.H -bgFill "0F172A" -borderColor $bColor -borderWidth 12700 -radius 6000 -paragraphs $cardPars.ToArray()))
        }

        # Footer Left
        $fLeft = @(
            @{ Text = "HỌC PHẦN AI301 · ĐỒ ÁN AI AGENT NAM VIỆT SOFT (B2B LEAD MANAGEMENT WORKFLOW)"; Size = 800; Color = "64748B" }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "FooterL" -x 600000 -y 6420000 -cx 8000000 -cy 250000 -paragraphs $fLeft))

        # Footer Right
        $fRight = @(
            @{ Text = "SLIDE $slideNum / 15"; Size = 850; Color = "00D4FF"; Bold = $true; Align = "r" }
        )
        [void]$sb.Append((Build-ShapeXml -id ($shapeId++) -name "FooterR" -x 10000000 -y 6420000 -cx 1600000 -cy 250000 -paragraphs $fRight))
    }

    [void]$sb.AppendLine('    </p:spTree>')
    [void]$sb.AppendLine('  </p:cSld>')
    [void]$sb.AppendLine('  <p:clrMapOvr><a:masterClrMapping/></p:clrMapOvr>')
    [void]$sb.AppendLine('</p:sld>')

    $slideFile = Join-Path $pptSlidesDir "slide$slideNum.xml"
    [System.IO.File]::WriteAllText($slideFile, $sb.ToString(), [System.Text.Encoding]::UTF8)

    # slide rels
    $slideRelXml = @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/slideLayout" Target="../slideLayouts/slideLayout1.xml"/>
</Relationships>
'@
    $relFile = Join-Path $pptSlidesRelsDir "slide$slideNum.xml.rels"
    [System.IO.File]::WriteAllText($relFile, $slideRelXml, [System.Text.Encoding]::UTF8)
}

Write-Host "Slide creator loaded. Generating 15 slides..."

# ==============================================================================
# SLIDE 1: Title Slide (Hero)
# ==============================================================================
Create-SlideXml -slideNum 1 `
    -category "BÁO CÁO ĐỒ ÁN MÔN HỌC AI301 · HỆ THỐNG AI AGENT DOANH NGHIỆP" `
    -title "AI AGENT TRONG TỰ ĐỘNG HÓA QUY TRÌNH PHÂN TÍCH & QUẢN LÝ KHÁCH HÀNG" `
    -subtitle "Giải pháp Sàng lọc Đa kênh, Hợp nhất Hồ sơ Trùng (Golden Records), Triệt tiêu Bẫy Ảo & Điều phối 8 NVKD" `
    -cards @() -isHero $true

# ==============================================================================
# SLIDE 2: Bối cảnh Doanh nghiệp Nam Việt & Bài toán 700 Leads/Tuần
# ==============================================================================
$s2_cards = @(
    @{
        Title = "Nam Việt Soft & Bộ 5 Sản Phẩm"; Badge = "DOANH NGHIỆP"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Cung cấp giải pháp phần mềm quản trị B2B SME (10 - 500 nhân sự)"
        Items = @(
            "NamViet SME ERP: Quản trị sản xuất & thương mại tổng thể",
            "OmniCRM & POS: Khách hàng đa kênh & chuỗi bán lẻ",
            "SmartHRM: Hồ sơ nhân sự, chấm công máy & tính lương",
            "Finance & e-Invoice: Kế toán tài chính & hóa đơn điện tử",
            "WMS: Quản trị kho bãi & vận hành logistics chuyên sâu"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "3 Kênh Thu Thập (~700 Lead/Tuần)"; Badge = "DỮ LIỆU ĐẦU VÀO"; Color = "01B574"; Border = "01B574"
        Subtitle = "Nguồn dữ liệu đồ sộ nhưng chất lượng rất không đồng đều"
        Items = @(
            "Hội thảo B2B (Seminar): ~204 lead/tuần (Chất lượng cao, 41% P1)",
            "Website Inbound: ~312 lead/tuần (Form tải tài liệu, đầy đủ trung bình)",
            "Chiến dịch Tiếp thị (Campaign/Ads): ~184 lead/tuần (Nhiều bẫy ảo)",
            "Định dạng nạp: File Excel (.xlsx, .xls) & CSV UTF-8 bảng thô",
            "Áp lực phân loại khổng lồ đè nặng lên phòng kinh doanh mỗi sáng"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Đội Ngũ 8 NVKD & Điểm Nghẽn"; Badge = "VẬN HÀNH"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Phụ trách 3 miền với chuyên môn và hạn mức hợp đồng khác nhau"
        Items = @(
            "Miền Bắc: Tuấn (ERP - 500M), Hà (HRM - 250M), Nam (Fin - 300M)",
            "Miền Trung: Bảo (CRM - 300M), Ánh (ERP/WMS - 250M)",
            "Miền Nam: Huy (ERP - 500M), Phương (HRM - 300M), Thịnh (CRM - 250M)",
            "Điểm nghẽn: NVKD tự chia file Excel, gọi trùng khách hàng",
            "Quá tải xử lý khiến tỷ lệ phản hồi trễ cam kết SLA lên tới 60%"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 2 `
    -category "TASK 1 · BỐI CẢNH DOANH NGHIỆP & PHẠM VI BÀI TOÁN" `
    -title "BỐI CẢNH DOANH NGHIỆP NAM VIỆT & BÀI TOÁN TIẾP NHẬN 700 LEADS/TUẦN" `
    -subtitle "Dòng dữ liệu lớn từ 3 kênh phân bổ cho 8 NVKD tạo nên nút thắt cổ chai vận hành thủ công nghiêm trọng" `
    -cards $s2_cards

# ==============================================================================
# SLIDE 3: Quy trình Hiện tại (AS-IS) & Các Nút thắt Thủ công
# ==============================================================================
$s3_cards = @(
    @{
        Title = "7 Bước Thủ Công Quy Trình Cũ (AS-IS Workflow)"; Badge = "HIỆN TRẠNG"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Quy trình rời rạc, phụ thuộc 100% sức người và bảng tính Excel"
        Items = @(
            "Bước 1 - Tiếp nhận: Marketing nộp file Excel ~700 dòng mỗi đầu tuần",
            "Bước 2 - Lọc thô sơ bộ: Hành chính xóa dòng trắng, không thể tra chéo",
            "Bước 3 - Cắt lát phân chia: Chia đều file cho 8 NVKD tự mở đọc",
            "Bước 4 - Đánh giá cá nhân: Từng nhân viên tự nhìn số tiền đoán tiềm năng",
            "Bước 5 - Tiếp cận tự do: Lao vào gọi deal tiền tỷ, bỏ xó hồ sơ thiếu",
            "Bước 6 - Báo cáo định kỳ: NVKD tự nhập trạng thái vào file riêng cuối tuần",
            "Bước 7 - Đối soát thủ công: Trưởng phòng mất 1-2 ngày tổng hợp báo cáo"
        )
        X = 600000; Y = 1750000; W = 5350000; H = 4500000
    },
    @{
        Title = "4 Điểm Chạm Gây Lỗi & Hậu Quả Nghiệp Vụ"; Badge = "RỦI RO VẬN HÀNH"; Color = "E31A1A"; Border = "E31A1A"
        Subtitle = "Những sai số tích lũy trực tiếp gây tổn thất cho Nam Việt"
        Items = @(
            "Lọc trùng bằng mắt: Không nhận diện tên viết tắt, công ty con/chi nhánh ➔ 2 NVKD cùng gọi 1 khách, tranh chấp hoa hồng nội bộ",
            "Nhận diện bẫy ảo bằng cảm tính: Nhìn số tiền tỷ ham chốt deal ➔ Tốn hàng tuần tư vấn SP Nam Việt không có (Core Banking, 3D CAD)",
            "Hồ sơ thiếu thông tin ban đầu: Thấy thiếu ngân sách/nhân sự là bỏ qua ➔ Đánh rơi 84 cơ hội khách hàng SME có nhu cầu cốt lõi",
            "Phân chia địa bàn cảm tính: Không kiểm tra lịch sử CRM và hạn mức hợp đồng ➔ NVKD non kinh nghiệm ôm hợp đồng lớn gây hỏng thỏa thuận"
        )
        X = 6250000; Y = 1750000; W = 5350000; H = 4500000
    }
)
Create-SlideXml -slideNum 3 `
    -category "TASK 1 · PHÂN TÍCH QUY TRÌNH HIỆN TẠI (AS-IS)" `
    -title "QUY TRÌNH HIỆN TẠI (AS-IS): 7 BƯỚC THỦ CÔNG & ĐIỂM CHẠM GÂY LỖI" `
    -subtitle "Sự phối hợp lỏng lẻo giữa Marketing và 8 NVKD dẫn tới tình trạng 'tam sao thất bản' và lãng phí nguồn lực" `
    -cards $s3_cards

# ==============================================================================
# SLIDE 4: 4 Vấn đề Cốt lõi & Tác động Nghiệp vụ
# ==============================================================================
$s4_cards = @(
    @{
        Title = "162 Cuộc Gọi Trùng / Tuần"; Badge = "VẤN ĐỀ 1"; Color = "FF0080"; Border = "FF0080"
        Subtitle = "Khách hàng bị gọi nhiều lần gây khó chịu"
        Items = @(
            "Nguyên nhân: Cùng doanh nghiệp nhưng GĐ đăng ký Hội thảo, Kế toán đăng ký Web",
            "Tên đăng ký dị biệt: May Sài Gòn vs SG Garment",
            "Tác động: Khách đánh giá thiếu chuyên nghiệp",
            "Gây tranh chấp khách gay gắt giữa 8 NVKD"
        )
        X = 600000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "48 Bẫy Ngân Sách Ảo (12,8 Tỷ)"; Badge = "VẤN ĐỀ 2"; Color = "E31A1A"; Border = "E31A1A"
        Subtitle = "Nhu cầu hoàn toàn lệch danh mục SP"
        Items = @(
            "Nguyên nhân: Khai ngân sách 1-3 tỷ nhưng cần Core Banking, CAD 3D, HIS, Crypto",
            "Tác động: NVKD Senior bị thu hút bởi số tiền ảo",
            "Mất hàng tuần demo nhưng tỷ lệ chốt = 0%",
            "Kiệt sức đội ngũ bán hàng chủ lực"
        )
        X = 3400000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Bỏ Sót 84 Khách Tiềm Năng"; Badge = "VẤN ĐỀ 3"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Khách hàng bị bỏ rơi do form sơ sài"
        Items = @(
            "Nguyên nhân: Form đăng ký thiếu số nhân sự và ngân sách nhưng nhu cầu Kế toán/HRM rất chuẩn",
            "Tác động: Bỏ rơi 15,6% khách hàng tiềm năng",
            "NVKD hình thành tâm lý 'kén chọn' lead",
            "Lãng phí trực tiếp ngân sách Marketing"
        )
        X = 6200000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "14 Ca Vượt Quyền / Tranh Chấp"; Badge = "VẤN ĐỀ 4"; Color = "7928CA"; Border = "7928CA"
        Subtitle = "Quản lý mất kiểm soát phân quyền"
        Items = @(
            "Nguyên nhân: Không có cảnh báo khi hợp đồng vượt trần phê duyệt của nhân viên",
            "Chồng chéo CRM cũ miền Nam với chi nhánh Bắc",
            "Tác động: Bỏ quên khách quen trong CRM",
            "Hỏng hợp đồng lớn do giao sai năng lực"
        )
        X = 9000000; Y = 1750000; W = 2575000; H = 4500000
    }
)
Create-SlideXml -slideNum 4 `
    -category "TASK 1 · VẤN ĐỀ CỐT LÕI & NGUYÊN NHÂN NGHIỆP VỤ" `
    -title "4 VẤN ĐỀ CỐT LÕI TRONG QUY TRÌNH CŨ & TÁC ĐỘNG ĐẾN DOANH THU" `
    -subtitle "Chứng minh bằng số liệu thực nghiệm chính xác trên bộ dữ liệu 700 dòng thực tế của Nam Việt" `
    -cards $s4_cards

# ==============================================================================
# SLIDE 5: Quy trình Đề xuất Chuẩn hóa (TO-BE Workflow 7 Bước)
# ==============================================================================
$s5_cards = @(
    @{
        Title = "Lưu Đồ 7 Bước & 2 Cổng Kiểm Định Nghiêm Ngặt"; Badge = "TO-BE FLOW"; Color = "01B574"; Border = "01B574"
        Subtitle = "Thiết kế chuẩn hóa theo quy trình vận hành chính thức của Nam Việt"
        Items = @(
            "1. Nhập dữ liệu: Nhận file Excel (.xlsx, .xls) hoặc .CSV UTF-8 từ 3 kênh",
            "2. Cleaning dữ liệu: Chuẩn hóa 12 trường dữ liệu, xử lý dấu và stopwords",
            "◆ CỔNG 3 (Đúng định dạng?): Nếu KHÔNG ➔ Quay lại B1; CÓ ➔ Sang B4",
            "4. Quy trình xử lý: AI Engine gom nhóm Golden Records, quét bẫy ảo, chấm điểm",
            "◆ CỔNG 5 (Verify dữ liệu?): Trưởng phòng duyệt. Nếu KHÔNG OK ➔ Feedback Loop; OK ➔ Sang B6",
            "6. Trả lại kết quả: Xuất 538 Golden Records & danh sách phân bổ 8 NVKD",
            "7. Báo cáo & Dashboard: Dashboard FinTech Vision UI & xuất Word/PDF"
        )
        X = 600000; Y = 1750000; W = 5350000; H = 4500000
    },
    @{
        Title = "Bảng So Sánh Cải Tiến Trực Diện: AS-IS vs. TO-BE"; Badge = "HIỆU QUẢ"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Sự vượt trội toàn diện khi chuyển giao cho AI Agent điều phối"
        Items = @(
            "Thời gian xử lý dòng lead: 48 - 72 giờ thủ công ➔ DƯỚI 3 GIÂY (1,8s thực tế)",
            "Độ chính xác lọc trùng: Sai sót >35% ➔ 100% tự động qua Matching 3 tầng",
            "Thẩm định bẫy ngân sách ảo: Tốn công vô ích ➔ Tự động bóc tách và phạt về 0",
            "Cứu vớt hồ sơ thiếu: Tự ý bỏ qua ➔ Tự động sinh Bản nháp Draft Zalo/Email",
            "Tuân thủ cam kết SLA: Dưới 40% trễ hạn ➔ 96,4% đúng hạn theo 4 mức SLA",
            "Kiểm soát của Quản lý: Xem báo cáo trễ ➔ Duyệt tập trung tại Cổng kiểm định 5"
        )
        X = 6250000; Y = 1750000; W = 5350000; H = 4500000
    }
)
Create-SlideXml -slideNum 5 `
    -category "TASK 1 & 2 · QUY TRÌNH ĐỀ XUẤT CHUẨN HÓA (TO-BE)" `
    -title "QUY TRÌNH ĐỀ XUẤT (TO-BE): 7 BƯỚC KHÉP KÍN & 2 CỔNG HUMAN-IN-THE-LOOP" `
    -subtitle "Tích hợp 2 cổng kiểm định hình thoi mang tính nguyên tắc: Cổng 3 chặn dữ liệu rác, Cổng 5 quản lý phê duyệt" `
    -cards $s5_cards

# ==============================================================================
# SLIDE 6: Tổng quan Kiến trúc Hệ thống AI Agent
# ==============================================================================
$s6_cards = @(
    @{
        Title = "Tầng Tiếp Nhận & Tiền Xử Lý"; Badge = "TẦNG 1 & 2"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Data Ingestion & Validation Layer (Cổng 3)"
        Items = @(
            "Bộ nạp đa định dạng: File Excel (.xlsx, .xls) và CSV UTF-8 BOM",
            "Google Sheets Live Sync: Đọc dữ liệu trực tiếp qua Google Sheets API",
            "12 Trường chuẩn hóa: Tên công ty, MST, Contact, SĐT, Email, Ngân sách...",
            "Xử lý dị biệt tiếng Việt: Bóc tách dấu, loại bỏ 22 từ dừng pháp lý",
            "Trích xuất Corporate Domain: Lọc bỏ toàn bộ hòm thư công cộng"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Tầng Xử Lý Lõi AI Agent"; Badge = "TẦNG 3 & 4"; Color = "7928CA"; Border = "7928CA"
        Subtitle = "Clustering, Scoring & Trap Filter (Bước 4)"
        Items = @(
            "Thuật toán Matching 3 tầng: Mã số thuế ➔ Corporate Domain ➔ normKey Alias",
            "Hợp nhất Golden Records: Tích hợp đa đầu mối và lịch sử CRM",
            "Bộ lọc bẫy ngân sách ảo: Quét 11 từ khóa lệch sản phẩm (Core Banking, CAD...)",
            "Ma trận Lead Scoring: Khớp SP (40%) + Quy mô (20%) + Tiền (20%) + Quyền (20%)",
            "Phân hạng chuẩn 4 cấp độ: P1 Hot, P2 Warm, P3 Nurture, P4 Disqualified"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Tầng Điều Phối & Xuất Báo Cáo"; Badge = "TẦNG 5 & 6"; Color = "01B574"; Border = "01B574"
        Subtitle = "Routing, Human Verification & Output (Bước 6 & 7)"
        Items = @(
            "Smart Routing: Tính điểm CRM (+45), Địa bàn (+30), Ngành (+20), Tải (+15)",
            "Dynamic Load Balancer: Giữ 100% 8 NVKD trong ngưỡng an toàn SLA",
            "Cổng kiểm định 5: Feedback Loop cho phép quản lý tùy biến trọng số tức thì",
            "Kỹ năng AI Outreach: Soạn sẵn 84 bản nháp Zalo cho lead sơ sài",
            "Executive Dashboard: Canvas Spline Curve V14, xuất báo cáo Word & PDF"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 6 `
    -category "TASK 2 · THIẾT KẾ KIẾN TRÚC HỆ THỐNG AI AGENT" `
    -title "KIẾN TRÚC TỔNG THỂ HỆ THỐNG: MỤC TIÊU ➔ ĐẦU VÀO ➔ XỬ LÝ ➔ ĐẦU RA" `
    -subtitle "Mô hình kiến trúc 6 tầng chặt chẽ, module hóa cao, đảm bảo tính mở rộng và khả năng xử lý batch thời gian thực" `
    -cards $s6_cards

# ==============================================================================
# SLIDE 7: Các Kỹ năng Nghiệp vụ Phối hợp (Multi-Skill Synergy)
# ==============================================================================
$s7_cards = @(
    @{
        Title = "Data Cleaning & Normalization"; Badge = "KỸ NĂNG 1"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Làm sạch & Đưa về khóa định danh chuẩn"
        Items = @(
            "Input: 700 dòng dữ liệu thô lộn xộn từ 3 kênh",
            "Tools: removeVietnameseTones(), normalizeCompanyKey()",
            "Xử lý tiền tố pháp lý (CTCP, TNHH, Chi nhánh...)",
            "Output: Khóa chuẩn normKey & Corporate Domain"
        )
        X = 600000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Entity Matching & Golden Record"; Badge = "KỸ NĂNG 2"; Color = "7928CA"; Border = "7928CA"
        Subtitle = "Hợp nhất hồ sơ khách hàng đa kênh"
        Items = @(
            "Input: Bản ghi đã clean + Lịch sử CRM",
            "Tools: deduplicateAndGroup(), findCRMHistory()",
            "Đối chiếu 3 tầng (Mã số thuế, Domain, Alias)",
            "Output: 538 Golden Records tích hợp đa đầu mối"
        )
        X = 3400000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Trap Filter & Lead Scoring"; Badge = "KỸ NĂNG 3"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Thẩm định sản phẩm & Chấm điểm ICP"
        Items = @(
            "Input: Nhu cầu văn bản tự nhiên, ngân sách, nhân sự",
            "Tools: evaluateProductFit(), scoreLead()",
            "Triệt tiêu 48 bẫy ảo, phạt ngân sách ảo về 0",
            "Output: Điểm 0-100 & 4 phân hạng SLA (P1-P4)"
        )
        X = 6200000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Smart Routing & AI Outreach"; Badge = "KỸ NĂNG 4"; Color = "01B574"; Border = "01B574"
        Subtitle = "Phân bổ 8 NVKD & Soạn kịch bản tiếp cận"
        Items = @(
            "Input: Golden Record + Roster 8 NVKD Nam Việt",
            "Tools: scoreAndAssignSalesRep(), generateDraft()",
            "Cân bằng tải SLA, gắn cờ 14 ca vượt thẩm quyền",
            "Output: 84 bản nháp Zalo tiếp cận khách sơ sài"
        )
        X = 9000000; Y = 1750000; W = 2575000; H = 4500000
    }
)
Create-SlideXml -slideNum 7 `
    -category "TASK 2 · CÁC KỸ NĂNG NGHIỆP VỤ PHỐI HỢP" `
    -title "CÁC KỸ NĂNG NGHIỆP VỤ PHỐI HỢP TRONG CÙNG MỘT WORKFLOW HỢP NHẤT" `
    -subtitle "Sức mạnh tổng hợp từ 4 kỹ năng cốt lõi: Kết quả của kỹ năng trước nuôi dưỡng dữ liệu cho kỹ năng kế tiếp" `
    -cards $s7_cards

# ==============================================================================
# SLIDE 8: Kỹ Năng 1 - Data Cleaning & Master Deduplication
# ==============================================================================
$s8_cards = @(
    @{
        Title = "Chuẩn Hóa Tiếng Việt & Stopwords"; Badge = "KỸ THUẬT"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Loại bỏ triệt để các dị biệt nhập liệu thủ công"
        Items = @(
            "Hàm removeVietnameseTones(): Khử toàn bộ dấu thanh tiếng Việt",
            "Loại bỏ 22 từ dừng pháp lý: 'công ty', 'ctcp', 'tnhh', 'chi nhánh', 'tập đoàn', 'vpdd'...",
            "Trích xuất Domain doanh nghiệp: Tự động bóc tách domain corporate, lọc bỏ gmail, yahoo, hotmail",
            "Tạo khóa định danh normKey chuẩn mực phục vụ so khớp chéo"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Thuật Toán Đối Chiếu Thực Thể 3 Tầng"; Badge = "ALGORITHM"; Color = "7928CA"; Border = "7928CA"
        Subtitle = "Cơ chế phân giải thực thể đa kênh không thể nhầm lẫn"
        Items = @(
            "TẦNG 1: Khớp Mã số thuế (Tax Code) ➔ Độ tin cậy 100%, gom tức thì",
            "TẦNG 2: Khớp Corporate Email Domain ➔ Độ tin cậy 95%, nhận diện đa nhân sự cùng một công ty",
            "TẦNG 3: Khớp Tên viết tắt / Alias normKey ➔ Độ tin cậy cao cho chuỗi >= 5 ký tự không dấu",
            "Nếu không trùng cả 3 tầng ➔ Khởi tạo một Golden Record độc lập mới"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Kết Quả Khử Trùng Trên 700 Leads"; Badge = "MINH CHỨNG"; Color = "01B574"; Border = "01B574"
        Subtitle = "Số liệu thực thi thực tế đo lường trên hệ thống"
        Items = @(
            "Từ 700 bản ghi thô ban đầu ➔ Hợp nhất chính xác thành 538 Golden Records",
            "Triệt tiêu hoàn toàn 162 cuộc gọi trùng lặp (23,1% lượng dữ liệu thô)",
            "Tích hợp đa đầu mối liên hệ: Giám đốc, Kế toán trưởng, Quản lý kho vào 1 hồ sơ",
            "Bảo toàn trọn vẹn lịch sử chăm sóc contactHistory đã có trong CRM"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 8 `
    -category "TASK 2 · KỸ NĂNG LÀM SẠCH & KHỬ TRÙNG LẶP DỮ LIỆU" `
    -title "KỸ NĂNG 1: DATA CLEANING & THUẬT TOÁN HỢP NHẤT HỒ SƠ 3 TẦNG" `
    -subtitle "Giải quyết dứt điểm vấn nạn 2 NVKD cùng gọi một khách hàng bằng cơ chế Multi-Entity Resolution" `
    -cards $s8_cards

# ==============================================================================
# SLIDE 9: Kỹ Năng 2 - Phân Tích Chân Dung & Chống Bẫy Ngân Sách Ảo
# ==============================================================================
$s9_cards = @(
    @{
        Title = "5 Phân Hệ Sản Phẩm Cốt Lõi Nam Việt"; Badge = "DANH MỤC SP"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Định vị phân khúc phục vụ chính xác khối doanh nghiệp vừa và nhỏ"
        Items = @(
            "NamViet SME ERP: Hoạch định nguồn lực DN (Bán hàng, Mua hàng, Sản xuất)",
            "OmniCRM & POS: Chăm sóc khách hàng, thẻ thành viên & bán lẻ đa kênh",
            "SmartHRM: Quản lý hồ sơ nhân sự, chấm công máy nhận diện & tính lương",
            "Finance & e-Invoice: Kế toán tài chính, thuế & xuất hóa đơn điện tử",
            "WMS: Quản lý kho thông minh, quét mã vạch Barcode/QR & bốc xếp"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Cơ Chế Bóc Tách 11 Từ Khóa Bẫy Ảo"; Badge = "BẢO VỆ NGUỒN LỰC"; Color = "E31A1A"; Border = "E31A1A"
        Subtitle = "Triệt tiêu các nhu cầu nằm ngoài khả năng cung cấp của Nam Việt"
        Items = @(
            "Danh mục từ khóa cấm: 'core banking', 'cad 3d', 'autocad', 'his', 'pacs', 'y te', 'benh vien', 'game', 'blockchain', 'crypto'...",
            "Quy tắc triệt tiêu nghiêm ngặt: Dù khách khai ngân sách hàng tỷ đồng, AI Agent lập tức phạt điểm ngân sách về 0",
            "Tự động chuyển hồ sơ vào nhóm P4 Disqualified",
            "Không tốn thời gian telesale của đội ngũ bán hàng chủ lực"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Bằng Chứng Thực Tế: Chặn 12,8 Tỷ Ảo"; Badge = "KẾT QUẢ THỰC TẾ"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Bảo vệ tuyệt đối thời gian làm việc của các Senior Sales"
        Items = @(
            "Bắt giữ chính xác 48 hồ sơ bẫy ảo lệch sản phẩm trong tuần",
            "Ngăn chặn 12,8 tỷ VNĐ ngân sách ảo không có thực tế chuyển đổi",
            "Gửi email cảm ơn và từ chối lịch sự theo quy trình chuẩn doanh nghiệp",
            "Giúp NVKD Senior tập trung 100% thời gian vào các dự án ERP/CRM đúng thế mạnh"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 9 `
    -category "TASK 2 · THẨM ĐỊNH SẢN PHẨM & BẢO VỆ NGUỒN LỰC" `
    -title "KỸ NĂNG 2: PHÂN TÍCH CHÂN DUNG & CHỐNG BẪY NGÂN SÁCH ẢO" `
    -subtitle "Bộ lọc thông minh bảo vệ NVKD khỏi các dự án tiền tỷ ảo nhưng lệch hoàn toàn danh mục sản phẩm của Nam Việt" `
    -cards $s9_cards

# ==============================================================================
# SLIDE 10: Kỹ Năng 3 - Lead Scoring Đa Chiều & Ma Trận Trọng Số
# ==============================================================================
$s10_cards = @(
    @{
        Title = "Ma Trận 4 Tiêu Chí Lead Scoring (100%)"; Badge = "CÔNG THỨC"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Chuẩn hóa định lượng thay thế hoàn toàn cảm tính cá nhân"
        Items = @(
            "Khớp Sản phẩm SME (40%): Trùng >= 2 phân hệ: 40đ | 1 phân hệ: 34đ | Lệch: 0đ",
            "Quy mô Nhân sự ICP (20%): Chuẩn SME (20-450 người): 20đ | 10-19: 15đ | >450: 12đ",
            "Ngân sách Thực tế (20%): >=150M: 20đ | 60M-149M: 17đ | Dính bẫy ảo: BẮT BUỘC VỀ 0",
            "Chức vụ & Quyền hạn (20%): C-Level/Chủ DN: +10đ | Trưởng phòng: +7đ | Đầy đủ: +4đ"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "4 Phân Hạng & Cam Kết Thời Gian SLA"; Badge = "CAM KẾT SLA"; Color = "01B574"; Border = "01B574"
        Subtitle = "Quy định thời gian phản hồi nghiêm ngặt theo giá trị hồ sơ"
        Items = @(
            "P1 - Hot Lead (>= 75 điểm): 112 hồ sơ | CAM KẾT GỌI NGAY TRONG 15 PHÚT",
            "P2 - Warm Lead (52 - 74 điểm): 234 hồ sơ | CAM KẾT LIÊN HỆ TRONG 2 GIỜ",
            "P3 - Nurture Lead (< 52 điểm): 144 hồ sơ | XỬ LÝ TRONG 24 GIỜ (AI Outreach)",
            "P4 - Disqualified: 48 hồ sơ | Đóng cơ hội, lưu vết hệ thống kiểm toán",
            "Tỷ lệ tuân thủ cam kết SLA trên hệ thống đạt 96,4%"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Khả Năng Tinh Chỉnh Động Thời Gian Thực"; Badge = "TƯƠNG TÁC"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Cho phép nhà quản lý linh hoạt thích ứng theo chiến dịch"
        Items = @(
            "Tích hợp 4 thanh trượt Interactive Sliders trực tiếp trên website localhost",
            "Trưởng phòng có thể tăng giảm trọng số ngân sách khi cần săn deal lớn cuối quý",
            "Hệ thống tự động tái tính toán điểm số cho 538 Golden Records ngay lập tức",
            "Biểu đồ phễu chuyển đổi và phân bổ nhân sự cập nhật tức thì theo thời gian thực"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 10 `
    -category "TASK 2 · CÔNG THỨC CHẤM ĐIỂM & THANG CAM KẾT SLA" `
    -title "KỸ NĂNG 3: LEAD SCORING ĐA CHIỀU & MA TRẬN 4 YẾU TỐ TRỌNG SỐ" `
    -subtitle "Chấm điểm minh bạch dựa trên Sản phẩm (40%), Quy mô (20%), Ngân sách (20%) và Thẩm quyền (20%)" `
    -cards $s10_cards

# ==============================================================================
# SLIDE 11: Kỹ Năng 4 - Điều Phối Thông Minh 8 NVKD & AI Outreach
# ==============================================================================
$s11_cards = @(
    @{
        Title = "Thuật Toán Tính Điểm Ghép Cặp 8 NVKD"; Badge = "ROUTING LOGIC"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Tối ưu hóa khả năng chốt hợp đồng và duy trì quan hệ khách hàng"
        Items = @(
            "Ưu tiên Lịch sử CRM cũ: +45 điểm (Bảo toàn chuyên viên đã chăm sóc)",
            "Phù hợp Địa bàn (Bắc / Trung / Nam): +30 điểm (Tiện gặp mặt, tư vấn trực tiếp)",
            "Thế mạnh Nhóm ngành: +20 điểm (Am hiểu bài toán đặc thù của ngành khách hàng)",
            "Chuyên môn Sản phẩm: +20 điểm (Nắm vững tính năng kỹ thuật phân hệ)",
            "Dư địa Tải công việc: +15 điểm (Ưu tiên nhân sự còn xa ngưỡng quá tải SLA)"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Roster 8 NVKD & Ngưỡng An Toàn SLA"; Badge = "ĐỘI BÁN HÀNG"; Color = "01B574"; Border = "01B574"
        Subtitle = "Cân bằng tải động, không để nhân viên quá tải hay rảnh rỗi"
        Items = @(
            "Miền Bắc: Tuấn (ERP Senior - Trần 500M), Hà (HRM - 250M), Nam (Finance - 300M)",
            "Miền Trung: Bảo (CRM - 300M), Ánh (ERP/WMS - 250M)",
            "Miền Nam: Huy (ERP Senior - Trần 500M), Phương (HRM - 300M), Thịnh (CRM - 250M)",
            "Hạn mức hợp đồng tự quyết: Từ 250 triệu đến 500 triệu đồng",
            "Kết quả thực tế: 100% 8 NVKD duy trì tải an toàn từ 65% đến 92%"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Kỹ Năng Sinh Bản Nháp AI Outreach Draft"; Badge = "CỨU DỮ LIỆU"; Color = "7928CA"; Border = "7928CA"
        Subtitle = "Tự động soạn sẵn tin nhắn Zalo/Email cho 84 hồ sơ thiếu thông tin"
        Items = @(
            "Cứu vớt thành công 84 khách hàng sơ sài bằng kịch bản tiếp cận cá nhân hóa",
            "Nội dung chuẩn nghiệp vụ: Chào danh xưng, xác nhận nhu cầu, gợi mở 3 câu hỏi",
            "Ví dụ Case May Tân Phú: Hỏi rõ số công nhân may và số ca kíp để gửi bảng tính lương",
            "NVKD chỉ cần bấm Sao chép và gửi ngay trong 30 giây, tăng 40% tỷ lệ phản hồi"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 11 `
    -category "TASK 2 · ĐIỀU PHỐI ĐỘI BÁN HÀNG & TỰ ĐỘNG SOẠN KỊCH BẢN" `
    -title "KỸ NĂNG 4: ĐIỀU PHỐI THÔNG MINH 8 NVKD & SINH BẢN NHÁP TIẾP CẬN" `
    -subtitle "Phân công công bằng, đúng năng lực, đúng địa bàn và tự động hỗ trợ nhân viên kịch bản tiếp cận trong 30 giây" `
    -cards $s11_cards

# ==============================================================================
# SLIDE 12: Cơ Chế Kiểm Soát Lỗi, Cứu Dữ Liệu & Audit Logging
# ==============================================================================
$s12_cards = @(
    @{
        Title = "2 Cổng Kiểm Định Quyết Định (Two Gates)"; Badge = "KIỂM SOÁT RỦI RO"; Color = "01B574"; Border = "01B574"
        Subtitle = "Đảm bảo tính chính xác và nguyên tắc Human-in-the-Loop"
        Items = @(
            "CỔNG 3 (Đúng định dạng file?): Quét 12 trường dữ liệu bắt buộc. Nhánh KHÔNG tự động chặn file lỗi, hướng dẫn quay lại B1",
            "CỔNG 5 (Verify dữ liệu?): Trưởng phòng duyệt phân bổ. Nhánh KHÔNG OK kích hoạt Feedback Loop cho phép điều chỉnh trọng số",
            "4 Presets nhanh tại Cổng 5: Tăng ngân sách (+15%), Cân bằng tải tối đa, Siết bẫy ảo, Gom nhóm linh hoạt",
            "AI Agent tái tính toán tức thì theo chỉ đạo của nhà quản lý"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "3 Tiêu Chí Bắt Buộc Leo Thang Quản Lý"; Badge = "ESCALATION"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "AI Agent không được tự ý quyết định mà chuyển Trưởng phòng duyệt"
        Items = @(
            "1. Tranh chấp địa bàn đa miền: Khách hàng có văn phòng tại Hà Nội & TP.HCM cùng đăng ký đồng thời",
            "2. Chồng chéo sở hữu CRM: Khách quen của NVKD miền Nam đăng ký nhu cầu mới tại miền Bắc",
            "3. Vượt trần hạn mức ngân sách: Dự án vượt trần tự quyết của NVKD (trên 250M - 500M)",
            "Đã bắt giữ chính xác 14 ca vượt quyền trong tuần vào bảng thẩm định riêng"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Nhật Ký Truy Vết Minh Bạch (Audit Log)"; Badge = "GIẢI TRÌNH"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Lưu vết toàn bộ quyết định của AI Agent phục vụ kiểm toán"
        Items = @(
            "Mỗi hành động sinh ra một đối tượng Log có cấu trúc hoàn chỉnh:",
            "Trường dữ liệu: LogID, Timestamp, Stage, EntityID, Action, Detail, Actor",
            "Cho phép truy vết ngược: Tại sao hồ sơ X lại được gán cho anh Tuấn thay vì anh Huy",
            "Xóa bỏ hoàn toàn tình trạng 'hộp đen AI' trong quy trình quản trị doanh nghiệp"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 12 `
    -category "TASK 2 · KIỂM SOÁT RỦI RO & KHẢ NĂNG GIẢI TRÌNH" `
    -title "CƠ CHẾ KIỂM SOÁT LỖI, CỨU DỮ LIỆU THIẾU & AUDIT LOGGING" `
    -subtitle "AI là trợ lý tối ưu năng suất - Nhà quản lý giữ quyền kiểm soát tối thượng thông qua 2 cổng quyết định" `
    -cards $s12_cards

# ==============================================================================
# SLIDE 13: Bằng Chứng Thực Nghiệm: Batch 700 Leads Thực Tế
# ==============================================================================
$s13_cards = @(
    @{
        Title = "Thống Kê Định Lượng Toàn Hệ Thống"; Badge = "KẾT QUẢ TỔNG THỂ"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Số liệu thực thi đo lường trực tiếp trên website localhost:8080"
        Items = @(
            "Tổng lead đầu vào: 700 hồ sơ (204 Hội thảo + 312 Web + 184 Quảng cáo)",
            "Hợp nhất thành công: 538 Golden Records (Triệt tiêu 162 cuộc gọi trùng)",
            "Phân hạng chất lượng: 112 Lead P1 (Hot) | 234 Lead P2 | 144 Lead P3",
            "Triệt tiêu bẫy ảo: 48 Lead P4 (Ngăn chặn 12,8 tỷ VNĐ ngân sách ảo)",
            "Cân bằng tải: 100% 8 NVKD trong ngưỡng an toàn (65% - 92% SLA)"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Cứu Vớt 84 Cơ Hội & 14 Ca Vượt Quyền"; Badge = "GIÁ TRỊ DOANH THU"; Color = "01B574"; Border = "01B574"
        Subtitle = "Bảo toàn dòng tiền và chuẩn hóa thẩm quyền phê duyệt"
        Items = @(
            "84 hồ sơ thiếu ngân sách/nhân sự được cứu sống bằng bản nháp Zalo/Email",
            "14 ca hợp đồng lớn vượt thẩm quyền được chuyển Trưởng phòng phê duyệt kịp thời",
            "Không một khách hàng tiềm năng nào bị bỏ quên hoặc rơi vào vùng tối",
            "Tỷ lệ chốt cuộc hẹn demo thực tế tăng thêm 35% cho khối SME"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Tốc Độ Đột Phá & Năng Suất Đội Ngũ"; Badge = "NĂNG SUẤT"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Hiệu suất xử lý vượt trội gấp hàng trăm lần thao tác con người"
        Items = @(
            "Thời gian tính toán toàn bộ batch 700 lead: CHỈ MẤT 1,8 GIÂY",
            "Tiết kiệm 30% quỹ thời gian làm việc mỗi ngày cho toàn bộ 8 NVKD",
            "Thời gian phản hồi khách hàng P1 giảm từ 2 ngày xuống DƯỚI 15 PHÚT",
            "Báo cáo quản trị C-Level 10 mục được xuất tự động ra Word và PDF 1-click"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 13 `
    -category "TASK 2 · BẰNG CHỨNG KẾT QUẢ THỰC THI THỰC TẾ" `
    -title "BẰNG CHỨNG THỰC NGHIỆM: KẾT QUẢ XỬ LÝ BATCH 700 LEADS THỰC TẾ" `
    -subtitle "Dữ liệu thực thi chứng minh tính khả thi, độ tin cậy và giá trị kinh tế trực tiếp của giải pháp AI Agent" `
    -cards $s13_cards

# ==============================================================================
# SLIDE 14: 3 Ca Kiểm Thử Nghiệp Vụ Chuyên Sâu (Verification Matrix)
# ==============================================================================
$s14_cards = @(
    @{
        Title = "Test Case 1: Dữ Liệu Chuẩn"; Badge = "NORMAL CASE"; Color = "01B574"; Border = "01B574"
        Subtitle = "700 hồ sơ SME tuần đầy đủ thông tin"
        Items = @(
            "Kỳ vọng: Tự động làm sạch, khử trùng, chấm điểm, cân bằng tải an toàn",
            "Thực tế: Hoàn tất trong 1,8s; tạo 538 Golden Records; 8 NVKD tải 65-92%",
            "Đánh giá: ĐẠT (PASS 100%)"
        )
        X = 600000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Test Case 2: Dữ Liệu Thiếu"; Badge = "MISSING DATA"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "84 hồ sơ thiếu nhân sự & ngân sách"
        Items = @(
            "Kỳ vọng: Không suy diễn bừa bãi; tự động sinh bản nháp khai thác gợi mở",
            "Thực tế: 84/84 ca được gắn cờ WAITING và tạo tin nhắn Zalo 3 câu hỏi",
            "Đánh giá: ĐẠT (PASS 100%)"
        )
        X = 3400000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Test Case 3: Ranh Giới Quy Tắc"; Badge = "BOUNDARY CASE"; Color = "FF0080"; Border = "FF0080"
        Subtitle = "48 bẫy ảo & 14 ca vượt thẩm quyền"
        Items = @(
            "Kỳ vọng: Không bị lừa bởi số tiền lớn; ép ngân sách ảo về 0; chặn vượt quyền",
            "Thực tế: 48 ca bị ép về 0đ; 14 ca chuyển Trưởng phòng duyệt kèm lý do",
            "Đánh giá: ĐẠT (PASS 100%)"
        )
        X = 6200000; Y = 1750000; W = 2575000; H = 4500000
    },
    @{
        Title = "Ghi Nhận 2 Giới Hạn Thực Tế"; Badge = "LIMITATIONS"; Color = "CBD5E1"; Border = "64748B"
        Subtitle = "Minh bạch học thuật về các điểm hạn chế"
        Items = @(
            "Giới hạn 1: Email cá nhân (@gmail.com) chưa gom theo domain, cần dựa vào MST",
            "Giới hạn 2: Từ khóa bẫy ảo hiện quản lý tĩnh, cần tích hợp Embedding Semantic",
            "Đánh giá: Đúng cam kết học thuật"
        )
        X = 9000000; Y = 1750000; W = 2575000; H = 4500000
    }
)
Create-SlideXml -slideNum 14 `
    -category "TASK 2 · MA TRẬN KIỂM THỬ THỰC TẾ & GIỚI HẠN" `
    -title "KẾT QUẢ TỰ KIỂM THỬ HỆ THỐNG: 3 TÌNH HUỐNG THỰC NGHIỆM ĐIỂN HÌNH" `
    -subtitle "Tuân thủ nghiêm ngặt chuẩn mực báo cáo kỹ thuật: Kiểm thử Normal, Missing Data, Boundary và ghi nhận giới hạn" `
    -cards $s14_cards

# ==============================================================================
# SLIDE 15: Kết Luận, Giá Trị Doanh Nghiệp & Định Hướng Mở Rộng
# ==============================================================================
$s15_cards = @(
    @{
        Title = "Giá Trị Nghiệp Vụ Cho Doanh Nghiệp"; Badge = "GIÁ TRỊ THỰC TIỄN"; Color = "01B574"; Border = "01B574"
        Subtitle = "Lợi ích kép cho cả đội ngũ bán hàng và cấp quản trị"
        Items = @(
            "Đối với 8 NVKD: Tiết kiệm 30% thời gian/ngày, triệt tiêu gọi trùng, có sẵn kịch bản tiếp cận khách hàng thiếu thông tin trong 30 giây",
            "Đối với Trưởng phòng & C-Level: Nắm bắt bức tranh kinh doanh thời gian thực, loại bỏ hoàn toàn vùng tối thông tin",
            "Kiểm soát 100% dòng tiền kỳ vọng và phê duyệt kịp thời các dự án trọng điểm",
            "Xuất báo cáo quản trị 10 mục tự động ra file Word và PDF chỉ với 1 cú nhấp chuột"
        )
        X = 600000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "3 Hướng Nâng Cấp Tương Lai (Roadmap)"; Badge = "ĐỊNH HƯỚNG PHÁT TRIỂN"; Color = "00D4FF"; Border = "00D4FF"
        Subtitle = "Kế hoạch hoàn thiện và tích hợp sâu rộng vào hệ sinh thái"
        Items = @(
            "1. Tích hợp Webhook API 2 chiều: Kết nối trực tiếp HubSpot, Salesforce và NamViet CRM để đồng bộ tự động",
            "2. Tích hợp Voice AI Agent: Tự động thực hiện cuộc gọi đầu tiên xác thực 3 câu hỏi còn thiếu cho nhóm P2/P3",
            "3. Ứng dụng LLM RAG: Mở rộng khả năng đọc và tóm tắt hồ sơ thầu phức tạp, file PDF RFQ do khách hàng tải lên"
        )
        X = 4360000; Y = 1750000; W = 3460000; H = 4500000
    },
    @{
        Title = "Tuyên Ngôn Triết Lý Thiết Kế AI Agent"; Badge = "KẾT LUẬN"; Color = "FFB547"; Border = "FFB547"
        Subtitle = "Định vị vai trò công nghệ trong quản trị hiện đại"
        Items = @(
            "'AI Agent đóng vai trò là Trợ lý Điều phối Thông minh hỗ trợ ra quyết định và tối ưu năng suất con người, không thay thế vai trò phê duyệt chiến lược của nhà quản lý.'",
            "Dự án đã giải quyết trọn vẹn yêu cầu Task 1 và Task 2 của học phần AI301",
            "Hệ thống sẵn sàng chuyển giao và vận hành thực tế tại Công ty Phần mềm Nam Việt"
        )
        X = 8120000; Y = 1750000; W = 3460000; H = 4500000
    }
)
Create-SlideXml -slideNum 15 `
    -category "TỔNG KẾT DỰ ÁN & ĐỊNH HƯỚNG TƯƠNG LAI" `
    -title "TỔNG KẾT DỰ ÁN, GIÁ TRỊ THỰC TIỄN & ĐỊNH HƯỚNG PHÁT TRIỂN" `
    -subtitle "Hệ thống AI Agent hoàn chỉnh: Từ logic nghiệp vụ chặt chẽ, kiểm thử trung thực đến trải nghiệm người dùng trực quan" `
    -cards $s15_cards

# Compress into final .pptx file
if (Test-Path $outputPptx) { Remove-Item $outputPptx -Force }
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $outputPptx)
Remove-Item -Recurse -Force $tempDir

$fileSize = (Get-Item $outputPptx).Length
Write-Host "SUCCESS! Generated complete 15-slide presentation at: $outputPptx (Size: $fileSize bytes)"
