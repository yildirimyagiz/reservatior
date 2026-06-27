import puppeteer, { Page } from 'puppeteer';
import { Phi3Service } from './phi3';
import * as fs from 'fs';
import * as path from 'path';

export class NeuralImporterService {
  private platformSelectors = {
    'sahibinden.com': {
      title: 'h1[class*="classifiedTitle"]',
      price: '.classifiedInfo .price',
      description: '.classifiedDescriptionContent',
      images: '.swiper-slide img',
      bedrooms: '.classifiedInfoItem:contains("Oda Sayısı")',
      bathrooms: '.classifiedInfoItem:contains("Banyo Sayısı")',
      area: '.classifiedInfoItem:contains("m²")',
      location: '.classifiedInfo .location'
    },
    'hurriyetemlak.com': {
      title: 'h1',
      price: '.price-container',
      description: '.description-text',
      images: '.gallery-item img',
      bedrooms: '.spec-item:contains("Oda")',
      bathrooms: '.spec-item:contains("Banyo")',
      area: '.spec-item:contains("m²")',
      location: '.location-text'
    },
    'zillow.com': {
      title: 'h1',
      price: '.price-container',
      description: '.ds-description-section',
      images: '.media-stream-photo img',
      bedrooms: '.ds-bed-bath-beds',
      bathrooms: '.ds-bed-bath-baths',
      area: '.ds-bed-bath-area',
      location: '.ds-address-row'
    },
    'redfin.com': {
      title: '.home-title-row h1',
      price: '.price-section',
      description: '.description-section',
      images: '.media-carousel img',
      bedrooms: '.stats-item:contains("bed")',
      bathrooms: '.stats-item:contains("bath")',
      area: '.stats-item:contains("sqft")',
      location: '.address-title'
    },
    'drive.google.com': {
      files: '.WYuW0e[data-target="doc"] .KL4NAf',
      fileNames: '.KL4NAf .aKR2Gc',
      fileLinks: '.WYuW0e[data-target="doc"] a'
    }
  };

  private detectPlatform(url: string): string {
    for (const platform of Object.keys(this.platformSelectors)) {
      if (url.includes(platform)) return platform;
    }
    return 'generic';
  }

  async downloadDriveFolderContents(folderUrl: string, downloadDir: string = path.join(process.cwd(), 'ml-services', 'downloads')) {
    console.log(`[NEURAL-IMPORT] Downloading Google Drive folder contents to: ${downloadDir}`);
    
    // First scan the folder to get file links
    const scanResult = await this.importFromDriveFolder(folderUrl);
    if (!scanResult.success || !scanResult.data.propertyFiles.length) {
      return scanResult;
    }

    // Create download directory if it doesn't exist
    if (!fs.existsSync(downloadDir)) {
      fs.mkdirSync(downloadDir, { recursive: true });
    }

    const downloadedFiles = [];
    const failedDownloads = [];

    for (const file of scanResult.data.propertyFiles) {
      try {
        console.log(`[NEURAL-IMPORT] Downloading: ${file.name}`);
        
        const downloadResult = await this.downloadFileFromDrive(file.url, downloadDir, file.name);
        
        if (downloadResult.success) {
          downloadedFiles.push({
            ...file,
            localPath: downloadResult.localPath,
            size: downloadResult.size
          });
        } else {
          failedDownloads.push({
            ...file,
            error: downloadResult.error
          });
        }
      } catch (e) {
        console.error(`[NEURAL-IMPORT] Failed to download ${file.name}:`, e);
        failedDownloads.push({
          ...file,
          error: e instanceof Error ? e.message : String(e)
        });
      }
    }

    console.log(`[NEURAL-IMPORT] Downloaded ${downloadedFiles.length} files, ${failedDownloads.length} failed`);

    return {
      success: true,
      data: {
        ...scanResult.data,
        downloadedFiles,
        failedDownloads,
        downloadDir,
        summary: {
          total: scanResult.data.propertyFiles.length,
          downloaded: downloadedFiles.length,
          failed: failedDownloads.length
        }
      },
      platform: 'drive.google.com',
      confidence: 90,
      msg: `Downloaded ${downloadedFiles.length} of ${scanResult.data.propertyFiles.length} property files to ${downloadDir}`
    };
  }

  private async downloadFileFromDrive(fileUrl: string, downloadDir: string, fileName: string) {
    try {
      // Extract file ID from Google Drive URL
      const fileIdMatch = fileUrl.match(/\/file\/d\/([a-zA-Z0-9_-]+)/);
      if (!fileIdMatch) {
        return {
          success: false,
          error: 'Invalid Google Drive URL format'
        };
      }

      const fileId = fileIdMatch[1];
      const fileExt = fileName.split('.').pop()?.toLowerCase();
      
      // Use Google Drive export URLs for different file types
      let exportUrl: string;
      if (fileExt === 'pdf') {
        exportUrl = `https://drive.google.com/uc?export=download&id=${fileId}`;
      } else if (['doc', 'docx'].includes(fileExt || '')) {
        exportUrl = `https://docs.google.com/document/d/${fileId}/export?format=pdf`;
      } else if (['jpg', 'jpeg', 'png'].includes(fileExt || '')) {
        exportUrl = `https://drive.google.com/uc?export=download&id=${fileId}`;
      } else {
        exportUrl = `https://drive.google.com/uc?export=download&id=${fileId}`;
      }

      console.log(`[NEURAL-IMPORT] Downloading from: ${exportUrl}`);

      // Use fetch to download the file
      const response = await fetch(exportUrl, {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
        }
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}: ${response.statusText}`);
      }

      const buffer = await response.arrayBuffer();
      const localPath = path.join(downloadDir, fileName);
      
      fs.writeFileSync(localPath, Buffer.from(buffer));
      
      const stats = fs.statSync(localPath);
      
      return {
        success: true,
        localPath,
        size: stats.size
      };

    } catch (e) {
      return {
        success: false,
        error: e instanceof Error ? e.message : String(e)
      };
    }
  }

  async importFromDriveFolder(folderUrl: string) {
    console.log(`[NEURAL-IMPORT] Scraping Google Drive folder: ${folderUrl}`);
    
    const browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-web-security']
    });

    try {
      const page = await browser.newPage();
      
      // Set realistic user agent and viewport
      await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
      await page.setViewport({ width: 1920, height: 1080 });
      
      await page.goto(folderUrl, { waitUntil: 'networkidle2', timeout: 45000 });

      // Extract file links from Drive folder
      const fileData = await page.evaluate((): {
        folderName: string;
        totalFiles: number;
        propertyFiles: Array<{ name: string; url: string; type?: string }>;
        timestamp: string;
      } => {
        const files = document.querySelectorAll('.WYuW0e[data-target="doc"]');
        const fileList: Array<{ name: string; url: string; type?: string }> = [];

        files.forEach(file => {
          const link = file.querySelector('a');
          const name = file.querySelector('.KL4NAf .aKR2Gc');
          
          if (link && name) {
            const href = link.href;
            const fileName = name.textContent?.trim() || '';
            
            // Filter for property-related files (PDF, DOC, images, etc.)
            if (fileName && (
              fileName.toLowerCase().includes('proje') ||
              fileName.toLowerCase().includes('emlak') ||
              fileName.toLowerCase().includes('property') ||
              fileName.toLowerCase().includes('satılık') ||
              /\.(pdf|doc|docx|jpg|jpeg|png)$/i.test(fileName)
            )) {
              fileList.push({
                name: fileName,
                url: href,
                type: fileName.split('.').pop()?.toLowerCase()
              });
            }
          }
        });

        return {
          folderName: document.title || 'Unknown Folder',
          totalFiles: fileList.length,
          propertyFiles: fileList,
          timestamp: new Date().toISOString()
        };
      });

      await browser.close();
      
      console.log(`[NEURAL-IMPORT] Found ${fileData.propertyFiles.length} property-related files`);
      
      return {
        success: true,
        data: fileData,
        platform: 'drive.google.com',
        confidence: 95,
        msg: `Successfully scanned Google Drive folder with ${fileData.propertyFiles.length} property files`
      };

    } catch (e) {
      await browser.close();
      console.error("[NEURAL-IMPORT] Drive Folder Scraping Error:", e);
      throw e;
    }
  }

  async importFromUrl(url: string) {
    console.log(`[NEURAL-IMPORT] Initiating harvest for: ${url}`);
    const platform = this.detectPlatform(url);
    const selectors = this.platformSelectors[platform as keyof typeof this.platformSelectors];

    const browser = await puppeteer.launch({
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-web-security']
    });

    try {
      const page = await browser.newPage();
      
      // Set realistic user agent and viewport
      await page.setUserAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
      await page.setViewport({ width: 1920, height: 1080 });
      
      // Handle authentication for platforms that require login
      if (platform === 'sahibinden.com' || platform === 'hurriyetemlak.com') {
        await this.handleAuthentication(page, platform);
      }
      
      await page.goto(url, { waitUntil: 'networkidle2', timeout: 45000 });

      // Extract structured data using platform-specific selectors
      const extractedData = await page.evaluate((sel: any) => {
        const extractText = (selector?: string) => {
          if (!selector) return '';
          const el = document.querySelector(selector);
          return el ? el.textContent?.trim() || '' : '';
        };

        const extractImages = (selector?: string) => {
          if (!selector) return [];
          const images = document.querySelectorAll(selector);
          return Array.from(images).map((img: any) => img.src || img.getAttribute('data-src')).filter(Boolean);
        };

        return {
          title: extractText(sel.title),
          price: extractText(sel.price),
          description: extractText(sel.description),
          images: extractImages(sel.images),
          bedrooms: extractText(sel.bedrooms),
          bathrooms: extractText(sel.bathrooms),
          area: extractText(sel.area),
          location: extractText(sel.location),
          platform: window.location.hostname,
          url: window.location.href,
          timestamp: new Date().toISOString()
        };
      }, selectors);

      await browser.close();

      // Use Phi-3 to clean and structure the data
      const cleanedData = await this.cleanWithAI(extractedData);
      
      return {
        success: true,
        data: cleanedData,
        platform,
        confidence: this.calculateConfidence(cleanedData),
        msg: `Successfully imported from ${platform}`
      };

    } catch (e) {
      await browser.close();
      console.error("[NEURAL-IMPORT] Critical Failure:", e);
      throw e;
    }
  }

  private async handleAuthentication(page: Page, platform: string) {
    // For demo purposes - in production, you'd handle OAuth or credential injection
    console.log(`[NEURAL-IMPORT] Handling authentication for ${platform}`);
    // Add platform-specific login logic here
  }

  private async cleanWithAI(rawData: any): Promise<any> {
    const prompt = `Clean and structure this property listing data into a standardized JSON format.
    
    Input: ${JSON.stringify(rawData)}
    
    Output format:
    {
      "title": "Clean property title",
      "price": {"amount": 123456, "currency": "USD", "period": "monthly"},
      "property": {
        "bedrooms": 2,
        "bathrooms": 1,
        "area": {"value": 120, "unit": "sqft"},
        "type": "apartment",
        "description": "Clean description"
      },
      "location": {
        "address": "Full address",
        "city": "City",
        "country": "Country"
      },
      "media": {
        "images": ["url1", "url2"],
        "count": 2
      },
      "source": {
        "platform": "original_platform",
        "url": "original_url",
        "scraped_at": "timestamp"
      }
    }
    
    JSON:`;

    const structuredDataStr = await Phi3Service.generateResponse(prompt);
    
    try {
      const jsonMatch = structuredDataStr.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        return JSON.parse(jsonMatch[0]);
      }
      throw new Error("Could not parse JSON from AI response");
    } catch (e) {
      console.error("[NEURAL-IMPORT] AI Structure Error:", structuredDataStr);
      return {
        ...rawData,
        error: true,
        msg: "AI could not structure data perfectly, manual review required."
      };
    }
  }

  private calculateConfidence(data: any): number {
    let score = 0;
    const maxScore = 10;
    
    if (data.title?.length > 10) score += 2;
    if (data.price?.amount) score += 2;
    if (data.property?.bedrooms) score += 1;
    if (data.property?.bathrooms) score += 1;
    if (data.property?.area?.value) score += 1;
    if (data.location?.address) score += 2;
    if (data.media?.images?.length > 0) score += 1;
    
    return Math.round((score / maxScore) * 100);
  }
}

export const neuralImporterService = new NeuralImporterService();
