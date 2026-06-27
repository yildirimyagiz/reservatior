import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";

export const documentAnalysesRoutes = new Elysia({ prefix: "/document-analyses" })
  .use(authMiddleware)

  /**
   * GET /document-analyses
   * Retrieves document analyses with pagination and filtering
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", orgId = "global" } = query as any;
    
    // Mock data for now
    const mockAnalyses = [
      {
        id: "1",
        documentName: "Contract_2024.pdf",
        type: "contract",
        status: "completed",
        confidence: 0.95,
        extractedFields: {
          parties: ["John Doe", "Jane Smith"],
          amount: 250000,
          date: "2024-01-15"
        },
        createdAt: new Date().toISOString()
      },
      {
        id: "2", 
        documentName: "Lease_Agreement.pdf",
        type: "lease",
        status: "processing",
        confidence: 0.87,
        extractedFields: {
          tenant: "Bob Wilson",
          property: "123 Main St",
          rent: 1500
        },
        createdAt: new Date().toISOString()
      }
    ];
    
    return {
      data: mockAnalyses,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total: mockAnalyses.length
      }
    };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  });
