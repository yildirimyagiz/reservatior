export interface RiskAnalysisResult {
  score: number;
  level: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL';
  action: 'ALLOW' | 'CHALLENGE_CAPTCHA' | 'CHALLENGE_PAYMENT' | 'BLOCK';
  factors: string[];
}

export interface RiskAnalysisInput {
  ip: string;
  userAgent: string;
  email: string;
  phone?: string;
  fingerprintId?: string;
}
