// Core application types

export type Locale = 'en' | 'tr' | 'es' | 'de';

export type RoomType =
  | 'living-room'
  | 'bedroom'
  | 'office'
  | 'dining-room'
  | 'kitchen'
  | 'bathroom'
  | 'outdoor';

export type InteriorStyle =
  | 'modern-minimalist'
  | 'scandinavian'
  | 'industrial'
  | 'mid-century-modern'
  | 'bohemian'
  | 'traditional'
  | 'coastal'
  | 'farmhouse'
  | 'contemporary'
  | 'rustic';

export type FurnitureCategory =
  | 'sofa'
  | 'chair'
  | 'table'
  | 'bed'
  | 'storage'
  | 'lighting'
  | 'decor'
  | 'rug'
  | 'plant';

export type ComputeMode = 'cpu' | 'gpu';

export type PromptMode = 'staging' | 'recolor' | 'style-transfer' | '3d-generation';

export interface FurnitureItem {
  id: string;
  name: string;
  category: FurnitureCategory;
  imageData: string; // base64 or blob URL
  source: 'user' | 'template' | 'seller' | 'shopify';
  sellerData?: {
    sellerId: string;
    productUrl: string;
    price?: number;
    currency?: string;
  };
  createdAt: number;
}

export interface RoomImage {
  id: string;
  name: string;
  imageData: string;
  roomType?: RoomType;
  createdAt: number;
}

export interface PromptConfig {
  roomType: RoomType;
  style: InteriorStyle;
  colorPalette: string[];
  extras: string[];
  mode: ComputeMode;
  promptMode: PromptMode;
  selectedFurniture: string[]; // furniture IDs
}

export interface GeneratedPrompt {
  positive: string;
  negative: string;
  settings: ComfyUISettings;
  disclaimer: string;
}

export interface ComfyUISettings {
  steps: [number, number]; // [min, max]
  resolution: string;
  sampler: string;
  controlNetDepthStrength?: [number, number];
  ipAdapterStrength?: [number, number];
}

export interface Preset {
  id: string;
  name: string;
  config: PromptConfig;
  createdAt: number;
}

export interface SellerAPIConfig {
  id: string;
  name: string;
  endpoint: string;
  apiKey?: string;
  enabled: boolean;
}

// Shopify Types

export interface ShopifyPrice {
  amount: string;
  currencyCode: string;
}

export interface ShopifyImage {
  url: string;
  altText?: string;
  width?: number;
  height?: number;
}

export interface ShopifyVariant {
  id: string;
  title: string;
  availableForSale: boolean;
  price: ShopifyPrice;
  image?: {
    url: string;
    altText?: string;
  };
}

export interface ShopifyProduct {
  id: string;
  title: string;
  handle: string;
  description: string;
  productType: string;
  vendor: string;
  tags: string[];
  price: ShopifyPrice;
  maxPrice?: ShopifyPrice;
  image?: ShopifyImage;
  images: ShopifyImage[];
  variants: ShopifyVariant[];
}

export interface ShopifyCollection {
  id: string;
  title: string;
  handle: string;
  description?: string;
  image?: {
    url: string;
    altText?: string;
  };
  productsCount: number;
}

export interface ShopifyPageInfo {
  hasNextPage: boolean;
  endCursor: string | null;
}

export interface ShopifyProductsResponse {
  products: ShopifyProduct[];
  pageInfo: ShopifyPageInfo;
}

export interface ShopifyCollectionsResponse {
  collections: ShopifyCollection[];
}

// Extended FurnitureItem to support Shopify products
export interface ShopifyFurnitureItem extends FurnitureItem {
  source: 'shopify';
  shopifyProduct: ShopifyProduct;
}

