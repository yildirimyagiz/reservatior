import { Elysia } from "elysia";
import { prisma } from "../lib/prisma";

export const b2bAuth = new Elysia({ name: "b2b-auth" }).derive(
  async ({ request, set }) => {
    const authHeader = request.headers.get("authorization");

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      set.status = 401;
      throw new Error("Unauthorized: Missing or invalid API Key");
    }

    const token = authHeader.split(" ")[1];

    // In a real production scenario, this token should be hashed before saving/comparing
    // but for simplicity, we will assume keyHash stores the direct key or we do direct lookup
    const apiKeyRecord = await prisma.apiKey.findUnique({
      where: { keyHash: token },
      include: { user: true, org: true }
    });

    if (!apiKeyRecord) {
      set.status = 401;
      throw new Error("Unauthorized: Invalid API Key");
    }

    if (apiKeyRecord.expiresAt && apiKeyRecord.expiresAt < new Date()) {
      set.status = 401;
      throw new Error("Unauthorized: API Key expired");
    }

    // Update last used timestamp asynchronously
    prisma.apiKey.update({
      where: { id: apiKeyRecord.id },
      data: { lastUsedAt: new Date() }
    }).catch(console.error);

    return {
      b2bUser: apiKeyRecord.user,
      b2bOrg: apiKeyRecord.org,
      apiKey: apiKeyRecord
    };
  }
);
