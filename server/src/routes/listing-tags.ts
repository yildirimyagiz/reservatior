import { Elysia, t } from "elysia";
import { prismaManager } from "../lib/prisma";

export const listingTagsRoutes = new Elysia({ prefix: "/listing-tags" })
  .post("/add", async ({ body }) => {
    const db = prismaManager.getClient();
    const { listingId, tagId, orgId } = body;

    const listingTag = await db.listingTag.create({
      data: {
        listingId,
        tagId,
        orgId
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
  });
