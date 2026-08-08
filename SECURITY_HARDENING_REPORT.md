# Güvenlik Sertleştirme Raporu (SECURITY HARDENING REPORT)

**Tarih:** 2026-08-07
**Kapsam:** `reservatior.com` üretim sunucusu (Ionos VPS `srv1233901`, 72.62.163.166) ve tüm repo
**Yöntem:** Dış görünürlük taraması → sistem sertleştirme → erişim denetimi → uygulama/API denetimi → izleme/yedek

---

## 1. Yönetici Özeti

Kampanya 4 faz halinde yürütüldü. **Kritik öncelikli bulgular giderildi**, orta ve düşük seviyede kalan riskler §5'te aksiyon planıyla listelendi.

| Faz | Konu | Durum |
|---|---|---|
| 1 | Dış görünürlük + sistem sertleştirme | ✅ Tamamlandı |
| 2 | SSH / erişim sertleştirme | ✅ Tamamlandı |
| 3 | Uygulama & bağımlılık güvenliği | ✅ Kısmen tamamlandı (düşük riskler kaldı) |
| 4 | İzleme, loglama, yedek | 🔶 Öneriler hazır (uygulanmadı) |

---

## 2. Faz 1 — Dış Görünürlük ve Sistem Sertleştirme

### Bulgular (başlangıç durumu)
| Bulgu | Önem | Çözüm |
|---|---|---|
| **3000 Easypanel paneli** dışarıdan açıktı (herkese) | **Kritik** | `iptables DOCKER-USER` guard ile kapatıldı |
| **2377 Swarm yönetim portu** dışarıdan **erişilebilirdi** (gRPC 415 yanıtı veriyordu) | **Kritik** | UFW `deny` ile kapatıldı (DOCKER-USER, dockerd'ın host socket bind'ini engellemiyor — sadece UFW INPUT kuralı kesiyor) |
| **UFW kurulu değildi** (önceki kayıtta "kuruldu" denmişti; 2026-08-07 doğrulamasında yoktu) | **Kritik** | UFW 0.36.2 kuruldu + yapılandırıldı |
| **fail2ban yoktu** — 7 günde 150 başarısız SSH denemesi | Yüksek | fail2ban kuruldu (sshd/postfix/postfix-sasl jail'leri) |
| **Swap yoktu** — 3 günde 60 OOM olayı (`bun`/`node` öldürülüyor) | Yüksek | 4Gi swap eklendi |
| `*.reservatior.com` wildcard tümü IP'ye çözüyor, sadece ana alan sertifikalı | Orta | Alt alanlarda panel yok; izleniyor |

### Alınan önlemler
1. **UFW 0.36.2** kuruldu + aktif: `allow 22,25,80,443,465,587` + `deny 2377,7946,3000` + `default deny incoming`, `deny routed`. (Doğrulama: 2377/7946/3000 dışarıdan kapalı, site 200, container'lar healthy.)
2. **Docker guard** (kalıcı): `/etc/systemd/system/docker-port-guard.service` → `iptables -I DOCKER-USER -p tcp --dport {3000,2377,7946} -j DROP`. `systemctl enable` ile açılışta çalışıyor.
   ⚠️ **Ders:** DOCKER-USER guard yalnızca **container yayınlanan (published)** portları korur; `dockerd` swarm'ın host'a doğrudan bağladığı portlar (2377/7946) bu zincirden geçmediği için **UFW INPUT kuralı şarttır** — bu bulgu sayesinde keşfedildi ve UFW ile kapatıldı.
3. **fail2ban** v1.0.2: `sshd`, `postfix`, `postfix-sasl` jail'leri aktif. bantime 15m, maxretry 3.
4. **4Gi swap** (`/swapfile` + fstab) — OOM koruması.

### Dışa açık portlar (denetim sonrası, 2026-08-07 teyitli)
`22 (SSH) · 25 (SMTP) · 80 (HTTP) · 443 (HTTPS) · 465 (SMTPS) · 587 (Submission)` — tamamı kasıtlı. Kapalı ve dışarıdan teyitli: `2377, 7946, 3000`.

---

## 3. Faz 2 — SSH ve Erişim Sertleştirme

### Alınan önlemler (`/etc/ssh/sshd_config.d/10-hardening.conf`)
- `PasswordAuthentication no` + `KbdInteractiveAuthentication no` → **parola SSH kapandı, yalnızca key**
- `PermitRootLogin prohibit-password` (sadece key ile root)
- `MaxAuthTries 3`, `MaxStartups 10:30:100`, `LoginGraceTime 30`
- `X11Forwarding no`, `AllowUsers root`
- `sshd -t` doğrulandı; key girişi test edildi, parola reddedildi

### Kimlik bilgileri
- **Root parolası rotate edildi** (yeni değer `/root/.root_credential` içinde; parola SSH kapalı olduğundan işlevsel değil ama kayıt düşüldü)
- `authorized_keys` temizlendi ve içeriği doğrulandı (2 key: kullanıcının Mac key'i + yedek key)

---

## 4. Faz 3 — Uygulama ve Bağımlılık Güvenliği

### 4.1 Secret / sızıntı taraması
Repo genelinde (node_modules/.git/scratch/ssl/wasm haricinde) pattern taraması yapıldı:
```
sk_live_ / sk_test_ / ghp_ / AIza / AKIA / xoxb- / BEGIN PRIVATE KEY
```
**Sonuç: temiz — kaynak kodda sızdırılmış secret bulunamadı.** (Önceki oturumda commit'lenen simüle payouts/2FA/secret'lar `9b326e72b` ile zaten temizlenmişti.)

### 4.2 Bağımlılık denetimi (bun audit)
| Proje | Bulgu | Aksiyon |
|---|---|---|
| `server/` | **79 açık (41 high)** | xlsx + valibot düzeltildi → **76 açık** |
| `client-seo/` | **36 açık (21 high)** | Next.js 14 → 15/16 migrasyonu planlandı (§5) |
| kök | 10 açık | Değerlendirmede |

### 4.3 Düzeltilenler (bu oturumda)
1. **xlsx** `0.18.5` (npm, patch yok — Prototype Pollution + ReDoS, **yüksek**)
   → SheetJS resmi CDN **`0.20.3`** (`https://cdn.sheetjs.com/xlsx-0.20.3/xlsx-0.20.3.tgz`).
   API aynı, kaynak kodda değişiklik gerekmedi. Smoke test: `aoa_to_sheet` → `write` → `read` döngüsü ✓
2. **valibot** `1.4.1` → `1.4.2` (moderate fix). Üretilen şemalar (`schemas/generated/*`) uyumlu doğrulandı ✓

### 4.4 Deploy sırasında bulunan ve düzeltilen üretim hatası
**pgbouncer crash-loop ("main section missing from config file"):** compose `DATABASES_*` (eski env API'si) kullanıyordu; `edoburu/pgbouncer:latest` imajı yeni `DATABASE_URL(S)` API'sine geçmişti. Env eşleşmediği için entrypoint `[pgbouncer]` bölümünü üretemiyor, container sürekli restartlanıyordu (server bu yüzden başlatılamıyordu).
- **Çözüm:** `docker-compose.yml` pgbouncer env'ine `LISTEN_PORT=6432` + 24 bölge DB'sini içeren `DATABASE_URLS` eklendi. (`e7c56853`)
- Doğrulama: pgbouncer **healthy**, server **healthy**, site **200**.

**Canlı denetimde bulunan ikinci auth hatası ("wrong password type"):** postgres 15 rollerinde şifre `scram-sha-256` (`SCRA` prefix) saklanıyor, pgbouncer ise varsayılan `md5` ile doğruluyordu → tüm property API sorguları `FATAL: server login failed: wrong password type` ile 500 dönüyordu.
- **Çözüm:** pgbouncer env'ine `AUTH_TYPE=scram-sha-256` eklendi (userlist plaintext olarak yeniden üretildi). `select 1` → pgbouncer üzerinden başarılı; API ardışık çağrılar 200.
- **Ek:** bayat Prisma/pgbouncer bağlantı havuzlarını temizlemek için server container'ı restart edildi; ilk çağrı da dahil tüm API çağrıları 200, console hatası yok.

### 4.4 Doğrulanan mevcut kontroller (sorun değil)
- **Rate limit mevcut ve global bağlı:** `server/src/index.ts:162` → auth 10/dk, heavy (AI/search) 30/dk, genel 200/dk, read 500/dk; in-memory fallback + isteğe bağlı Redis; `429` + `Retry-After` dönüyor. `X-Forwarded-For`'un yalnızca nginx arkasında güvenilir olduğu doğrulandı.
- **Güvenlik header'ları:** HSTS, X-Frame-Options, X-Content-Type-Options, Referrer-Policy, Permissions-Policy mevcut.
- **WAF / IP-reputation / network-segmentation middleware'leri** mevcut.
- **Next.js SSRF (CVE-2026-64645, CVSS 8.3):** client-seo `14.2.35` etkilenen aralıkta (`<15.5.21`) AMA istismar koşulu (rewrite/redirect destination'ında kullanıcı kontrollü hostname segmenti) yok — `next.config.mjs`'deki tüm destination'lar statik `backendUrl` env veya statik yollar. **Bu uygulamada istismar edilebilir değil.** (Yine de §5'te sürüm migrasyonu öneriliyor.)

### 4.5 Açık orta seviye bulgular
- **CSP yok:** site CSP header'ı göndermiyor. XSS'e karşı derinlemesine savunma eksik.
- **`NEXT_LOCALE` cookie:** `Secure` ve `SameSite` bayrakları yok (taşıyıcı iletim riski).
- **Easypanel veri volume'ü yok** (panel yarı-çalışır) — kapsam dışı, 3000 dışarıdan kapalı.
- `regions-config.json` eksikliği (pre-existing, RegionManager uyarısı).

---

## 5. Kalan Riskler ve Aksiyon Planı

### 🔴 Öncelikli (önümüzdeki 2 hafta)
1. **`client-seo` Next.js migrasyonu:** `14.2.35` → `15.5.21+` (veya 16.2.11+). React 18→19 + breaking changes içerir; staging'de `bun test` + canlı doğrulama sonrası deploy. *Şu an istismar edilmiyor ama 14.x hattında patch yok.*
2. **Sunucuya bu oturumun bağımlılık düzeltmelerini deploy et:** `server` imajı rebuild (xlsx 0.20.3 + valibot 1.4.2 canlıya girmeli).
3. **CSP header'ı ekle** (nginx veya Next headers). Varsayılan öneri: `default-src 'self'` + gerekli üçüncü taraflar beyaz listesi.

### 🟡 Orta (1 ay içinde)
4. `NEXT_LOCALE` cookie → `Secure; SameSite=Lax; Path=/`.
5. **`server/` transitive açıklar:** `puppeteer`, `whatsapp-web.js`, `baileys`, `zenstack` zincirlerinden gelen semver/ws/brace-expansion/basic-ftp vb. → staging branch'te `bun update --latest` + test. (whatsapp-web.js yönetilmeyen bir bağımlılık; ayrı değerlendirilecek.)
6. **Easypanel veri volume'ü** oluştur / paneli düzgün kur (paneli canlı sistemden kaldırmak da seçenek).

### 🟢 Düşük / izleme (1-3 ay)
7. **Faz 4 — loglama & izleme:** fail2ban istatistikleri haftalık kontrol, `journald` log rotation, disk takibi.
8. **Yedekleme:** PostgreSQL `pg_dump` + volume yedeği → cron ile günlük, offsite (örn. başka VPS bucket) aktarımı.
9. Wildcard alt alan adları için yönetim planı (kullanılmayanları DNS'ten kaldır).

---

## 6. İletişim / Kayıtlar
- Önceki denetim düzeltmeleri `9b326e72b` ile deploy edildi ve e-posta ile `yagizyildirim@icloud.com` + `info@reservatior.com` adreslerine iletildi (Postfix log onaylı).
- Bu raporun commit'inde yer alan değişiklikler: `server/package.json`, `server/bun.lock`, `SECURITY_HARDENING_REPORT.md` (`d56d19918` → `54d438275`), i18n çeviri restorasyonu (`f233105f1`), pgbouncer fix (`e7c56853`).
- **Canlıya alındı (2026-08-07):** xlsx 0.20.3 + valibot 1.4.2 sunucuda container içinde teyit edildi; pgbouncer + server healthy; UFW aktif; 2377/7946/3000 dışarıdan kapalı.

---

## 7. Üretim Veri İmportu ve Sahiplik Katmanı (2026-08-08)

**Amaç:** Canlı denetimde boş olduğu tespit edilen üretim TR DB'sine gerçek mülk verisi aktarmak ve "mülkünüzü sahiplenin" (İntent OS / sahiplik) akışının veri katmanını kurmak.

### 7.1 Büyükyalı Istanbul (`import-buyukyali.ts`)
- **Kaynak:** `datalar/buyukyali_2019/sold_units.json` (742 sözleşme kaydı) + `PRICE_LIST_2026` (USD).
- **Sonuç (üretim `realestate_tr`):** 625 birim Property, 1 Master Property + Facility, 14 Blok, **510 sahip Contact** (`OWNER_CONTACT`, `invitationPending: true`, birim listeleri `notes` içinde).
- **Veri notu:** Kaynakta **105 blok+kapı çakışması** var (742 kayıt → 624 benzersiz fiziksel birim). Aynı blok+kapı iki farklı daireyi (farklı kat/m²) veya iki sahibi temsil ediyor. Ayrıştırma **claim akışında** yapılacak: kullanıcı blok/kat bilgisini ve tapu/sözleşme belgesini (opsiyonel) vererek sahipliğini doğrulayacak → `PropertyOwnershipVerification` + birim split'i. Bu, eksik veri import'u bloklamadan portföy kazanımını hızlandırır.
- **Sahiplik envanteri:** 510 sahip (104'ü çoklu birim), 494 gerçek telefon, 477 gerçek e-posta (eksik olanlara `owner_N@buyukyali.import` yer tutucu atandı).
- **Bilinen script notu:** `salePriceTRY` ayrıştırması binlik ayracı nedeniyle hatalı (`1,727,100` → `1727.1`); `marketValueEstUSD` gross m²'den doğru hesaplanıyor. Fiyatlar claim akışında güncellenecek.

### 7.2 Avrupa Konutları Güneşli (`import-avrupa-konutlari-gunesli.ts`)
- **Kaynak:** `datalar/tr/istanbul/bagcilar/merkez/projeler/Avrupa Konutları Güneşli` (198 medya dosyası).
- **Sonuç:** Proje Property + Facility + 5 blok (1+1..5+1) + **198 `PropertyDocument` medya kaydı** (49 foto, 139 kat planı, 4 video, 3 sunum, 1 fiyat listesi, 2 harita). Birim fiyatları fiyat listesi JPG OCR'ı sonrası eklenecek.

### 7.3 Doğrulama
- Üretim TR DB: Property **626** (625 Büyükyalı + 1 Güneşli), FacilityBlock 19, Contact 510, PropertyDocument 198.
- Canlı API `X-Region: TR` ile her iki projeyi döndürüyor (`total: 626`).
- Varsayılan (headersız) API US DB'yi döndürüyor — sitenin TR içeriği region header'ı ile geliyor.
- İşlemler yerel Makina'dan üretim pgbouncer'ına **SSH tüneli** (container IP `172.19.0.4:6432`) ile yapıldı; host 6432 portu yayınlanmıyor (güvenli).
