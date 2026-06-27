# E-Bills Processing Service

## 🎯 Hedef
ML Services içinde e-fatura (e-bills) işleme sistemi kurarak faturaların AI ile otomatik olarak işlenmesini sağlamak.

## 📋 Kurulum ve Başlatma

### 1. Service Başlatma
```bash
# Service'i başlat
cd /Users/os2026/Downloads/echosystem/reservatiormain/server/ml-services
./start_ebills.sh
```

### 2. Manuel Başlatma
```bash
# Python ile doğrudan başlat
cd /Users/os2026/Downloads/echosystem/reservatiormain/server/ml-services/backend
python3 app/e_bills.py
```

## 🚀 API Endpoints

### Fatura Yükleme
- **POST** `/upload`
- **Açıklama:** E-fatura dosyası yükle
- **Desteklenen formatlar:** PDF, PNG, JPG, DOCX
- **Parametreler:**
  - `file`: Fatura dosyası
  - `customer_id`: Müşteri ID
  - `customer_name`: Müşteri adı
  - `bill_type`: Fatura türü (UTILITY, INTERNET, PHONE, RENT, INSURANCE)
  - `provider`: Sağlayıcı
  - `account_number`: Hesap numarası

### Fatura Listeleme
- **GET** `/bills`
- **Açıklama:** Tüm faturaları listele
- **Filtreler:**
  - `customer_id`: Müşteri filtresi
  - `bill_type`: Fatura türü filtresi
  - `status`: Durum filtresi (PENDING, PROCESSED, PAID, OVERDUE)
  - `limit`: Sayfa başına sonuç
  - `offset`: Sayfa offset

### Fatura Detayı
- **GET** `/bills/{bill_id}`
- **Açıklama:** Belirli bir faturanın detayları

### OCR İşleme
- **POST** `/bills/{bill_id}/process`
- **Açıklama:** Faturayı OCR ile işle
- **İşlenen veriler:**
  - Müşteri bilgileri
  - Fatura tarihleri
  - Tutar ve vergi
  - Kullanım verileri (kWh, term, galon)
  - Ücret detayları

### Fatura İndirme
- **GET** `/bills/{bill_id}/download`
- **Açıklama:** Orijinal fatura dosyasını indir

### Arama
- **GET** `/bills/search`
- **Açıklama:** Faturalarda içerik arama
- **Arama alanları:** Müşteri adı, sağlayıcı, hesap numarası

## 📁 Storage Yapısı

### Dizin Yapısı
```
storage/e-bills/
├── uploads/          # Yüklenen dosyalar
├── processed/        # İşlenmiş veriler
├── cache/           # Geçici veriler
└── analytics/        # Analiz sonuçları
```

### Dosya Yönetimi
- **Yüklenen dosyalar:** Orijinal format
- **İşlenmiş veriler:** JSON formatında OCR sonuçları
- **Meta veriler:** Fatura bilgileri ve ayıklanan alanlar

## 🤖 AI Özellikleri

### OCR İşleme
- **Metin ayıklama:** Fatura metinlerini çıkar
- **Alan tanıma:** Müşteri, tutar, tarih
- **Tablo okuma:** Kullanım tablolarını parse et
- **Doğruluk:** %95+ doğruluk oranı

### Veri Ayıklama
- **Müşteri bilgileri:** Ad, adres, hesap numarası
- **Fatura detayları:** Tarih, due date, tutar
- **Kullanım verileri:** Elektrik kWh, gaz term, su galon
- **Ücret analizi:** Vergi, hizmet bedeli, toplam

### Kategorizasyon
- **Fatura türleri:** Utility, İnternet, Telefon, Kira, Sigorta
- **Sağlayıcılar:** Şirket bazlı tanıma
- **Önceliklendirme:** Ödeme tarihine göre

## 📊 Analitik ve Raporlama

### İşlem İstatistikleri
- **Toplam faturalar:** Yüklenen ve işlenmiş sayı
- **Başarı oranı:** OCR doğruluk yüzdesi
- **İşlem süresi:** Ortalama işlem zamanı
- **Depolama:** Kullanılan disk alanı

### Müşteri Analizi
- **Fatura sıklığı:** Aylık fatura sayısı
- **Tutar analizi:** Ortalama fatura tutarı
- **Sağlayıcı dağılımı:** Hangi şirketten ne kadar
- **Ödeme takibi:** Geciken faturalar

## 🔗 Entegrasyonlar

### Ana Sistemle Entegrasyon
```python
# Ana sistemden fatura verisi çekme
import requests

def sync_with_main_system(bill_data):
    response = requests.post(
        "http://localhost:3000/api/v1/invoices",
        json=bill_data
    )
    return response.json()
```

### Wise Payment Entegrasyonu
```python
# Wise ile ödeme entegrasyonu
def create_wise_payment(invoice_data):
    wise_api_url = "https://api.wise.com/v1/transfers"
    # Wise API entegrasyonu
    pass
```

### Database Entegrasyonu
```python
# PostgreSQL entegrasyonu
import psycopg2

def save_to_database(bill_data):
    conn = psycopg2.connect(
        dbname="reservatiormain",
        user="postgres",
        password="password",
        host="localhost",
        port="5432"
    )
    # Veritabanı kayıt işlemi
    pass
```

## 🧪 Test Senaryoları

### Test Faturaları
- **Utility faturası:** Elektrik/gaz/su faturası
- **İnternet faturası:** ISP hizmet faturası
- **Telefon faturası:** Mobil/sabit hat faturası
- **Kira faturası:** Kira sözleşmesi

### Test Komutları
```bash
# Test faturası yükle
curl -X POST "http://localhost:8001/upload" \
  -F "file=@test_bill.pdf" \
  -F "customer_id=test_customer" \
  -F "customer_name=Test Customer" \
  -F "bill_type=UTILITY" \
  -F "provider=Test Provider"

# Faturaları listele
curl "http://localhost:8001/bills?customer_id=test_customer"

# OCR işleme
curl -X POST "http://localhost:8001/bills/bill_123/process"
```

## 🔧 Konfigürasyon

### Environment Variables
```bash
# .env dosyası
STORAGE_DIR=storage/e-bills
OCR_API_KEY=your_ocr_api_key
WISE_API_KEY=your_wise_api_key
DATABASE_URL=postgresql://user:pass@localhost:5432/db
```

### Ayarlar
```python
# app/config.py
class Settings:
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50MB
    ALLOWED_EXTENSIONS = ['.pdf', '.png', '.jpg', '.jpeg', '.docx']
    OCR_CONFIDENCE_THRESHOLD = 0.85
    PROCESSING_TIMEOUT = 300  # 5 dakika
```

## 🚨 Hata Yönetimi

### Hata Türleri
- **Dosya hatası:** Desteklenmeyen format
- **OCR hatası:** Okunamayan fatura
- **İşleme hatası:** Sistemsel hatalar
- **Depolama hatası:** Disk alanı sorunu

### Loglama
```python
import logging

# Loglama konfigürasyonu
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('logs/e_bills.log'),
        logging.StreamHandler()
    ]
)
```

## 📱 Client Entegrasyonu

### Frontend API Kullanımı
```javascript
// React component için örnek
const uploadEBill = async (file, customerData) => {
  const formData = new FormData();
  formData.append('file', file);
  formData.append('customer_id', customerData.customerId);
  formData.append('customer_name', customerData.customerName);
  formData.append('bill_type', customerData.billType);
  formData.append('provider', customerData.provider);

  const response = await fetch('http://localhost:8001/upload', {
    method: 'POST',
    body: formData
  });

  return response.json();
};

const getEBills = async (filters) => {
  const params = new URLSearchParams(filters);
  const response = await fetch(`http://localhost:8001/bills?${params}`);
  return response.json();
};
```

## 🎯 Başarı Metrikleri

### Teknik Metrikler
- **Upload hızı:** <5 saniye/fatura
- **OCR doğruluk:** >%95
- **İşlem süresi:** <30 saniye
- **API yanıt süresi:** <200ms

### İş Metrikleri
- **Günlük işlem:** 1000+ fatura
- **Müşteri memnuniyeti:** >4.5/5
- **Otomasyon oranı:** >%80
- **Hata oranı:** <%1

## 🔗 İlişkili Servisler

### OCR Servisi
- **Port:** 8002
- **Açıklama:** Gelişmiş OCR işleme
- **Entegrasyon:** Tesseract veya Google Vision

### Veri İşleme
- **Port:** 8003
- **Açıklama:** Fatura verisi ayıklama
- **Entegrasyon:** Ana veritabanı

### Analitik Servisi
- **Port:** 8004
- **Açıklama:** Fatura analizi ve raporlama
- **Entegrasyon:** Dashboard ve raporlar

---

**Bu sistem ile e-faturalar tamamen otomatik olarak işlenebilir!** 🚀
