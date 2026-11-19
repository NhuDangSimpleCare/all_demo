// ============================================================================
// UNIVERSAL DATA VALIDATION & INTELLIGENT SCHEMA DETECTION ENGINE
// DataLens AI Enterprise - Đa lĩnh vực (Sales, HR, Finance, Marketing, B2B...)
// Tách biệt: File hợp lệ kỹ thuật · Cấu trúc phân tích được · Nghiệp vụ cụ thể
// ============================================================================

(function (window) {
  "use strict";

  const UniversalDataEngine = {
    // 1. Từ điển nhận diện Lĩnh vực nghiệp vụ (Domain Classification Dictionary)
    domains: {
      SALES: {
        id: "SALES",
        name: "Dữ liệu Bán Hàng & Thương Mại (Sales)",
        icon: "shopping-bag",
        color: "#10B981",
        keywords: [
          "order", "order_id", "sale", "sales", "product", "item", "sku", "quantity", "qty",
          "price", "unit_price", "amount", "revenue", "discount", "total", "customer", "customer_id",
          "payment", "invoice", "shipping", "store", "channel", "bán hàng", "đơn hàng", "sản phẩm",
          "số lượng", "đơn giá", "thành tiền", "doanh thu", "chiết khấu", "tiền hàng"
        ],
        requiredKeyHints: ["order", "sale", "revenue", "product", "doanh thu", "đơn hàng", "bán hàng"]
      },
      HR: {
        id: "HR",
        name: "Dữ liệu Nhân Sự & Tiền Lương (Human Resources)",
        icon: "users",
        color: "#6366F1",
        keywords: [
          "employee", "employee_id", "staff", "staff_id", "worker", "department", "dept",
          "position", "job_title", "salary", "wage", "hire_date", "join_date", "birthday",
          "dob", "manager", "leave", "performance", "attendance", "nhân sự", "nhân viên",
          "phòng ban", "chức vụ", "mức lương", "lương", "ngày vào làm", "chấm công", "hệ số"
        ],
        requiredKeyHints: ["employee", "staff", "salary", "department", "nhân viên", "nhân sự", "lương"]
      },
      FINANCE: {
        id: "FINANCE",
        name: "Dữ liệu Tài Chính & Kế Toán (Finance)",
        icon: "credit-card",
        color: "#22D3EE",
        keywords: [
          "transaction", "transaction_id", "trans_id", "account", "account_no", "debit", "credit",
          "balance", "amount", "fee", "interest", "asset", "liability", "equity", "cash_flow",
          "expense", "cost", "budget", "tax", "tài chính", "giao dịch", "tài khoản", "số dư",
          "nợ", "có", "chi phí", "dòng tiền", "thu chi", "hóa đơn"
        ],
        requiredKeyHints: ["transaction", "account", "debit", "credit", "balance", "tài chính", "giao dịch", "số dư"]
      },
      MARKETING: {
        id: "MARKETING",
        name: "Dữ liệu Tiếp Thị & Quảng Cáo (Marketing)",
        icon: "trending-up",
        color: "#8B5CF6",
        keywords: [
          "campaign", "campaign_id", "campaign_name", "ad_id", "ad_name", "impressions", "clicks",
          "ctr", "cpc", "cpm", "conversions", "cpa", "spend", "cost", "channel", "platform",
          "audience", "lead_gen", "chiến dịch", "lượt hiển thị", "lượt click", "chuyển đổi",
          "chi phí quảng cáo", "kênh tiếp thị"
        ],
        requiredKeyHints: ["campaign", "clicks", "impressions", "ctr", "cpc", "chiến dịch", "quảng cáo"]
      },
      CUSTOMER: {
        id: "CUSTOMER",
        name: "Dữ liệu Trải Nghiệm & Khảo Sát Khách Hàng (Customer Analytics)",
        icon: "smile",
        color: "#F59E0B",
        keywords: [
          "survey", "respondent", "nps", "satisfaction", "csat", "ces", "rating", "score",
          "feedback", "comment", "review", "sentiment", "churn", "retention", "khảo sát",
          "đánh giá", "hài lòng", "ý kiến", "phản hồi", "điểm số", "trải nghiệm"
        ],
        requiredKeyHints: ["survey", "satisfaction", "rating", "nps", "feedback", "khảo sát", "hài lòng"]
      },
      INVENTORY: {
        id: "INVENTORY",
        name: "Dữ liệu Kho Vận & Tồn Kho (Inventory)",
        icon: "package",
        color: "#EC4899",
        keywords: [
          "inventory", "warehouse", "stock", "stock_in", "stock_out", "sku", "barcode", "batch",
          "lot", "reorder_level", "supplier", "vendor", "expiry_date", "tồn kho", "kho hàng",
          "nhập kho", "xuất kho", "nhà cung cấp", "hạn sử dụng", "vật tư"
        ],
        requiredKeyHints: ["stock", "warehouse", "inventory", "sku", "tồn kho", "kho", "nhập kho"]
      },
      EDUCATION: {
        id: "EDUCATION",
        name: "Dữ liệu Giáo Dục & Đào Tạo (Education)",
        icon: "book-open",
        color: "#14B8A6",
        keywords: [
          "student", "student_id", "class", "course", "grade", "score", "gpa", "exam", "major",
          "faculty", "teacher", "instructor", "semester", "attendance", "sinh viên", "học sinh",
          "lớp", "môn học", "điểm số", "học kỳ", "giáo viên", "giảng viên"
        ],
        requiredKeyHints: ["student", "grade", "gpa", "course", "sinh viên", "học sinh", "điểm"]
      },
      B2B_LEAD: {
        id: "B2B_LEAD",
        name: "Dữ liệu Khách Hàng Tiềm Năng B2B (B2B Lead Intelligence)",
        icon: "briefcase",
        color: "#6366F1",
        keywords: [
          "company", "company_name", "tax_code", "mst", "contact", "contact_name", "role",
          "position", "phone", "email", "province", "city", "industry", "company_size", "employees",
          "budget", "requirement", "need", "source", "mã số thuế", "người liên hệ", "doanh nghiệp",
          "ngân sách", "quy mô", "nhu cầu"
        ],
        requiredKeyHints: ["company", "tax", "contact", "lead", "doanh nghiệp", "mã số thuế", "khách hàng"]
      }
    },

    // 2. Từ điển dịch nghĩa cột thông minh (Semantic Column Meaning Mapping)
    semanticMeanings: {
      // Chung & Định danh
      id: "Mã định danh (ID)",
      code: "Mã tham chiếu",
      name: "Tên / Danh xưng",
      created_at: "Ngày tạo",
      updated_at: "Ngày cập nhật",
      date: "Ngày / Mốc thời gian",
      status: "Trạng thái",
      description: "Mô tả chi tiết",
      note: "Ghi chú",
      type: "Phân loại",
      category: "Nhóm / Danh mục",
      region: "Khu vực / Phân vùng",
      city: "Tỉnh / Thành phố",
      country: "Quốc gia",

      // Sales
      order_id: "Mã đơn hàng",
      order_date: "Ngày đặt hàng",
      customer_id: "Mã khách hàng",
      customer_name: "Tên khách hàng",
      product_id: "Mã sản phẩm",
      product_name: "Tên sản phẩm",
      product: "Sản phẩm",
      quantity: "Số lượng",
      qty: "Số lượng",
      price: "Đơn giá",
      unit_price: "Đơn giá",
      amount: "Thành tiền / Giá trị",
      total: "Tổng thanh toán",
      total_amount: "Tổng giá trị giao dịch",
      revenue: "Doanh thu",
      discount: "Chiết khấu / Giảm giá",
      payment_method: "Phương thức thanh toán",
      shipping_fee: "Phí vận chuyển",

      // HR
      employee_id: "Mã nhân viên",
      employee_name: "Họ tên nhân viên",
      department: "Phòng ban / Bộ phận",
      position: "Vị trí / Chức danh",
      salary: "Mức lương cơ bản",
      base_salary: "Lương chính",
      bonus: "Tiền thưởng / Phụ cấp",
      hire_date: "Ngày vào làm",
      join_date: "Ngày tuyển dụng",
      dob: "Ngày sinh",
      gender: "Giới tính",
      phone: "Số điện thoại liên hệ",
      email: "Thư điện tử (Email)",

      // Marketing
      campaign_id: "Mã chiến dịch tiếp thị",
      campaign_name: "Tên chiến dịch",
      campaign: "Chiến dịch",
      impressions: "Lượt hiển thị (Impressions)",
      clicks: "Lượt nhấp chuột (Clicks)",
      ctr: "Tỷ lệ nhấp (CTR %)",
      cpc: "Chi phí mỗi click (CPC)",
      conversions: "Số lượt chuyển đổi",
      cost: "Chi phí chiến dịch",
      spend: "Ngân sách đã tiêu",

      // Finance
      transaction_id: "Mã giao dịch tài chính",
      transaction_date: "Ngày phát sinh giao dịch",
      account: "Tài khoản kế toán",
      account_number: "Số tài khoản",
      debit: "Phát sinh Nợ",
      credit: "Phát sinh Có",
      balance: "Số dư tài khoản",

      // B2B Leads
      company_name: "Tên doanh nghiệp / Pháp nhân",
      tax_code: "Mã số thuế doanh nghiệp",
      contact_name: "Người liên hệ / Đầu mối",
      company_size: "Quy mô nhân sự",
      employees: "Số lượng nhân sự",
      budget: "Ngân sách dự kiến",
      requirement: "Nhu cầu / Bài toán phần mềm",
      source: "Kênh tiếp nhận Lead"
    },

    // 3. Chuẩn hóa tên cột để tra cứu
    cleanColumnKey(colName) {
      if (!colName) return "";
      return colName
        .toString()
        .trim()
        .toLowerCase()
        .replace(/[\s\-_.]+/g, "_")
        .normalize("NFD")
        .replace(/[\u0300-\u036f]/g, "")
        .replace(/đ/g, "d");
    },

    // 4. Nhận diện kiểu dữ liệu của một giá trị đơn lẻ
    detectValueType(val) {
      if (val === null || val === undefined) return "empty";
      const s = String(val).trim();
      if (s === "" || s.toLowerCase() === "n/a" || s.toLowerCase() === "null" || s === "-" || s === "---") {
        return "empty";
      }

      // Boolean
      if (/^(true|false|yes|no|đúng|sai|có|không)$/i.test(s)) return "boolean";

      // Email
      if (/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(s)) return "email";

      // Phone (cho phép +84, dấu cách, dấu chấm)
      if (/^(\+?84|0)[\s.-]?\d{2,3}[\s.-]?\d{3}[\s.-]?\d{3,4}$/.test(s)) return "phone";

      // URL
      if (/^https?:\/\/[^\s]+$/i.test(s)) return "url";

      // Date / Timestamp (hỗ trợ YYYY-MM-DD, DD/MM/YYYY, ISO...)
      if (/^\d{4}[-/.]\d{1,2}[-/.]\d{1,2}(\s+\d{1,2}:\d{2}(:\d{2})?)?$/.test(s) ||
          /^\d{1,2}[-/.]\d{1,2}[-/.]\d{2,4}(\s+\d{1,2}:\d{2}(:\d{2})?)?$/.test(s)) {
        const d = new Date(s.replace(/(\d{2})\/(\d{2})\/(\d{4})/, "$3-$2-$1"));
        if (!isNaN(d.getTime())) return "date";
      }

      // Number (loại bỏ dấu phân cách hàng nghìn, tiền tệ)
      const cleanNum = s.replace(/[,\s₫đ$€¥%]/gi, "").replace(/([0-9]+)\.([0-9]{3})(?!\d)/g, "$1$2");
      if (/^-?\d+(\.\d+)?$/.test(cleanNum) && !isNaN(Number(cleanNum))) {
        return Number(cleanNum) % 1 === 0 ? "integer" : "float";
      }

      return "text";
    },

    // 5. Kiểm tra toàn diện Schema & Chất lượng từng Cột (Column Profiling)
    analyzeColumn(colName, rows) {
      const totalRows = rows.length;
      let emptyCount = 0;
      const typeCounts = {
        integer: 0,
        float: 0,
        date: 0,
        boolean: 0,
        email: 0,
        phone: 0,
        url: 0,
        text: 0
      };
      const valuesMap = new Map();
      const samples = [];

      for (let i = 0; i < totalRows; i++) {
        const rawVal = rows[i][colName];
        const vType = this.detectValueType(rawVal);
        if (vType === "empty") {
          emptyCount++;
        } else {
          typeCounts[vType] = (typeCounts[vType] || 0) + 1;
          const sVal = String(rawVal).trim();
          valuesMap.set(sVal, (valuesMap.get(sVal) || 0) + 1);
          if (samples.length < 3 && !samples.includes(sVal)) {
            samples.push(sVal);
          }
        }
      }

      const validCount = totalRows - emptyCount;
      const missingRate = totalRows > 0 ? (emptyCount / totalRows) : 0;
      const uniqueCount = valuesMap.size;

      // Xác định kiểu chủ đạo (Dominant Type)
      let dominantType = "text";
      let maxCount = 0;
      let nonZeroTypes = 0;

      for (const [t, cnt] of Object.entries(typeCounts)) {
        if (cnt > 0) {
          nonZeroTypes++;
          if (cnt > maxCount) {
            maxCount = cnt;
            dominantType = t;
          }
        }
      }

      // Phát hiện Mixed Data Types nếu có 2 kiểu chiếm > 15% valid data
      const isMixed = validCount > 0 && (
        (typeCounts.text > 0 && (typeCounts.integer + typeCounts.float) > 0 &&
         (typeCounts.text / validCount >= 0.15) &&
         ((typeCounts.integer + typeCounts.float) / validCount >= 0.15))
      );

      // Thống kê số học nếu là kiểu số
      let numericStats = null;
      if ((dominantType === "integer" || dominantType === "float") && validCount > 0) {
        let min = Infinity, max = -Infinity, sum = 0;
        let numCount = 0;
        for (let i = 0; i < totalRows; i++) {
          const rawVal = rows[i][colName];
          if (rawVal !== null && rawVal !== undefined && String(rawVal).trim() !== "") {
            const num = Number(String(rawVal).replace(/[,\s₫đ$€¥%]/gi, ""));
            if (!isNaN(num)) {
              if (num < min) min = num;
              if (num > max) max = num;
              sum += num;
              numCount++;
            }
          }
        }
        if (numCount > 0) {
          numericStats = {
            min: min === Infinity ? 0 : min,
            max: max === -Infinity ? 0 : max,
            avg: Math.round((sum / numCount) * 100) / 100,
            sum: Math.round(sum * 100) / 100
          };
        }
      }

      return {
        columnName: colName,
        dominantType,
        validCount,
        emptyCount,
        missingRate,
        uniqueCount,
        isMixed,
        samples,
        numericStats,
        typeBreakdown: typeCounts
      };
    },

    // 6. Phân loại Lĩnh vực Dữ liệu (Domain Classification with Confidence)
    classifyDatasetDomain(headers, schemaList) {
      const cleanedHeaders = headers.map(h => this.cleanColumnKey(h));
      const scores = {};
      const evidence = {};

      for (const [domKey, domDef] of Object.entries(this.domains)) {
        scores[domKey] = 0;
        evidence[domKey] = [];

        // So khớp từ khóa với tên cột
        for (let i = 0; i < headers.length; i++) {
          const rawHeader = headers[i].toLowerCase();
          const cleanH = cleanedHeaders[i];

          for (const kw of domDef.keywords) {
            const cleanKw = this.cleanColumnKey(kw);
            if (cleanH === cleanKw || cleanH.includes(cleanKw) || rawHeader.includes(kw.toLowerCase())) {
              scores[domKey] += 10;
              if (!evidence[domKey].includes(headers[i])) {
                evidence[domKey].push(headers[i]);
              }
              break;
            }
          }
        }

        // Tăng điểm nếu có từ khóa cốt lõi (Required Key Hints)
        let coreHits = 0;
        for (const hint of domDef.requiredKeyHints) {
          const cleanHint = this.cleanColumnKey(hint);
          if (cleanedHeaders.some(h => h.includes(cleanHint))) {
            coreHits++;
          }
        }
        scores[domKey] += coreHits * 15;
      }

      // Tìm Domain có điểm cao nhất
      let bestDomainKey = "UNKNOWN";
      let highestScore = 0;

      for (const [k, sc] of Object.entries(scores)) {
        if (sc > highestScore) {
          highestScore = sc;
          bestDomainKey = k;
        }
      }

      // Tính Confidence % (dựa trên tỷ lệ cột khớp và điểm)
      const maxPossible = Math.max(headers.length * 15, 30);
      let confidence = Math.min(Math.round((highestScore / maxPossible) * 100), 98);

      if (highestScore < 15 || evidence[bestDomainKey]?.length === 0) {
        return {
          domainId: "UNKNOWN",
          domainName: "Dữ Liệu Bảng Tổng Quát (General Dataset)",
          confidence: Math.max(confidence, 35),
          isConfident: false,
          evidenceColumns: [],
          warning: "Không tìm thấy mẫu từ khóa đặc trưng rõ ràng. Hệ thống phân loại thành bảng dữ liệu tổng quát."
        };
      }

      const bestDef = this.domains[bestDomainKey];
      return {
        domainId: bestDef.id,
        domainName: bestDef.name,
        confidence: Math.max(confidence, 60),
        isConfident: confidence >= 50,
        evidenceColumns: evidence[bestDomainKey],
        warning: confidence < 50 ? "Nhận diện độ tin cậy trung bình dựa trên quy tắc so khớp từ khóa." : null
      };
    },

    // 7. Đề xuất Ý nghĩa Cột Thông Minh (Intelligent Column Mapping)
    generateColumnMappings(headers, schemaList, domain) {
      return headers.map(h => {
        const cleanH = this.cleanColumnKey(h);
        const schema = schemaList.find(s => s.columnName === h) || {};

        let detectedMeaning = "";
        let status = "auto_high"; // auto_high, auto_medium, needs_confirm, unknown

        // Tra trong semantic dictionary
        for (const [key, label] of Object.entries(this.semanticMeanings)) {
          const cleanKey = this.cleanColumnKey(key);
          if (cleanH === cleanKey) {
            detectedMeaning = label;
            status = "auto_high";
            break;
          } else if (cleanH.includes(cleanKey) || cleanKey.includes(cleanH)) {
            detectedMeaning = label;
            status = "auto_medium";
            break;
          }
        }

        if (!detectedMeaning) {
          // Đoán dựa theo kiểu dữ liệu
          if (schema.dominantType === "date") {
            detectedMeaning = "Thời gian / Ngày ghi nhận";
            status = "needs_confirm";
          } else if (schema.dominantType === "email") {
            detectedMeaning = "Địa chỉ Thư điện tử (Email)";
            status = "auto_high";
          } else if (schema.dominantType === "phone") {
            detectedMeaning = "Số điện thoại";
            status = "auto_high";
          } else if (schema.dominantType === "integer" || schema.dominantType === "float") {
            detectedMeaning = "Chỉ số số học (Đo lường / Thống kê)";
            status = "needs_confirm";
          } else {
            detectedMeaning = `Trường dữ liệu (${h})`;
            status = "unknown";
          }
        }

        return {
          originalColumn: h,
          detectedMeaning,
          dataType: schema.dominantType || "text",
          status,
          statusLabel: status === "auto_high" ? "Độ tin cậy cao" :
                       status === "auto_medium" ? "Độ tin cậy vừa" :
                       status === "needs_confirm" ? "Cần xác nhận" : "Chưa rõ",
          missingRate: Math.round((schema.missingRate || 0) * 100),
          uniqueCount: schema.uniqueCount || 0
        };
      });
    },

    // 8. Đánh giá Chất Lượng Toàn Diện (Comprehensive Data Profiling)
    profileDataQuality(rawRows, headers, schemaList) {
      const totalRows = rawRows.length;
      const totalColumns = headers.length;
      const totalCells = totalRows * totalColumns;

      let totalMissingCells = 0;
      let mixedColumnsCount = 0;
      const typeDistribution = {};

      schemaList.forEach(s => {
        totalMissingCells += s.emptyCount;
        if (s.isMixed) mixedColumnsCount++;
        typeDistribution[s.dominantType] = (typeDistribution[s.dominantType] || 0) + 1;
      });

      // Phát hiện bản ghi trùng lặp 100%
      const rowHashCounts = new Map();
      let duplicateRowsCount = 0;

      rawRows.forEach(row => {
        const hash = headers.map(h => String(row[h] || "").trim()).join("|||");
        const count = rowHashCounts.get(hash) || 0;
        if (count >= 1) {
          duplicateRowsCount++;
        }
        rowHashCounts.set(hash, count + 1);
      });

      // Tính điểm chất lượng dữ liệu (Data Quality Score: 0 - 100)
      const completenessRate = totalCells > 0 ? ((totalCells - totalMissingCells) / totalCells) : 0;
      const uniquenessRate = totalRows > 0 ? ((totalRows - duplicateRowsCount) / totalRows) : 1;
      const typeCleanlinessRate = totalColumns > 0 ? ((totalColumns - mixedColumnsCount) / totalColumns) : 1;

      const qualityScore = Math.round(
        (completenessRate * 50) + (uniquenessRate * 30) + (typeCleanlinessRate * 20)
      );

      // Cảnh báo chất lượng tiềm ẩn (Potential Data Quality Issues)
      const qualityIssues = [];
      if (duplicateRowsCount > 0) {
        qualityIssues.push({
          level: "warning",
          code: "DUPLICATE_ROWS",
          message: `Phát hiện ${duplicateRowsCount} bản ghi trùng lặp 100% về mặt giá trị.`
        });
      }

      schemaList.forEach(s => {
        if (s.missingRate >= 0.3) {
          qualityIssues.push({
            level: s.missingRate >= 0.6 ? "error" : "warning",
            code: "HIGH_MISSING_COLUMN",
            message: `Cột "${s.columnName}" bị khuyết thiếu ${Math.round(s.missingRate * 100)}% dữ liệu (${s.emptyCount}/${totalRows} dòng).`
          });
        }
        if (s.isMixed) {
          qualityIssues.push({
            level: "warning",
            code: "MIXED_DATA_TYPES",
            message: `Cột "${s.columnName}" chứa nhiều kiểu dữ liệu không đồng nhất (vừa chứa chữ, vừa chứa số).`
          });
        }
      });

      return {
        totalRows,
        totalColumns,
        totalCells,
        missingCells: totalMissingCells,
        completenessRate: Math.round(completenessRate * 100),
        duplicateRows: duplicateRowsCount,
        uniquenessRate: Math.round(uniquenessRate * 100),
        mixedColumnsCount,
        typeDistribution,
        qualityScore: Math.max(0, Math.min(100, qualityScore)),
        qualityIssues
      };
    },

    // 9. Bộ Thống Kê Phân Tích Đa Năng (Universal Analytics Generator)
    generateUniversalAnalytics(rawRows, schemaList, domain) {
      const numericColumns = schemaList.filter(s => s.dominantType === "integer" || s.dominantType === "float");
      const categoricalColumns = schemaList.filter(s => s.dominantType === "text" && s.uniqueCount > 1 && s.uniqueCount <= 30);
      const dateColumns = schemaList.filter(s => s.dominantType === "date");

      // Bảng thống kê số học
      const numericSummaries = numericColumns.map(s => ({
        column: s.columnName,
        min: s.numericStats?.min ?? 0,
        max: s.numericStats?.max ?? 0,
        avg: s.numericStats?.avg ?? 0,
        sum: s.numericStats?.sum ?? 0
      }));

      // Bảng tần suất danh mục hàng đầu
      const categorySummaries = categoricalColumns.slice(0, 3).map(s => {
        const counts = new Map();
        rawRows.forEach(r => {
          const val = String(r[s.columnName] || "").trim() || "(Trống)";
          counts.set(val, (counts.get(val) || 0) + 1);
        });
        const topValues = Array.from(counts.entries())
          .sort((a, b) => b[1] - a[1])
          .slice(0, 5)
          .map(([val, cnt]) => ({ value: val, count: cnt, percent: Math.round((cnt / rawRows.length) * 100) }));

        return {
          column: s.columnName,
          topValues
        };
      });

      return {
        numericSummaries,
        categorySummaries,
        hasDateSeries: dateColumns.length > 0,
        dateColumnName: dateColumns[0]?.columnName || null
      };
    },

    // 10. Hàm Kiểm Tra File Đầu Vào Nghiêm Ngặt (File Inspection & Parsing)
    // Trả về { success: boolean, code: string, error?: string, rawRows?: [], headers?: [] }
    inspectAndParse(rawContent, fileName) {
      if (!rawContent || (typeof rawContent === "string" && rawContent.trim() === "")) {
        return {
          success: false,
          code: "FILE_EMPTY",
          title: "FILE EMPTY – Tệp dữ liệu không chứa nội dung có thể xử lý.",
          detail: "Tệp rỗng (0 byte hoặc không có ký tự). Vui lòng chọn tệp khác!"
        };
      }

      // Xử lý chuỗi CSV
      if (typeof rawContent === "string") {
        const lines = rawContent.split(/\r?\n/).filter(line => line.trim().length > 0);
        if (lines.length === 0) {
          return {
            success: false,
            code: "FILE_EMPTY",
            title: "FILE EMPTY – Tệp dữ liệu không chứa nội dung có thể xử lý.",
            detail: "Không tìm thấy bản ghi hoặc dòng dữ liệu nào trong tệp."
          };
        }

        // Tách tiêu đề
        const firstLine = lines[0].replace(/^\uFEFF/, "").trim();
        // Kiểm tra phân cách phẩy, chấm phẩy, tab
        const delimiter = firstLine.includes(",") ? "," : firstLine.includes(";") ? ";" : firstLine.includes("\t") ? "\t" : ",";
        const rawHeaders = firstLine.split(delimiter).map(h => h.replace(/^["']|["']$/g, "").trim());

        // Kiểm tra có tiêu đề không
        if (rawHeaders.length === 0 || (rawHeaders.length === 1 && !rawHeaders[0])) {
          return {
            success: false,
            code: "HEADER_NOT_DETECTED",
            title: "HEADER NOT DETECTED – Không xác định được dòng tiêu đề.",
            detail: "Cấu trúc cột không rõ ràng. Không thể trích xuất tên trường."
          };
        }

        // Kiểm tra trường hợp chỉ có tiêu đề mà không có dòng dữ liệu (Header Only)
        if (lines.length === 1) {
          return {
            success: false,
            code: "NO_DATA_RECORDS",
            title: "NO DATA RECORDS – File có cấu trúc cột nhưng không có dòng dữ liệu.",
            detail: `Tệp chứa ${rawHeaders.length} cột (${rawHeaders.slice(0, 4).join(", ")}...) nhưng không có bất kỳ dòng dữ liệu nào bên dưới.`,
            headers: rawHeaders
          };
        }

        // Parse các dòng dữ liệu
        const parsedRows = [];
        for (let i = 1; i < lines.length; i++) {
          const rowVals = lines[i].split(delimiter).map(v => v.replace(/^["']|["']$/g, "").trim());
          if (rowVals.length === 1 && !rowVals[0]) continue; // bỏ qua dòng trống
          const obj = {};
          rawHeaders.forEach((h, idx) => {
            obj[h] = rowVals[idx] !== undefined ? rowVals[idx] : "";
          });
          parsedRows.push(obj);
        }

        if (parsedRows.length === 0) {
          return {
            success: false,
            code: "NO_DATA_RECORDS",
            title: "NO DATA RECORDS – File có cấu trúc cột nhưng không có dòng dữ liệu.",
            detail: "Đã đọc được tiêu đề nhưng tất cả các dòng dữ liệu đều trống.",
            headers: rawHeaders
          };
        }

        return {
          success: true,
          headers: rawHeaders,
          rawRows: parsedRows,
          rowCount: parsedRows.length,
          colCount: rawHeaders.length
        };
      }

      // Xử lý đối tượng mảng JSON
      if (Array.isArray(rawContent)) {
        if (rawContent.length === 0) {
          return {
            success: false,
            code: "NO_DATA_RECORDS",
            title: "NO DATA RECORDS – File có cấu trúc cột nhưng không có dòng dữ liệu.",
            detail: "Mảng dữ liệu không chứa phần tử nào."
          };
        }
        const headers = Object.keys(rawContent[0]);
        return {
          success: true,
          headers,
          rawRows: rawContent,
          rowCount: rawContent.length,
          colCount: headers.length
        };
      }

      return {
        success: false,
        code: "FILE_PARSING_ERROR",
        title: "FILE PARSING ERROR – Không thể đọc nội dung file.",
        detail: "Định dạng dữ liệu không tương thích hoặc bị hỏng."
      };
    },

    // 11. Pipeline Toàn Diện: Tiếp nhận File -> Phân tích Schema -> Đánh giá Domain & Profiling
    processDataset(rawInput, fileName = "dataset.csv") {
      const parseResult = this.inspectAndParse(rawInput, fileName);
      if (!parseResult.success) {
        return parseResult;
      }

      const { headers, rawRows } = parseResult;

      // Bước 2: Schema Detection
      const schemaList = headers.map(h => this.analyzeColumn(h, rawRows));

      // Bước 3: Domain Classification
      const domainInfo = this.classifyDatasetDomain(headers, schemaList);

      // Bước 4: Intelligent Column Mapping
      const mappings = this.generateColumnMappings(headers, schemaList, domainInfo);

      // Bước 5: Data Profiling
      const profile = this.profileDataQuality(rawRows, headers, schemaList);

      // Bước 6: Universal Analytics Preview
      const analytics = this.generateUniversalAnalytics(rawRows, schemaList, domainInfo);

      return {
        success: true,
        fileName,
        headers,
        rawRows,
        rowCount: rawRows.length,
        colCount: headers.length,
        schemaList,
        domainInfo,
        mappings,
        profile,
        analytics
      };
    }
  };

  // Export module
  window.UniversalDataEngine = UniversalDataEngine;
})(typeof window !== "undefined" ? window : global);
