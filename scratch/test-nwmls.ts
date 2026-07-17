import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';

puppeteer.use(StealthPlugin());

async function main() {
  const browser = await puppeteer.launch({ headless: true });
  const page = await browser.newPage();
  
  page.on('response', async (response) => {
    const url = response.url();
    if (url.includes('api') || url.includes('json') || url.includes('listing')) {
      console.log('Intercepted:', url);
    }
  });

  await page.goto('https://www.nwmls.com/what-is-the-mls/listing-search/#/listing/2232728', { waitUntil: 'networkidle2' });
  
  const content = await page.evaluate(() => document.body.innerText);
  console.log("Body snippet:", content.substring(0, 500));
  
  await browser.close();
}
main();
