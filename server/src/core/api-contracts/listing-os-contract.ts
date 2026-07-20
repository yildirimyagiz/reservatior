/**
 * Listing OS API Contract
 * Defines the API interface for Listing OS operations
 */

export interface ListingOSAPIContract {
  // Listing CRUD Operations
  createListing(params: CreateListingParams): Promise<ListingResponse>;
  getListing(listingId: string): Promise<ListingResponse>;
  updateListing(listingId: string, params: UpdateListingParams): Promise<ListingResponse>;
  deleteListing(listingId: string): Promise<void>;
  
  // Listing Operations
  publishListing(listingId: string): Promise<ListingResponse>;
  unpublishListing(listingId: string): Promise<ListingResponse>;
  featureListing(listingId: string, featured: boolean): Promise<ListingResponse>;
  archiveListing(listingId: string): Promise<void>;
  restoreListing(listingId: string): Promise<ListingResponse>;
  
  // Content Management
  uploadImages(listingId: string, images: File[]): Promise<ImageUploadResponse>;
  updateDescription(listingId: string, description: string): Promise<ListingResponse>;
  updateAmenities(listingId: string, amenities: string[]): Promise<ListingResponse>;
  updatePricing(listingId: string, pricing: PricingUpdate): Promise<ListingResponse>;
  updateAvailability(listingId: string, availability: AvailabilityUpdate): Promise<void>;
  
  // Market Analysis
  analyzeMarket(params: MarketAnalysisParams): Promise<MarketAnalysisResponse>;
  getCompetitorListings(listingId: string): Promise<CompetitorResponse[]>;
  
  // SEO Operations
  optimizeSEO(listingId: string): Promise<SEOOptimizationResponse>;
  getSEOScore(listingId: string): Promise<SEOScoreResponse>;
  
  // Analytics Operations
  getListingAnalytics(listingId: string, params: AnalyticsParams): Promise<ListingAnalyticsResponse>;
  getListingViews(listingId: string, params: TimeRangeParams): Promise<ViewDataResponse>;
  getListingInquiries(listingId: string, params: TimeRangeParams): Promise<InquiryDataResponse>;
  
  // Integration Operations
  syncWithMLS(listingId: string): Promise<MLSSyncResponse>;
  manageChannels(listingId: string, channels: ChannelUpdate): Promise<void>;
  
  // Search Operations
  searchListings(params: SearchParams): Promise<SearchResponse>;
  getSimilarListings(listingId: string): Promise<ListingResponse[]>;
}

// Request/Response Types
export interface CreateListingParams {
  propertyId: string;
  agentId: string;
  title: string;
  description: string;
  propertyType: string;
  bedrooms: number;
  bathrooms: number;
  squareFootage: number;
  price: number;
  currency: string;
  amenities: string[];
  images: File[];
  availability?: AvailabilityUpdate;
}

export interface UpdateListingParams {
  title?: string;
  description?: string;
  price?: number;
  currency?: string;
  amenities?: string[];
  status?: string;
}

export interface ListingResponse {
  id: string;
  propertyId: string;
  agentId: string;
  title: string;
  description: string;
  propertyType: string;
  bedrooms: number;
  bathrooms: number;
  squareFootage: number;
  price: number;
  currency: string;
  amenities: string[];
  images: string[];
  status: 'draft' | 'pending' | 'published' | 'unpublished' | 'archived' | 'expired';
  featured: boolean;
  seoScore: number;
  viewCount: number;
  inquiryCount: number;
  createdAt: string;
  updatedAt: string;
  publishedAt?: string;
}

export interface ImageUploadResponse {
  listingId: string;
  images: Array<{
    id: string;
    url: string;
    isPrimary: boolean;
  }>;
}

export interface PricingUpdate {
  basePrice: number;
  currency: string;
  weekendSurcharge?: number;
  seasonalAdjustments?: Array<{
    startDate: string;
    endDate: string;
    adjustment: number;
  }>;
  minimumStay?: number;
}

export interface AvailabilityUpdate {
  dates: Array<{
    date: string;
    available: boolean;
    price?: number;
  }>;
}

export interface MarketAnalysisParams {
  location: string;
  propertyType: string;
  priceRange: { min: number; max: number };
  timeRange?: { start: Date; end: Date };
}

export interface MarketAnalysisResponse {
  marketTrends: {
    demand: number;
    supply: number;
    priceTrend: number;
    averageDaysOnMarket: number;
  };
  competitorAnalysis: Array<{
    listingId: string;
    price: number;
    features: string[];
    advantage: string;
  }>;
  recommendations: string[];
  suggestedPrice: number;
}

export interface CompetitorResponse {
  listingId: string;
  title: string;
  price: number;
  currency: string;
  bedrooms: number;
  bathrooms: number;
  squareFootage: number;
  features: string[];
  url: string;
}

export interface SEOOptimizationResponse {
  listingId: string;
  optimizedTitle: string;
  optimizedDescription: string;
  keywords: Array<{
    keyword: string;
    density: number;
  }>;
  metaDescription: string;
  score: number;
  improvements: string[];
}

export interface SEOScoreResponse {
  listingId: string;
  score: number;
  breakdown: {
    title: number;
    description: number;
    images: number;
    keywords: number;
    structure: number;
  };
  recommendations: string[];
}

export interface AnalyticsParams {
  timeRange: { start: Date; end: Date };
  groupBy?: 'day' | 'week' | 'month';
  metrics?: string[];
}

export interface ListingAnalyticsResponse {
  views: number;
  uniqueViews: number;
  inquiries: number;
  conversionRate: number;
  averageTimeOnPage: number;
  breakdown: Array<{
    period: string;
    views: number;
    inquiries: number;
  }>;
}

export interface TimeRangeParams {
  startDate: string;
  endDate: string;
}

export interface ViewDataResponse {
  totalViews: number;
  uniqueViews: number;
  breakdown: Array<{
    date: string;
    views: number;
    uniqueViews: number;
  }>;
  sources: Array<{
    source: string;
    views: number;
    percentage: number;
  }>;
}

export interface InquiryDataResponse {
  totalInquiries: number;
  conversionRate: number;
  averageResponseTime: number;
  breakdown: Array<{
    date: string;
    inquiries: number;
  }>;
}

export interface MLSSyncResponse {
  listingId: string;
  syncStatus: 'success' | 'partial' | 'failed';
  syncedFields: string[];
  errors: string[];
  syncedAt: string;
}

export interface ChannelUpdate {
  channels: Array<{
    platform: string;
    enabled: boolean;
    listingId?: string;
  }>;
}

export interface SearchParams {
  location?: string;
  propertyType?: string;
  priceRange?: { min: number; max: number };
  bedrooms?: number;
  bathrooms?: number;
  amenities?: string[];
  page?: number;
  limit?: number;
}

export interface SearchResponse {
  listings: ListingResponse[];
  total: number;
  page: number;
  limit: number;
  facets: {
    propertyTypes: Array<{ type: string; count: number }>;
    priceRanges: Array<{ range: string; count: number }>;
    amenities: Array<{ amenity: string; count: number }>;
  };
}
