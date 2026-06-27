#!/bin/bash
# AtlasVS Build Preparation Script

set -e

echo "🚀 AtlasVS Build Preparation"
echo "=============================="
echo ""

# 1. Clean old builds
echo "🧹 Cleaning old builds..."
rm -rf .next
rm -rf node_modules/.cache
echo "✅ Clean complete"
echo ""

# 2. Install dependencies
echo "📦 Installing dependencies..."
if command -v pnpm &> /dev/null; then
    pnpm install --no-frozen-lockfile
else
    npm install
fi
echo "✅ Dependencies installed"
echo ""

# 3. Generate Prisma Client
echo "🔧 Generating Prisma Client..."
if [ -f "prisma/schema.prisma" ]; then
    npx prisma generate
    echo "✅ Prisma client generated"
else
    echo "⚠️  No Prisma schema found, skipping..."
fi
echo ""

# 4. Type check (optional, will continue on errors)
echo "📝 Type checking (optional)..."
npx tsc --noEmit || echo "⚠️  Type errors found (will be ignored in build)"
echo ""

# 5. Build
echo "🏗️  Building Next.js app..."
npm run build || pnpm run build
echo "✅ Build complete"
echo ""

echo "✅ All preparation steps completed!"
echo "Ready for Docker build or deployment"
