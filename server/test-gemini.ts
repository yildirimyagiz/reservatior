import 'dotenv/config';
import { GoogleGenerativeAI } from '@google/generative-ai';
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');
async function testModel(name: string) {
  try {
    const model = genAI.getGenerativeModel({ model: name });
    await model.generateContent("test");
    console.log(name + " WORKS!");
  } catch(e: any) {
    console.log(name + " FAILED: " + e.message);
  }
}
async function run() {
  await testModel("gemini-1.0-pro");
  await testModel("gemini-1.5-pro-latest");
}
run();
