import { type ClassValue, clsx } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

const API_BASE = typeof window !== 'undefined' 
  ? '/api/v1' 
  : '';

export function resolveMediaUrl(url: string | undefined | null): string | undefined {
  if (!url) return undefined;
  
  // Filter out fake/dummy domains from the database so they fallback to local assets
  if (url.includes('example.com') || url.includes('cdn.example.com')) {
    return undefined;
  }
  
  if (url.startsWith('http://') || url.startsWith('https://') || url.startsWith('data:')) return url;
  if (url.startsWith('/uploads/') || url.startsWith('/data/')) {
    return url;
  }
  return url;
}
