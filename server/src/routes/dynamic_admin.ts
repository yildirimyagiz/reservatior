import { Elysia } from "elysia";
import { authMiddleware, hasPermission } from "../middleware/auth";
import { prisma } from "../lib/prisma";
import { Prisma } from "@prisma/client";

export const dynamicAdminRoutes = new Elysia({ prefix: "/dynamic" })
  .use(authMiddleware)
  .onBeforeHandle(hasPermission("ORG_MANAGE"))

  // GET /admin/dynamic/schema/:model
  .get("/schema/:model", ({ params }) => {
    const schema = findModel(params.model);
    if (!schema) return { error: "Model schema not found" };
    return { data: schema };
  })

  // GET /admin/dynamic/data/:model
  .get("/data/:model", async ({ params, query }) => {
    const schema = findModel(params.model);
    if (!schema) return { error: "Model not found" };
    
    const prismaModelProp = schema.name.charAt(0).toLowerCase() + schema.name.slice(1);
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const delegate = (prisma as any)[prismaModelProp];
    
    const page = parseInt((query as any).page || "1");
    const limit = parseInt((query as any).limit || "50");
    const skip = (page - 1) * limit;
    
    const data = await delegate.findMany({
      skip,
      take: limit,
      orderBy: schema.fields.find(f => f.name === 'createdAt') ? { createdAt: 'desc' } : undefined
    });
    
    const total = await delegate.count();
    
    return { data, meta: { total, page, limit } };
  })

  // POST /admin/dynamic/data/:model
  .post("/data/:model", async ({ params, body }) => {
    const schema = findModel(params.model);
    if (!schema) return { error: "Model not found" };
    
    const prismaModelProp = schema.name.charAt(0).toLowerCase() + schema.name.slice(1);
    const delegate = (prisma as any)[prismaModelProp];
    
    try {
      const data = await delegate.create({ data: body });
      return { data };
    } catch (error: any) {
      return { error: error.message };
    }
  })

  // PATCH /admin/dynamic/data/:model/:id
  .patch("/data/:model/:id", async ({ params, body }) => {
    const schema = findModel(params.model);
    if (!schema) return { error: "Model not found" };
    
    const prismaModelProp = schema.name.charAt(0).toLowerCase() + schema.name.slice(1);
    const delegate = (prisma as any)[prismaModelProp];
    
    try {
      // Convert ID param to number if the schema says it's an Int
      const idField = schema.fields.find(f => f.isId);
      const idVal = idField?.type === 'Int' ? parseInt(params.id) : params.id;
      
      const data = await delegate.update({
        where: { id: idVal },
        data: body
      });
      return { data };
    } catch (error: any) {
      return { error: error.message };
    }
  })

  // DELETE /admin/dynamic/data/:model/:id
  .delete("/data/:model/:id", async ({ params }) => {
    const schema = findModel(params.model);
    if (!schema) return { error: "Model not found" };
    
    const prismaModelProp = schema.name.charAt(0).toLowerCase() + schema.name.slice(1);
    const delegate = (prisma as any)[prismaModelProp];
    
    try {
      const idField = schema.fields.find(f => f.isId);
      const idVal = idField?.type === 'Int' ? parseInt(params.id) : params.id;
      
      await delegate.delete({ where: { id: idVal } });
      return { success: true };
    } catch (error: any) {
      return { error: error.message };
    }
  });

/** Prisma model lookup tolerant to kebab-case, singular/plural and common suffixes. */
function findModel(raw: string) {
  const normalized = raw.toLowerCase().replace(/[^a-z0-9]/g, "");
  const candidates = [normalized];
  // Plural -> singular ("leases" -> "lease", "agencies" -> "agency")
  if (normalized.endsWith("ies")) {
    candidates.push(normalized.slice(0, -3) + "y");
  }
  if (normalized.endsWith("s")) {
    candidates.push(normalized.slice(0, -1));
  }
  // Singular -> plural ("lease" -> "leases")
  candidates.push(normalized + "s");
  for (const c of candidates) {
    const model = Prisma.dmmf.datamodel.models.find(
      (m) => m.name.toLowerCase() === c
    );
    if (model) return model;
  }
  return undefined;
}
