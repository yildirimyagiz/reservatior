import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "../prisma/schema_it.prisma",
  datasource: {
    url: env("DATABASE_URL_IT"),
  },
});
