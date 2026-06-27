declare module 'amazon-buddy' {
    export interface AmazonProduct {
        asin: string;
        discount?: string;
        price?: {
            current_price: number;
            currency: string;
            before_price: number;
            savings_amount: number;
            savings_percent: number;
        };
        reviews?: {
            total_reviews: number;
            rating: number;
        };
        title: string;
        thumbnail: string;
        url: string;
        description?: string;
        sponsored?: boolean;
        amazonChoice?: boolean;
        bestSeller?: boolean;
        amazonPrime?: boolean;
    }

    export interface AmazonSearchResult {
        totalProducts: number | string;
        category: string;
        result: AmazonProduct[];
    }

    export interface SearchOptions {
        keyword: string;
        number?: number;
        country?: string;
        sort?: string;
        rating?: number;
        min_price?: number;
        max_price?: number;
        page?: number;
    }

    export function products(options: SearchOptions): Promise<AmazonSearchResult>;
    export function asin(options: { asin: string; country?: string }): Promise<AmazonProduct>;
}
