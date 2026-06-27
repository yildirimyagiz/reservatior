import { Elysia, t } from "elysia";
import { prisma } from "../lib/prisma";
import { jwtVerify } from "jose";
import { ENCODED_SECRET } from "../lib/jwt";
import { regionMiddleware } from "../middleware/region";

const SSE_KEEPALIVE_INTERVAL = 15000;
const SSE_POLL_INTERVAL = 2000;

export const systemEventStreamRoutes = new Elysia({ prefix: "/system/events" })
  .use(regionMiddleware)

  .get("/stream", async ({ orgId, db, query, set }) => {
    const { orgId, token } = query as any;
    if (!orgId) {
      set.status = 400;
      return { error: "orgId is required" };
    }

    if (token) {
      try {
        await jwtVerify(token, ENCODED_SECRET);
      } catch {
        set.status = 401;
        return { error: "Invalid token" };
      }
    }

    set.headers["content-type"] = "text/event-stream";
    set.headers["cache-control"] = "no-cache";
    set.headers["connection"] = "keep-alive";
    set.headers["x-accel-buffering"] = "no";

    let lastId = query.lastEventId || "0";
    let closed = false;

    const stream = new ReadableStream({
      async start(controller) {
        const poll = async () => {
          if (closed) return;
          try {
            const where: any = { orgId, id: { gt: lastId } };
            const events = await prisma.systemEvent.findMany({
              where,
              orderBy: { createdAt: "asc" },
              take: 50,
            });
            for (const event of events) {
              const data = JSON.stringify(event);
              controller.enqueue(new TextEncoder().encode(`id: ${event.id}\ndata: ${data}\n\n`));
              lastId = event.id;
            }
          } catch (e) {
            if (!closed) controller.enqueue(new TextEncoder().encode(`: poll error\n\n`));
          }
          if (!closed) setTimeout(poll, SSE_POLL_INTERVAL);
        };

        const keepalive = () => {
          if (closed) return;
          controller.enqueue(new TextEncoder().encode(": keepalive\n\n"));
          setTimeout(keepalive, SSE_KEEPALIVE_INTERVAL);
        };

        poll();
        keepalive();
      },
      cancel() {
        closed = true;
      },
    });

    return stream;
  }, {
    query: t.Object({
      orgId: t.String(),
      token: t.Optional(t.String()),
      lastEventId: t.Optional(t.String()),
    }),
  });
