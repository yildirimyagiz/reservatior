import sharp from 'sharp';
import path from 'path';
import fs from 'fs';

const dir = path.join(process.cwd(), 'public/images/generated');

async function convert() {
    const rooms = ['living-room', 'bedroom', 'kitchen', 'office'];

    for (const room of rooms) {
        for (const type of ['empty', 'staged']) {
            const fileName = `${room}-${type}.png`;
            const filePath = path.join(dir, fileName);
            const outName = `${room}-${type}.webp`;
            const outPath = path.join(dir, outName);

            if (fs.existsSync(filePath)) {
                await sharp(filePath)
                    .webp({ quality: 85 })
                    .toFile(outPath);
                console.log(`Created ${outName}`);
            } else {
                console.log(`Skipping ${fileName}: File not found`);
            }
        }
    }
}

convert().catch(console.error);
