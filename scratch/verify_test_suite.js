// Test script for UniversalDataEngine
const fs = require("fs");
const path = require("path");

// Load universal_data_engine.js
const engineCode = fs.readFileSync(path.join(__dirname, "../universal_data_engine.js"), "utf8");
eval(engineCode);

const testDir = path.join(__dirname, "../test_datasets");
const testFiles = [
  "test_01_b2b_lead.csv",
  "test_02_sales_data.csv",
  "test_03_hr_data.csv",
  "test_04_marketing_data.csv",
  "test_05_finance_data.csv",
  "test_06_empty_file.csv",
  "test_07_header_only.csv",
  "test_08_corrupted_file.csv",
  "test_09_unknown_dataset.csv",
  "test_10_mixed_data_types.csv",
  "test_11_duplicate_data.csv",
  "test_12_large_dataset.csv"
];

console.log("==================================================================");
console.log("RUNNING AUTOMATED VERIFICATION OF 12 TEST DATASETS");
console.log("==================================================================");

testFiles.forEach((file, idx) => {
  const filePath = path.join(testDir, file);
  let content = "";
  try {
    content = fs.readFileSync(filePath, "utf8");
  } catch (err) {
    content = "";
  }

  const res = UniversalDataEngine.processDataset(content, file);
  console.log(`\n[TEST ${idx + 1}] ${file}:`);
  if (!res.success) {
    console.log(`  ❌ Rejected gracefully with code: ${res.code}`);
    console.log(`  Title: ${res.title}`);
    console.log(`  Detail: ${res.detail}`);
  } else {
    console.log(`  ✅ Processed successfully: ${res.rowCount} rows, ${res.colCount} cols`);
    console.log(`  Detected Domain: ${res.domainInfo.domainName} (Confidence: ${res.domainInfo.confidence}%)`);
    console.log(`  Quality Score: ${res.profile.qualityScore}/100 (Completeness: ${res.profile.completenessRate}%, Duplicates: ${res.profile.duplicateRows})`);
    if (res.profile.qualityIssues.length > 0) {
      console.log(`  Issues flagged: ${res.profile.qualityIssues.map(i => i.message).join(" | ")}`);
    }
  }
});
console.log("\n==================================================================");
