import { PropertyType, ListingStatus, ListingType, PropertyCategory, OwnershipVerificationStatus, VerificationMethod } from "@prisma/client";
import PrismaManager from "../src/lib/prisma-manager";
import puppeteer from 'puppeteer';

PrismaManager.init();

interface ScrapedProperty {
  address: string;
  city: string;
  state: string;
  zip: string;
  ownerName?: string;
  parcelNumber?: string;
  marketValue?: number;
  imageURLs?: string[];
  description?: string;
  bedrooms?: number;
  bathrooms?: number;
  sqft?: number;
  yearBuilt?: number;
}

class PropertyScraper {
  private browser: puppeteer.Browser | null;
  private client: ReturnType<typeof PrismaManager.getClient>;

  constructor() {
    this.browser = null;
    this.client = PrismaManager.getClient("US");
  }

  async init() {
    this.browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
    }
  }

  async geocodeAddress(address: string): Promise<{ lat: number; lng: number }> {
    if (!this.googleMapsApiKey) {
      console.warn('Google Maps API key not found, using default Miami coordinates');
      return { lat: 25.7617, lng: -80.1918 };
    }

    try {
      const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${this.googleMapsApiKey}`;
      const response = await fetch(url);
      const data = await response.json();

      if (data.status === 'OK' && data.results && data.results.length > 0) {
        const location = data.results[0].geometry.location;
        return { lat: location.lat, lng: location.lng };
      } else {
        console.warn(`Geocoding failed for ${address}: ${data.status}`);
        return { lat: 25.7617, lng: -80.1918 };
      }
    } catch (error) {
      console.error('Geocoding error:', error);
      return { lat: 25.7617, lng: -80.1918 };
    }
  }

  async searchPropertiesDuckDuckGo(query: string): Promise<string[]> {
    if (!this.browser) throw new Error('Browser not initialized');
    const page = await this.browser.newPage();
    const urls: string[] = [];

    try {
      await page.goto(`https://duckduckgo.com/?q=${encodeURIComponent(query)}&ia=web`, {
        waitUntil: 'networkidle2',
        timeout: 30000
      });

      await page.waitForSelector('.result__a', { timeout: 10000 });

      const propertyUrls = await page.evaluate(() => {
        const links = Array.from(document.querySelectorAll('.result__a'));
        return links
          .map(link => (link as HTMLAnchorElement).href)
          .filter(href => 
            href.includes('zillow.com') || 
            href.includes('realtor.com') || 
            href.includes('trulia.com') ||
            href.includes('.gov') ||
            href.includes('pa.') ||
            href.includes('property')
          )
          .slice(0, 10);
      });

      urls.push(...propertyUrls);
    } catch (error) {
      console.error('DuckDuckGo search error:', error);
    } finally {
      await page.close();
    }

    return urls;
  }

  async scrapeMiamiDadeProperty(address: string): Promise<Partial<ScrapedProperty>> {
    if (!this.browser) throw new Error('Browser not initialized');
    const page = await this.browser.newPage();
    let propertyData: Partial<ScrapedProperty> = {};

    try {
      await page.goto('https://www.miamidadepa.gov/pa/real-estate/property-search.page', {
        waitUntil: 'networkidle2',
        timeout: 30000
      });

      await page.waitForSelector('#search-input', { timeout: 10000 });
      await page.type('#search-input', address);
      await page.click('#search-button');

      await page.waitForSelector('.property-details', { timeout: 15000 });

      propertyData = await page.evaluate(() => {
        const data: Record<string, string | number | undefined> = {};

        const ownerElement = document.querySelector('.owner-name');
        if (ownerElement) {
          data.ownerName = ownerElement.textContent?.trim();
        }

        const parcelElement = document.querySelector('.parcel-number');
        if (parcelElement) {
          data.parcelNumber = parcelElement.textContent?.trim();
        }

        const valueElement = document.querySelector('.market-value');
        if (valueElement) {
          const valueText = valueElement.textContent?.replace(/[^0-9.]/g, '');
          data.marketValue = valueText ? parseFloat(valueText) : undefined;
        }

        const yearElement = document.querySelector('.year-built');
        if (yearElement) {
          data.yearBuilt = parseInt(yearElement.textContent?.trim() || '0');
        }

        const sqftElement = document.querySelector('.living-area');
        if (sqftElement) {
          data.sqft = parseInt(sqftElement.textContent?.replace(/[^0-9]/g, '') || '0');
        }

        return data;
      });

      const images = await page.evaluate(() => {
        const imgElements = Array.from(document.querySelectorAll('.property-gallery img, .property-image img'));
        return imgElements.map(img => (img as HTMLImageElement).src).filter(src => src);
      });

      propertyData.imageURLs = images;

    } catch (error) {
      console.error('Miami-Dade scraping error:', error);
    } finally {
      await page.close();
    }

    return propertyData;
  }

  async scrapeCountyProperty(countyUrl: string): Promise<Partial<ScrapedProperty>> {
    if (!this.browser) throw new Error('Browser not initialized');
    const page = await this.browser.newPage();
    let propertyData: Partial<ScrapedProperty> = {};

    try {
      await page.goto(countyUrl, {
        waitUntil: 'networkidle2',
        timeout: 30000
      });

      propertyData = await page.evaluate(() => {
        const data: Record<string, string | number | undefined> = {};

        const selectors: Record<string, string[]> = {
          owner: ['.owner-name', '.property-owner', '#ownerName', '.owner-info'],
          parcel: ['.parcel-id', '.parcel-number', '#parcelId', '.apn'],
          value: ['.market-value', '.assessed-value', '.property-value', '#marketValue'],
          address: ['.property-address', '.site-address', '#propertyAddress']
        };

        for (const [key, selectorList] of Object.entries(selectors)) {
          for (const selector of selectorList) {
            const element = document.querySelector(selector);
            if (element) {
              let value = element.textContent?.trim();
              if (key === 'value') {
                value = value?.replace(/[^0-9.]/g, '');
                data[key] = value ? parseFloat(value) : undefined;
              } else {
                data[key] = value;
              }
              break;
            }
          }
        }

        return data;
      });

    } catch (error) {
      console.error('County scraping error:', error);
    } finally {
      await page.close();
    }

    return propertyData;
  }

  async savePropertyToSystem(scrapedData: ScrapedProperty, coordinates: { lat: number; lng: number }, orgId: string = "seed-global-org-master") {
    const uniqueId = `scraped-${scrapedData.address.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase()}`;

    try {
      const property = await this.client.property.upsert({
        where: { id: uniqueId },
        update: {},
        create: {
          id: uniqueId,
          orgId: orgId,
          name: `${scrapedData.city}, ${scrapedData.state} Mülk`,
          type: PropertyType.APARTMENT,
          region: "USA",
          currency: "USD",
          addressLine1: scrapedData.address,
          city: scrapedData.city,
          state: scrapedData.state,
          zip: scrapedData.zip,
          country: "US",
          lat: coordinates.lat,
          lng: coordinates.lng,
          listingPrice: scrapedData.marketValue,
          listingType: ListingType.SALE,
          listingStatus: ListingStatus.AVAILABLE,
          propertyCategory: PropertyCategory.RESIDENTIAL
        }
      });

      console.log(`✅ Property saved: ${uniqueId}`);

      if (scrapedData.imageURLs && scrapedData.imageURLs.length > 0) {
        for (const imageUrl of scrapedData.imageURLs.slice(0, 5)) {
          try {
            await this.client.propertyPhoto.create({
              data: {
                propertyId: uniqueId,
                orgId: orgId,
                url: imageUrl,
                isPrimary: scrapedData.imageURLs.indexOf(imageUrl) === 0,
                caption: "Kamu kayıtlarından çekilmiş görsel"
              }
            });
          } catch (err) {
            console.error('Error saving image:', err);
          }
        }
      }

      if (scrapedData.ownerName || scrapedData.parcelNumber) {
        await this.client.taxRecord.create({
          data: {
            id: `tax-scraped-${uniqueId}`,
            propertyId: uniqueId,
            orgId: orgId,
            recordType: "PROPERTY_TAX",
            profileData: {
              assessor: "Miami-Dade Property Appraiser",
              parcelNumber: scrapedData.parcelNumber,
              lastAssessedValue: scrapedData.marketValue,
              ownerOfRecord: scrapedData.ownerName,
              taxYear: new Date().getFullYear(),
              status: "ACTIVE"
            }
          }
        });
      }

      await this.client.propertyOwnershipVerification.create({
        data: {
          id: `verif-scraped-${uniqueId}`,
          propertyId: uniqueId,
          orgId: orgId,
          verificationStatus: OwnershipVerificationStatus.PENDING,
          verificationMethod: VerificationMethod.GOVERNMENT_API,
          parcelNumber: scrapedData.parcelNumber,
          jurisdiction: "Miami-Dade County",
          aiConfidenceScore: 85.0,
          ownershipHistory: scrapedData.ownerName ? [{ owner: scrapedData.ownerName, type: "Public Record" }] : []
        }
      });

      console.log(`🎯 Property ready for claim: ${uniqueId}`);
      return property;

    } catch (error) {
      console.error(`Error saving property ${uniqueId}:`, error);
      throw error;
    }
  }

  async scrapeAndSaveProperties(addresses: string[]) {
    await this.init();

    for (const address of addresses) {
      console.log(`\n🔍 Scraping: ${address}`);

      try {
        const propertyData = await this.scrapeMiamiDadeProperty(address);
        
        if (propertyData.address || propertyData.ownerName) {
          const coordinates = await this.geocodeAddress(address);
          console.log(`📍 Geocoded: ${coordinates.lat}, ${coordinates.lng}`);

          const fullData: ScrapedProperty = {
            address: address,
            city: propertyData.city || "Miami",
            state: propertyData.state || "FL",
            zip: propertyData.zip || "33101",
            ownerName: propertyData.ownerName as string | undefined,
            parcelNumber: propertyData.parcelNumber as string | undefined,
            marketValue: propertyData.marketValue as number | undefined,
            imageURLs: propertyData.imageURLs,
            yearBuilt: propertyData.yearBuilt as number | undefined,
            sqft: propertyData.sqft as number | undefined
          };

          await this.savePropertyToSystem(fullData, coordinates);
        }

        await new Promise(resolve => setTimeout(resolve, 3000));

      } catch (error) {
        console.error(`Error processing ${address}:`, error);
      }
    }

    await this.close();
  }
}

async function main() {
  const scraper = new PropertyScraper();

  const testAddresses = [
    "1001 Brickell Ave, Miami, FL 33131",
    "500 Brickell Key Dr, Miami, FL 33131",
    "1200 Brickell Bay Dr, Miami, FL 33131"
  ];

  await scraper.scrapeAndSaveProperties(testAddresses);
}

main().catch(console.error).finally(() => PrismaManager.disconnectAll());
