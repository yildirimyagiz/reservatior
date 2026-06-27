import type {
  RoomType,
  InteriorStyle,
  ComputeMode,
  PromptMode,
  GeneratedPrompt,
  ComfyUISettings,
} from '@/types';

// Style descriptors for interior styles
const styleDescriptors: Record<string, string> = {
  'modern-minimalist': 'clean lines, minimal clutter, neutral palette, sleek furniture, open space',
  scandinavian: 'light wood, white walls, cozy textiles, functional design, natural light',
  industrial: 'exposed brick, metal accents, raw materials, urban loft aesthetic, Edison bulbs',
  'mid-century-modern': 'organic curves, tapered legs, bold colors, retro patterns, teak wood',
  bohemian: 'eclectic patterns, rich colors, layered textiles, global influences, plants',
  traditional: 'classic furniture, ornate details, rich fabrics, symmetry, warm colors',
  coastal: 'blue and white palette, natural textures, beach-inspired, light and airy',
  farmhouse: 'rustic wood, shiplap, vintage accents, comfortable, country charm',
  contemporary: 'current trends, mixed materials, bold art, flexible spaces, statement pieces',
  luxury:
    'high-end materials, gold accents, marble surfaces, sophisticated lighting, elegant furniture',
  cyberpunk:
    'neon lights, high-tech furniture, dark metals, futuristic aesthetic, glowing elements',
  japanese: 'minimalism, natural wood, tatami mats, low furniture, zen atmosphere, sliding doors',
  biophilic: 'integrated plants, natural textures, organic shapes, indoor-outdoor connection',
  'art-deco':
    'geometric patterns, bold colors, luxurious materials, mirror accents, golden details',
  rustic: 'natural wood, stone, earthy colors, handcrafted elements, cabin feel',
};

// Room-specific elements
const roomElements: Record<RoomType, string> = {
  'living-room': 'sofa, coffee table, armchairs, side tables, bookshelf, TV console',
  bedroom: 'bed with headboard, nightstands, dresser, mirror, reading lamp, soft bedding',
  office: 'desk, ergonomic chair, bookshelf, task lighting, monitor, organizational items',
  'dining-room': 'dining table, chairs, sideboard, chandelier, table setting, centerpiece',
  kitchen: 'cabinets, island, bar stools, pendant lights, appliances, open shelving',
  bathroom: 'vanity, mirror, towels, plants, decorative accessories, ambient lighting',
  outdoor: 'patio furniture, outdoor rug, planters, string lights, cushions, fire pit',
};

// Extra elements mapping
const extrasMapping: Record<string, string> = {
  plants: 'lush indoor plants, potted greenery, hanging plants',
  lighting: 'ambient lighting, decorative lamps, warm glow',
  wallArt: 'framed artwork, gallery wall, statement pieces',
  rugs: 'area rug, layered rugs, textured floor covering',
  cushions: 'throw pillows, decorative cushions, soft textiles',
  curtains: 'flowing curtains, window treatments, natural light filtering',
  books: 'styled books, decorative objects, personal touches',
  vases: 'ceramic vases, fresh flowers, decorative pottery',
};

export function generateStagingPrompt(
  roomType: RoomType,
  style: InteriorStyle,
  colorPalette: string[],
  extras: string[],
  mode: ComputeMode
): GeneratedPrompt {
  // Build positive prompt
  const positiveElements = [
    'photorealistic virtual staging',
    'professional interior photography',
    `${roomType.replace('-', ' ')} interior`,
    styleDescriptors[style],
    roomElements[roomType],
    ...extras.map((e) => extrasMapping[e] || e),
    colorPalette.length > 0 ? `color palette featuring ${colorPalette.join(', ')}` : '',
    'accurate furniture proportions',
    'realistic scale and placement',
    'cozy inviting atmosphere',
    'natural daylight through windows',
    'clean uncluttered composition',
    'high-end real estate photography style',
    '8K resolution, sharp details',
  ].filter(Boolean);

  const positive = positiveElements.join(', ');

  // Negative prompt
  const negative = [
    'blurry',
    'deformed proportions',
    'floating furniture',
    'unrealistic scale',
    'low quality',
    'watermark',
    'logo',
    'text',
    'cartoon',
    'CGI',
    'illustration',
    'artifacts',
    'empty room',
    'distorted perspective',
    'oversaturated',
    'underexposed',
    'noise',
    'grainy',
  ].join(', ');

  // Settings based on mode
  const settings = getSettings(mode, 'staging');

  return {
    positive,
    negative,
    settings,
    disclaimer:
      '⚠️ Images generated using this prompt are AI-staged visualizations. Final products may differ from visualizations.',
  };
}

export function generateRecolorPrompt(targetColors: string[], mode: ComputeMode): GeneratedPrompt {
  const positive = [
    'photorealistic interior',
    'professional color grading',
    `furniture and walls in ${targetColors.join(', ')} tones`,
    'consistent lighting',
    'natural shadows',
    'cohesive color palette',
    'high quality interior photography',
    'accurate material textures',
  ].join(', ');

  const negative = [
    'color bleeding',
    'unnatural colors',
    'oversaturated',
    'inconsistent lighting',
    'artifacts',
    'blurry',
    'low quality',
    'distorted',
  ].join(', ');

  return {
    positive,
    negative,
    settings: getSettings(mode, 'recolor'),
    disclaimer: '⚠️ Color changes are AI-generated approximations. Actual product colors may vary.',
  };
}

export function generateStyleTransferPrompt(
  targetStyle: InteriorStyle,
  mode: ComputeMode
): GeneratedPrompt {
  const positive = [
    'photorealistic interior design transformation',
    `${targetStyle.replace('-', ' ')} interior style`,
    styleDescriptors[targetStyle],
    'professional interior photography',
    'cohesive design aesthetic',
    'natural lighting',
    'high quality details',
    'architectural accuracy maintained',
  ].join(', ');

  const negative = [
    'mixed styles',
    'inconsistent design',
    'artifacts',
    'blurry',
    'distorted',
    'low quality',
    'unrealistic',
    'cartoon',
  ].join(', ');

  return {
    positive,
    negative,
    settings: getSettings(mode, 'style-transfer'),
    disclaimer:
      '⚠️ Style transfer is an AI visualization. Actual implementation may require professional design consultation.',
  };
}

export function generate3DPrompt(
  viewAngle: 'front' | 'left' | 'right' | 'back' | 'top' | 'angle',
  mode: ComputeMode
): GeneratedPrompt {
  const viewDescriptions: Record<string, string> = {
    front: 'front view, straight-on perspective',
    left: 'left side view, 90 degree rotation',
    right: 'right side view, 90 degree rotation',
    back: 'back view, rear perspective',
    top: 'top-down view, birds eye perspective',
    angle: '3/4 view, isometric perspective, 45 degree angle',
  };

  const positive = [
    'product photography',
    viewDescriptions[viewAngle],
    'clean white background',
    'studio lighting',
    'no shadows on background',
    'centered composition',
    'high detail',
    'sharp focus',
    'professional product shot',
    '8K resolution',
    'consistent with other views',
  ].join(', ');

  const negative = [
    'background elements',
    'shadows on background',
    'perspective distortion',
    'blurry',
    'low quality',
    'inconsistent lighting',
    'cropped',
    'partial view',
  ].join(', ');

  return {
    positive,
    negative,
    settings: getSettings(mode, '3d-generation'),
    disclaimer:
      '⚠️ 3D model generation requires additional processing. Use with TripoSR, Wonder3D, or Zero123++ workflows.',
  };
}

function getSettings(mode: ComputeMode, promptMode: PromptMode): ComfyUISettings {
  if (mode === 'cpu') {
    return {
      steps: [20, 30],
      resolution: '768x768 or 896x896',
      sampler: 'Euler a',
    };
  }

  // GPU mode
  const baseSettings: ComfyUISettings = {
    steps: [25, 35],
    resolution: '1024x1024',
    sampler: 'Euler a',
  };

  if (promptMode === 'staging') {
    return {
      ...baseSettings,
      controlNetDepthStrength: [0.8, 0.95],
      ipAdapterStrength: [0.5, 0.7],
    };
  }

  if (promptMode === 'recolor' || promptMode === 'style-transfer') {
    return {
      ...baseSettings,
      controlNetDepthStrength: [0.6, 0.8],
    };
  }

  // 3D generation
  return {
    ...baseSettings,
    steps: [30, 40],
    resolution: '1024x1024',
  };
}

export function generateToolPrompt(tool: string, mode: ComputeMode): GeneratedPrompt {
  let positive = '';
  let negative = 'low quality, blurry, artifacts, watermark, text';
  const promptMode: PromptMode = 'staging';

  switch (tool) {
    case 'eraser':
    case 'declutter':
      positive =
        'empty room, clean walls, no furniture, minimalistic, spacious, decluttered interior, high quality, photorealistic';
      negative = 'furniture, clutter, mess, items, objects';
      break;
    case 'enhance':
      positive =
        '4k, 8k, high definition, sharp focus, detailed texture, professional photography, masterpiece, best quality';
      negative = 'blurry, noise, grainy, low resolution, jpeg artifacts';
      break;
    case 'seasons':
      positive =
        'winter season, snowy view outside window, frost on window, cozy warm interior lighting, winter atmosphere';
      break;
    case 'rain-shine':
      positive =
        'sunny day, bright natural sunlight, clear blue sky outside window, warm lighting, summer atmosphere';
      break;
    case 'natural-twilight':
      positive =
        'twilight hour, golden hour lighting, soft sunset glow, evening atmosphere, warm ambient light';
      break;
    case 'virtual-twilight':
      positive =
        'dramatic twilight sky, deep blue evening, interior lights on, exterior night view, cinematic lighting';
      break;
    case 'night-day':
      positive = 'bright daytime, natural sunlight, clear day, morning light, fresh atmosphere';
      break;
    case 'water-pool':
      positive =
        'sparkling blue swimming pool, clean water, water reflections, luxury pool, detailed water texture';
      break;
    case 'pool-enhancement':
      positive =
        'crystal clear shiny pool water, tropical blue water, resort style pool, vibrant water color';
      break;
    case 'lawn':
      positive =
        'freshly cut green green grass, manicured lawn, vibrant healthy landscaping, garden view';
      break;
    case 'material':
      positive = 'high quality material texture, realistic surface detail, professional finish';
      break;
    default: // 'furniture'
      positive =
        'professional virtual staging, modern interior design, photorealistic furniture placement, high quality';
  }

  return {
    positive,
    negative,
    settings: getSettings(mode, promptMode),
    disclaimer: '⚠️ AI generation result.',
  };
}

export function formatPromptOutput(prompt: GeneratedPrompt): string {
  const settingsStr = [
    `Steps: ${prompt.settings.steps[0]}-${prompt.settings.steps[1]}`,
    `Resolution: ${prompt.settings.resolution}`,
    `Sampler: ${prompt.settings.sampler}`,
    prompt.settings.controlNetDepthStrength
      ? `ControlNet Depth Strength: ${prompt.settings.controlNetDepthStrength[0]}-${prompt.settings.controlNetDepthStrength[1]}`
      : '',
    prompt.settings.ipAdapterStrength
      ? `IP-Adapter Strength: ${prompt.settings.ipAdapterStrength[0]}-${prompt.settings.ipAdapterStrength[1]}`
      : '',
  ]
    .filter(Boolean)
    .join('\n');

  return `=== POSITIVE PROMPT ===
${prompt.positive}

=== NEGATIVE PROMPT ===
${prompt.negative}

=== COMFYUI SETTINGS ===
${settingsStr}

=== LEGAL DISCLAIMER ===
${prompt.disclaimer}`;
}
