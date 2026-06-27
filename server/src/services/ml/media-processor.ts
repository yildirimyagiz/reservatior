import * as fs from 'fs';
import * as path from 'path';
import { v4 as uuidv4 } from 'uuid';
import { GoogleGenerativeAI } from '@google/generative-ai';

// Initialize Gemini
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY || '');

export interface MLMediaResult {
    catalogType: 'project' | 'second_hand';
    localPath: string;
    fileName: string;
    visualTags: string[];
    confidence: number;
}

export class MediaProcessor {
    /**
     * Processes raw media buffer, classifies it via ML (Gemini Vision),
     * and saves it to the appropriate local catalog directory.
     */
    static async processAndCategorizeMedia(
        base64Data: string, 
        mimeType: string, 
        originalText: string = ''
    ): Promise<MLMediaResult> {
        let catalogType: 'project' | 'second_hand' = 'second_hand';
        let visualTags: string[] = [];
        let confidence = 0.5;

        // Try to classify using Gemini Multimodal
        try {
            const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });
            const prompt = `
            Analyze this real estate image and the accompanying text: "${originalText}".
            Determine if this is a brand new project (project) or a resale / second hand property (second_hand).
            Also extract any key visual features (e.g., 'Modern Kitchen', 'Sea View', 'Unfurnished').

            Respond ONLY with valid JSON in this format:
            {
                "catalogType": "project" | "second_hand",
                "visualTags": ["tag1", "tag2"],
                "confidence": 0.95
            }
            `;

            const imagePart = {
                inlineData: {
                    data: base64Data,
                    mimeType: mimeType
                }
            };

            const result = await model.generateContent([prompt, imagePart]);
            const responseText = result.response.text();
            
            const jsonStr = responseText.replace(/```json/g, '').replace(/```/g, '').trim();
            const aiData = JSON.parse(jsonStr);

            if (aiData.catalogType === 'project' || aiData.catalogType === 'second_hand') {
                catalogType = aiData.catalogType;
            }
            if (Array.isArray(aiData.visualTags)) {
                visualTags = aiData.visualTags;
            }
            confidence = aiData.confidence || 0.8;

            console.log(`🧠 ML Sınıflandırma Başarılı: ${catalogType} (${confidence})`);

        } catch (error: any) {
            console.error('⚠️ ML Sınıflandırma Hatası (Gemini API 404/Geçersiz Anahtar Olabilir), varsayılan olarak "second_hand" atanıyor:', error.message);
        }

        // Save file physically to the proper directory
        const ext = mimeType.split('/')[1] || 'jpg';
        const fileName = `${uuidv4()}.${ext}`;
        
        // Ensure directories exist
        const dataDir = path.join(process.cwd(), 'data', catalogType);
        if (!fs.existsSync(dataDir)) {
            fs.mkdirSync(dataDir, { recursive: true });
        }

        const localPath = path.join(dataDir, fileName);
        const buffer = Buffer.from(base64Data, 'base64');
        
        fs.writeFileSync(localPath, buffer);
        console.log(`📁 Görsel kaydedildi: ${localPath}`);

        return {
            catalogType,
            localPath,
            fileName,
            visualTags,
            confidence
        };
    }
}
