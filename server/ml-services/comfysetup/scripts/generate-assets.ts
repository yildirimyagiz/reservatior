
import fs from 'fs';
import path from 'path';
import { STAGING_IMAGES } from '../src/lib/staging-images';
import sharp from 'sharp';

const SD_API_URL = 'http://127.0.0.1:7860';
const OUTPUT_DIR = path.join(process.cwd(), 'public/images/generated');

if (!fs.existsSync(OUTPUT_DIR)) {
    fs.mkdirSync(OUTPUT_DIR, { recursive: true });
}

async function downloadImage(url: string): Promise<Buffer> {
    // Check if it's a local file in public folder
    if (url.startsWith('/')) {
        const localPath = path.join(process.cwd(), 'public', url);
        if (fs.existsSync(localPath)) {
            console.log(`  Reading local file: ${localPath}`);
            return fs.readFileSync(localPath);
        }
    }

    // Otherwise fetch from URL
    const res = await fetch(url);
    if (!res.ok) throw new Error(`Failed to fetch ${url}: ${res.statusText}`);
    return Buffer.from(await res.arrayBuffer());
}

async function generateStaged(imageBuffer: Buffer, prompt: string, strength: number = 0.60): Promise<Buffer> {
    const base64Image = imageBuffer.toString('base64');

    // ... 

    const payload = {
        init_images: [base64Image],
        prompt: `(masterpiece, best quality, ultra realistic), ${prompt}, 8k`,
        negative_prompt: "text, watermark, ugly, distorted, low quality, blur, pixelated, empty room, vacant, distorted walls, changing windows, new windows, changing floor, changing ceiling, changing lighting, changing lamps, new light fixtures",
        steps: 30,
        denoising_strength: 0.42, // "Locked" Mode: Won't touch ceiling/walls
        width: 512,
        height: 512,
        cfg_scale: 15 // Force furniture to appear despite low strength
    };

    console.log(`    Sending request to SD API (512x512)...`);
    const res = await fetch(`${SD_API_URL}/sdapi/v1/img2img`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    });

    if (!res.ok) {
        const errText = await res.text();
        throw new Error(`SD API Error (${res.status}): ${errText}`);
    }

    const data = await res.json();
    return Buffer.from(data.images[0], 'base64');
}

interface RoomData {
    before: string;
    after: string;
    label: string;
    clean?: boolean; // New flag to "clean" the room first
}

async function processRoom(key: string, roomData: RoomData, prompt: string) {
    console.log(`Processing ${key}...`);
    try {
        const afterFilename = `${key}-staged.png`;
        const outputPath = path.join(OUTPUT_DIR, afterFilename);

        // 1. Download source image
        console.log(`  Downloading source image...`);
        let rawBuffer = await downloadImage(roomData.before);

        // Resize early
        let workingBuffer = await sharp(rawBuffer)
            .resize(512, 512, { fit: 'cover' })
            .toBuffer();

        // 1.5 Clean Room (De-furnish) if requested
        if (roomData.clean) {
            console.log(`  Cleaning room (removing furniture)...`);
            workingBuffer = await generateStaged(workingBuffer, "empty room, empty space, white walls, wood floor, interior architecture, no furniture, vacant", 0.85); // High strength to remove furniture

            // Save the *new* empty state
            const emptyFilename = `${key}-empty.png`;
            const emptyPath = path.join(OUTPUT_DIR, emptyFilename);
            fs.writeFileSync(emptyPath, workingBuffer);
            console.log(`  Saved cleaned (empty) image to ${emptyPath}`);
        } else {
            // Just save the downloaded one as empty
            const beforeFilename = `${key}-empty.png`;
            const beforePath = path.join(OUTPUT_DIR, beforeFilename);
            fs.writeFileSync(beforePath, workingBuffer);
            console.log(`  Saved source image to ${beforePath}`);
        }

        // 2. Generate "After" (Staging) from the (potentially cleaned) working buffer
        console.log(`  Generating staged version...`);
        const afterBuffer = await generateStaged(workingBuffer, prompt, 0.40);

        // 3. Save
        fs.writeFileSync(outputPath, afterBuffer);
        console.log(`  Saved to ${outputPath}`);
    } catch (e) {
        console.error(`  Failed:`, e);
    }
}

async function main() {
    console.log('Starting Batch Generation...');

    // Mapping rooms to prompts
    await processRoom('living-room', STAGING_IMAGES.livingRoom,
        "large beige sectional sofa, dark wooden coffee table, blue area rug, tall floor lamp, modern furniture"
    );

    await processRoom('bedroom', STAGING_IMAGES.bedroom, "king size bed with white duvet, two wooden nightstands, grey area rug, modern bedroom set");
    await processRoom('kitchen', STAGING_IMAGES.kitchen, "bar stools, bowl of fruit, espresso machine, plant on counter, kitchen accessories");
    await processRoom('office', STAGING_IMAGES.office, "modern wooden desk, black office chair, laptop computer, potted plant, home office furniture");

    // Living room typically already has a pair, but let's do it to be consistent if needed. 
    // Skipping livingRoom if we want to keep the good manual one, OR overwrite it. 
    // Let's stick to fixing the broken ones: Bedroom, Kitchen, Office.
}

main();
