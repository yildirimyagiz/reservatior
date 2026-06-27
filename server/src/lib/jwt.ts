import { jwt } from "@elysiajs/jwt";

export const JWT_SECRET = process.env.JWT_SECRET ?? "change-me-min-32-chars-in-production-generate-with-openssl";
export const ENCODED_SECRET = new TextEncoder().encode(JWT_SECRET);

export const jwtConfig = jwt({
  name: "jwt",
  secret: JWT_SECRET,
});
