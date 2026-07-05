export interface ExecutionLockConfig {
  forceEscrow: boolean;
  forceContractStateMachine: boolean;
  forceDisputeResolution: boolean;
  forcePaymentThroughEscrow: boolean;
  requireSignatureBeforeActive: boolean;
  disputeConfidenceThreshold: number; // 0-1, AI kararı için minimum güven skoru
}

const DEFAULT_CONFIG: ExecutionLockConfig = {
  forceEscrow: false,
  forceContractStateMachine: false,
  forceDisputeResolution: false,
  forcePaymentThroughEscrow: false,
  requireSignatureBeforeActive: false,
  disputeConfidenceThreshold: 0.85,
};

// HIGH_LOCK: Yüksek riskli / zorunlu emanet pazarları
const HIGH_LOCK: Partial<ExecutionLockConfig> = {
  forceEscrow: true,
  forceContractStateMachine: true,
  forceDisputeResolution: true,
  forcePaymentThroughEscrow: true,
  requireSignatureBeforeActive: true,
  disputeConfidenceThreshold: 0.90,
};

// MED_LOCK: Orta riskli pazarlar (APAC, Latin Amerika)
const MED_LOCK: Partial<ExecutionLockConfig> = {
  forceEscrow: true,
  forceContractStateMachine: true,
  forceDisputeResolution: false,
  forcePaymentThroughEscrow: false,
  requireSignatureBeforeActive: true,
  disputeConfidenceThreshold: 0.85,
};

const REGION_LOCKS: Record<string, Partial<ExecutionLockConfig>> = {
  // ── MENA (Yüksek Escrow Zorunluluğu) ─────────────────────────────
  TR:  HIGH_LOCK, // KVKK + Türk Hukuku
  AE:  HIGH_LOCK, // RERA Dubai – emanet zorunlu
  SA:  HIGH_LOCK, // RERA SA – Suudi zorunlu emanet
  // ── Avrupa (GDPR + sıkı kiracı hakları) ──────────────────────────
  UK:  HIGH_LOCK, // Mülkiyet yasası 2018, zorunlu TDS emanet
  DE:  HIGH_LOCK, // BGB Mietrecht – katı kiracı korumaları
  FR:  HIGH_LOCK, // Loi Alur – sıkı kira mevzuatı
  ES:  HIGH_LOCK, // LAU – Ley de Arrendamientos Urbanos
  IT:  HIGH_LOCK, // Codice Civile kira düzenlemeleri
  NL:  HIGH_LOCK, // Hollanda Huurrecht – kiracı hakları
  // ── Kuzey Amerika ────────────────────────────────────────────────
  US:  DEFAULT_CONFIG, // Eyalet bazlı değişken
  CA:  MED_LOCK,       // REBBA 2002 – Ontario zorunlu depozit
  MX:  MED_LOCK,       // Código Civil Federal
  // ── Latin Amerika ────────────────────────────────────────────────
  BR:  MED_LOCK, // Lei do Inquilinato
  AR:  MED_LOCK, // Locaciones Urbanas – yüksek enflasyon riski
  // ── APAC ─────────────────────────────────────────────────────────
  AU:  MED_LOCK, // Residential Tenancies Act (eyalet bazlı)
  NZ:  MED_LOCK, // Residential Tenancies Act 1986
  JP:  HIGH_LOCK, // Japan Housing – kefil zorunluluğu
  KR:  HIGH_LOCK, // Jeonse (전세) – yüksek emanet riski
  CN:  MED_LOCK, // Çin kira düzenlemeleri
  IN:  MED_LOCK, // Rent Control Acts (eyalet bazlı)
  SG:  MED_LOCK, // Residential Property Act
  MY:  MED_LOCK, // National Land Code
  TH:  MED_LOCK, // Civil and Commercial Code
};

export function getExecutionLockConfig(region: string): ExecutionLockConfig {
  const normalized = region.toUpperCase().trim();
  const regionConfig = REGION_LOCKS[normalized];
  if (!regionConfig) return DEFAULT_CONFIG;
  return { ...DEFAULT_CONFIG, ...regionConfig };
}

export function isExecutionLocked(region: string, lockKey: keyof ExecutionLockConfig): boolean {
  const config = getExecutionLockConfig(region);
  return config[lockKey] === true;
}

/** Tüm tanımlı bölgeleri listeler */
export function getSupportedLockRegions(): string[] {
  return Object.keys(REGION_LOCKS);
}
