import { Elysia, t } from "elysia";
import { authMiddleware } from "../middleware/auth";
import { messageService } from "../services/message";
import { 
  MessagePlainInputCreate, 
  MessagePlainInputUpdate 
} from "../../generated/prismabox/Message";
import { regionMiddleware } from "../middleware/region";

export const messageRoutes = new Elysia({ prefix: "/message" })
  .use(authMiddleware)
  .use(regionMiddleware)

  /**
   * GET /message/threads
   * Retrieves all message threads with metadata.
   */
  .get("/threads", async ({ orgId: contextOrgId, db, query }) => {
    const { page = "1", limit = "20", orgId: queryOrgId } = query as any;
    const orgId = queryOrgId || contextOrgId;
    
    // Get all unique threads
    const result = await messageService.withDB(db as any).getAll({
      where: {
        isThreadStarter: true,
        ...(orgId && { orgId }),
      },
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
      orderBy: { updatedAt: "desc" },
      include: {
        org: true,
      }
    });

    // Map to thread format
    const data = (result.data || []).map((msg: any) => ({
      id: msg.threadId || msg.id,
      subject: msg.subject,
      lastMessage: msg.body,
      updatedAt: msg.updatedAt,
      participants: msg.threadInfo?.participants || [],
      unreadCount: 0, // TODO: Calculate from readStatus
    }));

    return { data };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * GET /message/threads/:threadId
   * Retrieves all messages in a specific thread.
   */
  .get("/threads/:threadId", async ({ orgId, db, params, set }) => {
    const result = await messageService.withDB(db as any).getAll({
      where: {
        threadId: params.threadId,
      },
      orderBy: { createdAt: "asc" },
      include: {
        attachments: true,
      }
    });

    const messages = result.data || [];

    if (!messages || messages.length === 0) {
      set.status = 404;
      return { error: "Thread not found", data: [] };
    }

    const data = messages.map((m: any) => ({
      id: m.id,
      threadId: m.threadId,
      body: m.body,
      content: m.body,
      senderId: m.senderUserId || m.senderContactId || 'SYSTEM',
      senderType: m.senderType,
      createdAt: m.createdAt,
      timestamp: m.createdAt,
      isRead: m.readStatus ? true : false,
      attachments: m.attachments || [],
    }));

    return { data };
  }, {
    params: t.Object({ threadId: t.String() })
  })

  /**
   * POST /message/threads/:threadId
   * Sends a message to a specific thread.
   */
  .post("/threads/:threadId", async ({ orgId, db, params, body, set }) => {
    const messageData = {
      ...(body as any),
      threadId: params.threadId,
      isThreadStarter: false,
    };
    
    const data = await messageService.withDB(db as any).create(messageData);
    set.status = 201;
    return { data };
  }, {
    params: t.Object({ threadId: t.String() }),
    body: MessagePlainInputCreate
  })

  /**
   * GET /message/conversations
   * Retrieves all conversations (threads with latest message) for message dropdown.
   */
  .get("/conversations", async ({ orgId: contextOrgId, db, query }) => {
    const { page = "1", limit = "20", orgId: queryOrgId } = query as any;
    const orgId = queryOrgId || contextOrgId;

    // Get unique threads with their latest message
    const result = await messageService.withDB(db as any).getAll({
      where: {
        ...(orgId && { orgId }),
      },
      distinct: ["threadId"],
      orderBy: { updatedAt: "desc" },
      skip: (parseInt(page) - 1) * parseInt(limit),
      take: parseInt(limit),
    });

    // Map to conversation format
    const data = (result.data || []).map((msg: any) => ({
      id: msg.threadId || msg.id,
      name: msg.subject || msg.senderName || "Unknown",
      lastMessage: msg.body || "",
      time: msg.updatedAt || msg.createdAt,
      unread: msg.readStatus === "UNREAD",
      online: false,
      avatarUrl: msg.senderAvatar || undefined,
    }));

    return { data };
  }, {
    query: t.Partial(t.Object({
      page: t.Optional(t.String()),
      limit: t.Optional(t.String()),
      orgId: t.Optional(t.String()),
    }))
  })

  /**
   * GET /message
   * Retrieves all Message with pagination and basic filtering.
   */
  .get("/", async ({ orgId, db, query }) => {
    const { page = "1", limit = "20", ...where } = query as any;
      if (orgId) where.orgId = orgId;
    return messageService.withDB(db as any).getAll({
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
   * POST /message
   * Creates a new Message.
   */
  .post("/", async ({ orgId, db, body, set }) => {
    const data = await messageService.withDB(db as any).create(body);
    set.status = 201;
    return { data };
  }, {
    body: MessagePlainInputCreate
  })

  /**
   * GET /message/:id
   * Retrieves a single Message by ID.
   */
  .get("/:id", async ({ orgId, db, params, set }) => {
    const data = await messageService.withDB(db as any).getById(params.id);
    if (!data) {
      set.status = 404;
      return { error: "Message not found" };
    }
    return { data };
  }, {
    params: t.Object({ id: t.String() })
  })

  /**
   * PATCH /message/:id
   * Updates an existing Message.
   */
  .patch("/:id", async ({ orgId, db, params, body, set }) => {
    try {
      const data = await messageService.withDB(db as any).update(params.id, body);
      return { data };
    } catch (e) {
      set.status = 404;
      return { error: "Message not found or update failed" };
    }
  }, {
    params: t.Object({ id: t.String() }),
    body: MessagePlainInputUpdate
  })

  /**
   * DELETE /message/:id
   * Deletes a Message.
   */
  .delete("/:id", async ({ orgId, db, params, set }) => {
    try {
      await messageService.withDB(db as any).delete(params.id);
      return { success: true, message: "Message deleted successfully" };
    } catch (e) {
      set.status = 404;
      return { error: "Message not found or already deleted" };
    }
  }, {
    params: t.Object({ id: t.String() })
  });
