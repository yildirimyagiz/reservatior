import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { ticketService } from "../services/ticket";
import { 
  TicketPlainInputCreate, 
  TicketPlainInputUpdate 
} from "../../generated/prismabox/Ticket";
import { spawn } from "child_process";
import path from "path";

export const ticketRoutes = new Elysia({ prefix: "/tickets" })
  .use(authMiddleware)

  /**
   * POST /ticket/ai-suggest
   * AI-powered ticket suggestion and analysis using ML services
   */
  .post("/ai-suggest", async ({ body }) => {
    try {
      // Call Python ML service for analysis
      const mlServicePath = path.join(process.cwd(), 'server', 'ml-services', 'backend', 'app', 'services', 'support_analysis_service.py');
      
      const pythonProcess = spawn('python3', [
        '-c',
        `
import sys
sys.path.insert(0, '${path.join(process.cwd(), 'server', 'ml-services', 'backend')}')
from app.services.support_analysis_service import support_analyzer
import asyncio
import json

message = """${body.message}"""
attachments = ${JSON.stringify(body.attachments || [])}

result = asyncio.run(support_analyzer.analyze_with_gemini(message, attachments))
print(json.dumps(result))
        `
      ]);

      let output = '';
      let error = '';

      pythonProcess.stdout.on('data', (data) => {
        output += data.toString();
      });

      pythonProcess.stderr.on('data', (data) => {
        error += data.toString();
      });

      return new Promise((resolve) => {
        pythonProcess.on('close', (code) => {
          if (code !== 0 || error) {
            // Fallback to basic analysis if ML service fails
            resolve({
              suggestion: "I understand your issue. Based on your description, I recommend creating a support ticket.",
              subject: "Support Request",
              priority: "MEDIUM",
              createTicket: true,
              category: "other",
              assigned_team: "general_support",
              fallback: true
            });
          } else {
            try {
              const analysisResult = JSON.parse(output.trim());
              resolve({
                suggestion: analysisResult.summary || "I understand your issue. Based on your description, I recommend creating a support ticket.",
                subject: analysisResult.category === 'technical' ? 'Technical Support Request' : 
                        analysisResult.category === 'billing' ? 'Billing Inquiry' :
                        analysisResult.category === 'legal' ? 'Legal Matter' :
                        'Support Request',
                priority: analysisResult.priority?.toUpperCase() || "MEDIUM",
                createTicket: true,
                category: analysisResult.category,
                assigned_team: analysisResult.assigned_team,
                suggested_solution: analysisResult.suggested_solution,
                response_time: analysisResult.response_time,
                escalation: analysisResult.escalation,
                file_analysis: analysisResult.file_analysis,
                ai_analyzed: analysisResult.ai_analyzed,
                confidence: analysisResult.confidence
              });
            } catch (e) {
              resolve({
                suggestion: "I understand your issue. Based on your description, I recommend creating a support ticket.",
                subject: "Support Request",
                priority: "MEDIUM",
                createTicket: true,
                fallback: true
              });
            }
          }
        });
      });
    } catch (error) {
      // Fallback response
      return {
        suggestion: "I understand your issue. Based on your description, I recommend creating a support ticket.",
        subject: "Support Request",
        priority: "MEDIUM",
        createTicket: true,
        fallback: true
      };
    }
  }, {
    body: t.Object({
      message: t.String(),
      attachments: t.Optional(t.Array(t.String()))
    })
  })

  /**
   * POST /ticket/upload
   * Upload file attachment for tickets
   */
  .post("/upload", async ({ body, set }) => {
    // TODO: Implement file upload to storage service
    // For now, return a mock URL
    return {
      url: "https://storage.example.com/uploads/mock-file.pdf",
      filename: body.file?.name || "uploaded-file"
    };
  }, {
    body: t.Object({
      file: t.Optional(t.Any())
    })
  })

  /**
   * GET /ticket
   * Retrieves all Ticket with pagination and basic filtering.
   */
  .get("/", async ({ query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
    return ticketService.getAll({
      where,
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { createdAt: "desc" }
    });
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * POST /ticket
   * Creates a new Ticket.
   */
  .post("/", async ({ body, set }) => {
    const data = await ticketService.create(body);
    set.status = 201;
    return { data };
  }, {
    body: TicketPlainInputCreate
  })

  /**
   * GET /ticket/:id
   * Retrieves a single Ticket by ID.
   */
  .get("/:id", async ({ params, set }) => {
    const data = await ticketService.getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Ticket not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /ticket/:id
   * Updates an existing Ticket.
   */
  .patch("/:id", async ({ params, body, set }) => {
    try {
      const data = await ticketService.update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Ticket not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: TicketPlainInputUpdate
  })

  /**
   * DELETE /ticket/:id
   * Deletes a Ticket.
   */
  .delete("/:id", async ({ params, set }) => {
    try {
      await ticketService.delete(params.id);
      return { success: true, message: "Ticket deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Ticket not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
