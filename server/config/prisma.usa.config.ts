import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "../prisma/schema_usa.prisma",
  datasource: {
    url: env("DATABASE_URL_US"),
  },
  migrations: {
    seed: "bun ./prisma/seed-seattle.ts",
  },
});
