import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema_sa.prisma",
  datasource: {
    url: env("DATABASE_URL_SA"),
  },
});
