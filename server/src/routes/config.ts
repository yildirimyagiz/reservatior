import { Elysia, t } from 'elysia';
import { RegionManager } from '../lib/config/RegionManager';
import { regionMiddleware } from "../middleware/region";

export const configRoutes = new Elysia({ prefix: '/config' })
  .use(regionMiddleware)
  .get('/regions', () => ({
    success: true,
    regions: RegionManager.getAllRegions()
  }))
  .get('/regions/:countryCode', ({ orgId, db, params: { countryCode } }) => {
    const region = RegionManager.getRegion(countryCode);
    if (!region) {
      return { success: false, message: 'Unsupported region' };
    }
    return { success: true, region };
  })
  .get('/geo', ({ orgId, db, headers }) => {
    // Determine country from standard CDN/Proxy headers
    const cfCountry = headers['cf-ipcountry'];
    const vercelCountry = headers['x-vercel-ip-country'];
    const cloudfrontCountry = headers['cloudfront-viewer-country'];
    
    // Default to US if running locally or headers are missing
    let detectedCountry = (cfCountry || vercelCountry || cloudfrontCountry || 'US').toUpperCase();
    
    // Check if the detected country is supported, else fallback to US
    const region = RegionManager.getRegion(detectedCountry);
    if (!region) detectedCountry = 'US';

    return { 
      success: true, 
      country: detectedCountry,
      message: `Detected region from IP: ${detectedCountry}`
    };
  });
