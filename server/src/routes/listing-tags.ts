import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";

export const listingTagsRoutes = new Elysia({ prefix: "/listing-tags" })
  .post("/add", async ({ body }) => {
    const db = prismaManager.getClient();
    const { listingId, tagId, orgId } = body;

    // Get tag info to calculate expiry date
    const tag = await db.tag.findUnique({
      where: { id: tagId },
      select: { duration: true }
    });

    // Calculate expiry date based on tag duration
    let expiryDate = null;
    if (tag?.duration) {
      const now = new Date();
      expiryDate = new Date(now.getTime() + tag.duration * 24 * 60 * 60 * 1000); // duration in days
    }

    const listingTag = await db.listingTag.create({
      data: {
        listingId,
        tagId,
        orgId,
        expiryDate
      }
    });

    return { success: true, listingTag };
  }, {
    body: t.Object({
      listingId: t.String(),
      tagId: t.String(),
      orgId: t.String()
    })
  })
  .delete("/remove", async ({ body }) => {
    const db = prismaManager.getClient();
    const { listingId, tagId } = body;

    // To delete, we need the composite unique key or we deleteMany
    await db.listingTag.deleteMany({
      where: {
        listingId,
        tagId
      }
    });

    return { success: true, message: "Tag removed" };
  }, {
    body: t.Object({
      listingId: t.String(),
      tagId: t.String()
    })
  })
  .get("/active", async ({ query }) => {
    const db = prismaManager.getClient();
    const { listingId } = query as any;

    const activeTags = await db.listingTag.findMany({
      where: {
        listingId,
        expiryDate: {
          gte: new Date() // Only tags that haven't expired
        },
        deletedAt: null
      },
      include: {
        tag: true
      }
    });

    return { success: true, activeTags };
  });
