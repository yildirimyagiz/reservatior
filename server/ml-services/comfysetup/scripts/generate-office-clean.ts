import fs from 'fs';
import path from 'path';

const COMFY_URL = 'http://127.0.0.1:8188';
const OUTPUT_DIR = path.join(process.cwd(), 'public/images/generated');
const INPUT_DIR = path.join(process.cwd(), 'public/images/generated');

const CHECKPOINT_NAME = 'Realistic_Vision_V5.1.safetensors';
const CONTROLNET_NAME = 'control_v11f1p_sd15_depth.pth';

async function uploadImage(filepath: string): Promise<string> {
    const filename = path.basename(filepath);
    const formData = new FormData();
    const blob = new Blob([fs.readFileSync(filepath)]);
    formData.append('image', blob, filename);
    formData.append('overwrite', 'true');
    const res = await fetch(`${COMFY_URL}/upload/image`, { method: 'POST', body: formData });
    if (!res.ok) throw new Error(`Failed to upload ${filename}: ${res.statusText}`);
    return (await res.json()).name;
}

async function queuePrompt(prompt: any): Promise<string> {
    const res = await fetch(`${COMFY_URL}/prompt`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ prompt })
    });
    if (!res.ok) throw new Error(`Failed to queue: ${res.status} ${await res.text()}`);
    return (await res.json()).prompt_id;
}

async function getHistory(promptId: string): Promise<any> {
    const res = await fetch(`${COMFY_URL}/history/${promptId}`);
    if (!res.ok) throw new Error(`Failed to get history`);
    return (await res.json())[promptId];
}

async function downloadOutput(filename: string): Promise<Buffer> {
    const res = await fetch(`${COMFY_URL}/view?filename=${filename}&subfolder=&type=output`);
    if (!res.ok) throw new Error(`Failed to download`);
    return Buffer.from(await res.arrayBuffer());
}

function buildWorkflow(imageName: string, positivePrompt: string, negativePrompt: string, denoise: number, seed: number) {
    return {
        "3": { "inputs": { "seed": seed, "steps": 40, "cfg": 10.0, "sampler_name": "dpmpp_2m", "scheduler": "karras", "denoise": denoise, "model": ["4", 0], "positive": ["13", 0], "negative": ["7", 0], "latent_image": ["10", 0] }, "class_type": "KSampler" },
        "4": { "inputs": { "ckpt_name": CHECKPOINT_NAME }, "class_type": "CheckpointLoaderSimple" },
        "6": { "inputs": { "text": `(masterpiece, best quality, ultra realistic, 8k, professional photography), ${positivePrompt}`, "clip": ["4", 1] }, "class_type": "CLIPTextEncode" },
        "7": { "inputs": { "text": negativePrompt, "clip": ["4", 1] }, "class_type": "CLIPTextEncode" },
        "8": { "inputs": { "samples": ["3", 0], "vae": ["4", 2] }, "class_type": "VAEDecode" },
        "9": { "inputs": { "filename_prefix": "comfy_output", "images": ["8", 0] }, "class_type": "SaveImage" },
        "10": { "inputs": { "pixels": ["12", 0], "vae": ["4", 2] }, "class_type": "VAEEncode" },
        "11": { "inputs": { "control_net_name": CONTROLNET_NAME }, "class_type": "ControlNetLoader" },
        "12": { "inputs": { "image": imageName, "upload": "image" }, "class_type": "LoadImage" },
        "13": { "inputs": { "strength": 0.50, "image": ["12", 0], "control_net": ["11", 0], "conditioning": ["6", 0] }, "class_type": "ControlNetApply" }
    };
}

async function generateSingle(key: string, prompt: string, negativePrompt: string, denoise: number) {
    const inputPath = path.join(INPUT_DIR, `${key}-empty.png`);
    console.log(`Processing ${key}...`);
    if (!fs.existsSync(inputPath)) { console.error(`Missing: ${inputPath}`); return; }
    const serverImageName = await uploadImage(inputPath);
    const workflow = buildWorkflow(serverImageName, prompt, negativePrompt, denoise, Math.floor(Math.random() * 1000000));
    const promptId = await queuePrompt(workflow);
    console.log(`  Queued: ${promptId}`);
    let history; while (!history) { try { history = await getHistory(promptId); } catch (e) { } if (!history) await new Promise(r => setTimeout(r, 1000)); }
    const outputs = history.outputs["9"].images;
    if (outputs?.length > 0) {
        const buffer = await downloadOutput(outputs[0].filename);
        const outPath = path.join(OUTPUT_DIR, `${key}-staged.png`);
        fs.writeFileSync(outPath, buffer);
        console.log(`  Saved to ${outPath}`);
    }
}

// AGGRESSIVE FLATTENING: Remove "huge things" (debris piles)
generateSingle(
    'office',
    'empty room, flat wall-to-wall carpet, clean white walls, smooth ceiling, neutral lighting, vast empty space, minimalist, clean floor, seamless texture, no objects',
    'black, black section, black patch, dark spot, shadow, red, red section, red patch, red color, 3d objects, debris, piles, trash, furniture, items, things, spots, uneven floor, bumps, rocks, paper, clutter, decorations, plants, vibrant colors',
    0.75 // High denoise + Low strength = Flatten the geometry of the debris
);
