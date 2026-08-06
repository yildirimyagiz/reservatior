import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { prismaManager } from "../lib/prisma";

// Mock DB Stores
const eDevletContractsStore = new Map<string, any>();
const eidsVerifiedProperties = new Map<string, any>();
const agentAssignmentsStore = new Map<string, any>();
const inAppApprovalsStore = new Map<string, any>();

export const turkeyRoutes = new Elysia({ prefix: "/turkey" })
  .use(authMiddleware)

  /**
   * 1. EİDS (Elektronik İlan Doğrulama Sistemi) - Tapu & Taşınmaz Doğrulama
   * GET /turkey/eids/verify-property
   */
  .get(
    "/eids/verify-property",
    async ({ query, set }) => {
      const { listingId, tapuTakbisId, cityCode, districtCode, ada, parsel } = query as any;

      if (!listingId && !tapuTakbisId) {
        set.status = 400;
        return { success: false, error: "listingId or tapuTakbisId is required." };
      }

      const cacheKey = listingId || tapuTakbisId;
      if (eidsVerifiedProperties.has(cacheKey)) {
        return { success: true, data: eidsVerifiedProperties.get(cacheKey) };
      }

      const verificationResult = {
        eidsListingId: listingId || `EIDS-2026-${Math.floor(100000 + Math.random() * 900000)}`,
        verified: true,
        verifiedAt: new Date().toISOString(),
        ownershipStatus: "VERIFIED_OWNER",
        propertyDetails: {
          cityCode: cityCode || "34",
          districtCode: districtCode || "204",
          ada: ada || "1402",
          parsel: parsel || "8",
          bagimsizBolumNo: "12",
          ownerNameMasked: "A*** Y******",
          addressText: "Kadıköy Moda Cad. No:45 D:12 İstanbul",
        },
        eidsBadgeUrl: "https://reservatior.com/badges/eids-verified.svg",
      };

      eidsVerifiedProperties.set(cacheKey, verificationResult);
      return { success: true, data: verificationResult };
    },
    {
      query: t.Partial(
        t.Object({
          listingId: t.String(),
          tapuTakbisId: t.String(),
          cityCode: t.String(),
          districtCode: t.String(),
          ada: t.String(),
          parsel: t.String(),
        })
      ),
    }
  )

  /**
   * 2. Platform İçi Doğrudan İlan Onayı & SMS OTP (e-Devlet Yönlendirmesiz)
   * POST /turkey/in-app-approval/send-otp
   */
  .post(
    "/in-app-approval/send-otp",
    async ({ body }) => {
      const { phone, listingId } = body as any;
      const otpCode = "884192"; // Demo OTP Code

      inAppApprovalsStore.set(listingId, {
        phone,
        otpCode,
        status: "PENDING_VERIFICATION",
        createdAt: new Date().toISOString(),
      });

      return {
        success: true,
        data: {
          listingId,
          phone,
          otpSent: true,
          expiresInSeconds: 180,
          demoCode: "884192",
        },
        message: "Platform içi ilan onay SMS kodu gönderildi.",
      };
    },
    {
      body: t.Object({
        phone: t.String(),
        listingId: t.String(),
      }),
    }
  )

  /**
   * POST /turkey/in-app-approval/verify-otp
   */
  .post(
    "/in-app-approval/verify-otp",
    async ({ body, set }) => {
      const { listingId, otpCode, landlordTckn } = body as any;
      const approvalRecord = inAppApprovalsStore.get(listingId);

      if (!approvalRecord || (otpCode !== "884192" && otpCode !== approvalRecord.otpCode)) {
        set.status = 400;
        return { success: false, error: "Geçersiz SMS OTP doğrulama kodu." };
      }

      approvalRecord.status = "APPROVED_IN_APP";
      approvalRecord.approvedAt = new Date().toISOString();
      approvalRecord.landlordTckn = landlordTckn;
      inAppApprovalsStore.set(listingId, approvalRecord);

      return {
        success: true,
        data: {
          listingId,
          approved: true,
          method: "SMS_OTP_KPS_VERIFIED",
          approvedAt: approvalRecord.approvedAt,
        },
        message: "İlan onayı platform içerisinde e-Devlet yönlendirmesi olmaksızın başarıyla tamamlandı!",
      };
    },
    {
      body: t.Object({
        listingId: t.String(),
        otpCode: t.String(),
        landlordTckn: t.Optional(t.String()),
      }),
    }
  )

  /**
   * 3. Emlakçı / Danışman Yetkilendirme & Seçim Servisi
   * GET /turkey/agents/recommended
   */
  .get("/agents/recommended", async () => {
    const agents = [
      {
        agentId: "ag_101",
        name: "Murat Yılmaz",
        agency: "Vizyon Gayrimenkul Kadıköy",
        licenseNo: "34001928",
        rating: 4.9,
        dealsCount: 142,
        commissionSharePct: 3.5,
        photo: "https://images.unsplash.com/photo-1560250097-0b93528c311a?w=150&h=150&fit=crop",
      },
      {
        agentId: "ag_102",
        name: "Selin Kaya",
        agency: "Turyap Beşiktaş Yetkili Ofisi",
        licenseNo: "34008102",
        rating: 4.8,
        dealsCount: 98,
        commissionSharePct: 3.5,
        photo: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=150&h=150&fit=crop",
      },
      {
        agentId: "ag_103",
        name: "Reservatior Direkt (Emlakçısız)",
        agency: "Yalnızca Platform Hizmeti",
        licenseNo: "RESERV-DIRECT",
        rating: 5.0,
        dealsCount: 1500,
        commissionSharePct: 1.5,
        photo: "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=150&h=150&fit=crop",
      },
    ];

    return { success: true, data: agents };
  })

  /**
   * POST /turkey/agents/assign
   */
  .post(
    "/agents/assign",
    async ({ body }) => {
      const { listingId, agentId, landlordTckn } = body as any;

      const assignment = {
        listingId,
        agentId,
        landlordTckn,
        assignedAt: new Date().toISOString(),
        status: "AUTHORIZED",
        authorizationDocUrl: `https://reservatior.com/documents/agent-authorizations/${listingId}_${agentId}.pdf`,
      };

      agentAssignmentsStore.set(listingId, assignment);

      return {
        success: true,
        data: assignment,
        message: "Emlak danışmanı yetkilendirmesi platform içinde başarıyla kaydedildi.",
      };
    },
    {
      body: t.Object({
        listingId: t.String(),
        agentId: t.String(),
        landlordTckn: t.String(),
      }),
    }
  )

  /**
   * 4. GMSİ (Gayrimenkul Sermaye İratı) Vergi Raporlama Servisi
   * GET /turkey/gmsi/tax-report
   */
  .get(
    "/gmsi/tax-report",
    async ({ query }) => {
      const { taxYear = "2026", landlordTckn } = query as any;

      const report = {
        taxYear: parseInt(taxYear),
        generatedAt: new Date().toISOString(),
        landlordInfo: {
          tckn: landlordTckn || "12345678901",
          fullName: "Ahmet Yılmaz",
          taxOffice: "Zincirlikuyu Vergi Dairesi",
        },
        summary: {
          totalGrossRentCollectedTry: 420000.0,
          annualExemptionTry: 33000.0,
          deductibleExpensesTry: 14700.0,
          netTaxableBaseTry: 372300.0,
          estimatedTaxDutyTry: 61845.0,
          deductionMethod: "REAL_EXPENSE_WITH_COMMISSION_INVOICES",
        },
        monthlyBreakdown: [
          {
            month: `${taxYear}-01`,
            grossRent: 35000.0,
            payoutDate: `${taxYear}-01-05`,
            bankReference: "PAYTR_TX_994812",
            reservatiorFeeDeducted: 1225.0,
            invoiceNo: `RSV${taxYear}000001`,
          },
          {
            month: `${taxYear}-02`,
            grossRent: 35000.0,
            payoutDate: `${taxYear}-02-05`,
            bankReference: "PAYTR_TX_994899",
            reservatiorFeeDeducted: 1225.0,
            invoiceNo: `RSV${taxYear}000002`,
          },
        ],
        gibExportUrl: `https://reservatior.com/api/turkey/gmsi/export-xml?year=${taxYear}`,
      };

      return { success: true, data: report };
    },
    {
      query: t.Partial(
        t.Object({
          taxYear: t.String(),
          landlordTckn: t.String(),
        })
      ),
    }
  );
