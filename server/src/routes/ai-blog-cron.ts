import { Elysia } from "elysia";
import { cron } from "@elysiajs/cron";
import { AIBlogOrchestrator } from "../services/ai/ai-blog-orchestrator";

export const aiBlogCronRoutes = new Elysia({ name: "AIBlogCron" })
  .use(
    cron({
      name: 'weekly-ai-blog-generation',
      // Runs every Sunday at 02:00 AM (server time)
      pattern: '0 2 * * 0',
      async run() {
        console.log("[Cron] Triggering Weekly AI Blog Generation...");
        await AIBlogOrchestrator.runWeeklyGeneration();
      }
    })
  );
