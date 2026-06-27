export interface BrochureTemplate {
  id: string;
  name: string;
  description: string;
  isPremium: boolean;
  thumbnailUrl?: string;
}

export interface BrochureInput {
  propertyId?: string;
  templateId: string;
  customPhotos?: string[];
  // Ad-hoc
  title?: string;
  address?: string;
  description?: string;
  price?: number;
  bedrooms?: number;
  bathrooms?: number;
  sqft?: number;
}

export const brochureService = {
  getTemplates: async (): Promise<BrochureTemplate[]> => {
    const res = await fetch("/api/v1/brochures/templates");
    if (!res.ok) throw new Error("Failed to fetch templates");
    const data = await res.json();
    return data.templates;
  },

  generate: async (input: BrochureInput): Promise<Blob> => {
    const res = await fetch("/api/v1/brochures/generate", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(input),
    });
    
    if (!res.ok) {
        const text = await res.text();
        throw new Error(text || "Failed to generate brochure");
    }
    
    // Returns PDF blob
    return res.blob();
  }
};

