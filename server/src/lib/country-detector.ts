/**
 * Maps incoming phone prefixes (WhatsApp) or language codes (Telegram) 
 * to the correct Reservatior Database Region and Language Context.
 */

export function getRegionFromWhatsApp(phone: string): { lang: string, region: string } {
  const p = phone.replace('+', '').trim();
  
  if (p.startsWith('90')) return { lang: 'tr', region: 'TR' }; // Turkey
  if (p.startsWith('971')) return { lang: 'ar', region: 'AE' }; // UAE
  if (p.startsWith('966')) return { lang: 'ar', region: 'SA' }; // Saudi Arabia
  if (p.startsWith('44')) return { lang: 'en', region: 'UK' }; // UK
  if (p.startsWith('49')) return { lang: 'de', region: 'DE' }; // Germany
  if (p.startsWith('33')) return { lang: 'fr', region: 'FR' }; // France
  if (p.startsWith('34')) return { lang: 'es', region: 'ES' }; // Spain
  if (p.startsWith('39')) return { lang: 'it', region: 'IT' }; // Italy
  if (p.startsWith('31')) return { lang: 'nl', region: 'NL' }; // Netherlands
  if (p.startsWith('52')) return { lang: 'es', region: 'MX' }; // Mexico
  if (p.startsWith('55')) return { lang: 'pt', region: 'BR' }; // Brazil
  if (p.startsWith('54')) return { lang: 'es', region: 'AR' }; // Argentina
  if (p.startsWith('61')) return { lang: 'en', region: 'AU' }; // Australia
  if (p.startsWith('64')) return { lang: 'en', region: 'NZ' }; // New Zealand
  if (p.startsWith('81')) return { lang: 'ja', region: 'JP' }; // Japan
  if (p.startsWith('82')) return { lang: 'ko', region: 'KR' }; // Korea
  if (p.startsWith('86')) return { lang: 'zh', region: 'CN' }; // China
  if (p.startsWith('91')) return { lang: 'en', region: 'IN' }; // India
  if (p.startsWith('65')) return { lang: 'en', region: 'SG' }; // Singapore
  if (p.startsWith('60')) return { lang: 'ms', region: 'MY' }; // Malaysia
  if (p.startsWith('66')) return { lang: 'th', region: 'TH' }; // Thailand
  if (p.startsWith('1')) return { lang: 'en', region: 'US' }; // USA/Canada
  
  return { lang: 'en', region: 'US' }; // Default
}

export function getRegionFromTelegramLang(langCode: string): { lang: string, region: string } {
  const code = langCode.substring(0, 2).toLowerCase();
  
  const map: Record<string, string> = {
    'tr': 'TR',
    'ar': 'AE', // Arabic -> UAE (Default DB)
    'en': 'US',
    'de': 'DE',
    'fr': 'FR',
    'es': 'ES',
    'it': 'IT',
    'nl': 'NL',
    'pt': 'BR',
    'ja': 'JP',
    'ko': 'KR',
    'zh': 'CN',
    'th': 'TH',
    'ms': 'MY',
    'hi': 'IN'
  };

  return { 
    lang: code, 
    region: map[code] || 'US' 
  };
}
