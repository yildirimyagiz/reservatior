// Shopify Storefront API Client
import {
    PRODUCTS_QUERY,
    PRODUCT_BY_HANDLE_QUERY,
    COLLECTIONS_QUERY,
    COLLECTION_PRODUCTS_QUERY,
} from './queries';
import type {
    ShopifyProduct,
    ShopifyCollection,
    ShopifyProductsResponse,
    ShopifyCollectionsResponse,
} from '@/types';

interface ShopifyConfig {
    storeDomain: string;
    storefrontAccessToken: string;
    apiVersion?: string;
}

// Get config from environment
function getConfig(): ShopifyConfig {
    const storeDomain = process.env.SHOPIFY_STORE_DOMAIN;
    const storefrontAccessToken = process.env.SHOPIFY_STOREFRONT_ACCESS_TOKEN;

    if (!storeDomain || !storefrontAccessToken) {
        throw new Error(
            'Missing Shopify configuration. Please set SHOPIFY_STORE_DOMAIN and SHOPIFY_STOREFRONT_ACCESS_TOKEN environment variables.'
        );
    }

    return {
        storeDomain,
        storefrontAccessToken,
        apiVersion: process.env.SHOPIFY_API_VERSION || '2024-01',
    };
}

// Make GraphQL request to Shopify Storefront API
async function shopifyFetch<T>(query: string, variables: Record<string, unknown> = {}): Promise<T> {
    const config = getConfig();
    const endpoint = `https://${config.storeDomain}/api/${config.apiVersion}/graphql.json`;

    const response = await fetch(endpoint, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-Shopify-Storefront-Access-Token': config.storefrontAccessToken,
        },
        body: JSON.stringify({ query, variables }),
        next: { revalidate: 60 }, // Cache for 60 seconds
    });

    if (!response.ok) {
        const errorText = await response.text();
        throw new Error(`Shopify API error: ${response.status} - ${errorText}`);
    }

    const json = await response.json();

    if (json.errors) {
        console.error('Shopify GraphQL errors:', json.errors);
        throw new Error(json.errors[0]?.message || 'GraphQL query failed');
    }

    return json.data as T;
}

// Transform Shopify product edge to simplified format
function transformProduct(node: ShopifyProductNode): ShopifyProduct {
    const featuredImage = node.featuredImage || node.images?.edges?.[0]?.node;

    return {
        id: node.id,
        title: node.title,
        handle: node.handle,
        description: node.description || '',
        productType: node.productType || '',
        vendor: node.vendor || '',
        tags: node.tags || [],
        price: {
            amount: node.priceRange?.minVariantPrice?.amount || '0',
            currencyCode: node.priceRange?.minVariantPrice?.currencyCode || 'USD',
        },
        maxPrice: node.priceRange?.maxVariantPrice ? {
            amount: node.priceRange.maxVariantPrice.amount,
            currencyCode: node.priceRange.maxVariantPrice.currencyCode,
        } : undefined,
        image: featuredImage ? {
            url: featuredImage.url,
            altText: featuredImage.altText || node.title,
            width: featuredImage.width,
            height: featuredImage.height,
        } : undefined,
        images: node.images?.edges?.map(edge => ({
            url: edge.node.url,
            altText: edge.node.altText || node.title,
            width: edge.node.width,
            height: edge.node.height,
        })) || [],
        variants: node.variants?.edges?.map(edge => ({
            id: edge.node.id,
            title: edge.node.title,
            availableForSale: edge.node.availableForSale,
            price: {
                amount: edge.node.price.amount,
                currencyCode: edge.node.price.currencyCode,
            },
            image: edge.node.image ? {
                url: edge.node.image.url,
                altText: edge.node.image.altText,
            } : undefined,
        })) || [],
    };
}

// Internal types for Shopify API response
interface ShopifyProductNode {
    id: string;
    title: string;
    handle: string;
    description?: string;
    productType?: string;
    vendor?: string;
    tags?: string[];
    priceRange?: {
        minVariantPrice?: { amount: string; currencyCode: string };
        maxVariantPrice?: { amount: string; currencyCode: string };
    };
    featuredImage?: {
        url: string;
        altText?: string;
        width?: number;
        height?: number;
    };
    images?: {
        edges: Array<{
            node: {
                url: string;
                altText?: string;
                width?: number;
                height?: number;
            };
        }>;
    };
    variants?: {
        edges: Array<{
            node: {
                id: string;
                title: string;
                availableForSale: boolean;
                price: { amount: string; currencyCode: string };
                image?: { url: string; altText?: string };
            };
        }>;
    };
}

interface ProductsQueryResult {
    products: {
        pageInfo: {
            hasNextPage: boolean;
            endCursor: string | null;
        };
        edges: Array<{
            cursor: string;
            node: ShopifyProductNode;
        }>;
    };
}

interface CollectionsQueryResult {
    collections: {
        edges: Array<{
            node: {
                id: string;
                title: string;
                handle: string;
                description?: string;
                image?: { url: string; altText?: string };
                productsCount?: { count: number };
            };
        }>;
    };
}

interface CollectionProductsQueryResult {
    collectionByHandle: {
        id: string;
        title: string;
        description?: string;
        products: {
            pageInfo: {
                hasNextPage: boolean;
                endCursor: string | null;
            };
            edges: Array<{
                cursor: string;
                node: ShopifyProductNode;
            }>;
        };
    } | null;
}

// API Functions

export async function getProducts(options: {
    first?: number;
    after?: string;
    query?: string;
    sortKey?: 'TITLE' | 'PRICE' | 'BEST_SELLING' | 'CREATED' | 'UPDATED_AT';
    reverse?: boolean;
}): Promise<ShopifyProductsResponse> {
    const { first = 20, after, query, sortKey, reverse } = options;

    const data = await shopifyFetch<ProductsQueryResult>(PRODUCTS_QUERY, {
        first,
        after,
        query,
        sortKey,
        reverse,
    });

    return {
        products: data.products.edges.map(edge => transformProduct(edge.node)),
        pageInfo: data.products.pageInfo,
    };
}

export async function getProductByHandle(handle: string): Promise<ShopifyProduct | null> {
    const data = await shopifyFetch<{ productByHandle: ShopifyProductNode | null }>(
        PRODUCT_BY_HANDLE_QUERY,
        { handle }
    );

    if (!data.productByHandle) {
        return null;
    }

    return transformProduct(data.productByHandle);
}

export async function getCollections(first: number = 20): Promise<ShopifyCollectionsResponse> {
    const data = await shopifyFetch<CollectionsQueryResult>(COLLECTIONS_QUERY, { first });

    const collections: ShopifyCollection[] = data.collections.edges.map(edge => ({
        id: edge.node.id,
        title: edge.node.title,
        handle: edge.node.handle,
        description: edge.node.description,
        image: edge.node.image ? {
            url: edge.node.image.url,
            altText: edge.node.image.altText,
        } : undefined,
        productsCount: edge.node.productsCount?.count || 0,
    }));

    return { collections };
}

export async function getCollectionProducts(options: {
    handle: string;
    first?: number;
    after?: string;
}): Promise<ShopifyProductsResponse | null> {
    const { handle, first = 20, after } = options;

    const data = await shopifyFetch<CollectionProductsQueryResult>(COLLECTION_PRODUCTS_QUERY, {
        handle,
        first,
        after,
    });

    if (!data.collectionByHandle) {
        return null;
    }

    return {
        products: data.collectionByHandle.products.edges.map(edge => transformProduct(edge.node)),
        pageInfo: data.collectionByHandle.products.pageInfo,
    };
}

// Furniture-specific helpers

// Furniture-specific helpers

function getMockProducts(count: number): ShopifyProduct[] {
    return Array(count).fill(null).map((_, i) => ({
        id: `mock-product-${i}`,
        title: `Mock Furniture Item ${i + 1}`,
        handle: `mock-furniture-${i + 1}`,
        description: 'This is a mock product generated because the Shopify API connection failed.',
        productType: 'Furniture',
        vendor: 'Comfy Mock',
        tags: ['Furniture', 'Mock'],
        price: { amount: '299.00', currencyCode: 'USD' },
        featuredImage: {
            url: '/images/placeholder-staged.jpg',
            altText: 'Mock Furniture',
            width: 800,
            height: 600
        },
        images: [{
            url: '/images/placeholder-staged.jpg',
            altText: 'Mock Furniture',
            width: 800,
            height: 600
        }],
        variants: []
    }));
}

export async function getFurnitureProducts(options: {
    category?: string;
    first?: number;
    after?: string;
}): Promise<ShopifyProductsResponse> {
    const { category, first = 20, after } = options;

    // Build query filter for furniture
    let query = 'product_type:furniture OR tag:furniture';

    if (category) {
        query = `(${query}) AND (product_type:${category} OR tag:${category})`;
    }

    try {
        return await getProducts({ first, after, query });
    } catch (e) {
        console.warn(`Shopify API failed for furniture (category: ${category}), returning mocks. Error: ${e}`);
        return {
            products: getMockProducts(first),
            pageInfo: { hasNextPage: false, endCursor: null }
        };
    }
}

export async function searchFurniture(searchTerm: string, first: number = 20): Promise<ShopifyProductsResponse> {
    const query = `title:*${searchTerm}* OR tag:*${searchTerm}*`;
    try {
        return await getProducts({ first, query });
    } catch (e) {
        console.warn(`Shopify search failed, returning mocks. Error: ${e}`);
        return {
             products: getMockProducts(first),
             pageInfo: { hasNextPage: false, endCursor: null }
        };
    }
}
