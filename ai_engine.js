// ============================================================================
// AI AGENT ENGINE - SÀNG LỌC, HỢP NHẤT HỒ SƠ, CHẤM ĐIỂM & PHÂN HẠNG TIỀM NĂNG B2B
// Bám sát lưu đồ: "QUY TRÌNH SÀNG LỌC & ĐIỀU PHỐI KHÁCH HÀNG TIỀM NĂNG - CÔNG TY NAM VIỆT"
// ============================================================================

class NamVietAIAgent {
  constructor(config) {
    this.config = config;
    this.auditLogs = [];
  }

  // Ghi nhận nhật ký hoạt động (Bước: Cập nhật & Theo dõi, Ghi Log)
  logAction(stage, entityId, companyName, action, detail, actor = "AI Agent") {
    const now = new Date();
    const timeStr = now.toTimeString().split(" ")[0];
    this.auditLogs.unshift({
      id: `LOG-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
      timestamp: `2026-11-11 ${timeStr}`,
      stage,
      entityId,
      companyName,
      action,
      detail,
      actor
    });
  }

  // Bỏ dấu tiếng Việt để chuẩn hóa so khớp tên viết tắt / alias
  removeVietnameseTones(str) {
    if (!str) return "";
    return str
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/đ/g, "d")
      .replace(/Đ/g, "D")
      .toLowerCase();
  }

  // Chuẩn hóa tên doanh nghiệp về khóa gốc (normName)
  normalizeCompanyKey(name) {
    if (!name) return "";
    let clean = this.removeVietnameseTones(name);
    // Loại bỏ nội dung trong ngoặc đơn và hậu tố #...
    clean = clean.replace(/\(.*?\)/g, " ");
    // Loại bỏ các từ tiền tố/hậu tố pháp nhân và phân vùng địa lý bắt buộc
    const stopWords = [
      "cong ty", "co phan", "tnhh", "ctcp", "tap doan", "doanh nghiep",
      "chi nhanh", "viet nam", "jsc", "co ltd", "corp", "company",
      "mien bac", "mien trung", "mien nam",
      "precision", "mech", "logistics", "tiep van", "acl", "pharma",
      "he thong", "chuoi", "nha phan phoi", "xuong", "studio", "sme"
    ];
    stopWords.forEach(w => {
      const regex = new RegExp(`\\b${w}\\b`, "gi");
      clean = clean.replace(regex, " ");
    });
    clean = clean.replace(/[^a-z0-9]/g, "");
    return clean;
  }

  // Trích xuất domain email doanh nghiệp (bỏ qua email cá nhân miễn phí - freeEmailDomains)
  extractCorporateDomain(email) {
    if (!email || !email.includes("@")) return "";
    const domain = email.split("@")[1].toLowerCase().trim();
    const freeEmailDomains = ["gmail.com", "yahoo.com", "outlook.com", "hotmail.com", "icloud.com"];
    if (freeEmailDomains.includes(domain)) return "";
    return domain;
  }

  // ==========================================================================
  // BƯỚC 1: CHUẨN HÓA & LỌC TRÙNG DỮ LIỆU -> CÙNG MỘT DOANH NGHIỆP? -> GOM NHÓM
  // ==========================================================================
  deduplicateAndGroup(rawLeads) {
    const groups = [];
    const freeDomains = new Set(["gmail.com", "yahoo.com", "outlook.com", "hotmail.com"]);

    rawLeads.forEach(lead => {
      const taxCode = (lead.tax_code || "").toString().trim();
      const domain = this.extractCorporateDomain(lead.email);
      const normKey = this.normalizeCompanyKey(lead.company_name);

      // Tìm xem lead này có khớp với nhóm doanh nghiệp nào đã tạo chưa
      let matchedGroup = null;
      let matchReasons = [];

      for (const grp of groups) {
        const reasons = [];
        if (taxCode && grp.taxCodes.has(taxCode)) {
          reasons.push(`Trùng Mã số thuế (${taxCode})`);
        }
        if (domain && grp.domains.has(domain)) {
          reasons.push(`Trùng tên miền Email (@${domain})`);
        }
        if (normKey && normKey.length >= 5) {
          for (const existingKey of grp.normKeys) {
            if (existingKey === normKey || (existingKey.length >= 6 && (existingKey.includes(normKey) || normKey.includes(existingKey)))) {
              reasons.push(`Khớp tên rút gọn/Alias ("${lead.company_name}")`);
              break;
            }
          }
        }
        if (reasons.length > 0) {
          matchedGroup = grp;
          matchReasons = reasons;
          break;
        }
      }

      if (matchedGroup) {
        matchedGroup.rawLeads.push(lead);
        if (taxCode) matchedGroup.taxCodes.add(taxCode);
        if (domain) matchedGroup.domains.add(domain);
        if (normKey) matchedGroup.normKeys.add(normKey);
        matchedGroup.aliases.add(lead.company_name);
        matchedGroup.sources.add(lead.source || "Website");
        if (lead.region) matchedGroup.regions.add(lead.region);
        if (lead.province) matchedGroup.provinces.add(lead.province);
        if (lead.industry) matchedGroup.industries.add(lead.industry);
        matchReasons.forEach(r => matchedGroup.matchReasons.add(r));
      } else {
        const newGrp = {
          entityId: `ENT-${String(groups.length + 1).padStart(3, "0")}`,
          primaryName: lead.company_name,
          rawLeads: [lead],
          taxCodes: new Set(taxCode ? [taxCode] : []),
          domains: new Set(domain ? [domain] : []),
          normKeys: new Set(normKey ? [normKey] : []),
          aliases: new Set([lead.company_name]),
          sources: new Set([lead.source || "Website"]),
          regions: new Set(lead.region ? [lead.region] : []),
          provinces: new Set(lead.province ? [lead.province] : []),
          industries: new Set(lead.industry ? [lead.industry] : []),
          matchReasons: new Set()
        };
        groups.push(newGrp);
      }
    });

    // Chuyển từng group thành Hồ sơ hợp nhất (Golden Record)
    return groups.map(grp => {
      // Chọn tên công ty đầy đủ nhất làm tên chính thức
      const sortedNames = Array.from(grp.aliases).sort((a, b) => b.length - a.length);
      const canonicalName = sortedNames[0];
      const taxCode = Array.from(grp.taxCodes)[0] || "";
      const domain = Array.from(grp.domains)[0] || "";

      // Tổng hợp danh sách người liên hệ từ các lần đăng ký
      const contacts = grp.rawLeads.map(l => ({
        lead_id: l.lead_id,
        name: l.contact_name || "Chưa rõ tên",
        role: l.role || "Chưa rõ chức vụ",
        phone: l.phone || "",
        email: l.email || "",
        source: l.source || "Website",
        created_at: l.created_at || "",
        region: l.region || "",
        province: l.province || "",
        budget_million: Number(l.budget_million) || 0,
        requirement: l.requirement || ""
      }));

      // Hợp nhất quy mô và ngân sách
      const maxCompanySize = Math.max(...grp.rawLeads.map(l => Number(l.company_size) || 0));
      const maxBudget = Math.max(...grp.rawLeads.map(l => Number(l.budget_million) || 0));
      const combinedRequirements = grp.rawLeads
        .map(l => `[${l.source} - ${l.contact_name}${l.role ? " (" + l.role + ")" : ""}]: ${l.requirement}`)
        .join(" | ");

      // Kiểm tra lịch sử liên hệ trong CRM (Contact History)
      const matchedHistory = this.findCRMHistory(taxCode, domain, grp.normKeys);

      const isMerged = grp.rawLeads.length > 1;
      if (isMerged) {
        this.logAction(
          "Lọc trùng & Gom nhóm",
          grp.entityId,
          canonicalName,
          `Gom ${grp.rawLeads.length} hồ sơ trùng/alias thành 1 Golden Record`,
          `Các tên đăng ký: ${Array.from(grp.aliases).join(" / ")}. Lý do: ${Array.from(grp.matchReasons).join(", ")}`
        );
      }

      return {
        entityId: grp.entityId,
        canonicalName,
        aliases: Array.from(grp.aliases),
        isMerged,
        mergedCount: grp.rawLeads.length,
        matchReasons: Array.from(grp.matchReasons),
        taxCode,
        domain,
        sources: Array.from(grp.sources),
        regions: Array.from(grp.regions),
        provinces: Array.from(grp.provinces),
        primaryRegion: Array.from(grp.regions)[0] || "",
        primaryProvince: Array.from(grp.provinces)[0] || "",
        primaryIndustry: Array.from(grp.industries)[0] || "Thương mại & Phân phối",
        companySize: maxCompanySize,
        budgetMillion: maxBudget,
        contacts,
        combinedRequirements,
        crmHistory: matchedHistory
      };
    });
  }

  findCRMHistory(taxCode, domain, normKeys) {
    for (const hist of this.config.contactHistory) {
      if (taxCode && hist.taxCode === taxCode) return hist;
      if (domain && hist.domain === domain) return hist;
      for (const k of normKeys) {
        if (k && hist.normalizedKey && (k.includes(hist.normalizedKey) || hist.normalizedKey.includes(k))) {
          return hist;
        }
      }
    }
    return null;
  }

  // ==========================================================================
  // BƯỚC 2: KIỂM TRA HỒ SƠ ĐẦY ĐỦ & PHÙ HỢP (PRODUCT FIT & ICP CHECK)
  // + TẠO CÂU HỎI / THÔNG ĐIỆP TIẾP CẬN (DRAFT) CHO HỒ SƠ THIẾU THÔNG TIN
  // ==========================================================================
  evaluateProductFitAndCompleteness(entity) {
    const reqLower = this.removeVietnameseTones(entity.combinedRequirements);
    const rawReqLower = entity.combinedRequirements.toLowerCase();

    // 1. Kiểm tra từ khóa lệch sản phẩm (Bẫy ngân sách ảo)
    let nonFitDetected = null;
    for (const nf of this.config.nonFitKeywords) {
      if (rawReqLower.includes(nf.keyword) || reqLower.includes(this.removeVietnameseTones(nf.keyword))) {
        nonFitDetected = nf;
        break;
      }
    }

    // 2. Đối chiếu mức độ khớp với 5 nhóm sản phẩm của Nam Việt
    const matchedProducts = [];
    this.config.products.forEach(prod => {
      let hitCount = 0;
      const matchedKw = [];
      prod.keywords.forEach(kw => {
        if (rawReqLower.includes(kw) || reqLower.includes(this.removeVietnameseTones(kw))) {
          hitCount++;
          matchedKw.push(kw);
        }
      });
      if (hitCount > 0) {
        matchedProducts.push({
          id: prod.id,
          name: prod.name,
          category: prod.category,
          hitCount,
          matchedKw,
          minBudget: prod.minBudget
        });
      }
    });

    matchedProducts.sort((a, b) => b.hitCount - a.hitCount);

    // 3. Kiểm tra các trường thông tin còn thiếu
    const missingFields = [];
    if (!entity.companySize || entity.companySize <= 0) missingFields.push("Quy mô nhân sự");
    if (!entity.budgetMillion || entity.budgetMillion <= 0) missingFields.push("Ngân sách dự kiến");
    if (!entity.primaryRegion && !entity.primaryProvince) missingFields.push("Khu vực / Tỉnh thành");
    const hasClearRole = entity.contacts.some(c => c.role && c.role !== "Chưa rõ chức vụ" && c.role.trim() !== "");
    if (!hasClearRole) missingFields.push("Chức vụ người liên hệ");

    const isComplete = missingFields.length === 0;
    const isProductFit = !nonFitDetected && matchedProducts.length > 0;
    const isIncomplete = missingFields.length > 0 && !nonFitDetected;

    // 4. Tạo Bản nháp câu hỏi / Thông điệp tiếp cận (Draft) nếu thiếu thông tin nhưng nhu cầu phù hợp
    let aiDraft = null;
    if (isIncomplete) {
      aiDraft = this.generateOutreachDraft(entity, matchedProducts, missingFields);
    }

    return {
      isComplete,
      isIncomplete,
      missingFields,
      isProductFit,
      nonFitDetected,
      matchedProducts,
      primaryProduct: matchedProducts[0] || null,
      aiDraft,
      draftDecision: isComplete ? "NOT_NEEDED" : "USE_AI_DRAFT"
    };
  }

  // Sinh Bản nháp Câu hỏi khai thác & Thông điệp tiếp cận cá nhân hóa
  generateOutreachDraft(entity, matchedProducts, missingFields) {
    const mainContact = entity.contacts[0];
    const prodNames = matchedProducts.length > 0
      ? matchedProducts.map(p => p.name).join(" & ")
      : "Giải pháp Phần mềm Quản trị Doanh nghiệp NamViet SME";

    const questions = [];
    if (missingFields.includes("Quy mô nhân sự")) {
      questions.push("Hiện tại quy mô nhân sự / số lượng người dùng (users) hoặc số chi nhánh/kho của bên mình là khoảng bao nhiêu người ạ?");
    }
    if (missingFields.includes("Ngân sách dự kiến")) {
      questions.push("Doanh nghiệp mình đang ưu tiên triển khai theo hình thức thuê bao (Cloud SaaS hàng tháng) hay mua trọn gói, và khoảng ngân sách dự kiến cho giai đoạn 1 là bao nhiêu ạ?");
    }
    if (missingFields.includes("Khu vực / Tỉnh thành")) {
      questions.push("Trụ sở văn phòng hoặc nhà máy/cửa hàng chính của mình đang đặt tại tỉnh/thành phố nào để Nam Việt sắp xếp chuyên gia phụ trách đúng khu vực hỗ trợ trực tiếp ạ?");
    }
    if (missingFields.includes("Chức vụ người liên hệ")) {
      questions.push("Anh/Chị hiện đang phụ trách bộ phận nào trong doanh nghiệp để em gửi đúng tài liệu Demo chuyên sâu theo nghiệp vụ của mình ạ?");
    }

    const messageDraft = `Chào ${mainContact.name} (${entity.canonicalName}),\n` +
      `Em đến từ Công ty Phần mềm Nam Việt. Em đã nhận được thông tin đăng ký từ ${entity.sources.join("/")} về nhu cầu: "${mainContact.requirement}".\n\n` +
      `Qua phân tích ban đầu, bài toán của bên mình rất phù hợp với phân hệ **${prodNames}** của Nam Việt. Để chuẩn bị bản Demo sát thực tế và báo giá tối ưu nhất, ${mainContact.name} cho em xin thêm ${questions.length} thông tin ngắn sau nhé:\n` +
      questions.map((q, idx) => `${idx + 1}. ${q}`).join("\n") +
      `\n\nEm xin phép kết nối Zalo qua số ${mainContact.phone} hoặc gửi lịch Demo 20 phút trong tuần này ạ!`;

    return {
      recommendedChannel: "Zalo / Email & Gọi điện xác nhận (SLA < 2 giờ)",
      targetContact: `${mainContact.name} (${mainContact.phone})`,
      qualificationQuestions: questions,
      messageText: messageDraft,
      status: "Chờ liên hệ bổ sung"
    };
  }

  // ==========================================================================
  // BƯỚC 3 & 4: CHẤM ĐIỂM ƯU TIÊN (0-100), ĐỀ XUẤT ĐỊNH TUYẾN & PHÂN HẠNG & KIỂM TRA TRANH CHẤP/THẨM QUYỀN
  // ==========================================================================
  scoreAndAssignSalesRep(entity, fitInfo, weights = { productFit: 40, icpSize: 20, realisticBudget: 20, completenessAuthority: 20 }) {
    // 1. Chuẩn hóa 4 trọng số luôn quy đổi về đúng 100%
    const rawW = {
      productFit: Number(weights.productFit) || 40,
      icpSize: Number(weights.icpSize) || 20,
      realisticBudget: Number(weights.realisticBudget) || 20,
      completenessAuthority: Number(weights.completenessAuthority) || 20
    };
    const sumW = (rawW.productFit + rawW.icpSize + rawW.realisticBudget + rawW.completenessAuthority) || 100;
    const normW = {
      productFit: (rawW.productFit / sumW) * 100,
      icpSize: (rawW.icpSize / sumW) * 100,
      realisticBudget: (rawW.realisticBudget / sumW) * 100,
      completenessAuthority: (rawW.completenessAuthority / sumW) * 100
    };

    let scoreBreakdown = {
      productFitScore: 0,
      icpSizeScore: 0,
      budgetScore: 0,
      authorityScore: 0,
      penalties: []
    };

    // 1. Điểm khớp sản phẩm (0 - normW.productFit)
    if (fitInfo.nonFitDetected) {
      scoreBreakdown.productFitScore = 0;
      scoreBreakdown.penalties.push(`Cảnh báo lệch sản phẩm: ${fitInfo.nonFitDetected.reason}`);
    } else if (fitInfo.matchedProducts.length >= 2) {
      scoreBreakdown.productFitScore = Math.round(normW.productFit);
    } else if (fitInfo.matchedProducts.length === 1) {
      scoreBreakdown.productFitScore = Math.round(normW.productFit * 0.85);
    } else {
      scoreBreakdown.productFitScore = Math.round(normW.productFit * 0.4);
    }

    // 2. Điểm chân dung quy mô SME ICP (0 - normW.icpSize)
    const size = entity.companySize;
    if (size >= 20 && size <= 450) {
      scoreBreakdown.icpSizeScore = Math.round(normW.icpSize);
    } else if (size >= 10 && size < 20) {
      scoreBreakdown.icpSizeScore = Math.round(normW.icpSize * 0.75);
    } else if (size > 450) {
      scoreBreakdown.icpSizeScore = Math.round(normW.icpSize * 0.6);
    } else {
      scoreBreakdown.icpSizeScore = Math.round(normW.icpSize * 0.35);
    }

    // 3. Quy tắc Triệt tiêu Điểm Ngân sách Ảo: Nếu nonFitDetected == true, budgetScore bắt buộc bị ép về 0
    const budget = entity.budgetMillion;
    if (fitInfo.nonFitDetected) {
      scoreBreakdown.budgetScore = 0;
      scoreBreakdown.penalties.push(`Ngân sách ${budget} triệu VNĐ bị triệt tiêu về 0 vì không khớp danh mục sản phẩm SME của Nam Việt.`);
    } else if (budget >= 150) {
      scoreBreakdown.budgetScore = Math.round(normW.realisticBudget);
    } else if (budget >= 60) {
      scoreBreakdown.budgetScore = Math.round(normW.realisticBudget * 0.85);
    } else if (budget >= 20) {
      scoreBreakdown.budgetScore = Math.round(normW.realisticBudget * 0.65);
    } else {
      scoreBreakdown.budgetScore = Math.round(normW.realisticBudget * 0.3);
    }

    // 4. Điểm Chức vụ & Độ đầy đủ thông tin
    let authPoints = 0;
    const rolesStr = entity.contacts.map(c => (c.role || "").toLowerCase()).join(" ");
    if (rolesStr.includes("giám đốc") || rolesStr.includes("ceo") || rolesStr.includes("coo") || rolesStr.includes("chủ")) {
      authPoints += 10;
    } else if (rolesStr.includes("trưởng phòng") || rolesStr.includes("kế toán trưởng") || rolesStr.includes("quản lý")) {
      authPoints += 7;
    } else {
      authPoints += 4;
    }
    if (entity.isMerged) authPoints += 6;
    if (fitInfo.isComplete) authPoints += 4;
    scoreBreakdown.authorityScore = Math.min(Math.round(normW.completenessAuthority), Math.round((authPoints / 20) * normW.completenessAuthority));

    const totalScore = fitInfo.nonFitDetected
      ? Math.min(30, Math.round(scoreBreakdown.icpSizeScore + scoreBreakdown.authorityScore))
      : Math.min(100, Math.round(
          scoreBreakdown.productFitScore +
          scoreBreakdown.icpSizeScore +
          scoreBreakdown.budgetScore +
          scoreBreakdown.authorityScore
        ));

    // Thang phân hạng & Cam kết SLA nghiêm ngặt:
    // totalScore >= 75 -> P1 (Hot Lead): SLA phản hồi trong 15 phút.
    // 52 <= totalScore < 75 -> P2 (Warm Lead): SLA phản hồi trong 2 giờ.
    // totalScore < 52 -> P3 (Trung bình / Khai thác): SLA phản hồi trong 24 giờ.
    let priorityTier = "P3 (Trung bình / Khai thác)";
    let slaText = "SLA phản hồi trong 24 giờ";
    if (fitInfo.nonFitDetected) {
      priorityTier = "P4 - Không phù hợp SP";
      slaText = "Gửi email từ chối lịch sự / Giới thiệu đối tác";
    } else if (totalScore >= 75) {
      priorityTier = "P1 (Hot Lead)";
      slaText = "SLA phản hồi trong 15 phút";
    } else if (totalScore >= 52) {
      priorityTier = "P2 (Warm Lead)";
      slaText = "SLA phản hồi trong 2 giờ";
    } else {
      priorityTier = "P3 (Trung bình / Khai thác)";
      slaText = "SLA phản hồi trong 24 giờ";
    }

    // Thứ tự ưu tiên chấm điểm chọn NVKD:
    // (1) NVKD từng chăm sóc trong CRM (+45đ)
    // -> (2) Đúng Tỉnh/Khu vực (+30đ)
    // -> (3) Đúng Nhóm ngành (+20đ)
    // -> (4) Đúng Chuyên môn sản phẩm (+20đ)
    // -> (5) Tỷ lệ tải công việc còn trống (currentLoad / weeklyCapacity, tối đa +15đ).
    const candidates = this.config.salesTeam.map(rep => {
      let matchScore = 0;
      const reasons = [];

      // 1. NVKD từng chăm sóc trong CRM (+45đ)
      const isHistoricalOwner = entity.crmHistory && entity.crmHistory.salesId === rep.id;
      if (isHistoricalOwner) {
        matchScore += 45;
        reasons.push(`Đã có lịch sử chăm sóc trong CRM (${entity.crmHistory.lastContactDate}) [+45đ]`);
      }

      // 2. Đúng Tỉnh/Khu vực (+30đ)
      const matchedProv = entity.provinces.find(p => rep.provinces.includes(p));
      if (matchedProv) {
        matchScore += 30;
        reasons.push(`Phụ trách đúng địa bàn ${matchedProv} (${rep.region}) [+30đ]`);
      } else if (entity.regions.includes(rep.region)) {
        matchScore += 20;
        reasons.push(`Đúng khu vực ${rep.region} [+20đ]`);
      }

      // 3. Đúng Nhóm ngành (+20đ)
      if (rep.industries.includes(entity.primaryIndustry)) {
        matchScore += 20;
        reasons.push(`Đúng nhóm ngành "${entity.primaryIndustry}" [+20đ]`);
      }

      // 4. Đúng Chuyên môn sản phẩm (+20đ)
      if (fitInfo.primaryProduct && rep.specialties.includes(fitInfo.primaryProduct.id)) {
        matchScore += 20;
        reasons.push(`Chuyên sâu dòng sản phẩm ${fitInfo.primaryProduct.id} [+20đ]`);
      }

      // 5. Tỷ lệ tải công việc còn trống (currentLoad / weeklyCapacity, tối đa +15đ)
      const loadRatio = rep.currentLoad / rep.weeklyCapacity;
      const capacityBonus = Math.max(0, Math.round((1 - loadRatio) * 15));
      matchScore += capacityBonus;
      reasons.push(`Dư địa tải công việc (${Math.round((1 - loadRatio) * 100)}%) [+${capacityBonus}đ]`);

      return {
        rep,
        matchScore,
        reasons,
        isHistoricalOwner
      };
    });

    candidates.sort((a, b) => b.matchScore - a.matchScore);
    const primaryCandidate = candidates[0];
    const secondaryCandidate = candidates[1];

    // KIỂM SOÁT TRANH CHẤP, VƯỢT THẨM QUYỀN (requiresManagerApproval = true)
    let requiresManagerApproval = false;
    const escalationReasons = [];

    // Điều kiện 1: Tranh chấp vùng miền (Doanh nghiệp có nhiều chi nhánh ở từ 2 miền trở lên cùng đăng ký)
    if (entity.regions.length > 1) {
      requiresManagerApproval = true;
      escalationReasons.push(
        `Tranh chấp vùng miền: Doanh nghiệp đăng ký từ ${entity.regions.length} miền (${entity.regions.join(" & ")}) giữa ${primaryCandidate.rep.name} và ${secondaryCandidate ? secondaryCandidate.rep.name : "NVKD khác"}.`
      );
    }

    // Điều kiện 2: Chồng chéo sở hữu CRM (Khách cũ của NVKD miền này nhưng chi nhánh mới lại nằm ở địa bàn của NVKD miền khác)
    if (entity.crmHistory && entity.isMerged && entity.crmHistory.salesId !== primaryCandidate.rep.id) {
      requiresManagerApproval = true;
      escalationReasons.push(
        `Chồng chéo sở hữu CRM: Khách cũ do ${entity.crmHistory.salesName} (${entity.crmHistory.salesId}) chăm sóc, nhưng đầu mối mới thuộc địa bàn của ${primaryCandidate.rep.name}.`
      );
    }

    // Điều kiện 3: Vượt hạn mức thẩm quyền (budget > maxBudgetAuthority)
    if (!fitInfo.nonFitDetected && entity.budgetMillion > primaryCandidate.rep.maxBudgetAuthority) {
      requiresManagerApproval = true;
      escalationReasons.push(
        `Vượt hạn mức thẩm quyền: Dự án ${entity.budgetMillion}M VNĐ vượt quá trần thẩm quyền tự quyết (${primaryCandidate.rep.maxBudgetAuthority}M VNĐ) của ${primaryCandidate.rep.name}.`
      );
    }

    let workflowStage = "ASSIGNED_AND_LOGGED";
    let approvalStatus = "AUTO_APPROVED";

    if (fitInfo.nonFitDetected) {
      workflowStage = "FILTERED_NON_FIT";
      approvalStatus = "REJECTED_NON_FIT";
    } else if (!fitInfo.isComplete) {
      workflowStage = "WAITING_SUPPLEMENTAL_INFO";
      approvalStatus = "PENDING_INFO";
    } else if (requiresManagerApproval) {
      workflowStage = "PENDING_MANAGER_APPROVAL";
      approvalStatus = "WAITING_MANAGER";
    }

    return {
      totalScore,
      scoreBreakdown,
      priorityTier,
      slaText,
      recommendedRep: primaryCandidate.rep,
      recommendedReasons: primaryCandidate.reasons,
      runnerUpRep: secondaryCandidate ? secondaryCandidate.rep : null,
      requiresManagerApproval,
      escalationReasons,
      workflowStage,
      approvalStatus
    };
  }

  // ==========================================================================
  // CHẠY TOÀN BỘ PIPELINE CHO DANH SÁCH ĐẦU VÀO
  // ==========================================================================
  runFullPipeline(rawLeads, customWeights) {
    this.auditLogs = [];
    this.logAction(
      "Tiếp nhận đầu vào",
      "BATCH-WEEKLY",
      "Toàn bộ danh sách",
      `Tiếp nhận ${rawLeads.length} hồ sơ đăng ký từ Hội thảo, Website & Campaign`,
      "Bắt đầu quy trình Chuẩn hóa, Lọc trùng, Kiểm tra ICP, Chấm điểm & Phân hạng tiềm năng"
    );

    // Bước 1: Chuẩn hóa & Lọc trùng
    const entities = this.deduplicateAndGroup(rawLeads);

    // Bước 2, 3, 4: Đánh giá từng hồ sơ hợp nhất
    const processedEntities = entities.map(ent => {
      const fitInfo = this.evaluateProductFitAndCompleteness(ent);
      const routingInfo = this.scoreAndAssignSalesRep(ent, fitInfo, customWeights);

      if (routingInfo.workflowStage === "PENDING_MANAGER_APPROVAL") {
        this.logAction(
          "Tranh chấp / Vượt thẩm quyền",
          ent.entityId,
          ent.canonicalName,
          `Chuyển Trưởng phòng Kinh doanh xét duyệt (${routingInfo.recommendedRep.name})`,
          routingInfo.escalationReasons.join(" | ")
        );
      } else if (routingInfo.workflowStage === "WAITING_SUPPLEMENTAL_INFO") {
        this.logAction(
          "Tạo bản nháp tiếp cận",
          ent.entityId,
          ent.canonicalName,
          `AI tạo câu hỏi bổ sung (${fitInfo.missingFields.join(", ")})`,
          `Giao ${routingInfo.recommendedRep.name} liên hệ bổ sung thông tin`
        );
      } else if (routingInfo.workflowStage === "FILTERED_NON_FIT") {
        this.logAction(
          "Chặn bẫy ngân sách ảo",
          ent.entityId,
          ent.canonicalName,
          `Phát hiện lệch sản phẩm (Ngân sách ${ent.budgetMillion}M VNĐ)`,
          fitInfo.nonFitDetected.reason
        );
      } else {
        this.logAction(
          "Phân loại & Định tuyến",
          ent.entityId,
          ent.canonicalName,
          `Định tuyến khai thác theo tiêu chuẩn SLA (${routingInfo.totalScore}đ)`,
          routingInfo.recommendedReasons.join(", ")
        );
      }

      return {
        ...ent,
        fitInfo,
        routingInfo
      };
    });

    // Sắp xếp theo điểm ưu tiên giảm dần
    processedEntities.sort((a, b) => b.routingInfo.totalScore - a.routingInfo.totalScore);

    return this.buildSummaryAndInsights(rawLeads, processedEntities);
  }

  // Tổng hợp số liệu Phễu Workflow & Đề xuất Kinh doanh cho Trưởng phòng KD
  buildSummaryAndInsights(rawLeads, entities) {
    const totalRaw = rawLeads.length;
    const totalEntities = entities.length;
    const duplicatesEliminated = totalRaw - totalEntities;
    const mergedClusters = entities.filter(e => e.isMerged);

    const sourceCounts = { "Hội thảo": 0, "Website": 0, "Campaign": 0 };
    rawLeads.forEach(l => {
      const s = l.source || "Website";
      sourceCounts[s] = (sourceCounts[s] || 0) + 1;
    });

    const completeAndFit = entities.filter(e => e.fitInfo.isComplete && e.fitInfo.isProductFit);
    const incompleteNeedDraft = entities.filter(e => !e.fitInfo.isComplete && !e.fitInfo.nonFitDetected);
    const nonFitBigBudget = entities.filter(e => e.fitInfo.nonFitDetected);
    const managerEscalations = entities.filter(e => e.routingInfo.requiresManagerApproval && !e.fitInfo.nonFitDetected);
    const readyToAssign = entities.filter(e => e.routingInfo.workflowStage === "ASSIGNED_AND_LOGGED");

    // Thống kê phân bổ theo khu vực
    const repStats = this.config.salesTeam.map(rep => {
      const assigned = entities.filter(
        e => e.routingInfo.recommendedRep.id === rep.id && !e.fitInfo.nonFitDetected
      );
      const hotCount = assigned.filter(e => e.routingInfo.totalScore >= 80).length;
      const draftCount = assigned.filter(e => !e.fitInfo.isComplete).length;
      const disputeCount = assigned.filter(e => e.routingInfo.requiresManagerApproval).length;
      const totalPipelineValue = assigned.reduce((acc, item) => acc + (item.budgetMillion || 45), 0);

      return {
        ...rep,
        assignedCount: assigned.length,
        hotCount,
        draftCount,
        disputeCount,
        totalPipelineValue,
        assignedEntities: assigned
      };
    });

    // Thống kê nhu cầu theo 5 nhóm sản phẩm
    const productStats = this.config.products.map(prod => {
      const matched = entities.filter(
        e => !e.fitInfo.nonFitDetected && e.fitInfo.matchedProducts.some(mp => mp.id === prod.id)
      );
      const totalVal = matched.reduce((sum, e) => sum + (e.budgetMillion || prod.minBudget), 0);
      return {
        ...prod,
        leadCount: matched.length,
        estimatedPipeline: totalVal
      };
    });

    return {
      rawLeads,
      entities,
      metrics: {
        totalRaw,
        totalEntities,
        duplicatesEliminated,
        mergedClusterCount: mergedClusters.length,
        completeAndFitCount: completeAndFit.length,
        incompleteNeedDraftCount: incompleteNeedDraft.length,
        nonFitBigBudgetCount: nonFitBigBudget.length,
        nonFitSavedBudgetSum: nonFitBigBudget.reduce((s, e) => s + e.budgetMillion, 0),
        managerEscalationsCount: managerEscalations.length,
        readyToAssignCount: readyToAssign.length,
        sourceCounts
      },
      repStats,
      productStats,
      auditLogs: this.auditLogs
    };
  }
}

window.NamVietAIAgent = NamVietAIAgent;

