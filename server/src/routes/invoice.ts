import { Elysia } from "elysia";
import { invoiceService } from "../services/invoice";
import { regionMiddleware } from "../middleware/region";

export const invoiceRoutes = new Elysia({ prefix: "/api/v1/invoices" })
  .use(regionMiddleware)
  .get("/", async ({ orgId, db, query }) => {
    try {
      const { status, customerId, dateFrom, dateTo, page = "1", limit = "50" } = query || {};
      
      const invoices = await invoiceService.withDB(db as any).getInvoices({
        status: status as string,
        customerId: customerId as string,
        dateFrom: dateFrom as string,
        dateTo: dateTo as string
      });

      const totalCount = invoices.length;
      const startIndex = (parseInt(page) - 1) * parseInt(limit);
      const endIndex = Math.min(startIndex + parseInt(limit), totalCount);
      const paginatedInvoices = invoices.slice(startIndex, endIndex);

      return {
        data: paginatedInvoices,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: totalCount,
          totalPages: Math.ceil(totalCount / parseInt(limit))
        }
      };
    } catch (error) {
      return {
        error: "Failed to fetch invoices",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .post("/", async ({ orgId, db, body }: { body: any }) => {
    try {
      const invoice = await invoiceService.withDB(db as any).createInvoice(body);
      
      return {
        data: invoice,
        message: "Invoice created successfully"
      };
    } catch (error) {
      return {
        error: "Failed to create invoice",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .get("/:id", async ({ orgId, db, params }) => {
    try {
      const invoice = await invoiceService.withDB(db as any).getInvoices({ customerId: params.id as string });
      
      if (invoice.length === 0) {
        return {
          error: "Invoice not found",
          message: "No invoices found for this customer"
        };
      }

      return {
        data: invoice[0] // Return most recent invoice
      };
    } catch (error) {
      return {
        error: "Failed to fetch invoice",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .put("/:id/status", async ({ orgId, db, params, body }) => {
    try {
      const invoice = await invoiceService.withDB(db as any).updateInvoiceStatus(
        params.id as string, 
        body.status as any
      );
      
      return {
        data: invoice,
        message: "Invoice status updated successfully"
      };
    } catch (error) {
      return {
        error: "Failed to update invoice status",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .get("/:id/pdf", async ({ orgId, db, params }) => {
    try {
      const pdfBuffer = await invoiceService.withDB(db as any).generateInvoicePDF(params.id as string);
      
      return new Response(pdfBuffer, {
        headers: {
          'Content-Type': 'application/pdf',
          'Content-Disposition': `attachment; filename="invoice-${params.id}.pdf"`
        }
      });
    } catch (error) {
      return {
        error: "Failed to generate PDF",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .post("/:id/send", async ({ orgId, db, params }) => {
    try {
      await invoiceService.withDB(db as any).sendInvoiceEmail(params.id as string);
      
      return {
        message: "Invoice sent successfully"
      };
    } catch (error) {
      return {
        error: "Failed to send invoice",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .get("/statistics", async () => {
    try {
      const stats = await invoiceService.getInvoiceStatistics();
      
      return {
        data: stats
      };
    } catch (error) {
      return {
        error: "Failed to fetch statistics",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .get("/overdue", async () => {
    try {
      const overdueInvoices = await invoiceService.getOverdueInvoices();
      
      return {
        data: overdueInvoices
      };
    } catch (error) {
      return {
        error: "Failed to fetch overdue invoices",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .post("/templates/:templateId/customers/:customerId", async ({ orgId, db, params }) => {
    try {
      const invoice = await invoiceService.withDB(db as any).createInvoiceFromTemplate(
        params.templateId as string,
        params.customerId as string
      );
      
      return {
        data: invoice,
        message: "Invoice created from template successfully"
      };
    } catch (error) {
      return {
        error: "Failed to create invoice from template",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  })

  .get("/templates", async () => {
    try {
      const templates = await invoiceService.getInvoiceTemplates();
      
      return {
        data: templates
      };
    } catch (error) {
      return {
        error: "Failed to fetch templates",
        message: error instanceof Error ? error.message : "Unknown error"
      };
    }
  });
