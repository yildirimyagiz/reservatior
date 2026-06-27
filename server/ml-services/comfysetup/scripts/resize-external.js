const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

const dir = path.join(process.cwd(), 'public/images/generated');
const files = fs.readdirSync(dir).filter(f => f.endsWith('.png'));

async function resize() {
    for (const file of files) {
        const filePath = path.join(dir, file);
        const buffer = fs.readFileSync(filePath);
        const resized = await sharp(buffer)
            .resize(512, 512, { fit: 'cover' })
            .toBuffer();
        fs.writeFileSync(filePath, resized);
        console.log(`Resized ${file} to 512x512`);
    }
}

resize();
