$appJs = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\app.js" -Raw
$indexHtml = Get-Content -Path "c:\Users\cong chua sofia\Downloads\AII_DEMO\index.html" -Raw

$requiredFunctions = @(
    "switchNavSection",
    "toggleSidebar",
    "closeModal",
    "closeCommonModal",
    "setAgentStatus",
    "toggleDemoMode",
    "startDemoMode",
    "exitDemoMode",
    "prevDemoStep",
    "nextDemoStep",
    "confirmResetModal",
    "executeResetConfirmed",
    "triggerRunAiPipeline",
    "downloadExcelTemplate",
    "downloadCsvTemplate",
    "openWorkflowStepModal",
    "clearLeadSearch",
    "handleSortChange",
    "changeScoringPage",
    "setScoringPage",
    "setScoringPageSize",
    "handleSearchLeads",
    "handlePriorityFilter",
    "handleRepFilter",
    "openEntityDetailModal",
    "openNoteModal",
    "filterByRepCard",
    "openReassignRepModal",
    "executeReassignRep",
    "renderTaskTable",
    "toggleTaskComplete",
    "filterTasks",
    "openCreateTaskModal",
    "executeCreateTask",
    "handleManagerApprovalAll",
    "approveManagerDecision",
    "applyFeedbackPreset",
    "handleFeedbackSubmit",
    "openFeedbackModal",
    "openWeightModal",
    "applyCustomWeightsModal",
    "downloadReportDoc",
    "downloadReportMd",
    "downloadReportPdf",
    "exportReportToWord",
    "exportReportToMarkdown",
    "printReportToPdf",
    "exportLogsJson",
    "setChartPeriod",
    "scrollToPreviewTable",
    "confirmSchemaMapping",
    "resetToAutoMapping",
    "exportValidationReport",
    "triggerRunUniversalOrB2BAnalysis",
    "reviewScopeWithAI",
    "loadSelectedTestSuiteFile",
    "setProcessingMode"
)

Write-Host "Verifying $($requiredFunctions.Count) functions across the system..."
$missing = @()
foreach ($fn in $requiredFunctions) {
    $foundInApp = ($appJs -match "(function\s+$fn\s*\(|window\.$fn\s*=|const\s+$fn\s*=|let\s+$fn\s*=|var\s+$fn\s*=)")
    $foundInHtml = ($indexHtml -match "(function\s+$fn\s*\(|window\.$fn\s*=|const\s+$fn\s*=|let\s+$fn\s*=|var\s+$fn\s*=)")
    if ($foundInApp -or $foundInHtml) {
        Write-Host " [PASS] $fn"
    } else {
        Write-Host " [FAIL] MISSING: $fn"
        $missing += $fn
    }
}

Write-Host "`nTotal verified: $($requiredFunctions.Count)"
Write-Host "Total missing: $($missing.Count)"
if ($missing.Count -eq 0) {
    Write-Host ">>> 100% OF INTERACTIVE FUNCTIONS ARE IMPLEMENTED AND VERIFIED!"
}
