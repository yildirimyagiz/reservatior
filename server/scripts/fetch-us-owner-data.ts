import { PrismaClient } from "@prisma/client";
import prismaManager from "../src/lib/prisma";
import * as cheerio from 'cheerio';
import puppeteer from 'puppeteer';

const prisma = prismaManager.getClient("US");

// County Assessor API endpoints and configurations
const COUNTY_APIS: Record<string, { url: string; hasApi: boolean; requiresAuth: boolean; searchEndpoint?: string }> = {
  "King County": { url: "https://blue.kingcounty.gov/Assessor/eRealProperty/Detail.aspx", hasApi: true, requiresAuth: false, searchEndpoint: "https://blue.kingcounty.gov/Assessor/eRealProperty/Search.aspx" },
  "Cook County": { url: "https://www.cookcountypropertyinfo.com/PropertySearch/PropertySearch", hasApi: true, requiresAuth: false },
  "Miami-Dade": { url: "https://www.miamidade.gov/PropertyTax/Pages/PropertyTaxSearch.aspx", hasApi: true, requiresAuth: false },
  "Los Angeles": { url: "https://assessor.lacounty.gov", hasApi: false, requiresAuth: false },
  "New York": { url: "https://a836-acris.nyc.gov/DS/DocumentSearch/DocumentSearch", hasApi: false, requiresAuth: false },
};

interface OwnerData {
  ownerName: string;
  mailingAddress?: string;
  mailingCity?: string;
  mailingState?: string;
  mailingZip?: string;
  phone?: string;
  email?: string;
  isCompany: boolean;
}

async function fetchOwnerFromCounty(address: string, city: string, state: string): Promise<OwnerData | null> {
  console.log(`🔍 Fetching owner data for: ${address}, ${city}, ${state}`);
  
  // Determine county based on city/state
  const countyInfo = getCountyForCity(city, state);
  
  console.log(`📍 County detected: ${countyInfo?.name || 'None'}, hasApi: ${countyInfo?.hasApi || false}`);
  
  if (countyInfo && countyInfo.hasApi) {
    try {
      console.log(`📡 Attempting real API call to ${countyInfo.name}...`);
      // Attempt real API call for counties with APIs
      const realData = await fetchFromCountyAPI(address, city, state, countyInfo);
      if (realData) {
        console.log(`✅ Real data retrieved from ${countyInfo.name}`);
        return realData;
      } else {
        console.log(`⚠️ API returned null, no data available`);
        return null; // Don't add fake data
      }
    } catch (error) {
      console.log(`⚠️ API call failed for ${countyInfo.name}:`, error);
      return null; // Don't add fake data
    }
  } else {
    console.log(`⚠️ No API available for ${countyInfo?.name || 'unknown county'}, skipping`);
    return null; // Don't add fake data
  }
  
  // NO MOCK DATA - only add real data or skip
  return null;
}

function getCountyForCity(city: string, state: string): { name: string; hasApi: boolean; requiresAuth: boolean } | null {
  const cityLower = city.toLowerCase();
  const stateLower = state.toLowerCase();
  
  console.log(`🔍 County detection: city="${cityLower}", state="${stateLower}"`);
  
  // Map cities to counties - handle both abbreviations and full state names
  if ((stateLower === "wa" || stateLower === "washington") && (cityLower.includes("seattle") || cityLower.includes("bellevue") || cityLower.includes("kirkland"))) {
    return { name: "King County", hasApi: true, requiresAuth: false };
  }
  if ((stateLower === "az" || stateLower === "arizona") && (cityLower.includes("phoenix") || cityLower.includes("scottsdale") || cityLower.includes("mesa"))) {
    return { name: "Maricopa County", hasApi: true, requiresAuth: false }; // FREE working assessor website
  }
  if ((stateLower === "fl" || stateLower === "florida") && (cityLower.includes("miami") || cityLower.includes("fort lauderdale"))) {
    return { name: "Miami-Dade", hasApi: true, requiresAuth: false };
  }
  if ((stateLower === "il" || stateLower === "illinois") && (cityLower.includes("chicago") || cityLower.includes("evanston"))) {
    return { name: "Cook County", hasApi: true, requiresAuth: false };
  }
  if ((stateLower === "co" || stateLower === "colorado") && (cityLower.includes("fort collins") || cityLower.includes("loveland") || cityLower.includes("larimer"))) {
    return { name: "Larimer County", hasApi: true, requiresAuth: false }; // Free working assessor website
  }
  if ((stateLower === "co" || stateLower === "colorado") && (cityLower.includes("denver") || cityLower.includes("aurora") || cityLower.includes("lakewood"))) {
    return { name: "Denver County", hasApi: false, requiresAuth: false }; // Denver URLs not working
  }
  if ((stateLower === "ca" || stateLower === "california") && (cityLower.includes("los angeles") || cityLower.includes("la"))) {
    return { name: "Los Angeles", hasApi: false, requiresAuth: false };
  }
  if ((stateLower === "ny" || stateLower === "new york") && (cityLower.includes("new york") || cityLower.includes("manhattan") || cityLower.includes("brooklyn"))) {
    return { name: "New York", hasApi: false, requiresAuth: false };
  }
  
  return null;
}

async function fetchFromCountyAPI(address: string, city: string, state: string, countyInfo: any): Promise<OwnerData | null> {
  console.log(`📡 Attempting real data fetch from ${countyInfo.name}...`);
  
  try {
    if (countyInfo.name === "King County") {
      return await fetchKingCountyOwnerData(address, city);
    }
    
    if (countyInfo.name === "Maricopa County") {
      return await fetchMaricopaCountyOwnerData(address, city);
    }
    
    if (countyInfo.name === "Cook County") {
      return await fetchCookCountyOwnerData(address, city);
    }
    
    if (countyInfo.name === "Miami-Dade") {
      return await fetchMiamiDadeOwnerData(address, city);
    }
    
    if (countyInfo.name === "Larimer County") {
      return await fetchLarimerCountyOwnerData(address, city);
    }
    
    if (countyInfo.name === "Denver County") {
      return await fetchDenverCountyOwnerData(address, city);
    }
    
    console.log(`❌ No real API implementation for ${countyInfo.name}`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error fetching from ${countyInfo.name}:`, error);
    return null;
  }
}

async function fetchKingCountyOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping King County (Seattle) property records...`);
  
  try {
    // King County Assessor eRealProperty Search
    const searchUrl = "https://blue.kingcounty.gov/Assessor/eRealProperty/Search.aspx";
    
    // First, get the search page to extract form data
    const searchPage = await fetch(searchUrl, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      }
    });
    
    if (!searchPage.ok) {
      console.log(`❌ Failed to load King County search page`);
      return null;
    }
    
    const searchHtml = await searchPage.text();
    const $ = cheerio.load(searchHtml);
    
    // Extract form fields (ViewState, etc.)
    const viewState = $('#__VIEWSTATE').val() || '';
    const viewStateGenerator = $('#__VIEWSTATEGENERATOR').val() || '';
    const eventValidation = $('#__EVENTVALIDATION').val() || '';
    
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Submit search form with address
    const formData = new URLSearchParams();
    formData.append('__VIEWSTATE', viewState as string);
    formData.append('__VIEWSTATEGENERATOR', viewStateGenerator as string);
    formData.append('__EVENTVALIDATION', eventValidation as string);
    formData.append('ctl00$MainContent$Address', address);
    formData.append('ctl00$MainContent$City', city);
    formData.append('ctl00$MainContent$SearchType', 'Address');
    formData.append('ctl00$MainContent$btnSearch', 'Search');
    
    const submitResponse = await fetch(searchUrl, {
      method: 'POST',
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      },
      body: formData
    });
    
    if (!submitResponse.ok) {
      console.log(`❌ Failed to submit search form`);
      return null;
    }
    
    const resultsHtml = await submitResponse.text();
    const $results = cheerio.load(resultsHtml);
    
    // Try to find property results
    const propertyLinks = $results('a[href*="Detail.aspx"]');
    
    if (propertyLinks.length > 0) {
      console.log(`✅ Found ${propertyLinks.length} property results`);
      
      // Get first property detail
      const firstPropertyUrl = propertyLinks.first().attr('href');
      if (firstPropertyUrl) {
        const detailUrl = firstPropertyUrl.startsWith('http') 
          ? firstPropertyUrl 
          : `https://blue.kingcounty.gov${firstPropertyUrl}`;
        
        // Fetch property detail page
        const detailResponse = await fetch(detailUrl, {
          headers: {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
          }
        });
        
        if (detailResponse.ok) {
          const detailHtml = await detailResponse.text();
          const $detail = cheerio.load(detailHtml);
          
          // Extract owner information from detail page
          // King County detail page structure - need to identify actual selectors
          const ownerName = $detail('td:contains("Owner")').next().text().trim() ||
                           $detail('[id*="Owner"]').text().trim() ||
                           $detail('.owner-name').text().trim();
          
          const mailingAddress = $detail('td:contains("Mailing")').next().text().trim() ||
                                $detail('[id*="Mailing"]').text().trim();
          
          if (ownerName) {
            console.log(`✅ Found real owner data: ${ownerName}`);
            
            return {
              ownerName: ownerName,
              mailingAddress: mailingAddress || undefined,
              mailingCity: city,
              mailingState: 'WA',
              isCompany: ownerName.toLowerCase().includes('llc') || 
                        ownerName.toLowerCase().includes('inc') ||
                        ownerName.toLowerCase().includes('trust')
            };
          }
        }
      }
    }
    
    console.log(`⚠️ No owner data found in results`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error scraping King County:`, error);
    return null;
  }
}

async function fetchCookCountyOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping Cook County (Chicago) property records...`);
  
  try {
    // Cook County Property Tax Portal
    const searchUrl = "https://www.cookcountypropertyinfo.com/PropertySearch/PropertySearch";
    
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Fetch search page
    const searchPage = await fetch(searchUrl, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      }
    });
    
    if (!searchPage.ok) {
      console.log(`❌ Failed to load Cook County search page`);
      return null;
    }
    
    const searchHtml = await searchPage.text();
    const $ = cheerio.load(searchHtml);
    
    // Extract form fields
    const viewState = $('#__VIEWSTATE').val() || '';
    const viewStateGenerator = $('#__VIEWSTATEGENERATOR').val() || '';
    const eventValidation = $('#__EVENTVALIDATION').val() || '';
    
    // Submit search form
    const formData = new URLSearchParams();
    formData.append('__VIEWSTATE', viewState as string);
    formData.append('__VIEWSTATEGENERATOR', viewStateGenerator as string);
    formData.append('__EVENTVALIDATION', eventValidation as string);
    formData.append('ctl00$MainContent$txtAddress', address);
    formData.append('ctl00$MainContent$txtCity', city);
    formData.append('ctl00$MainContent$btnSearch', 'Search');
    
    const submitResponse = await fetch(searchUrl, {
      method: 'POST',
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      },
      body: formData
    });
    
    if (!submitResponse.ok) {
      console.log(`❌ Failed to submit Cook County search form`);
      return null;
    }
    
    const resultsHtml = await submitResponse.text();
    const $results = cheerio.load(resultsHtml);
    
    // Try to find property results
    const propertyRows = $results('table tr').has('td');
    
    if (propertyRows.length > 0) {
      console.log(`✅ Found ${propertyRows.length} property results`);
      
      // Try to extract owner information from results
      const firstRow = propertyRows.first();
      const ownerName = firstRow.find('td').eq(2).text().trim() || // Usually owner is in 3rd column
                       firstRow.find('td:contains("Owner")').next().text().trim();
      
      if (ownerName) {
        console.log(`✅ Found real owner data: ${ownerName}`);
        
        return {
          ownerName: ownerName,
          mailingCity: city,
          mailingState: 'IL',
          isCompany: ownerName.toLowerCase().includes('llc') || 
                    ownerName.toLowerCase().includes('inc') ||
                    ownerName.toLowerCase().includes('trust')
        };
      }
    }
    
    console.log(`⚠️ No owner data found in Cook County results`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error scraping Cook County:`, error);
    return null;
  }
}

async function fetchMiamiDadeOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping Miami-Dade property records...`);
  
  try {
    // Miami-Dade Property Search
    const searchUrl = "https://www.miamidade.gov/PropertyTax/Pages/PropertyTaxSearch.aspx";
    
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Fetch search page
    const searchPage = await fetch(searchUrl, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      }
    });
    
    if (!searchPage.ok) {
      console.log(`❌ Failed to load Miami-Dade search page`);
      return null;
    }
    
    const searchHtml = await searchPage.text();
    const $ = cheerio.load(searchHtml);
    
    // Extract form fields
    const viewState = $('#__VIEWSTATE').val() || '';
    const viewStateGenerator = $('#__VIEWSTATEGENERATOR').val() || '';
    const eventValidation = $('#__EVENTVALIDATION').val() || '';
    
    // Submit search form
    const formData = new URLSearchParams();
    formData.append('__VIEWSTATE', viewState as string);
    formData.append('__VIEWSTATEGENERATOR', viewStateGenerator as string);
    formData.append('__EVENTVALIDATION', eventValidation as string);
    formData.append('ctl00$PlaceHolderMain$txtAddress', address);
    formData.append('ctl00$PlaceHolderMain$txtCity', city);
    formData.append('ctl00$PlaceHolderMain$btnSearch', 'Search');
    
    const submitResponse = await fetch(searchUrl, {
      method: 'POST',
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
      },
      body: formData
    });
    
    if (!submitResponse.ok) {
      console.log(`❌ Failed to submit Miami-Dade search form`);
      return null;
    }
    
    const resultsHtml = await submitResponse.text();
    const $results = cheerio.load(resultsHtml);
    
    // Try to find property results
    const propertyRows = $results('table tr').has('td');
    
    if (propertyRows.length > 0) {
      console.log(`✅ Found ${propertyRows.length} property results`);
      
      // Try to extract owner information from results
      const firstRow = propertyRows.first();
      const ownerName = firstRow.find('td').eq(1).text().trim() || // Usually owner is in 2nd column
                       firstRow.find('td:contains("Owner")').next().text().trim();
      
      if (ownerName) {
        console.log(`✅ Found real owner data: ${ownerName}`);
        
        return {
          ownerName: ownerName,
          mailingCity: city,
          mailingState: 'FL',
          isCompany: ownerName.toLowerCase().includes('llc') || 
                    ownerName.toLowerCase().includes('inc') ||
                    ownerName.toLowerCase().includes('trust')
        };
      }
    }
    
    console.log(`⚠️ No owner data found in Miami-Dade results`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error scraping Miami-Dade:`, error);
    return null;
  }
}

async function fetchMaricopaCountyOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping Maricopa County (FREE) tax records with Puppeteer...`);
  console.log(`📍 Address: ${address}, ${city}`);
  
  let browser = null;
  try {
    console.log(`🚀 Launching Puppeteer browser...`);
    browser = await puppeteer.launch({ 
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();
    
    // Set user agent to avoid detection
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
    
    // Navigate to Maricopa County Assessor (FREE working website)
    console.log(`🌐 Navigating to Maricopa County Assessor (FREE)...`);
    const response = await page.goto('https://mcassessor.maricopa.gov/', {
      waitUntil: 'networkidle2',
      timeout: 30000
    });
    
    console.log(`📄 Page status: ${response?.status()}, OK: ${response?.ok()}`);
    
    if (!response?.ok()) {
      console.log(`❌ Failed to load Maricopa County page`);
      await browser.close();
      return null;
    }
    
    // Wait for page to load
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Get page title to verify we loaded the right page
    const pageTitle = await page.title();
    console.log(`📋 Page title: ${pageTitle}`);
    
    // Try to find address input field and fill it
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Try different possible selectors for address input
    const addressSelectors = [
      'input[name*="address"]',
      'input[id*="address"]',
      'input[type="text"]',
      '#address',
      '#Address',
      '.address-input',
      'input[placeholder*="address"]'
    ];
    
    let addressInput = null;
    for (const selector of addressSelectors) {
      try {
        addressInput = await page.$(selector);
        if (addressInput) {
          console.log(`✅ Found address input with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (!addressInput) {
      console.log(`❌ Could not find address input field`);
      await browser.close();
      return null;
    }
    
    // Fill address
    await addressInput.type(address);
    await new Promise(resolve => setTimeout(resolve, 500));
    
    // Try to find and click search button
    const searchButtonSelectors = [
      'button[type="submit"]',
      'input[type="submit"]',
      'button:contains("Search")',
      '#search',
      '#Search',
      '.search-button',
      'button:contains("Submit")'
    ];
    
    let searchButton = null;
    for (const selector of searchButtonSelectors) {
      try {
        searchButton = await page.$(selector);
        if (searchButton) {
          console.log(`✅ Found search button with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (searchButton) {
      await searchButton.click();
    } else {
      // Try pressing Enter
      await page.keyboard.press('Enter');
    }
    
    // Wait for results
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // Get page content and try to extract owner information
    const pageContent = await page.content();
    const $ = cheerio.load(pageContent);
    
    // Try to find owner information in various formats
    const ownerSelectors = [
      '.owner-name',
      '[class*="owner"]',
      'td:contains("Owner")',
      'th:contains("Owner")',
      '[data-owner]',
      '.property-owner'
    ];
    
    let ownerName = null;
    for (const selector of ownerSelectors) {
      try {
        const element = $(selector);
        if (element.length > 0) {
          ownerName = element.first().text().trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with selector ${selector}: ${ownerName}`);
            break;
          }
        }
      } catch (e) {
        continue;
      }
    }
    
    // If no specific owner found, try to extract from page text
    if (!ownerName) {
      const pageText = $('body').text();
      
      // Look for patterns like "Owner: John Smith" or "Property Owner: John Smith"
      const ownerPatterns = [
        /Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Property Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Owner Name:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi
      ];
      
      for (const pattern of ownerPatterns) {
        const match = pageText.match(pattern);
        if (match) {
          ownerName = match[0].replace(/Owner:?\s*/gi, '').trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with pattern: ${ownerName}`);
            break;
          }
        }
      }
    }
    
    await browser.close();
    
    if (ownerName && ownerName.length > 2) {
      console.log(`✅ REAL DATA FOUND from Maricopa County: ${ownerName}`);
      
      return {
        ownerName: ownerName,
        mailingAddress: address,
        mailingCity: city,
        mailingState: 'AZ',
        isCompany: ownerName.toLowerCase().includes('llc') || 
                  ownerName.toLowerCase().includes('inc') ||
                  ownerName.toLowerCase().includes('trust') ||
                  ownerName.toLowerCase().includes('corp') ||
                  ownerName.toLowerCase().includes('company')
      };
    }
    
    console.log(`⚠️ No owner data found on Maricopa County page`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error with Maricopa County scraping:`, error);
    if (browser) {
      await browser.close();
    }
    return null;
  }
}

async function fetchLarimerCountyOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping Larimer County (FREE) tax records with Puppeteer...`);
  console.log(`📍 Address: ${address}, ${city}`);
  
  let browser = null;
  try {
    console.log(`🚀 Launching Puppeteer browser...`);
    browser = await puppeteer.launch({ 
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();
    
    // Set user agent to avoid detection
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
    
    // Navigate to Larimer County Assessor (FREE working website)
    console.log(`🌐 Navigating to Larimer County Assessor (FREE)...`);
    const response = await page.goto('https://www.larimer.gov/assessor/search', {
      waitUntil: 'networkidle2',
      timeout: 30000
    });
    
    console.log(`📄 Page status: ${response?.status()}, OK: ${response?.ok()}`);
    
    if (!response?.ok()) {
      console.log(`❌ Failed to load Larimer County page`);
      await browser.close();
      return null;
    }
    
    // Wait for page to load
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Get page title to verify we loaded the right page
    const pageTitle = await page.title();
    console.log(`📋 Page title: ${pageTitle}`);
    
    // Try to find address input field and fill it
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Try different possible selectors for address input
    const addressSelectors = [
      'input[name*="address"]',
      'input[id*="address"]',
      'input[type="text"]',
      '#address',
      '#Address',
      '.address-input',
      'input[placeholder*="address"]'
    ];
    
    let addressInput = null;
    for (const selector of addressSelectors) {
      try {
        addressInput = await page.$(selector);
        if (addressInput) {
          console.log(`✅ Found address input with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (!addressInput) {
      console.log(`❌ Could not find address input field`);
      await browser.close();
      return null;
    }
    
    // Fill address
    await addressInput.type(address);
    await new Promise(resolve => setTimeout(resolve, 500));
    
    // Try to find and click search button
    const searchButtonSelectors = [
      'button[type="submit"]',
      'input[type="submit"]',
      'button:contains("Search")',
      '#search',
      '#Search',
      '.search-button',
      'button:contains("Submit")'
    ];
    
    let searchButton = null;
    for (const selector of searchButtonSelectors) {
      try {
        searchButton = await page.$(selector);
        if (searchButton) {
          console.log(`✅ Found search button with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (searchButton) {
      await searchButton.click();
    } else {
      // Try pressing Enter
      await page.keyboard.press('Enter');
    }
    
    // Wait for results
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // Get page content and try to extract owner information
    const pageContent = await page.content();
    const $ = cheerio.load(pageContent);
    
    // Try to find owner information in various formats
    const ownerSelectors = [
      '.owner-name',
      '[class*="owner"]',
      'td:contains("Owner")',
      'th:contains("Owner")',
      '[data-owner]',
      '.property-owner'
    ];
    
    let ownerName = null;
    for (const selector of ownerSelectors) {
      try {
        const element = $(selector);
        if (element.length > 0) {
          ownerName = element.first().text().trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with selector ${selector}: ${ownerName}`);
            break;
          }
        }
      } catch (e) {
        continue;
      }
    }
    
    // If no specific owner found, try to extract from page text
    if (!ownerName) {
      const pageText = $('body').text();
      
      // Look for patterns like "Owner: John Smith" or "Property Owner: John Smith"
      const ownerPatterns = [
        /Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Property Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Owner Name:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi
      ];
      
      for (const pattern of ownerPatterns) {
        const match = pageText.match(pattern);
        if (match) {
          ownerName = match[0].replace(/Owner:?\s*/gi, '').trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with pattern: ${ownerName}`);
            break;
          }
        }
      }
    }
    
    await browser.close();
    
    if (ownerName && ownerName.length > 2) {
      console.log(`✅ REAL DATA FOUND from Larimer County: ${ownerName}`);
      
      return {
        ownerName: ownerName,
        mailingAddress: address,
        mailingCity: city,
        mailingState: 'CO',
        isCompany: ownerName.toLowerCase().includes('llc') || 
                  ownerName.toLowerCase().includes('inc') ||
                  ownerName.toLowerCase().includes('trust') ||
                  ownerName.toLowerCase().includes('corp') ||
                  ownerName.toLowerCase().includes('company')
      };
    }
    
    console.log(`⚠️ No owner data found on Larimer County page`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error with Larimer County scraping:`, error);
    if (browser) {
      await browser.close();
    }
    return null;
  }
}

async function fetchDenverCountyOwnerData(address: string, city: string): Promise<OwnerData | null> {
  console.log(`🔍 Scraping Denver County tax records with Puppeteer...`);
  console.log(`📍 Address: ${address}, ${city}`);
  
  let browser = null;
  try {
    console.log(`🚀 Launching Puppeteer browser...`);
    browser = await puppeteer.launch({ 
      headless: true,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    });
    const page = await browser.newPage();
    
    // Set user agent to avoid detection
    await page.setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36');
    
    // Try multiple possible Denver County Assessor URLs
    const possibleUrls = [
      'https://www.denvergov.org/Property',
      'https://www.denvergov.org/My-Property',
      'https://denvergov.org/My-Property/Property-Information',
      'https://www.denvergov.org/assessor/property-search',
      'https://www.denvergov.org/property-search',
      'https://assessor.denvergov.org/property-search',
      'https://www.denvergov.org/content/denvergov/en/assessor-property-records/property-search.html'
    ];
    
    let workingUrl = null;
    for (const url of possibleUrls) {
      console.log(`🌐 Trying URL: ${url}`);
      try {
        const response = await page.goto(url, {
          waitUntil: 'networkidle2',
          timeout: 15000
        });
        
        console.log(`📄 Page status: ${response?.status()}, OK: ${response?.ok()}`);
        
        if (response?.ok()) {
          const pageTitle = await page.title();
          console.log(`📋 Page title: ${pageTitle}`);
          workingUrl = url;
          break;
        }
      } catch (e) {
        console.log(`❌ URL failed: ${url}`);
        continue;
      }
    }
    
    if (!workingUrl) {
      console.log(`❌ No working URL found for Denver County Assessor`);
      await browser.close();
      return null;
    }
    
    // Wait for page to load
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Try to find address input field and fill it
    console.log(`🔍 Searching for address: ${address}, ${city}`);
    
    // Try different possible selectors for address input
    const addressSelectors = [
      'input[name*="address"]',
      'input[id*="address"]',
      'input[type="text"]',
      '#address',
      '#Address',
      '.address-input'
    ];
    
    let addressInput = null;
    for (const selector of addressSelectors) {
      try {
        addressInput = await page.$(selector);
        if (addressInput) {
          console.log(`✅ Found address input with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (!addressInput) {
      console.log(`❌ Could not find address input field`);
      await browser.close();
      return null;
    }
    
    // Fill address
    await addressInput.type(address);
    await new Promise(resolve => setTimeout(resolve, 500));
    
    // Try to find and click search button
    const searchButtonSelectors = [
      'button[type="submit"]',
      'input[type="submit"]',
      'button:contains("Search")',
      '#search',
      '#Search',
      '.search-button'
    ];
    
    let searchButton = null;
    for (const selector of searchButtonSelectors) {
      try {
        searchButton = await page.$(selector);
        if (searchButton) {
          console.log(`✅ Found search button with selector: ${selector}`);
          break;
        }
      } catch (e) {
        continue;
      }
    }
    
    if (searchButton) {
      await searchButton.click();
    } else {
      // Try pressing Enter
      await page.keyboard.press('Enter');
    }
    
    // Wait for results
    await new Promise(resolve => setTimeout(resolve, 3000));
    
    // Get page content and try to extract owner information
    const pageContent = await page.content();
    const $ = cheerio.load(pageContent);
    
    // Try to find owner information in various formats
    const ownerSelectors = [
      '.owner-name',
      '[class*="owner"]',
      'td:contains("Owner")',
      'th:contains("Owner")',
      '[data-owner]'
    ];
    
    let ownerName = null;
    for (const selector of ownerSelectors) {
      try {
        const element = $(selector);
        if (element.length > 0) {
          ownerName = element.first().text().trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with selector ${selector}: ${ownerName}`);
            break;
          }
        }
      } catch (e) {
        continue;
      }
    }
    
    // If no specific owner found, try to extract from page text
    if (!ownerName) {
      const pageText = $('body').text();
      
      // Look for patterns like "Owner: John Smith" or "Property Owner: John Smith"
      const ownerPatterns = [
        /Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Property Owner:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi,
        /Owner Name:\s*([A-Z][a-z]+(?:\s+[A-Z][a-z]+)+)/gi
      ];
      
      for (const pattern of ownerPatterns) {
        const match = pageText.match(pattern);
        if (match) {
          ownerName = match[0].replace(/Owner:?\s*/gi, '').trim();
          if (ownerName && ownerName.length > 2) {
            console.log(`✅ Found owner with pattern: ${ownerName}`);
            break;
          }
        }
      }
    }
    
    await browser.close();
    
    if (ownerName && ownerName.length > 2) {
      console.log(`✅ REAL DATA FOUND: ${ownerName}`);
      
      return {
        ownerName: ownerName,
        mailingAddress: address,
        mailingCity: city,
        mailingState: 'CO',
        isCompany: ownerName.toLowerCase().includes('llc') || 
                  ownerName.toLowerCase().includes('inc') ||
                  ownerName.toLowerCase().includes('trust') ||
                  ownerName.toLowerCase().includes('corp') ||
                  ownerName.toLowerCase().includes('company')
      };
    }
    
    console.log(`⚠️ No owner data found on page`);
    return null;
    
  } catch (error) {
    console.error(`❌ Error with Puppeteer scraping:`, error);
    if (browser) {
      await browser.close();
    }
    return null;
  }
}

function generateMockOwnerData(city: string, state: string): OwnerData {
  const lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez"];
  const firstNames = ["John", "Mary", "Robert", "Patricia", "Michael", "Jennifer", "William", "Linda", "David", "Elizabeth"];
  const companySuffixes = ["LLC", "Inc", "Corp", "Holdings", "Trust", "Properties", "Investments"];
  
  const isCompany = Math.random() > 0.7; // 30% chance of being a company
  
  if (isCompany) {
    const companyName = `${lastNames[Math.floor(Math.random() * lastNames.length)]} ${companySuffixes[Math.floor(Math.random() * companySuffixes.length)]}`;
    return {
      ownerName: companyName,
      mailingAddress: `${Math.floor(Math.random() * 9999) + 1} Business Park Blvd`,
      mailingCity: city,
      mailingState: state,
      mailingZip: generateZipCode(state),
      isCompany: true
    };
  } else {
    const firstName = firstNames[Math.floor(Math.random() * firstNames.length)];
    const lastName = lastNames[Math.floor(Math.random() * lastNames.length)];
    return {
      ownerName: `${firstName} ${lastName}`,
      mailingAddress: `${Math.floor(Math.random() * 9999) + 1} ${["Main St", "Oak Ave", "Pine Rd", "Elm Dr", "Maple Ln"][Math.floor(Math.random() * 5)]}`,
      mailingCity: city,
      mailingState: state,
      mailingZip: generateZipCode(state),
      phone: generatePhoneNumber(state),
      email: `${firstName.toLowerCase()}.${lastName.toLowerCase()}@email.com`,
      isCompany: false
    };
  }
}

function generateZipCode(state: string): string {
  const zipRanges: Record<string, { start: number; end: number }> = {
    "WA": { start: 98001, end: 99403 },
    "FL": { start: 32003, end: 34997 },
    "IL": { start: 60001, end: 62999 },
    "CA": { start: 90001, end: 96162 },
    "NY": { start: 10001, end: 14975 },
  };
  
  const range = zipRanges[state] || { start: 10000, end: 99999 };
  return String(Math.floor(Math.random() * (range.end - range.start + 1)) + range.start);
}

function generatePhoneNumber(state: string): string {
  const areaCodes: Record<string, string[]> = {
    "WA": ["206", "253", "425", "509", "360"],
    "FL": ["305", "786", "954", "561", "407", "813"],
    "IL": ["312", "773", "872", "630", "847"],
    "CA": ["213", "310", "323", "415", "510", "619"],
    "NY": ["212", "646", "718", "347", "917"],
  };
  
  const codes = areaCodes[state] || ["555"];
  const areaCode = codes[Math.floor(Math.random() * codes.length)];
  const exchange = Math.floor(Math.random() * 900) + 100;
  const number = Math.floor(Math.random() * 9000) + 1000;
  
  return `${areaCode}-${exchange}-${number}`;
}

async function enrichPropertiesWithOwnerData() {
  console.log("🏢 Starting USA Property Owner Data Enrichment...\n");
  
  // Try Phoenix (Maricopa County) - free working assessor website
  const properties = await prisma.property.findMany({
    where: {
      country: "US",
      city: "Phoenix" // Maricopa County includes Phoenix
    },
    take: 3 // Test with just 3 properties first
  });
  
  console.log(`📊 Found ${properties.length} Phoenix properties to test real scraping\n`);
  
  let enrichedCount = 0;
  let errorCount = 0;
  let companyCount = 0;
  let realDataCount = 0;
  
  for (const property of properties) {
    try {
      console.log(`\n🔍 Testing real scraping for: ${property.name} at ${property.addressLine1}, ${property.city}, ${property.state}`);
      
      const ownerData = await fetchOwnerFromCounty(
        property.addressLine1 || "",
        property.city || "",
        property.state || ""
      );
      
      if (ownerData) {
        // Create contact record
        const contactId = `us_owner_${property.id}`;
        const contact = await prisma.contact.upsert({
          where: { id: contactId },
          update: {
            fullName: ownerData.ownerName,
            email: ownerData.email,
            phone: ownerData.phone,
            type: "OWNER_CONTACT"
          },
          create: {
            id: contactId,
            orgId: property.orgId,
            type: "OWNER_CONTACT",
            fullName: ownerData.ownerName,
            email: ownerData.email,
            phone: ownerData.phone,
            notes: `Property owner for ${property.name} at ${property.addressLine1}, ${property.city}, ${property.state}. ${ownerData.mailingAddress ? `Mailing: ${ownerData.mailingAddress}, ${ownerData.mailingCity}, ${ownerData.mailingState} ${ownerData.mailingZip}` : ''}`
          }
        });
        
        if (ownerData.isCompany) {
          companyCount++;
        }
        
        // Check if this is real data (not from mock generator)
        if (ownerData.mailingAddress && ownerData.mailingAddress.length > 10) {
          realDataCount++;
          console.log(`✅ REAL DATA: ${property.name} - Owner: ${ownerData.ownerName} (${ownerData.isCompany ? 'Company' : 'Individual'})`);
        } else {
          console.log(`⚠️ MOCK DATA: ${property.name} - Owner: ${ownerData.ownerName} (${ownerData.isCompany ? 'Company' : 'Individual'})`);
        }
        
        enrichedCount++;
      }
      
      // Rate limiting to avoid overwhelming county APIs
      await new Promise(resolve => setTimeout(resolve, 2000));
      
    } catch (error) {
      console.error(`❌ Error enriching ${property.name}:`, error);
      errorCount++;
    }
  }
  
  console.log(`\n🎉 Test Complete:`);
  console.log(`   ✅ Successfully enriched: ${enrichedCount}`);
  console.log(`   📊 Real data from scraping: ${realDataCount}`);
  console.log(`   🎭 Mock data (fallback): ${enrichedCount - realDataCount}`);
  console.log(`   🏢 Companies: ${companyCount}`);
  console.log(`   👤 Individuals: ${enrichedCount - companyCount}`);
  console.log(`   ❌ Errors: ${errorCount}`);
}

async function main() {
  await enrichPropertiesWithOwnerData();
}

main()
  .catch(console.error)
  .finally(() => prismaManager.disconnectAll());
