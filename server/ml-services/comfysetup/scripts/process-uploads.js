const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

// Map uploaded files to target keys
const MAPPING = [
    {
        src: 'uploaded_media_0_1769536001707.jpg', // Bedroom
        dest: 'bedroom-empty.png'
    },
    {
        src: 'uploaded_media_1_1769536001707.jpg', // Living Room (Was wrongly mapped to kitchen)
        dest: 'living-room-empty.png'
    },
    {
        src: 'uploaded_media_2_1769536001707.jpg', // Kitchen
        dest: 'kitchen-empty.png'
    },
    {
        src: 'uploaded_media_3_1769536001707.jpg', // Office
        dest: 'office-empty.png'
    }
];

const ARTIFACT_DIR = '/Users/yldyagz/.gemini/antigravity/brain/1f20b8d7-152f-48b0-ba11-5b1cdc9a33b8';
const TARGET_DIR = path.join(process.cwd(), 'public/images/generated');

async function main() {
    for (const item of MAPPING) {
        const srcPath = path.join(ARTIFACT_DIR, item.src);
        const destPath = path.join(TARGET_DIR, item.dest);

        console.log(`Processing ${item.src} -> ${item.dest}...`);

        if (!fs.existsSync(srcPath)) {
            console.error(`  Source not found: ${srcPath}`);
            continue;
        }

        const buffer = await sharp(srcPath)
            .resize(512, 512, { fit: 'cover' }) // Force 512x512
            .png() // Convert to PNG
            .toBuffer();

        fs.writeFileSync(destPath, buffer);
        console.log(`  Saved to ${destPath}`);
    }
}

main();
