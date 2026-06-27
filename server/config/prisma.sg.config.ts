import "dotenv/config";
import { defineConfig, env } from "prisma/config";

export default defineConfig({
  schema: "prisma/schema_sg.prisma",
  datasource: {
    url: env("DATABASE_URL_SG"),
  },
});
