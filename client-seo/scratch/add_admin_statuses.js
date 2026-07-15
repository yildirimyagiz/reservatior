const fs = require('fs');

const statuses = [
  'CONFIRMED', 'PENDING', 'COMPLETED', 'CANCELLED',
  'CONNECTED', 'ERROR', 'DISCONNECTED', 'ACTIVE',
  'INACTIVE', 'BLACKLISTED', 'VERIFIED', 'RECEIVED',
  'EXPIRED', 'EXPIRING', 'DRAFT', 'SOLD',
  'AVAILABLE', 'RENTED', 'MAINTENANCE', 'FAILED',
  'NOTICE', 'PAST_DUE', 'TERMINATED'
];

const trDict = {
  CONFIRMED: "Onaylandı", PENDING: "Bekliyor", COMPLETED: "Tamamlandı",
  CANCELLED: "İptal Edildi", CONNECTED: "Bağlandı", ERROR: "Hata",
  DISCONNECTED: "Bağlantı Koptu", ACTIVE: "Aktif", INACTIVE: "Pasif",
  BLACKLISTED: "Kara Listede", VERIFIED: "Doğrulandı", RECEIVED: "Alındı",
  EXPIRED: "Süresi Doldu", EXPIRING: "Süresi Doluyor", DRAFT: "Taslak",
  SOLD: "Satıldı", AVAILABLE: "Müsait", RENTED: "Kiralandı",
  MAINTENANCE: "Bakımda", FAILED: "Başarısız", NOTICE: "İhtarda",
  PAST_DUE: "Gecikmiş", TERMINATED: "Sonlandırıldı"
};

const enDict = {
  CONFIRMED: "Confirmed", PENDING: "Pending", COMPLETED: "Completed",
  CANCELLED: "Cancelled", CONNECTED: "Connected", ERROR: "Error",
  DISCONNECTED: "Disconnected", ACTIVE: "Active", INACTIVE: "Inactive",
  BLACKLISTED: "Blacklisted", VERIFIED: "Verified", RECEIVED: "Received",
  EXPIRED: "Expired", EXPIRING: "Expiring", DRAFT: "Draft",
  SOLD: "Sold", AVAILABLE: "Available", RENTED: "Rented",
  MAINTENANCE: "Maintenance", FAILED: "Failed", NOTICE: "Notice",
  PAST_DUE: "Past Due", TERMINATED: "Terminated"
};

function updateFile(file, dict) {
  const content = JSON.parse(fs.readFileSync(file, 'utf8'));
  for (const status of statuses) {
    const key = `admin_status_${status.toLowerCase()}`;
    if (!content[key]) {
      content[key] = dict[status];
    }
  }
  fs.writeFileSync(file, JSON.stringify(content, null, 2));
}

updateFile('public/locales/tr.json', trDict);
updateFile('public/locales/en.json', enDict);
console.log('Done!');
