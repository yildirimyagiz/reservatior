import fs from 'fs';
import path from 'path';

const COMFY_URL = 'http://127.0.0.1:8188';
const OUTPUT_DIR = path.join(process.cwd(), 'public/images/generated');
const INPUT_DIR = path.join(process.cwd(), 'public/images/generated');

// Ensure directories exist
if (!fs.existsSync(OUTPUT_DIR)) fs.mkdirSync(OUTPUT_DIR, { recursive: true });

// Checkpoint & ControlNet Names (Must match what we downloaded)
const CHECKPOINT_NAME = 'Realistic_Vision_V5.1.safetensors';
const CONTROLNET_NAME = 'control_v11f1p_sd15_depth.pth';

async function uploadImage(filepath: string): Promise<string> {
    const filename = path.basename(filepath);
    const formData = new FormData();
    const blob = new Blob([fs.readFileSync(filepath)]);
    formData.append('image', blob, filename);
    formData.append('overwrite', 'true');

    const res = await fetch(`${COMFY_URL}/upload/image`, {
        method: 'POST',
        body: formData
    });

    if (!res.ok) throw new Error(`Failed to upload ${filename}: ${res.statusText}`);
    const json = await res.json();
    return json.name;
}

async function queuePrompt(prompt: any): Promise<string> {
    const res = await fetch(`${COMFY_URL}/prompt`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt })
    });

    if (!res.ok) {
        const text = await res.text();
        throw new Error(`Failed to queue prompt: ${res.status} ${text}`);
    }
    const json = await res.json();
    return json.prompt_id;
}

async function getHistory(promptId: string): Promise<any> {
    const res = await fetch(`${COMFY_URL}/history/${promptId}`);
    if (!res.ok) throw new Error(`Failed to get history: ${res.statusText}`);
    const json = await res.json();
    return json[promptId];
}

async function downloadOutput(filename: string): Promise<Buffer> {
    const res = await fetch(`${COMFY_URL}/view?filename=${filename}&subfolder=&type=output`);
    if (!res.ok) throw new Error(`Failed to download output: ${res.statusText}`);
    return Buffer.from(await res.arrayBuffer());
}

// ----------------------------------------------------------------------------
// WORKFLOW CONSTRUCTION
// ----------------------------------------------------------------------------
function buildWorkflow(imageName: string, positivePrompt: string, seed: number) {
    return {
        "3": {
            "inputs": {
                "seed": seed,
                "steps": 30,
                "cfg": 9.0,
                "sampler_name": "euler",
                "scheduler": "normal",
                "denoise": 0.85, // With ControlNet Depth, we can use Higher Denoise to add furniture while keeping structure!
                "model": ["4", 0],
                "positive": ["13", 0], // From ControlNet
                "negative": ["7", 0], // Direct from negative
                "latent_image": ["10", 0] // VAE Encode (img2img)
            },
            "class_type": "KSampler"
        },
        "4": {
            "inputs": {
                "ckpt_name": CHECKPOINT_NAME
            },
            "class_type": "CheckpointLoaderSimple"
        },
        "6": { // Positive Prompt
            "inputs": {
                "text": `(masterpiece, best quality, ultra realistic, 8k), ${positivePrompt}`,
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "7": { // Negative Prompt
            "inputs": {
                "text": "text, watermark, ugly, low quality, blur, distorted, empty room, vacant, distorted walls",
                "clip": ["4", 1]
            },
            "class_type": "CLIPTextEncode"
        },
        "8": {
            "inputs": {
                "samples": ["3", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEDecode"
        },
        "9": {
            "inputs": {
                "filename_prefix": "comfy_output",
                "images": ["8", 0]
            },
            "class_type": "SaveImage"
        },
        "10": { // VAE Encode
            "inputs": {
                "pixels": ["12", 0],
                "vae": ["4", 2]
            },
            "class_type": "VAEEncode"
        },
        "11": { // ControlNet Loader
            "inputs": {
                "control_net_name": CONTROLNET_NAME
            },
            "class_type": "ControlNetLoader"
        },
        "12": { // Load Image
            "inputs": {
                "image": imageName,
                "upload": "image"
            },
            "class_type": "LoadImage"
        },
        "13": { // ControlNet Apply (Advanced or Simple)
            "inputs": {
                "strength": 1.0,
                "image": ["12", 0], // Use original image for depth/canny
                "control_net": ["11", 0],
                "conditioning": ["6", 0] // Apply to Positive Prompt
            },
            // Note: Standard 'ControlNetApply' input name for conditioning is 'conditioning'
            "class_type": "ControlNetApply"
        }
    };
}

async function main() {
    const rooms = [
        { key: 'living-room', prompt: "modern living room with beige sofa, coffee table, rug, curtains" },
        { key: 'bedroom', prompt: "modern bedroom with king size bed, nightstands, rug, artwork" },
        { key: 'kitchen', prompt: "modern kitchen with bar stools, fruit bowl, espresso machine, plants" },
        { key: 'office', prompt: "modern home office with desk, chair, laptop, bookshelf, plant" },
    ];

    for (const room of rooms) {
        const inputFile = `${room.key}-empty.png`;
        const inputPath = path.join(INPUT_DIR, inputFile);

        console.log(`Processing ${room.key}...`);

        try {
            if (!fs.existsSync(inputPath)) {
                console.error(`  Missing input: ${inputPath}`);
                continue;
            }

            // 1. Upload
            const serverImageName = await uploadImage(inputPath);

            // 2. Build Workflow
            const workflow = buildWorkflow(serverImageName, room.prompt, Math.floor(Math.random() * 1000000));

            // 3. Queue
            const promptId = await queuePrompt(workflow);
            console.log(`  Queued: ${promptId}`);

            // 4. Wait
            let history;
            while (!history) {
                try {
                    history = await getHistory(promptId);
                } catch (e) { }
                if (!history) await new Promise(r => setTimeout(r, 1000));
            }

            // 5. Download
            const outputs = history.outputs["9"].images;
            if (outputs && outputs.length > 0) {
                const best = outputs[0];
                const buffer = await downloadOutput(best.filename);

                const outPath = path.join(OUTPUT_DIR, `${room.key}-staged.png`);
                fs.writeFileSync(outPath, buffer);
                console.log(`  Saved to ${outPath}`);
            }

        } catch (e) {
            console.error(`  Failed ${room.key}:`, e);
        }
    }
}

main();
