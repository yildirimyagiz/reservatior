import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema_in.prisma",
  datasource: {
    url: env("DATABASE_URL_IN"),
  },
});
