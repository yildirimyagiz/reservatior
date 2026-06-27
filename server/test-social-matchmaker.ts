import { AISocialParser } from "./src/services/ai/ai-social-parser";
import { SmartMatcher } from "./src/services/matchmaking/smart-matcher";

async function run() {
  const testMessages = [
    "Kadıköy Moda'da kiralık 2+1 daire arıyorum, bütçem maksimum 25.000 TL. Yardımcı olabilecek var mı?",
    "Sahibinden satılık Beylikdüzü'nde lüks 3+1, 5.000.000 TL, acil satılık!",
    "Moda'daki kiralık ev tutulmuştur, ilginiz için teşekkürler."
  ];

  for (let i = 0; i < testMessages.length; i++) {
    const msg = testMessages[i];
    console.log(`\n--- TESTING MESSAGE ${i + 1} ---`);
    console.log(`Raw Message: "${msg}"`);
    
    // 1. Parse Message
    const parsed = await AISocialParser.parseMessage(msg);
    console.log("Parsed JSON:", JSON.stringify(parsed, null, 2));
    
    // 2. Process and Match
    await SmartMatcher.processParsedMessage("+905551234567", parsed, "test-msg-id");
  }
}

run().catch(console.error).finally(() => process.exit(0));
