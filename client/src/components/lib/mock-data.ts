import { t } from "i18next";
import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";
export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
export interface Property {
  id: string;
  title: string;
  address: string;
  price: string;
  stats: {
    beds: number;
    baths: number;
    sqft: number;
  };
  description: string;
  type: "Villa" | "Apartment" | "Penthouse";
  region: "USA" | "Europe" | "Turkey";
  images: string[];
  coverImage: string;
  agent: {
    name: string;
    avatar: string;
  };
  status: "available" | "sold" | "pending";
  featured: boolean;
  createdAt: Date;
  updatedAt: Date;
}

// Fallback mock data for development
export const MOCK_PROPERTIES: Property[] = [{
  id: "1",
  title: t("client.src.modern_luxury_villa"),
  address: "123 Sunset Blvd, Beverly Hills",
  price: "$2,500,000",
  stats: {
    beds: 4,
    baths: 3,
    sqft: 3500
  },
  description: t("client.src.stunning_modern_villa_with"),
  type: "Villa",
  region: "USA",
  images: [],
  coverImage: "",
  agent: {
    name: "John Doe",
    avatar: ""
  },
  status: "available",
  featured: true,
  createdAt: new Date(),
  updatedAt: new Date()
}];
export function formatPrice(price: number): string {
  if (price >= 1000000) {
    return `$${(price / 1000000).toFixed(1)}M`;
  }
  return `$${price.toLocaleString()}`;
}