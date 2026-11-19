$handlers = @(
    "applyFeedbackPreset",
    "closeCommonModal",
    "confirmSchemaMapping",
    "downloadReportDoc",
    "downloadReportMd",
    "downloadReportPdf",
    "exitDemoMode",
    "exportLogsJson",
    "exportValidationReport",
    "handleFeedbackSubmit",
    "handleManagerApprovalAll",
    "loadSelectedTestSuiteFile",
    "nextDemoStep",
    "openDataImportModal",
    "openFeedbackModal",
    "openWeightModal",
    "prevDemoStep",
    "resetStudioFlow",
    "resetToAutoMapping",
    "reviewScopeWithAI",
    "scrollToPreviewTable",
    "setChartPeriod",
    "setProcessingMode",
    "startDemoMode",
    "switchNavSection",
    "toggleSidebar",
    "triggerRunAiPipeline",
    "triggerRunUniversalOrB2BAnalysis"
)

$appJs = Get-Content 'c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js' -Raw
$indexHtml = Get-Content 'c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html' -Raw

foreach ($h in $handlers) {
    $inApp = ($appJs -match "function\s+$h\b") -or ($appJs -match "window\.$h\s*=")
    $inHtml = ($indexHtml -match "function\s+$h\b") -or ($indexHtml -match "window\.$h\s*=")
    $status = if ($inApp -or $inHtml) { "EXISTS" } else { "MISSING" }
    Write-Host "$h : $status (inApp: $inApp, inHtml: $inHtml)"
}
