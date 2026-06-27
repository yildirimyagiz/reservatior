# ─────────────────────────────────────────────────────────────────────────────
#  Elysia Real Estate API — Dockerfile
#  Supports both monolith (src/index.ts) and individual microservices
#  (src/pages/<service>/index.ts) via the CMD override in docker-compose.
# ─────────────────────────────────────────────────────────────────────────────

FROM oven/bun:1-alpine AS base
WORKDIR /app

# ── Dependencies ─────────────────────────────────────────────────────────────
FROM base AS deps
COPY package.json bun.lockb* ./
RUN bun install --frozen-lockfile

# ── Build ───────────────────────────────────────────────────────────────────
FROM deps AS builder
COPY . .
# Skip Prisma generate during build - do it at runtime instead
# This prevents build timeouts with large schemas

# ── Production runner ────────────────────────────────────────────────────────
FROM oven/bun:1-alpine AS runner
WORKDIR /app

# Security: run as non-root
RUN addgroup --system --gid 1001 elysia && \
    adduser  --system --uid 1001 elysia

ENV NODE_ENV=production

# Copy everything needed at runtime
COPY --from=builder --chown=elysia:elysia /app/node_modules ./node_modules
COPY --from=builder --chown=elysia:elysia /app/prisma      ./prisma
COPY --from=builder --chown=elysia:elysia /app/src         ./src
COPY --from=builder --chown=elysia:elysia /app/package.json ./

# Switch to non-root user
USER elysia

# Default: run the API gateway (monolith).
# Override CMD in docker-compose for individual microservices.
EXPOSE 3000
CMD ["bun", "run", "src/index.ts"]
