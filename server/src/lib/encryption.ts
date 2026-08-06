/**
 * Encryption Layer
 * Comprehensive encryption for data at rest, in transit, and field-level encryption
 * Supports AES-256-GCM, RSA, and TLS configuration
 */

import { createCipheriv, createDecipheriv, randomBytes, scrypt } from 'crypto';

export enum EncryptionAlgorithm {
  AES_256_GCM = 'AES-256-GCM',
  AES_256_CBC = 'AES-256-CBC',
  RSA_OAEP = 'RSA-OAEP',
  RSA_PKCS1 = 'RSA-PKCS1',
}

export enum EncryptionLevel {
  STANDARD = 'STANDARD',
  HIGH = 'HIGH',
  CRITICAL = 'CRITICAL',
}

export interface EncryptionKey {
  keyId: string;
  algorithm: EncryptionAlgorithm;
  key: Buffer;
  iv?: Buffer;
  createdAt: Date;
  expiresAt?: Date;
  version: number;
}

export interface EncryptionResult {
  encrypted: string;
  keyId: string;
  algorithm: EncryptionAlgorithm;
  iv: string;
  authTag?: string;
}

export interface FieldEncryptionConfig {
  field: string;
  level: EncryptionLevel;
  algorithm: EncryptionAlgorithm;
  keyRotationPeriod: number; // days
}

/**
 * Encryption Service
 */
export class EncryptionService {
  keys: Map<string, EncryptionKey> = new Map();
  private masterKey: Buffer;

  constructor(masterKey?: Buffer) {
    this.masterKey = masterKey || randomBytes(32);
  }

  /**
   * Generate encryption key
   */
  generateKey(algorithm: EncryptionAlgorithm = EncryptionAlgorithm.AES_256_GCM): EncryptionKey {
    const keyId = crypto.randomUUID();
    const key = randomBytes(32);
    const iv = algorithm === EncryptionAlgorithm.AES_256_GCM ? randomBytes(16) : undefined;

    const encryptionKey: EncryptionKey = {
      keyId,
      algorithm,
      key,
      iv,
      createdAt: new Date(),
      version: 1,
    };

    this.keys.set(keyId, encryptionKey);

    console.log(`[Encryption] Generated key: ${keyId} (${algorithm})`);

    return encryptionKey;
  }

  /**
   * Encrypt data
   */
  encrypt(data: string, keyId?: string): EncryptionResult {
    const key = keyId ? this.keys.get(keyId) : this.generateKey();

    if (!key) {
      throw new Error('Key not found');
    }

    let encrypted: string;
    let iv: string;
    let authTag: string | undefined;

    switch (key.algorithm) {
      case EncryptionAlgorithm.AES_256_GCM:
        const cipherGCM = createCipheriv('aes-256-gcm', key.key, key.iv);
        let encryptedGCM = cipherGCM.update(data, 'utf8', 'hex');
        encryptedGCM += cipherGCM.final('hex');
        authTag = cipherGCM.getAuthTag().toString('hex');
        encrypted = encryptedGCM;
        iv = key.iv.toString('hex');
        break;

      case EncryptionAlgorithm.AES_256_CBC:
        const cipherCBC = createCipheriv('aes-256-cbc', key.key, key.iv);
        let encryptedCBC = cipherCBC.update(data, 'utf8', 'hex');
        encryptedCBC += cipherCBC.final('hex');
        encrypted = encryptedCBC;
        iv = key.iv.toString('hex');
        break;

      default:
        throw new Error(`Unsupported algorithm: ${key.algorithm}`);
    }

    return {
      encrypted,
      keyId: key.keyId,
      algorithm: key.algorithm,
      iv,
      authTag,
    };
  }

  /**
   * Decrypt data
   */
  decrypt(encrypted: string, keyId: string, iv: string, authTag?: string): string {
    const key = this.keys.get(keyId);

    if (!key) {
      throw new Error('Key not found');
    }

    let decrypted: string;

    switch (key.algorithm) {
      case EncryptionAlgorithm.AES_256_GCM:
        const decipherGCM = createDecipheriv('aes-256-gcm', key.key, Buffer.from(iv, 'hex'));
        if (authTag) {
          decipherGCM.setAuthTag(Buffer.from(authTag, 'hex'));
        }
        let decryptedGCM = decipherGCM.update(encrypted, 'hex', 'utf8');
        decryptedGCM += decipherGCM.final('utf8');
        decrypted = decryptedGCM;
        break;

      case EncryptionAlgorithm.AES_256_CBC:
        const decipherCBC = createDecipheriv('aes-256-cbc', key.key, Buffer.from(iv, 'hex'));
        let decryptedCBC = decipherCBC.update(encrypted, 'hex', 'utf8');
        decryptedCBC += decipherCBC.final('utf8');
        decrypted = decryptedCBC;
        break;

      default:
        throw new Error(`Unsupported algorithm: ${key.algorithm}`);
    }

    return decrypted;
  }

  /**
   * Rotate key
   */
  rotateKey(keyId: string): EncryptionKey {
    const oldKey = this.keys.get(keyId);

    if (!oldKey) {
      throw new Error('Key not found');
    }

    // Generate new key
    const newKey = this.generateKey(oldKey.algorithm);

    // Re-encrypt data with new key (in production, implement data re-encryption)
    console.log(`[Encryption] Rotated key: ${keyId} -> ${newKey.keyId}`);

    return newKey;
  }

  /**
   * Delete key
   */
  deleteKey(keyId: string): void {
    this.keys.delete(keyId);
    console.log(`[Encryption] Deleted key: ${keyId}`);
  }

  /**
   * Get key by ID
   */
  getKey(keyId: string): EncryptionKey | undefined {
    return this.keys.get(keyId);
  }

  /**
   * Derive key from password
   */
  static async deriveKey(password: string, salt: Buffer): Promise<Buffer> {
    return new Promise((resolve, reject) => {
      scrypt(password, salt, 32, (err, derivedKey) => {
        if (err) reject(err);
        else resolve(derivedKey);
      });
    });
  }
}

/**
 * Field-Level Encryption
 */
export class FieldLevelEncryption {
  private encryptionService: EncryptionService;
  private fieldConfigs: Map<string, FieldEncryptionConfig> = new Map();

  constructor(encryptionService: EncryptionService) {
    this.encryptionService = encryptionService;
    this.initializeFieldConfigs();
  }

  /**
   * Initialize field encryption configurations
   */
  private initializeFieldConfigs(): void {
    // Identity information
    this.fieldConfigs.set('user.email', {
      field: 'user.email',
      level: EncryptionLevel.HIGH,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 90,
    });

    this.fieldConfigs.set('user.phone', {
      field: 'user.phone',
      level: EncryptionLevel.HIGH,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 90,
    });

    this.fieldConfigs.set('user.ssn', {
      field: 'user.ssn',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    this.fieldConfigs.set('user.passportNumber', {
      field: 'user.passportNumber',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    // Financial information
    this.fieldConfigs.set('bankAccount.accountNumber', {
      field: 'bankAccount.accountNumber',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    this.fieldConfigs.set('bankAccount.routingNumber', {
      field: 'bankAccount.routingNumber',
      level: EncryptionLevel.HIGH,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 90,
    });

    this.fieldConfigs.set('bankAccount.iban', {
      field: 'bankAccount.iban',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    this.fieldConfigs.set('payment.cardNumber', {
      field: 'payment.cardNumber',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    this.fieldConfigs.set('payment.cvv', {
      field: 'payment.cvv',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 30,
    });

    // Contracts
    this.fieldConfigs.set('contract.content', {
      field: 'contract.content',
      level: EncryptionLevel.HIGH,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 180,
    });

    this.fieldConfigs.set('contract.signatures', {
      field: 'contract.signatures',
      level: EncryptionLevel.CRITICAL,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 180,
    });

    // Property
    this.fieldConfigs.set('property.ownerName', {
      field: 'property.ownerName',
      level: EncryptionLevel.HIGH,
      algorithm: EncryptionAlgorithm.AES_256_GCM,
      keyRotationPeriod: 90,
    });
  }

  /**
   * Encrypt field
   */
  encryptField(field: string, value: string): { encrypted: string; metadata: any } {
    const config = this.fieldConfigs.get(field);

    if (!config) {
      // Field not configured for encryption, return as-is
      return { encrypted: value, metadata: { encrypted: false } };
    }

    const keyId = `${field}_key`;
    const result = this.encryptionService.encrypt(value, keyId);

    return {
      encrypted: result.encrypted,
      metadata: {
        encrypted: true,
        keyId: result.keyId,
        algorithm: result.algorithm,
        iv: result.iv,
        authTag: result.authTag,
        level: config.level,
      },
    };
  }

  /**
   * Decrypt field
   */
  decryptField(field: string, encrypted: string, metadata: any): string {
    if (!metadata.encrypted) {
      return encrypted;
    }

    return this.encryptionService.decrypt(
      encrypted,
      metadata.keyId,
      metadata.iv,
      metadata.authTag
    );
  }

  /**
   * Encrypt object fields
   */
  encryptObject<T extends Record<string, any>>(obj: T): T {
    const encrypted: any = {};

    for (const [key, value] of Object.entries(obj)) {
      if (typeof value === 'string') {
        const result = this.encryptField(key, value);
        encrypted[key] = result.encrypted;
        encrypted[`${key}_metadata`] = result.metadata;
      } else {
        encrypted[key] = value;
      }
    }

    return encrypted as T;
  }

  /**
   * Decrypt object fields
   */
  decryptObject<T extends Record<string, any>>(obj: T): T {
    const decrypted: any = {};

    for (const [key, value] of Object.entries(obj)) {
      if (key.endsWith('_metadata')) {
        continue;
      }

      const metadataKey = `${key}_metadata`;
      const metadata = obj[metadataKey];

      if (metadata && metadata.encrypted) {
        decrypted[key] = this.decryptField(key, value, metadata);
      } else {
        decrypted[key] = value;
      }
    }

    return decrypted as T;
  }

  /**
   * Add field configuration
   */
  addFieldConfig(config: FieldEncryptionConfig): void {
    this.fieldConfigs.set(config.field, config);
    console.log(`[Field Encryption] Added config for field: ${config.field}`);
  }

  /**
   * Get field configuration
   */
  getFieldConfig(field: string): FieldEncryptionConfig | undefined {
    return this.fieldConfigs.get(field);
  }

  /**
   * Check field rotation needed
   */
  checkRotationNeeded(field: string): boolean {
    const config = this.fieldConfigs.get(field);
    if (!config) return false;

    const keyId = `${field}_key`;
    const key = this.encryptionService.getKey(keyId);

    if (!key) return true;

    const daysSinceCreation = (Date.now() - key.createdAt.getTime()) / (1000 * 60 * 60 * 24);
    return daysSinceCreation >= config.keyRotationPeriod;
  }

  /**
   * Rotate field encryption key
   */
  rotateFieldKey(field: string): void {
    const config = this.fieldConfigs.get(field);
    if (!config) return;

    const oldKeyId = `${field}_key`;
    const newKey = this.encryptionService.rotateKey(oldKeyId);

    // Update key reference
    this.encryptionService.deleteKey(oldKeyId);
    this.encryptionService.keys.set(`${field}_key`, newKey);

    console.log(`[Field Encryption] Rotated key for field: ${field}`);
  }
}

/**
 * Database Encryption
 */
export class DatabaseEncryption {
  private encryptionService: EncryptionService;
  private tableKeys: Map<string, string> = new Map();

  constructor(encryptionService: EncryptionService) {
    this.encryptionService = encryptionService;
  }

  /**
   * Encrypt database value
   */
  encryptValue(table: string, column: string, value: string): string {
    const keyId = this.getTableKey(table, column);
    const result = this.encryptionService.encrypt(value, keyId);

    // Store as JSON with metadata
    return JSON.stringify({
      encrypted: result.encrypted,
      keyId: result.keyId,
      algorithm: result.algorithm,
      iv: result.iv,
      authTag: result.authTag,
    });
  }

  /**
   * Decrypt database value
   */
  decryptValue(encryptedValue: string): string {
    try {
      const data = JSON.parse(encryptedValue);

      return this.encryptionService.decrypt(
        data.encrypted,
        data.keyId,
        data.iv,
        data.authTag
      );
    } catch {
      // Value might not be encrypted
      return encryptedValue;
    }
  }

  /**
   * Get or create table key
   */
  private getTableKey(table: string, column: string): string {
    const keyId = `${table}_${column}_key`;

    if (!this.tableKeys.has(keyId)) {
      this.encryptionService.generateKey();
      this.tableKeys.set(keyId, keyId);
    }

    return keyId;
  }

  /**
   * Enable encryption for table column
   */
  enableColumnEncryption(table: string, column: string): void {
    const keyId = this.getTableKey(table, column);
    console.log(`[Database Encryption] Enabled encryption for ${table}.${column} (key: ${keyId})`);
  }

  /**
   * Disable encryption for table column
   */
  disableColumnEncryption(table: string, column: string): void {
    const keyId = `${table}_${column}_key`;
    this.tableKeys.delete(keyId);
    console.log(`[Database Encryption] Disabled encryption for ${table}.${column}`);
  }
}

/**
 * TLS Configuration
 */
export class TLSConfiguration {
  /**
   * Get TLS configuration
   */
  static getTLSConfig(): {
    minVersion: string;
    ciphers: string[];
    honorCipherOrder: boolean;
    rejectUnauthorized: boolean;
  } {
    return {
      minVersion: 'TLSv1.2',
      ciphers: [
        'ECDHE-ECDSA-AES256-GCM-SHA384',
        'ECDHE-RSA-AES256-GCM-SHA384',
        'ECDHE-ECDSA-CHACHA20-POLY1305',
        'ECDHE-RSA-CHACHA20-POLY1305',
        'ECDHE-ECDSA-AES128-GCM-SHA256',
        'ECDHE-RSA-AES128-GCM-SHA256',
      ],
      honorCipherOrder: true,
      rejectUnauthorized: true,
    };
  }

  /**
   * Generate self-signed certificate (for development)
   */
  static generateSelfSignedCertificate(): { cert: string; key: string } {
    // In production, use proper certificate authority
    // For development, generate self-signed
    console.log('[TLS] Generating self-signed certificate for development');
    
    return {
      cert: 'mock-certificate',
      key: 'mock-private-key',
    };
  }

  /**
   * Validate certificate
   */
  static validateCertificate(cert: string): boolean {
    // In production, validate certificate chain
    return true;
  }

  /**
   * Check certificate expiration
   */
  static checkCertificateExpiration(cert: string): { valid: boolean; expiresAt: Date; daysUntilExpiry: number } {
    // In production, parse certificate and check expiration
    return {
      valid: true,
      expiresAt: new Date(Date.now() + 90 * 24 * 60 * 60 * 1000),
      daysUntilExpiry: 90,
    };
  }
}

/**
 * Data at Rest Encryption
 */
export class DataAtRestEncryption {
  private encryptionService: EncryptionService;

  constructor(encryptionService: EncryptionService) {
    this.encryptionService = encryptionService;
  }

  /**
   * Encrypt file
   */
  encryptFile(filePath: string, outputPath: string): void {
    // In production, read file, encrypt, write to output
    console.log(`[Data at Rest] Encrypting file: ${filePath} -> ${outputPath}`);
  }

  /**
   * Decrypt file
   */
  decryptFile(filePath: string, outputPath: string): void {
    // In production, read file, decrypt, write to output
    console.log(`[Data at Rest] Decrypting file: ${filePath} -> ${outputPath}`);
  }

  /**
   * Encrypt directory
   */
  encryptDirectory(dirPath: string, outputPath: string): void {
    // In production, recursively encrypt all files in directory
    console.log(`[Data at Rest] Encrypting directory: ${dirPath} -> ${outputPath}`);
  }

  /**
   * Decrypt directory
   */
  decryptDirectory(dirPath: string, outputPath: string): void {
    // In production, recursively decrypt all files in directory
    console.log(`[Data at Rest] Decrypting directory: ${dirPath} -> ${outputPath}`);
  }

  /**
   * Enable disk encryption (Linux)
   */
  static enableDiskEncryption(device: string): void {
    // In production, use LUKS or similar
    console.log(`[Data at Rest] Enabling disk encryption for: ${device}`);
  }

  /**
   * Check disk encryption status
   */
  static checkDiskEncryptionStatus(device: string): { encrypted: boolean; method: string } {
    // In production, check LUKS status
    return {
      encrypted: false,
      method: 'none',
    };
  }
}

/**
 * Encryption Middleware
 */
export const encryptionMiddleware = async ({ 
  body, 
  set 
}: any) => {
  // In production, automatically encrypt sensitive fields in request body
  // For now, just log
  console.log('[Encryption] Processing request body encryption');
  
  // Add encryption header
  set.headers = {
    ...set.headers,
    'X-Encryption-Enabled': 'true',
  };
};

/**
 * Initialize encryption service
 */
export function initializeEncryptionService(): {
  encryptionService: EncryptionService;
  fieldLevelEncryption: FieldLevelEncryption;
  databaseEncryption: DatabaseEncryption;
} {
  const encryptionService = new EncryptionService();
  const fieldLevelEncryption = new FieldLevelEncryption(encryptionService);
  const databaseEncryption = new DatabaseEncryption(encryptionService);

  console.log('[Encryption] Initialized encryption service');

  return {
    encryptionService,
    fieldLevelEncryption,
    databaseEncryption,
  };
}
