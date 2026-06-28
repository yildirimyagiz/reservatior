import { jwt } from "@elysiajs/jwt";

if (!process.env.JWT_SECRET || process.env.JWT_SECRET.includes("change-me")) {
  throw new Error(
    "🔴 CRITICAL: JWT_SECRET is not set or is using the insecure default value.\n" +
    "   Generate a secure secret with: openssl rand -hex 32\n" +
    "   Then set it in your .env file."
  );
}

export const JWT_SECRET = process.env.JWT_SECRET;
export const ENCODED_SECRET = new TextEncoder().encode(JWT_SECRET);

export const jwtConfig = jwt({
  name: "jwt",
  secret: JWT_SECRET,
});
