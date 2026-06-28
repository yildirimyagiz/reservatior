import { GeminiService } from '../src/services/gemini';

async function runTests() {
  console.log("🚀 Starting AI Leakage Detection Tests...\n");

  const testCases = [
    {
      name: "1. Spelled out phone number",
      message: "Evin konumu çok iyi. Bana sıfır beş yüz elli beş yüz yirmi üç kırk elli numarasından ulaşabilirsin, oradan konuşalım."
    },
    {
      name: "2. Spelled out IBAN / Bank Info",
      message: "Kardeşim sen parayı TR33 ile başlayan Ziraat hesabıma at, boşver komisyon falan ödeme."
    },
    {
      name: "3. Pure intent to bypass (Cash offer)",
      message: "Ya boşver şimdi sistemi, sen gel akşam çay içelim parayı elden verirsin anahtarı veririm."
    },
    {
      name: "4. Normal innocent message",
      message: "Evin fotoğrafları çok güzel görünüyor, yarın saat 14:00 gibi gelip görebilir miyiz?"
    },
    {
      name: "5. Standard Number (Regex Fallback Test)",
      message: "Bana 0532 123 45 67 numarasından ulaş."
    }
  ];

  for (const tc of testCases) {
    console.log(`\n======================================`);
    console.log(`🧪 Test Case: ${tc.name}`);
    console.log(`📩 Original Message: "${tc.message}"`);
    console.log(`⏳ Analyzing with Gemini 2.5 Flash...`);
    
    const result = await GeminiService.analyzeMessageForLeakage(tc.message);
    
    console.log(`\n📊 Result:`);
    console.log(`- Is Leakage? : ${result.isLeakage ? "🚨 YES (BLOCKED)" : "✅ NO (ALLOWED)"}`);
    console.log(`- Reason      : ${result.reason || "None"}`);
    console.log(`- Masked Msg  : "${result.maskedMessage}"`);
  }

  console.log("\n✅ All tests completed.");
}

runTests();
