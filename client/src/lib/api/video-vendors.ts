import { apiClient } from "./client";

// Video Vendor Types
export type VendorTier = "BASIC" | "PROFESSIONAL" | "ENTERPRISE" | "PREMIUM";
export type VendorStatus = "ACTIVE" | "INACTIVE" | "SUSPENDED" | "PENDING_VERIFICATION";
export type ServiceType = "VIDEO_PRODUCTION" | "PHOTOGRAPHY" | "DRONE_FOOTAGE" | "VIRTUAL_TOUR" | "3D_TOUR" | "LIVE_STREAMING";

export interface VideoVendor {
  id: string;
  orgId: string;
  name: string;
  description?: string;
  tier: VendorTier;
  status: VendorStatus;
  contactEmail: string;
  contactPhone?: string;
  website?: string;
  address?: string;
  city?: string;
  state?: string;
  zip?: string;
  country?: string;
  serviceAreas: string[];
  services: ServiceType[];
  pricing: {
    basePrice: number;
    perHourRate?: number;
    perVideoRate?: number;
    packagePricing?: Array<{
      name: string;
      price: number;
      duration: string;
      features: string[];
    }>;
  };
  capabilities: {
    videoResolution: string[];
    audioQuality: string[];
    editingSoftware: string[];
    equipment: string[];
    turnaroundTime: number; // hours
    revisions: number;
  };
  quality: {
    averageRating: number;
    totalReviews: number;
    qualityScore: number;
    reliabilityScore: number;
    communicationScore: number;
  };
  availability: {
    timezone: string;
    workingHours: {
      start: string;
      end: string;
      days: string[];
    };
    bookingLeadTime: number; // days
  };
  verification: {
    isVerified: boolean;
    verifiedAt?: string;
    verificationDocuments?: string[];
    backgroundCheck: {
      status: "PENDING" | "PASSED" | "FAILED";
      checkedAt?: string;
    };
  };
  financial: {
    totalEarnings: number;
    activePartnerships: number;
    completedVideos: number;
    averageRevenuePerVideo: number;
  };
  settings: {
    autoAcceptBookings: boolean;
    requireDeposit: boolean;
    depositPercentage: number;
    cancellationPolicy: string;
    insuranceRequired: boolean;
  };
  metadata?: Record<string, any>;
  createdAt: string;
  updatedAt: string;
  
  // Relations
  organization?: {
    id: string;
    name: string;
    type: string;
    region: string;
  };
  partnerships?: Array<{
    id: string;
    agentId: string;
    orgId: string;
    status: string;
    commissionRate: number;
    startDate: string;
    endDate?: string;
    agent?: {
      id: string;
      name: string;
      email: string;
      experienceLevel: string;
    };
    organization?: {
      id: string;
      name: string;
      type: string;
    };
    videos?: Array<{
      id: string;
      title: string;
      status: string;
    }>;
    partnershipEarnings?: Array<{
      id: string;
      amount: number;
      date: string;
    }>;
  }>;
  videos?: Array<{
    id: string;
    title: string;
    status: string;
    property?: {
      id: string;
      name: string;
      addressLine1: string;
      city: string;
      state: string;
      areaSqm: number;
      bedrooms: number;
      bathrooms: number;
    };
    agent?: {
      id: string;
      name: string;
      email: string;
      experienceLevel: string;
    };
    partnership?: {
      id: string;
      commissionRate: number;
    };
    videoEarnings?: Array<{
      id: string;
      amount: number;
      date: string;
    }>;
    qualityReviews?: Array<{
      id: string;
      rating: number;
      comment: string;
      reviewedAt: string;
      reviewer?: {
        id: string;
        name: string;
        email: string;
      };
    }>;
  }>;
  vendorEarnings?: Array<{
    id: string;
    amount: number;
    date: string;
    video?: {
      id: string;
      title: string;
      property?: {
        id: string;
        name: string;
      };
      agent?: {
        id: string;
        name: string;
      };
    };
  }>;
  qualityReviews?: Array<{
    id: string;
    rating: number;
    comment: string;
    reviewedAt: string;
    reviewer?: {
      id: string;
      name: string;
      email: string;
    };
  }>;
}

export const videoVendorsApi = {
  // Basic CRUD
  getAll: async (params?: { 
    page?: number; 
    limit?: number; 
    tier?: VendorTier; 
    status?: VendorStatus; 
    orgId?: string; 
    serviceAreas?: string[];
    search?: string;
  }) => {
    return await apiClient.get("/video-vendors", { params });
  },
  
  getById: async (id: string): Promise<VideoVendor> => {
    return await apiClient.get(`/video-vendors/${id}`);
  },
  
  create: async (data: Partial<VideoVendor>): Promise<VideoVendor> => {
    return await apiClient.post("/video-vendors", data);
  },
  
  update: async (id: string, data: Partial<VideoVendor>): Promise<VideoVendor> => {
    return await apiClient.put(`/video-vendors/${id}`, data);
  },
  
  delete: async (id: string): Promise<void> => {
    await apiClient.delete(`/video-vendors/${id}`);
  },

  // Status Management
  activate: async (id: string): Promise<VideoVendor> => {
    return await apiClient.patch(`/video-vendors/${id}/activate`);
  },
  
  deactivate: async (id: string): Promise<VideoVendor> => {
    return await apiClient.patch(`/video-vendors/${id}/deactivate`);
  },
  
  suspend: async (id: string, reason?: string): Promise<VideoVendor> => {
    return await apiClient.post(`/video-vendors/${id}/suspend`, { reason });
  },

  // Verification
  verify: async (id: string, documents?: string[]): Promise<VideoVendor> => {
    return await apiClient.post(`/video-vendors/${id}/verify`, { documents });
  },
  
  requestVerification: async (id: string): Promise<VideoVendor> => {
    return await apiClient.post(`/video-vendors/${id}/request-verification`);
  },

  // Capabilities & Testing
  testConnection: async (id: string): Promise<{
    success: boolean;
    message: string;
    responseTime: number;
  }> => {
    return await apiClient.post(`/video-vendors/${id}/test`);
  },
  
  getCapabilities: async (id: string): Promise<{
    services: ServiceType[];
    equipment: string[];
    software: string[];
    qualityMetrics: Record<string, number>;
  }> => {
    return await apiClient.get(`/video-vendors/${id}/capabilities`);
  },

  // Partnerships
  createPartnership: async (vendorId: string, data: {
    agentId: string;
    commissionRate: number;
    startDate: string;
    endDate?: string;
    terms?: string;
  }): Promise<any> => {
    return await apiClient.post(`/video-vendors/${vendorId}/partnerships`, data);
  },
  
  getPartnerships: async (vendorId: string): Promise<any[]> => {
    return await apiClient.get(`/video-vendors/${vendorId}/partnerships`);
  },
  
  updatePartnership: async (vendorId: string, partnershipId: string, data: {
    commissionRate?: number;
    status?: string;
    endDate?: string;
  }): Promise<any> => {
    return await apiClient.put(`/video-vendors/${vendorId}/partnerships/${partnershipId}`, data);
  },

  // Analytics & Performance
  getAnalytics: async (vendorId: string, filters?: {
    startDate?: string;
    endDate?: string;
    period?: "daily" | "weekly" | "monthly";
  }): Promise<{
    totalEarnings: number;
    completedVideos: number;
    averageRating: number;
    revenueTrends: Array<{
      date: string;
      earnings: number;
      videos: number;
    }>;
    performanceMetrics: Record<string, number>;
    topServices: Array<{
      service: ServiceType;
      count: number;
      revenue: number;
    }>;
  }> => {
    return await apiClient.get(`/video-vendors/${vendorId}/analytics`, { params: filters });
  },

  // Quality & Reviews
  getQualityReviews: async (vendorId: string, params?: {
    rating?: number;
    startDate?: string;
    endDate?: string;
    page?: number;
    limit?: number;
  }): Promise<any> => {
    return await apiClient.get(`/video-vendors/${vendorId}/reviews`, { params });
  },
  
  submitReview: async (vendorId: string, data: {
    rating: number;
    comment?: string;
    videoId?: string;
  }): Promise<any> => {
    return await apiClient.post(`/video-vendors/${vendorId}/reviews`, data);
  },

  // Search & Discovery
  search: async (query: string, filters?: {
    serviceAreas?: string[];
    services?: ServiceType[];
    tier?: VendorTier;
    minRating?: number;
    maxPrice?: number;
    location?: string;
  }): Promise<{
    vendors: VideoVendor[];
    total: number;
    suggestions?: string[];
  }> => {
    return await apiClient.get(`/video-vendors/search`, { 
      params: { query, ...filters } 
    });
  },
  
  getByTier: async (tier: VendorTier, params?: {
    page?: number;
    limit?: number;
    sortBy?: "rating" | "price" | "experience";
    sortOrder?: "asc" | "desc";
  }): Promise<{
    vendors: VideoVendor[];
    pagination: {
      page: number;
      limit: number;
      total: number;
      pages: number;
    };
  }> => {
    return await apiClient.get(`/video-vendors/tiers/${tier}`, { params });
  },

  // Earnings & Financial
  getEarnings: async (vendorId: string, filters?: {
    startDate?: string;
    endDate?: string;
    type?: "all" | "partnership" | "direct";
  }): Promise<{
    totalEarnings: number;
    earningsBreakdown: Array<{
      type: string;
      amount: number;
      percentage: number;
    }>;
    recentEarnings: Array<{
      id: string;
      amount: number;
      date: string;
      source: string;
    }>;
    projectedEarnings: number;
  }> => {
    return await apiClient.get(`/video-vendors/${vendorId}/earnings`, { params: filters });
  },

  // Availability & Booking
  getAvailability: async (vendorId: string, params?: {
    startDate?: string;
    endDate?: string;
    serviceType?: ServiceType;
  }): Promise<{
    availableSlots: Array<{
      date: string;
      startTime: string;
      endTime: string;
      available: boolean;
    }>;
    bookingLeadTime: number;
    timezone: string;
  }> => {
    return await apiClient.get(`/video-vendors/${vendorId}/availability`, { params });
  },
  
  createBooking: async (vendorId: string, data: {
    propertyId: string;
    serviceType: ServiceType;
    scheduledDate: string;
    duration: number;
    specialRequirements?: string;
    budget?: number;
  }): Promise<any> => {
    return await apiClient.post(`/video-vendors/${vendorId}/bookings`, data);
  },

  // Portfolio & Showcase
  getPortfolio: async (vendorId: string, params?: {
    serviceType?: ServiceType;
    limit?: number;
    featured?: boolean;
  }): Promise<{
    videos: Array<{
      id: string;
      title: string;
      thumbnail: string;
      duration: number;
      views: number;
      likes: number;
      featured: boolean;
      property?: {
        id: string;
        name: string;
        address: string;
      };
    }>;
    totalVideos: number;
  }> => {
    return await apiClient.get(`/video-vendors/${vendorId}/portfolio`, { params });
  },
  
  uploadPortfolioVideo: async (vendorId: string, data: {
    title: string;
    description?: string;
    propertyId?: string;
    serviceType: ServiceType;
    video: File;
    thumbnail?: File;
  }): Promise<any> => {
    const formData = new FormData();
    formData.append("title", data.title);
    if (data.description) formData.append("description", data.description);
    if (data.propertyId) formData.append("propertyId", data.propertyId);
    formData.append("serviceType", data.serviceType);
    formData.append("video", data.video);
    if (data.thumbnail) formData.append("thumbnail", data.thumbnail);

    return await apiClient.post(`/video-vendors/${vendorId}/portfolio`, formData);
  },
};
