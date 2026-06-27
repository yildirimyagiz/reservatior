"use client";

import React from 'react';
import { Grid3X3, Info, X } from 'lucide-react';
import Image from 'next/image';

interface Photo {
  id: string;
  name: string;
  url: string;
  roomType?: string;
}

interface PhotoGridProps {
  photos: Photo[];
  onRemove: (photoId: string) => void;
  onRoomTypeChange: (photoId: string, roomType: string) => void;
  roomTypeOptions: { value: string; label: string }[];
}

const PhotoGrid: React.FC<PhotoGridProps> = ({
  photos,
  onRemove,
  onRoomTypeChange,
  roomTypeOptions
}) => {
  if (photos.length === 0) return null;

  return (
    <div className="bg-white dark:bg-slate-900 rounded-lg border border-slate-200 dark:border-slate-800 p-6">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-semibold flex items-center gap-2">
          <Grid3X3 size={20} className="text-blue-500" />
          Uploaded Photos ({photos.length})
        </h3>
        <div className="flex items-center gap-2 text-sm text-slate-500">
          <Info size={14} />
          Click to set room type
        </div>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3">
        {photos.map((photo, index) => (
          <div key={photo.id} className="relative group rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-slate-100 dark:bg-slate-800">
            <div className="aspect-square relative">
              <Image 
                src={photo.url} 
                alt={photo.name} 
                fill
                className="object-cover"
                unoptimized // Required for blob URLs
              />
              <div className="absolute top-2 left-2 w-6 h-6 rounded-full bg-black/70 text-white text-xs flex items-center justify-center font-medium z-10">
                {index + 1}
              </div>
              <button
                onClick={() => onRemove(photo.id)}
                className="absolute top-2 right-2 w-6 h-6 rounded-full bg-red-500/80 text-white opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center hover:bg-red-500 z-10"
              >
                <X size={14} />
              </button>
            </div>
            <div className="p-2">
              <select
                value={photo.roomType || 'room'}
                onChange={(e) => onRoomTypeChange(photo.id, e.target.value)}
                className="w-full text-xs bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded px-2 py-1.5 focus:outline-none focus:border-blue-500"
              >
                {roomTypeOptions.map(option => (
                  <option key={option.value} value={option.value}>{option.label}</option>
                ))}
              </select>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default PhotoGrid;
