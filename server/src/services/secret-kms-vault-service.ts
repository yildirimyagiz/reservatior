import crypto from "crypto";

export interface EnvelopeCiphertext {
  encryptedData: string;      // Base64 encoded ciphered text (AES-256-GCM)
  iv: string;                 // Initialization Vector
  authTag: string;            // Cryptographic authentication tag for GCM integrity
  encryptedDek: string;       // Data Encryption Key encrypted under Master Key (Envelope)
  keyVersion: number;         // DEK Version for rotation management
  tenantId: string;           // Tenant ownership claim
  encryptionTimestamp: string;
}

export interface KeyLeaseMetadata {
  dekId: string;
  version: number;
  createdAt: number;
  expiresAt: number;
  usageCount: number;
  maxUsageThreshold: number;
  status: "ACTIVE" | "ROTATING" | "REVOKED";
}

export interface KmsDiagnosticReport {
  status: string;
  vaultEngine: string;
  activeTenantKeysCount: number;
  autoRotationIntervalSec: number;
  envelopeAlgorithm: string;
  timestamp: string;
}

/**
 * Enterprise Secret Management & Envelope Encryption Vault Service
 * Implements Envelope Encryption (Master Encryption Key -> Data Encryption Key),
 * Automatic Key Rotation, Secret Leasing, and Zero-Exposure Memory Patterns.
 */
export class SecretKmsVaultService {
  private static instance: SecretKmsVaultService;
  
  // Master Encryption Key (MEK) simulated in secure isolated scope (in prod: AWS KMS / HashiCorp Transit Engine)
  private readonly masterKey: Buffer;
  
  // Tenant Data Encryption Key (DEK) storage - Encrypted via MEK at rest in RAM
  private tenantDekStore: Map<string, { encryptedDek: Buffer; metadata: KeyLeaseMetadata }> = new Map();

  private readonly DEFAULT_LEASE_TTL = 86400000; // 24 Hours Key Lease Duration
  private readonly MAX_DEK_USAGE = 10000;        // Rotate key automatically after 10k operations

  private constructor() {
    // Generate secure 32-byte (256-bit) Master Key or load from secure environment
    const envSecret = process.env.KMS_MASTER_KEY_HEX;
    this.masterKey = envSecret ? Buffer.from(envSecret, 'hex') : crypto.randomBytes(32);
    
    // Start automated background rotation listener
    this.startAutoRotationEngine();
  }

  public static getInstance(): SecretKmsVaultService {
    if (!SecretKmsVaultService.instance) {
      SecretKmsVaultService.instance = new SecretKmsVaultService();
    }
    return SecretKmsVaultService.instance;
  }

  /**
   * Encrypt sensitive data (Document OS signatures, financial strings, PII) using Envelope Encryption.
   */
  public async encryptEnvelope(plaintext: string, tenantId: string): Promise<EnvelopeCiphertext> {
    // 1. Obtain active or rotated DEK for Tenant
    const { dekBuffer, metadata } = await this.leaseTenantDek(tenantId);

    // 2. Generate random Initialization Vector (IV) for AES-256-GCM
    const iv = crypto.randomBytes(12);

    // 3. Encrypt Plaintext using leased DEK
    const cipher = crypto.createCipheriv("aes-256-gcm", dekBuffer, iv);
    let encryptedData = cipher.update(plaintext, "utf8", "base64");
    encryptedData += cipher.final("base64");
    const authTag = cipher.getAuthTag().toString("base64");

    // 4. Increment key usage metrics for auto-rotation trigger
    metadata.usageCount++;
    if (metadata.usageCount >= metadata.maxUsageThreshold) {
      await this.rotateTenantKey(tenantId);
    }

    // 5. Encrypt DEK under Master Key to construct final Envelope
    const encryptedDek = this.wrapKeyWithMaster(dekBuffer);

    // Zero out sensitive DEK memory reference immediately
    dekBuffer.fill(0);

    return {
      encryptedData,
      iv: iv.toString("base64"),
      authTag,
      encryptedDek: encryptedDek.toString("base64"),
      keyVersion: metadata.version,
      tenantId,
      encryptionTimestamp: new Date().toISOString(),
    };
  }

  /**
   * Decrypts an Envelope Ciphertext by unwrapping the DEK with the Master Key.
   */
  public async decryptEnvelope(envelope: EnvelopeCiphertext, tenantId: string): Promise<string> {
    // Verify Tenant Ownership authorization boundary
    if (envelope.tenantId !== tenantId) {
      throw new Error(`SECURITY_ALERT_IDOR_VIOLATION: Tenant ${tenantId} unauthorized to decrypt ciphertext belonging to ${envelope.tenantId}`);
    }

    // 1. Unwrap DEK using Master Encryption Key
    const dekBuffer = this.unwrapKeyWithMaster(Buffer.from(envelope.encryptedDek, "base64"));

    // 2. Decrypt Ciphertext via AES-256-GCM
    const iv = Buffer.from(envelope.iv, "base64");
    const authTag = Buffer.from(envelope.authTag, "base64");

    const decipher = crypto.createDecipheriv("aes-256-gcm", dekBuffer, iv);
    decipher.setAuthTag(authTag);

    let decrypted = decipher.update(envelope.encryptedData, "base64", "utf8");
    decrypted += decipher.final("utf8");

    // Zero out decrypted DEK memory
    dekBuffer.fill(0);

    return decrypted;
  }

  /**
   * Explicitly rotate a tenant's Data Encryption Key (DEK) and increment key version.
   */
  public async rotateTenantKey(tenantId: string): Promise<KeyLeaseMetadata> {
    const existing = this.tenantDekStore.get(tenantId);
    const newVersion = existing ? existing.metadata.version + 1 : 1;

    const newDek = crypto.randomBytes(32);
    const encryptedDek = this.wrapKeyWithMaster(newDek);

    const newMetadata: KeyLeaseMetadata = {
      dekId: crypto.randomUUID(),
      version: newVersion,
      createdAt: Date.now(),
      expiresAt: Date.now() + this.DEFAULT_LEASE_TTL,
      usageCount: 0,
      maxUsageThreshold: this.MAX_DEK_USAGE,
      status: "ACTIVE",
    };

    this.tenantDekStore.set(tenantId, { encryptedDek, metadata: newMetadata });
    newDek.fill(0); // Zeroize memory after storage

    return newMetadata;
  }

  /**
   * Retrieve Vault Diagnostics without exposing cryptographic secret payloads
   */
  public getVaultDiagnostics(): KmsDiagnosticReport {
    return {
      status: "OPERATIONAL_HIGH_ASSURANCE",
      vaultEngine: "AES_256_GCM_ENVELOPE_LEAVE_ZERO_TRACE",
      activeTenantKeysCount: this.tenantDekStore.size,
      autoRotationIntervalSec: this.DEFAULT_LEASE_TTL / 1000,
      envelopeAlgorithm: "MEK-KMS -> DEK (AES-256-GCM)",
      timestamp: new Date().toISOString(),
    };
  }

  private async leaseTenantDek(tenantId: string): Promise<{ dekBuffer: Buffer; metadata: KeyLeaseMetadata }> {
    let entry = this.tenantDekStore.get(tenantId);

    // If no key exists or existing key lease expired, rotate/provision new DEK
    if (!entry || Date.now() > entry.metadata.expiresAt || entry.metadata.status !== "ACTIVE") {
      await this.rotateTenantKey(tenantId);
      entry = this.tenantDekStore.get(tenantId)!;
    }

    const dekBuffer = this.unwrapKeyWithMaster(entry.encryptedDek);
    return { dekBuffer, metadata: entry.metadata };
  }

  private wrapKeyWithMaster(rawKey: Buffer): Buffer {
    const iv = crypto.randomBytes(12);
    const cipher = crypto.createCipheriv("aes-256-gcm", this.masterKey, iv);
    const encrypted = Buffer.concat([cipher.update(rawKey), cipher.final()]);
    const tag = cipher.getAuthTag();
    // Return concatenated: IV (12) + Tag (16) + Encrypted Key (32)
    return Buffer.concat([iv, tag, encrypted]);
  }

  private unwrapKeyWithMaster(wrapped: Buffer): Buffer {
    const iv = wrapped.subarray(0, 12);
    const tag = wrapped.subarray(12, 28);
    const encrypted = wrapped.subarray(28);

    const decipher = crypto.createDecipheriv("aes-256-gcm", this.masterKey, iv);
    decipher.setAuthTag(tag);
    return Buffer.concat([decipher.update(encrypted), decipher.final()]);
  }

  private startAutoRotationEngine(): void {
    // Schedule background validation every 15 minutes to purge expired DEK leases
    setInterval(() => {
      const now = Date.now();
      for (const [tenantId, entry] of this.tenantDekStore.entries()) {
        if (now > entry.metadata.expiresAt) {
          entry.metadata.status = "REVOKED";
          // Rotate key on expiration
          this.rotateTenantKey(tenantId).catch(() => {});
        }
      }
    }, 900000).unref();
  }
}
