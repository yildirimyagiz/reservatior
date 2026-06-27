# WhatsApp Entegrasyon Kullanım Rehberi

## 📱 WhatsApp Entegrasyonu Aktif Edildi

WhatsApp entegrasyonu başarıyla aktif edildi! Artık Reservatior uygulamanız üzerinden WhatsApp mesajları gönderebilir ve alabilirsiniz.

## 🚀 Hızlı Başlangıç

### 1. WhatsApp Servisini Başlatma

```bash
# WhatsApp servisini başlat
POST /api/v1/whatsapp/initialize
```

Bu endpoint WhatsApp servisini başlatır ve QR kod oluşturur.

### 2. QR Kod ile Bağlanma

```bash
# QR kod al
GET /api/v1/whatsapp/qr
```

QR kodu alıp WhatsApp uygulamanızdan taratın:
- WhatsApp uygulamasını açın
- Ayarlar → Bağlı Cihazlar → Cihaz Bağla
- QR kodu okutun

### 3. Bağlantı Durumunu Kontrol Etme

```bash
# Durum kontrolü
GET /api/v1/whatsapp/status
```

Response:
```json
{
  "success": true,
  "data": {
    "connected": true,
    "phoneNumber": "+905551234567"
  }
}
```

## 📤 Mesaj Gönderme

### Tekil Mesaj

```bash
POST /api/v1/whatsapp/send
Content-Type: application/json

{
  "to": "905551234567",
  "body": "Merhaba! Reservatior'dan mesajınız var.",
  "mediaUrl": "https://example.com/image.jpg" // opsiyonel
}
```

### Toplu Mesaj

```bash
POST /api/v1/whatsapp/send-bulk
Content-Type: application/json

{
  "messages": [
    {
      "to": "905551234567",
      "body": "Mesaj 1"
    },
    {
      "to": "905559876543",
      "body": "Mesaj 2"
    }
  ]
}
```

## 🔌 API Endpoint'leri

| Endpoint | Method | Açıklama |
|----------|--------|----------|
| `/api/v1/whatsapp/status` | GET | Bağlantı durumu |
| `/api/v1/whatsapp/initialize` | POST | Servisi başlat |
| `/api/v1/whatsapp/qr` | GET | QR kod al |
| `/api/v1/whatsapp/send` | POST | Mesaj gönder |
| `/api/v1/whatsapp/send-bulk` | POST | Toplu mesaj |
| `/api/v1/whatsapp/disconnect` | POST | Bağlantıyı kes |

## 🛠️ İletişim Sistemi ile Entegrasyon

WhatsApp entegrasyonu mevcut iletişim sistemi ile tam uyumlu çalışır:

### Communication Channel Kullanımı

```typescript
// İletişim kaydı oluşturma
await communicationService.createCommunication({
  type: 'WHATSAPP',
  direction: 'OUTBOUND',
  content: 'WhatsApp mesajı',
  recipientPhone: '905551234567'
});

// WhatsApp üzerinden gönder
await whatsappService.sendMessage({
  to: '905551234567',
  body: 'WhatsApp mesajı'
});
```

### Otomatik Yanıt Sistemi

Gelen WhatsApp mesajları otomatik olarak işlenir ve iletişim sistemine kaydedilir.

## 🔧 Environment Variables

`.env` dosyasına eklenen değişkenler:

```env
WHATSAPP_ENABLED=true
WHATSAPP_SESSION_ID=reservatior-whatsapp
WHATSAPP_WEBHOOK_URL=https://your-domain.com/api/v1/whatsapp/webhook
```

## 📋 Kullanım Senaryoları

### 1. Müşteri Bildirimleri

```typescript
// Yeni rezervasyon bildirimi
await whatsappService.sendMessage({
  to: customer.phone,
  body: `🎉 Rezervasyonunuz onaylandı! Rezervasyon No: ${booking.id}`
});
```

### 2. Agent İletişimi

```typescript
// Agent'a görev atama
await whatsappService.sendMessage({
  to: agent.phone,
  body: `📋 Yeni görev atandı: ${task.title}`
});
```

### 3. Pazarlama Kampanyaları

```typescript
// Toplu promosyon mesajı
const customers = await getActiveCustomers();
const messages = customers.map(c => ({
  to: c.phone,
  body: `🏠 Özel fırsat: ${campaign.message}`
}));

await whatsappService.sendBulkMessages(messages);
```

## ⚠️ Dikkat Edilmesi Gerekenler

1. **Rate Limiting:** WhatsApp mesaj gönderme limitlerine dikkat edin
2. **Template Mesajlar:** Bulk mesajlar için approved template kullanın
3. **Session Yönetimi:** Session bilgileri `.wwebjs_auth` dizininde saklanır
4. **Security:** WhatsApp credentials'ı güvenli tutun
5. **Error Handling:** Mesaj gönderme hatalarını yönetin

## 🧪 Test

### Local Test

```bash
# Server'ı başlat
cd server
bun run dev

# WhatsApp servisini başlat
curl -X POST http://localhost:3000/api/v1/whatsapp/initialize

# QR kod al
curl http://localhost:3000/api/v1/whatsapp/qr

# Test mesajı gönder
curl -X POST http://localhost:3000/api/v1/whatsapp/send \
  -H "Content-Type: application/json" \
  -d '{"to":"905551234567","body":"Test mesajı"}'
```

### Production Test

Production ortamında webhook URL'ini güncelleyin ve test edin.

## 🔄 Cloud Run Deployment

Cloud Run'a deployment sırasında WhatsApp session bilgileri kalıcı olmayabilir. Bu yüzden:

1. Session bilgilerini Cloud Storage'a saklayın
2. Veya Redis kullanın
3. Veya Heroku Redis add-on kullanın

## 📊 Monitoring

### Loglar

WhatsApp servis logları server terminal'de görüntülenir:

```
🟢 WhatsApp client is ready
📱 WhatsApp QR Code received
✅ WhatsApp message sent to 905551234567
```

### Health Check

```bash
# WhatsApp servisi health check
curl http://localhost:3000/api/v1/whatsapp/status
```

## 🚨 Sorun Giderme

### QR Kod Gelmiyor

```bash
# Session'ı temizle
rm -rf .wwebjs_auth

# Servisi yeniden başlat
curl -X POST http://localhost:3000/api/v1/whatsapp/initialize
```

### Bağlantı Kopuyor

```bash
# Puppeteer headless mode kontrolü
# Docker container'da çalışıyorsa additional args ekleyin
```

### Mesaj Gönderilemiyor

```bash
# Telefon numarası formatını kontrol edin
# +90 ile başlamalı ve @c.us ile bitmeli
# Örnek: 905551234567@ c.us
```

## 🎯 Sonraki Adımlar

1. **WhatsApp Business API:** Production için WhatsApp Business API'ye geçin
2. **Template Approval:** Bulk mesajlar için template onayı alın
3. **Webhook Setup:** Gelen mesajlar için webhook kurun
4. **Analytics:** Mesaj gönderme istatistikleri ekleyin
5. **Multi-language:** Çoklu dil desteği ekleyin

## 📞 Destek

Sorun yaşarsanız:
1. Logları kontrol edin
2. WhatsApp servisini restart edin
3. Session'ı temizleyin
4. Environment variables'ı kontrol edin

---

**WhatsApp entegrasyonu aktif ve kullanıma hazır! 🚀**
