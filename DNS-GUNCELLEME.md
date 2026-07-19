# reservatior.com DNS Güncelleme Talimatları

## Sorun
reservatior.com iki farklı Hostinger sunucusuna yönlendirilmiş:
- 72.61.71.6 (eski sunucu -部分 çalışıyor)
- 72.61.71.166 (eski sunucu - hiç çalışmıyor)

Trafiğin ~%50'si yanlış sunucuya gidiyor. Bu yüzden videolar ve sayfalar yüklenmiyor.

## Yapılacaklar

Hostinger DNS Yöneticisinde şu değişiklikleri yapın:

### Silinecek Kayıtlar
- A Kaydı: @ → 72.61.71.6
- A Kaydı: @ → 72.61.71.166
- A Kaydı: www → 72.61.71.6 (veya 72.61.71.166)

### Eklenecek Kayıtlar
| Tip | Host | Değer | TTL |
|-----|------|-------|-----|
| A | @ | 72.62.163.166 | 300 |
| A | www | 72.62.163.166 | 300 |

### Dikkat Edilmesi Gerekenler
1. TTL'yi kısa tutun (300 saniye) — propagation hızlı olsun
2. Diğer DNS kayıtlarını (MX, TXT vb.) silmeyin
3. Değişiklikten sonra propagation 5-30 dakika sürebilir

## Doğrulama
Değişiklik sonrası şu komutu çalıştırarak kontrol edin:
```
nslookup reservatior.com
```
Sonuç `72.62.163.166` göstermeli.
