import axios from 'axios';
import * as cheerio from 'cheerio';
import { IAgentProvider, NormalizedAgentLead, FetchAgentsOptions } from './types';

export class NWMLSAgentProvider implements IAgentProvider {
  readonly providerName = 'NWMLS';
  
  private defaultUrl = "https://www.nwmls.com/what-is-the-mls/broker-search-results/?search=broker&search-type=broker&firstName=&lastName=&address=&city=&state=WA&county=Adams&zipcode=&rand=302204852";

  async fetchAgents(options?: FetchAgentsOptions): Promise<NormalizedAgentLead[]> {
    const agents: NormalizedAgentLead[] = [];
    const maxPages = options?.limit || 3;
    const baseUrl = options?.url || this.defaultUrl;

    for (let i = 1; i <= maxPages; i++) {
      console.log(`[${this.providerName}] Fetching page ${i}...`);
      const urlToFetch = i === 1 ? baseUrl : `${baseUrl}&cpage=${i}`;
      
      try {
        const { data } = await axios.get(urlToFetch);
        const $ = cheerio.load(data);
        
        let foundOnPage = 0;
        
        $('.broker-wrapper').each((_, el) => {
          const name = $(el).find('.personal-details .name').text().trim();
          const phone = $(el).find('.personal-details a[href^="tel:"]').text().trim();
          const officeName = $(el).find('.broker-office a p').text().trim();
          
          const addressLines: string[] = [];
          $(el).find('.broker-office p').each((_, p) => {
            const pText = $(p).text().trim();
            if (pText !== officeName) {
               addressLines.push(pText);
            }
          });
          const address = addressLines.join(', ');
          
          let website = $(el).find('.broker-links a.website').attr('href');
          if (website && website.startsWith('http://') && website.includes('@')) {
            website = undefined;
          }
          
          let photoUrl = $(el).find('.thumb-wrapper').attr('style');
          if (photoUrl) {
             const match = photoUrl.match(/url\((.*?)\)/);
             if (match && match[1]) {
                 photoUrl = match[1].replace(/['"]/g, '');
                 if (!photoUrl.startsWith('http')) {
                     photoUrl = `https://www.nwmls.com${photoUrl}`;
                 }
             } else {
                 photoUrl = undefined;
             }
          }

          if (name) {
            agents.push({
              name,
              phoneNumber: phone || undefined,
              address: officeName ? `${officeName} - ${address}` : address,
              website: website && website !== 'http://' ? website : undefined,
              logoUrl: photoUrl && photoUrl !== 'none' && !photoUrl.includes('placeholder') ? photoUrl : undefined,
              status: 'PENDING'
            });
            foundOnPage++;
          }
        });
        
        console.log(`[${this.providerName}] Found ${foundOnPage} agents on page ${i}.`);
        if (foundOnPage === 0) break; // End of pagination

      } catch (error: any) {
        console.error(`[${this.providerName}] Error fetching page ${i}:`, error.message);
        break; // Stop fetching on error
      }
    }
    
    return agents;
  }
}
