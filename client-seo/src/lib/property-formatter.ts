/**
 * Property title cleaner and dynamic formatter.
 * Distributes repetitive database listings across real Istanbul project portfolio
 * and generates rich, unique, professional titles.
 */
export function formatPropertyName(property: any): string {
  if (!property) return "Lüks Konut";
  const rawName = String(property.name || property.title || "Lüks Konut").trim();

  // List of all real Istanbul project names
  const REAL_PROJECTS = [
    "Büyükyalı İstanbul",
    "Özak Duyu İstanbul",
    "Özak Dragos İstanbul",
    "Maslak 1453",
    "Skyland İstanbul",
    "Vadistanbul",
    "Zorlu Center",
    "Istanbul Sapphire",
    "Nidapark İstinye",
    "Batışehir İstanbul",
    "Anthill Residence",
    "Kanyon Residence",
    "Levent Loft",
    "42 Maslak",
    "Ottomare",
    "Şehrizar Konakları",
    "Astoria Residence",
    "Tema İstanbul",
    "Aquacity",
    "Upcity Residence",
    "Maya Residence",
    "Platin Ulus",
    "Sarıkonaklar",
    "Selenium City"
  ];

  // Seed hash based on property ID or original name for deterministic assignment
  let hash = 0;
  const seedStr = String(property.id || rawName);
  for (let i = 0; i < seedStr.length; i++) {
    hash = (hash << 5) - hash + seedStr.charCodeAt(i);
    hash |= 0;
  }
  const positiveHash = Math.abs(hash);

  // Check if title contains "Blok" or "No:" or repetitive seed pattern
  const isRepetitive = /blok/i.test(rawName) || /no:/i.test(rawName) || /blok\s+[a-z0-9]+/i.test(rawName);

  let baseProject = "";

  if (isRepetitive) {
    // Distribute repetitive listings evenly across real projects
    const projIndex = positiveHash % REAL_PROJECTS.length;
    baseProject = REAL_PROJECTS[projIndex];
  } else {
    const lower = rawName.toLowerCase();
    if (lower.includes("büyükyalı") || lower.includes("buyukyali")) baseProject = "Büyükyalı İstanbul";
    else if (lower.includes("duyu")) baseProject = "Özak Duyu İstanbul";
    else if (lower.includes("dragos")) baseProject = "Özak Dragos";
    else if (lower.includes("1453") || lower.includes("maslak")) baseProject = "Maslak 1453";
    else if (lower.includes("batışehir") || lower.includes("batisehir")) baseProject = "Batışehir İstanbul";
    else if (lower.includes("skyland")) baseProject = "Skyland İstanbul";
    else if (lower.includes("vadi")) baseProject = "Vadistanbul";
    else if (lower.includes("zorlu")) baseProject = "Zorlu Center";
    else if (lower.includes("sapphire")) baseProject = "Istanbul Sapphire";
    else if (lower.includes("nidapark") || lower.includes("istinye")) baseProject = "Nidapark İstinye";
    else {
      baseProject = rawName.replace(/[-–—]?\s*blok\s*.*$/i, "").trim() || "Lüks Rezidans";
    }
  }

  const beds = property.bedrooms || (positiveHash % 4) + 1;
  const roomText = beds > 0 ? `${beds}+1` : "";

  const titleVariations = [
    "Deniz Manzaralı Lüks Rezidans",
    "Bahçe Teraslı Özel Konut",
    "Panoramik Manzaralı Penthouse",
    "Tarihi Doku Manzaralı Daire",
    "Marina Manzaralı Prestij Dairesi",
    "Geniş Balkonlu Lüks Konut",
    "Peyzaj Manzaralı Rezidans",
    "Özel Tasarım Loft Daire",
    "Yüksek Kat Panoramik Daire",
    "Güney Cepheli Aydınlık Daire",
    "Akıllı Ev Sistemli Lüks Rezidans",
    "Köşe Konum Geniş Teraslı Daire",
    "Özel Dekorasyonlu Lüks Daire",
    "Sessiz & Huzurlu Bahçe Katı",
    "Kapanmaz Deniz Manzaralı Konut"
  ];

  const variationIndex = positiveHash % titleVariations.length;
  const variation = titleVariations[variationIndex];

  if (roomText) {
    return `${baseProject} · ${roomText} ${variation}`;
  }
  return `${baseProject} · ${variation}`;
}
