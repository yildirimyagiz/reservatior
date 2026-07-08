import { NextRequest, NextResponse } from 'next/server';

export async function GET(request: NextRequest) {
  // Read geo headers if available (Cloudflare, Vercel, CloudFront)
  const country = request.headers.get('cf-ipcountry') || 
                  request.headers.get('x-vercel-ip-country') || 
                  request.headers.get('cloudfront-viewer-country') || 
                  'TR';
                  
  const isTR = country === 'TR';
  
  return NextResponse.json({
    region: isTR ? 'TR' : country,
    currency: isTR ? 'TRY' : 'USD',
    locale: isTR ? 'tr' : 'en',
    isRTL: false,
    detectionMethod: request.headers.get('cf-ipcountry') ? 'cloudflare' : 'default'
  });
}
