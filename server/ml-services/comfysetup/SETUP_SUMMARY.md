# AtlasVS + VPS ComfyUI - Setup Summary

## ✅ Tamamlanan İşlemler

### 1. VPS ComfyUI Kurulumu
- ✅ ComfyUI `/opt/ComfyUI` dizinine klonlandı
- ✅ Python sanal ortamı oluşturuldu
- ✅ PyTorch (CPU) ve bağımlılıklar kuruldu
- ✅ ComfyUI Manager eklendi
- ✅ Systemd servisi oluşturuldu
- ✅ Servis aktifleştirildi ve otomatik başlatma ayarlandı
- ✅ Pinokio kaldırılarak ~935MB disk alanı kazanıldı

### 2. AtlasVS Entegrasyonu
- ✅ `VPS_COMFY_HOST` config eklendi
- ✅ `staging_pipeline.py` güncellendi
- ✅ VPS ComfyUI öncelik sırasına eklendi
- ✅ `.env` dosyaları güncellendi

### 3. Dokümantasyon
- ✅ VPS ComfyUI setup guide oluşturuldu
- ✅ Deployment guide hazırlandı
- ✅ Setup scripti oluşturuldu

## 🖥️ VPS Bilgileri

```
IP: 72.62.163.166
Port: 8188
User: root
ComfyUI Path: /opt/ComfyUI
Service: comfyui.service
Logs: /var/log/comfyui.log
```

## 🔗 Erişim

### Web Interface
```
http://72.62.163.166:8188
```

### API Test
```bash
curl http://72.62.163.166:8188/system_stats
```

## 🚀 Kullanım

### AtlasVS'de Kullanım

Environment değişkenleri otomatik olarak ayarlı. AtlasVS şimdi şu sırayla engine'leri kontrol ediyor:

1. **Local A1111** (127.0.0.1:7860) - Geliştirme için
2. **RunPod A1111** - Kredi yüklendiğinde
3. **VPS ComfyUI** (72.62.163.166:8188) - ✅ Aktif
4. **Local ComfyUI** (127.0.0.1:8188) - Alternatif
5. **RunPod ComfyUI** - Fallback

### Manuel Test

```python
# Backend'de
from app.ai.staging_pipeline import staging_pipeline

# Mevcut engine'i kontrol et
engine = await staging_pipeline.get_available_engine()
print(f"Active engine: {engine}")  # "vps_comfyui" olmalı

# Test generation
result = await staging_pipeline.stage_image(
    image_path="path/to/image.jpg",
    room_type="living_room",
    style="modern"
)
```

## 🛠️ Servis Yönetimi

### SSH Bağlantısı
```bash
ssh root@72.62.163.166
# Şifre: KelAlaka@9182
```

### Servis Komutları
```bash
# Durum kontrolü
systemctl status comfyui.service

# Yeniden başlat
systemctl restart comfyui.service

# Logları izle
tail -f /var/log/comfyui.log
```

### ComfyUI Güncelleme
```bash
cd /opt/ComfyUI
git pull
source venv/bin/activate
pip install -r requirements.txt --upgrade
systemctl restart comfyui.service
```

## 📊 Performans

- **Mod**: CPU-only (VPS'de GPU yok)
- **Hız**: ~30-60 saniye/görsel
- **Maliyet**: ÜCRETSİZ (VPS maliyeti haricinde)
- **Güvenilirlik**: Dedike instance, her zaman erişilebilir

## 🔜 Sırada Ne Var?

### RunPod Entegrasyonu (Kredi yüklendiğinde)
1. RunPod'a kredi yükle
2. API anahtarı al
3. `.env` dosyalarını güncelle:
   ```bash
   RUNPOD_API_KEY=your_key_here
   RUNPOD_A1111_ENDPOINT_ID=your_endpoint_id
   ```
4. Test et

### Önerilen İyileştirmeler
- [ ] NGINX reverse proxy + SSL ekle
- [ ] SSH key authentication kurulumu
- [ ] Firewall ayarları (ufw)
- [ ] Monitoring ekle (Prometheus/Grafana)
- [ ] Otomatik backup scriptleri
- [ ] GPU VPS'e yükseltmeyi değerlendir

## 📚 Dokümantasyon

- **VPS Setup**: `docs/VPS_COMFYUI_SETUP.md`
- **Deployment Guide**: `docs/DEPLOYMENT_GUIDE.md`
- **Setup Script**: `scripts/setup-vps-comfyui.sh`

## 🆘 Sorun Giderme

### ComfyUI çalışmıyorsa
```bash
ssh root@72.62.163.166
systemctl restart comfyui.service
journalctl -u comfyui.service -n 50
```

### Port erişilemiyorsa
```bash
# VPS'de
netstat -tlnp | grep 8188

# Firewall kontrolü
ufw status
ufw allow 8188
```

## 💰 Maliyet Analizi

| Servis | Maliyet | Hız | Kullanım |
|--------|---------|-----|----------|
| VPS ComfyUI | ~$5-10/ay (VPS dahil) | 30-60s | Test/staging |
| RunPod A1111 | $0.0004/sn (~$0.10/100 görsel) | 3-5s | Production |
| Local | ÜCRETSİZ | 3-5s (GPU) | Development |

## 🎉 Sonuç

VPS'de ComfyUI başarıyla kuruldu ve AtlasVS'ye entegre edildi. Sistem artık şunları yapabilir:

- ✅ VPS üzerinden CPU-based image generation
- ✅ Otomatik engine fallback sistemi
- ✅ Systemd ile otomatik restart
- ✅ Merkezi log yönetimi
- ✅ RunPod entegrasyonuna hazır altyapı

---

**Kurulum Tarihi**: 2026-03-02  
**Kurulum Süresi**: ~15 dakika  
**Disk Kazancı**: 935MB (Pinokio temizliği)  
**Durum**: ✅ Aktif ve Çalışıyor
