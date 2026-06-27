# Google Maps API Key Test

## API Key Kontrolü

API Key'iniz 404 Forbidden döndürüyor:

```
HTTP/2 404
```

Bu şu anlamlara geliyor:
1. API key kısıtlanmış (HTTP referrers)
2. API key devre dışı bırakılmış
3. API key yanlış

## Hızlı Çözüm

### 1. Google Cloud Console
https://console.cloud.google.com/

### 2. API Key'i Düzeltin
- **APIs & Services** → **Credentials**
- API key'inizi seçin
- **Application restrictions** → **HTTP referrers**
- Mevcut kısıtlamaları silin veya güncelleyin:
  ```
  http://localhost:3000/*
  http://localhost:3001/*
  http://localhost:3002/*
  ```

### 3. API'leri Etkinleştirin
- **Maps JavaScript API**
- **Places API**
- **Geocoding API**

### 4. Test İçin Yeni Key
Yeni bir API key oluşturun ve kısıtlama olmadan test edin.

## Console'da Bakılacak Hatalar

Browser Console'unda (`F12`) şunu arayın:
```
Google Maps API warning: ApiNotActivatedMapError
Google Maps API error: RefererNotAllowedMapError
Google Maps API error: InvalidKeyMapError
```

## Geçici Test İçin

Yeni API key alana kadar test için:
1. Google Cloud Console'da yeni key oluşturun
2. **Application restrictions** → **None** (geçici olarak)
3. Yeni key'i .env dosyasına ekleyin
