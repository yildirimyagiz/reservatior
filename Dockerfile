FROM oven/bun:latest

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy source code
COPY . .

# Generate Prisma clients for all schemas
RUN for config in prisma/*.config.ts; do \
      if [ -f "$config" ]; then \
        echo "Generating for $config"; \
        bunx zenstack generate --config "$config"; \
      fi \
    done

# Expose port (adjust if needed)
EXPOSE 3000

# Run the application
CMD ["bun", "run", "dev"]