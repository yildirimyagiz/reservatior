# Prisma Komutları - Kapsamlı Rehber

## 📋 Temel Prisma Komutları

### Schema İşlemleri
```bash
# Prisma client generate
bun run db:generate
# veya
prisma generate

# Schema formatlama
prisma format

# Schema doğrulama
prisma validate
```

### Database İşlemleri
```bash
# Schema'yı database'e push et (migration olmadan)
bun run db:push
# veya
prisma db push

# Migration oluştur
bun run db:migrate
# veya
prisma migrate dev

# Production migration
prisma migrate deploy

# Database reset (DİKKAT: Tüm veriyi siler)
prisma migrate reset

# Seed data yükle
bun run db:seed
```

### Prisma Studio
```bash
# Prisma Studio başlat
bun run db:studio
# veya
prisma studio

# Belirli bir port ile başlat
prisma studio --port 5555
```

## 🚀 Geliştirme Komutları

### Local Development
```bash
# Development ortamı için complete setup
bun run db:generate && bun run db:push && bun run db:seed

# Watch mode ile development
bun run dev
```

### Migration Yönetimi
```bash
# Yeni migration oluştur
prisma migrate dev --name add_user_table

# Migration history görüntüle
prisma migrate status

# Belirli bir migration'a rollback
prisma migrate resolve [migration-name] --applied
```

## 🏗️ Production Komutları

### Production Deployment
```bash
# Production için client generate
prisma generate

# Production migration'ları uygula
prisma migrate deploy

# Production database seed (opsiyonel)
NODE_ENV=production bun run db:seed
```

### Environment Variables
```bash
# Development
DATABASE_URL="postgresql://user:password@localhost:5432/reservatior"

# Production
DATABASE_URL="postgresql://user:password@production-host:5432/reservatior"
```

## 🔧 Gelişmiş İşlemler

### Schema Sürüm Yönetimi
```bash
# Schema diff görüntüle
prisma migrate diff --from-empty --to-schema-datamodel prisma/schema.prisma --script

# İki database arası diff
prisma migrate diff --from-url $DATABASE_URL_1 --to-url $DATABASE_URL_2 --script
```

### Debugging
```bash
# Debug mode ile Prisma çalıştır
DEBUG="prisma:query" bun run dev

# Prisma query logları
DATABASE_URL="postgresql://...?log_queries=true" bun run dev
```

### Performance
```bash
# Prisma client optimize
prisma generate --no-hints

# Connection pool ayarları (schema.prisma'da)
# connection_limit = 10
# pool_timeout = 20
```

## 📦 Multi-Database Desteği

### Regional Databases
```bash
# Her region için ayrı database URL
DATABASE_URL_TURKEY="postgresql://..."
DATABASE_URL_USA="postgresql://..."
DATABASE_URL_EUROPE="postgresql://..."

# Belirli bir region için migrate
DATABASE_URL=$DATABASE_URL_TURKEY prisma migrate deploy
```

## 🔄 CI/CD Entegrasyonu

### GitHub Actions
```yaml
- name: Generate Prisma Client
  run: bun run db:generate

- name: Run Migrations
  run: prisma migrate deploy
  env:
    DATABASE_URL: ${{ secrets.DATABASE_URL }}
```

### Docker
```dockerfile
# Dockerfile'da
RUN bunx prisma generate
RUN prisma migrate deploy
```

## 🛠️ Sorun Giderme

### Common Issues
```bash
# Client generate hatası
rm -rf node_modules/.prisma
bun run db:generate

# Migration conflict
prisma migrate resolve --rolled-back [migration-name]

# Database connection issues
prisma db push --skip-generate
```

### Cleanup
```bash
# Prisma cache temizle
rm -rf .prisma
rm -rf node_modules/.prisma

# Tüm Prisma dosyalarını temizle
bun run clean
bun install
bun run db:generate
```

## 📊 Monitoring

### Query Analysis
```bash
# Prisma Studio ile query analiz
prisma studio

# Slow query logları
DATABASE_URL="postgresql://...?log_queries=true&log_level=info" bun run dev
```

## 🎯 En Sık Kullanılan Komutlar

### Daily Development
```bash
# 1. Schema değişikliği sonrası
bun run db:generate && bun run db:push

# 2. Yeni tablo ekleme
prisma migrate dev --name new_table

# 3. Database'i görüntüleme
bun run db:studio

# 4. Seed data yenileme
bun run db:seed
```

### Production Deployment
```bash
# 1. Client generate
prisma generate

# 2. Migration deploy
prisma migrate deploy

# 3. Health check
curl http://localhost:3000/health
```

## 🚨 Dikkat Edilmesi Gerekenler

1. **Migration silmeyin:** Production'da migration silmek veri kaybına neden olabilir
2. **Backup alın:** Önemli işlemlerden önce database backup alın
3. **Test edin:** Production'da çalıştırmadan önce staging'de test edin
4. **Environment variables:** Her environment için doğru DATABASE_URL kullanın
5. **Schema validation:** Commit öncesi `prisma validate` çalıştırın

## 📝 Package.json Scripts

```json
{
  "scripts": {
    "db:generate": "prisma generate && bun run schemas:generate",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "db:seed": "bun run prisma/seed.ts",
    "db:reset": "prisma migrate reset",
    "db:deploy": "prisma migrate deploy"
  }
}
```

## 🔗 Faydalı Linkler

- [Prisma Documentation](https://www.prisma.io/docs)
- [Migration Guide](https://www.prisma.io/docs/concepts/components/prisma-migrate)
- [Studio Guide](https://www.prisma.io/studio)
- [Performance Optimization](https://www.prisma.io/docs/guides/performance-and-optimization)
