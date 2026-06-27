import * as fs from 'fs';
const { PDFParse } = require('pdf-parse');

const pdfPath = '/Users/os2026/Downloads/Reservatior/server/data/projects/catalogs/Katalog.pdf';

async function extract() {
  const dataBuffer = fs.readFileSync(pdfPath);
  const uint8Array = new Uint8Array(dataBuffer);
  
  // Instantiate PDFParse
  const parser = new PDFParse(uint8Array);
  
  // Call load to parse the PDF
  const info = await parser.load();
  console.log("--- Total Pages:", info.numPages);
  
  // Extract text
  const textObj = await parser.getText();
  // textObj pages array contains pages
  let fullText = "";
  for (const page of textObj.pages) {
    fullText += `--- Page ${page.pageNumber || (page as any).num} ---\n` + page.text + '\n';
  }
  
  fs.writeFileSync('/Users/os2026/Downloads/Reservatior/server/data/projects/catalogs/Katalog.txt', fullText);
  console.log("--- Saved extracted text to Katalog.txt");
  
  // Print preview
  console.log("\n--- Sample Text Preview ---\n", fullText.substring(0, 4000));
}

extract().catch(console.error);
