import { prisma } from "../../lib/prisma";
import * as fs from 'fs';
import * as path from 'path';

/**
 * AIStagingEngine bridges the NodeJS app and the Python ML-Services Virtual Staging engine.
 * It sends an empty room image and receives a furnished one.
 */
export class AIStagingEngine {
    static async stageImage(propertyId: string, imageUrl: string, roomType: string = 'living_room', style: string = 'modern') {
        console.log(`[AIStagingEngine] Requesting virtual staging for property ${propertyId}...`);
        
        try {
            const response = await fetch("http://localhost:8000/api/v1/staging/generate", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    image_url: imageUrl,
                    room_type: roomType,
                    style: style
                })
            });

            if (!response.ok) {
                throw new Error(`Python API responded with ${response.status}: ${await response.text()}`);
            }

            const data = await response.json();
            
            // Expected output: { original_url, staged_url, status, engine }
            return {
                status: data.status,
                originalUrl: data.original_url,
                stagedUrl: data.staged_url,
                engine: data.engine
            };
        } catch (e: any) {
            console.error("[AIStagingEngine] Failed to stage image:", e);
            throw e;
        }
    }
}
