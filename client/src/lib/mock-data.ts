// Mock data for development
import { createPlaceholderImage } from "./placeholder-images";

// Generate placeholder images
const createImageUrls = (count: number, width: number, height: number) =>
  Array.from({ length: count }, () => createPlaceholderImage(width, height));

export const MOCK_PROPERTIES = [
  {
    id: "1",
    title: "Modern Downtown Apartment",
    description: "Stunning 2-bedroom apartment in the heart of downtown",
    price: "$450,000",
    address: "123 Main St, Downtown",
    type: "Apartment" as const,
    region: "USA" as const,
    images: createImageUrls(4, 400, 300),
    coverImage: createPlaceholderImage(400, 300),
    agent: {
      name: "John Smith",
      avatar: createPlaceholderImage(40, 40),
    },
    status: "available" as const,
    stats: {
      beds: 2,
      baths: 2,
      sqft: 1200,
    },
    featured: true,
  },
  {
    id: "2",
    title: "Luxury Penthouse Suite",
    description: "Exclusive penthouse with panoramic city views",
    price: "$1,250,000",
    address: "456 Sky Tower, Downtown",
    type: "Penthouse" as const,
    region: "USA" as const,
    images: createImageUrls(4, 400, 300),
    coverImage: createPlaceholderImage(400, 300),
    agent: {
      name: "Sarah Johnson",
      avatar: createPlaceholderImage(40, 40),
    },
    status: "available" as const,
    stats: {
      beds: 3,
      baths: 3,
      sqft: 2500,
    },
    featured: true,
  },
  {
    id: "3",
    title: "Cozy Suburban Home",
    description: "Perfect family home in quiet neighborhood",
    price: "$650,000",
    address: "789 Oak Lane, Suburbs",
    type: "Villa" as const,
    region: "USA" as const,
    images: createImageUrls(4, 400, 300),
    coverImage: createPlaceholderImage(400, 300),
    agent: {
      name: "Mike Wilson",
      avatar: createPlaceholderImage(40, 40),
    },
    status: "available" as const,
    stats: {
      beds: 4,
      baths: 2,
      sqft: 2000,
    },
    featured: false,
  },
];

export const MOCK_USERS = [
  {
    id: "1",
    name: "John Smith",
    email: "john@example.com",
    role: "agent",
    avatar: createPlaceholderImage(40, 40),
  },
  {
    id: "2",
    name: "Sarah Johnson",
    email: "sarah@example.com",
    role: "client",
    avatar: createPlaceholderImage(40, 40),
  },
];
