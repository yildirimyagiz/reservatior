import { DesignStyle } from '../store/canvas-store';

export interface DesignStyleConfig {
  value: DesignStyle;
  label: string;
  image: string;
  description: string;
  tags: string[];
}

export const DESIGN_STYLES: DesignStyleConfig[] = [
  {
    value: 'modern-minimalist',
    label: 'Modern Minimalist',
    image: '/images/rooms/staged/living-room-1.jpg',
    description: 'Clean lines, minimal clutter, neutral palette, sleek furniture',
    tags: ['elegant', 'clean', 'neutral'],
  },
  {
    value: 'scandinavian',
    label: 'Scandinavian',
    image: '/images/staged-templates/scandinavian.png',
    description: 'Light wood, white walls, cozy textiles, functional design',
    tags: ['warm', 'natural', 'hygge'],
  },
  {
    value: 'industrial',
    label: 'Industrial',
    image: '/images/staged-templates/industrial.png',
    description: 'Exposed brick, metal accents, raw materials, urban loft aesthetic',
    tags: ['urban', 'raw', 'loft'],
  },
  {
    value: 'mid-century-modern',
    label: 'Mid-Century Modern',
    image: '/images/staged-templates/mid-century.png',
    description: 'Organic curves, tapered legs, bold colors, retro patterns',
    tags: ['retro', 'iconic', 'organic'],
  },
  {
    value: 'bohemian',
    label: 'Bohemian',
    image: '/images/rooms/staged/living-room-3.png',
    description: 'Eclectic patterns, rich colors, layered textiles, global influences',
    tags: ['eclectic', 'colorful', 'textured'],
  },
  {
    value: 'contemporary',
    label: 'Contemporary',
    image: '/images/staged-templates/contemporary.png',
    description: 'Current trends, mixed materials, bold art, flexible spaces',
    tags: ['trendy', 'bold', 'versatile'],
  },
  {
    value: 'luxury',
    label: 'Luxury',
    image: '/images/staged-templates/luxury.png',
    description: 'High-end materials, gold accents, marble surfaces, sophisticated lighting',
    tags: ['premium', 'elegant', 'opulent'],
  },
  {
    value: 'japanese',
    label: 'Japanese',
    image: '/images/rooms/staged/living-room-2.png',
    description: 'Minimalism, natural wood, tatami mats, low furniture, zen atmosphere',
    tags: ['zen', 'minimal', 'harmonious'],
  },
  {
    value: 'biophilic',
    label: 'Biophilic',
    image: '/samples/comfy/after_kitchen.png',
    description: 'Integrated plants, natural textures, organic shapes, indoor-outdoor connection',
    tags: ['green', 'natural', 'organic'],
  },
  {
    value: 'coastal',
    label: 'Coastal',
    image: '/images/rooms/staged/living-room-2.png',
    description: 'Blue and white palette, natural textures, beach-inspired, light and airy',
    tags: ['beach', 'airy', 'fresh'],
  },
  {
    value: 'farmhouse',
    label: 'Farmhouse',
    image: '/images/rooms/staged/living-room-1.jpg',
    description: 'Rustic wood, shiplap, vintage accents, comfortable, country charm',
    tags: ['rustic', 'cozy', 'charming'],
  },
  {
    value: 'pacific-northwest',
    label: 'Pacific Northwest',
    image: '/images/rooms/staged/living-room-1.jpg',
    description: 'Dark woods, stone accents, forest-inspired palette, cabin aesthetics',
    tags: ['forest', 'earthy', 'moody'],
  },
  {
    value: 'urban-industrial',
    label: 'Urban Industrial',
    image: '/images/generated/office-staged.png',
    description: 'Converted warehouses, concrete floors, metal fixtures, open plan',
    tags: ['urban', 'concrete', 'open'],
  },
  {
    value: 'coastal-modern',
    label: 'Coastal Modern',
    image: '/images/rooms/staged/living-room-2.png',
    description: 'Sleek seaside design, natural materials, ocean color palette',
    tags: ['ocean', 'sleek', 'bright'],
  },
  {
    value: 'tech-loft',
    label: 'Tech Loft',
    image: '/images/generated/living-room-staged.png',
    description: 'Smart home integration, modern tech-forward furniture, ambient lighting',
    tags: ['smart', 'modern', 'tech'],
  },
  {
    value: 'cyberpunk',
    label: 'Cyberpunk',
    image: '/images/generated/office-staged.png',
    description: 'Neon lights, high-tech furniture, dark metals, futuristic aesthetic',
    tags: ['neon', 'futuristic', 'dark'],
  },
];

// Staging template presets: curated before/after combos for each style
export interface StagingTemplate {
  id: string;
  style: DesignStyle;
  roomType: string;
  label: string;
  description: string;
  thumbnail: string;
  promptOverride?: string;
}

export const STAGING_TEMPLATES: StagingTemplate[] = [
  {
    id: 'tmpl-scandi-living',
    style: 'scandinavian',
    roomType: 'living-room',
    label: 'Scandinavian Living',
    description: 'Light wood floors, fabric sofa, cozy throws, indoor plants',
    thumbnail: '/images/staged-templates/scandinavian.png',
  },
  {
    id: 'tmpl-industrial-living',
    style: 'industrial',
    roomType: 'living-room',
    label: 'Industrial Loft',
    description: 'Exposed brick, leather sofa, Edison bulbs, reclaimed wood',
    thumbnail: '/images/staged-templates/industrial.png',
  },
  {
    id: 'tmpl-midcen-living',
    style: 'mid-century-modern',
    roomType: 'living-room',
    label: 'Mid-Century Living',
    description: 'Teak sideboard, velvet armchair, geometric rug, arc lamp',
    thumbnail: '/images/staged-templates/mid-century.png',
  },
  {
    id: 'tmpl-luxury-living',
    style: 'luxury',
    roomType: 'living-room',
    label: 'Luxury Suite',
    description: 'Marble table, crystal chandelier, velvet sofa, gold accents',
    thumbnail: '/images/staged-templates/luxury.png',
  },
  {
    id: 'tmpl-contemporary-living',
    style: 'contemporary',
    roomType: 'living-room',
    label: 'Contemporary Chic',
    description: 'Modular sofa, bold art, track lighting, mixed textures',
    thumbnail: '/images/staged-templates/contemporary.png',
  },
  {
    id: 'tmpl-scandi-bedroom',
    style: 'scandinavian',
    roomType: 'bedroom',
    label: 'Nordic Bedroom',
    description: 'White linens, light wood nightstands, woven textiles',
    thumbnail: '/images/staged-templates/scandinavian.png',
  },
  {
    id: 'tmpl-luxury-bedroom',
    style: 'luxury',
    roomType: 'bedroom',
    label: 'Luxury Master',
    description: 'Tufted headboard, silk bedding, statement chandelier',
    thumbnail: '/images/staged-templates/luxury.png',
  },
  {
    id: 'tmpl-industrial-office',
    style: 'industrial',
    roomType: 'office',
    label: 'Industrial Office',
    description: 'Metal desk, Edison task light, exposed ductwork, leather chair',
    thumbnail: '/images/staged-templates/industrial.png',
  },
];

// Furniture placement presets for common room configurations
export interface FurniturePlacementPreset {
  id: string;
  label: string;
  roomType: string;
  description: string;
  items: {
    name: string;
    type: string;
    relativeX: number; // 0-1 relative to room width
    relativeY: number;
    relativeWidth: number;
    relativeHeight: number;
  }[];
}

export const FURNITURE_PLACEMENT_PRESETS: FurniturePlacementPreset[] = [
  {
    id: 'layout-living-l-shape',
    label: 'L-Shape Living',
    roomType: 'living-room',
    description: 'L-shaped sofa setup with coffee table and side tables',
    items: [
      { name: 'Sofa', type: 'sofa', relativeX: 0.15, relativeY: 0.55, relativeWidth: 0.45, relativeHeight: 0.25 },
      { name: 'Coffee Table', type: 'table', relativeX: 0.30, relativeY: 0.42, relativeWidth: 0.18, relativeHeight: 0.12 },
      { name: 'Armchair', type: 'chair', relativeX: 0.60, relativeY: 0.50, relativeWidth: 0.15, relativeHeight: 0.18 },
      { name: 'Side Table', type: 'table', relativeX: 0.10, relativeY: 0.45, relativeWidth: 0.08, relativeHeight: 0.08 },
      { name: 'Floor Lamp', type: 'lighting', relativeX: 0.65, relativeY: 0.38, relativeWidth: 0.06, relativeHeight: 0.20 },
    ],
  },
  {
    id: 'layout-living-centered',
    label: 'Centered Layout',
    roomType: 'living-room',
    description: 'Symmetrical arrangement with focal point sofa group',
    items: [
      { name: 'Main Sofa', type: 'sofa', relativeX: 0.20, relativeY: 0.60, relativeWidth: 0.40, relativeHeight: 0.20 },
      { name: 'Coffee Table', type: 'table', relativeX: 0.28, relativeY: 0.45, relativeWidth: 0.22, relativeHeight: 0.14 },
      { name: 'Left Armchair', type: 'chair', relativeX: 0.10, relativeY: 0.40, relativeWidth: 0.14, relativeHeight: 0.16 },
      { name: 'Right Armchair', type: 'chair', relativeX: 0.58, relativeY: 0.40, relativeWidth: 0.14, relativeHeight: 0.16 },
      { name: 'Area Rug', type: 'decor', relativeX: 0.15, relativeY: 0.38, relativeWidth: 0.50, relativeHeight: 0.35 },
    ],
  },
  {
    id: 'layout-bedroom-master',
    label: 'Master Bedroom',
    roomType: 'bedroom',
    description: 'Centered bed with matching nightstands and dresser',
    items: [
      { name: 'Bed', type: 'bed', relativeX: 0.22, relativeY: 0.30, relativeWidth: 0.40, relativeHeight: 0.45 },
      { name: 'Left Nightstand', type: 'table', relativeX: 0.12, relativeY: 0.35, relativeWidth: 0.10, relativeHeight: 0.10 },
      { name: 'Right Nightstand', type: 'table', relativeX: 0.62, relativeY: 0.35, relativeWidth: 0.10, relativeHeight: 0.10 },
      { name: 'Dresser', type: 'storage', relativeX: 0.75, relativeY: 0.55, relativeWidth: 0.18, relativeHeight: 0.15 },
    ],
  },
  {
    id: 'layout-office-exec',
    label: 'Executive Office',
    roomType: 'office',
    description: 'Large desk, ergonomic chair, bookshelf wall',
    items: [
      { name: 'Desk', type: 'table', relativeX: 0.25, relativeY: 0.35, relativeWidth: 0.35, relativeHeight: 0.20 },
      { name: 'Office Chair', type: 'chair', relativeX: 0.35, relativeY: 0.55, relativeWidth: 0.12, relativeHeight: 0.16 },
      { name: 'Bookshelf', type: 'storage', relativeX: 0.70, relativeY: 0.15, relativeWidth: 0.22, relativeHeight: 0.60 },
      { name: 'Task Lamp', type: 'lighting', relativeX: 0.55, relativeY: 0.30, relativeWidth: 0.06, relativeHeight: 0.12 },
    ],
  },
];
