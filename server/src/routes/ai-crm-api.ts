import { Elysia, t } from "elysia";
import { AITransactionMailer } from "../services/marketing/ai-transaction-mailer";
import { AIBrochureEngine } from "../services/ai/ai-brochure-engine";
import { prisma } from "../lib/prisma";

export const aiCrmRoutes = new Elysia({ prefix: "/api/crm" })
  /**
   * Simulate a User Registration Hook
   */
  .post("/welcome", async ({ body }) => {
    const { email, name } = body;
    await AITransactionMailer.sendWelcomeEmail(email, name);
    return { success: true, message: "Welcome email dispatched" };
  }, {
    body: t.Object({
      email: t.String(),
      name: t.String()
    })
  })

  /**
   * Simulate a Contract Generation / Signature Request
   */
  .post("/request-contract-signature", async ({ body }) => {
    const { email, name, contractType, propertyId } = body;
    
    // In reality, this would fetch from DB, but we mock property name here
    const property = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!property) throw new Error("Property not found");

    const mockDocumentId = "doc_" + Math.random().toString(36).substring(7);
    
    await AITransactionMailer.sendContractEmail(
      email, 
      name, 
      contractType, 
      property.name, 
      mockDocumentId
    );
    
    return { success: true, documentId: mockDocumentId };
  }, {
    body: t.Object({
      email: t.String(),
      name: t.String(),
      contractType: t.String(), // "Satış Sözleşmesi", "Tahliye Taahhüdü" etc.
      propertyId: t.String()
    })
  })

  /**
   * Transaction Update (Kiralama Talebi, Satın Alma Onayı vs.)
   */
  .post("/update-transaction", async ({ body }) => {
    const { email, name, requestType, propertyId, status } = body;
    
    const property = await prisma.property.findUnique({ where: { id: propertyId } });
    if (!property) throw new Error("Property not found");

    await AITransactionMailer.sendTransactionAlert(
      email,
      name,
      requestType, // "Rental Request", "Purchase Offer"
      property.name,
      status // "APPROVED", "PROCESSING"
    );

    return { success: true };
  }, {
    body: t.Object({
      email: t.String(),
      name: t.String(),
      requestType: t.String(),
      status: t.String(),
      propertyId: t.String()
    })
  })

  /**
   * Generate an AI Brochure via Python ML Services
   */
  .post("/generate-brochure", async ({ body }) => {
    const { propertyId } = body;
    const result = await AIBrochureEngine.prepareBrochureData(propertyId);
    return { success: true, data: result };
  }, {
    body: t.Object({
      propertyId: t.String()
    })
  });
