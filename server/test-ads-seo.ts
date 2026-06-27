import { prisma } from "./src/lib/prisma";
import { AIAdsSEOEngine } from "./src/services/ai/ai-ads-seo-engine";

async function run() {
  const property = await prisma.property.findFirst();
  if (!property) {
    console.log("No property found in DB to test with.");
    return;
  }
  
  console.log("Testing Property:", property.name, "ID:", property.id);
  console.log("\n--- GOOGLE ADS ---");
  const ads = await AIAdsSEOEngine.generateGoogleAds(property.id);
  console.log(JSON.stringify(ads, null, 2));
  
  console.log("\n--- SEO CONTENT ---");
  const seo = await AIAdsSEOEngine.generateSEOContent(property.id);
  console.log(JSON.stringify(seo, null, 2));
}

run().catch(console.error).finally(() => process.exit(0));
