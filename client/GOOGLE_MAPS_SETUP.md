# Google Maps API Key Configuration

## Google Maps API Key Gerekli

Haritaların çalışması için gerçek bir Google Maps API key gerekli.

### Adım 1: Google Cloud Console'da API Key Alın

1. [Google Cloud Console](https://console.cloud.google.com/) gidin
2. Yeni bir proje oluşturun veya mevcut projeyi seçin
3. **APIs & Services** > **Library** gidin
4. Aşağıdaki API'leri etkinleştirin:
   - **Maps JavaScript API**
   - **Geocoding API**
   - **Places API**

5. **APIs & Services** > **Credentials** gidin
6. **Create Credentials** > **API Key** tıklayın
7. API key'i kopyalayın

### Adım 2: Environment Variable'ı Ayarlayın

`.env` dosyasını oluşturun veya güncelleyin:

```bash
# client/.env
VITE_GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY_HERE
```

### Adım 3: Development Server'ı Yeniden Başlatın

```bash
cd client
pnpm dev
```

### Adım 4: Haritaları Test Edin

- `http://localhost:3002/properties` - Properties sayfası (Grid + Map View)
- `http://localhost:3002/property-search` - Arama haritası
- `http://localhost:3002/property/1` - Property detayı

### API Key Kısıtlamaları

Güvenlik için API key'inizi kısıtlayın:

1. Google Cloud Console'da API key'e gidin
2. **Edit API Key** tıklayın
3. **Application restrictions** altında:
   - **HTTP referrers** seçin
   - `http://localhost:3002/*` ve `https://yourdomain.com/*` ekleyin
4. **API restrictions** altında:
   - Sadece gerekli API'leri seçin (Maps JavaScript, Geocoding, Places)

### Test İçin Dummy Key

Sistemde dummy key mevcut ancak harita yüklenmeyecektir:
```
AIzaSyDummyKeyForTesting
```

### Sorun Giderme

Eğer harita görünmüyorsa:

1. **Console'u kontrol edin** - API hataları için
2. **API key'i doğrulayın** - doğru mu?
3. **API'lerin etkinleştirildiğini kontrol edin**
4. **Network tab'ı kontrol edin** - Google API çağrıları başarılı mı?

### Örnek Console Hataları

```
Google Maps API warning: NoApiKeys
Google Maps API error: MissingKeyMapError
Google Maps API error: InvalidKeyMapError
```

Bu hatalar API key sorunlarını gösterir.
