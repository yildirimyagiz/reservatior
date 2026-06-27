"use client";

import React, { useCallback, useState, useRef } from 'react';
import { Upload, ImagePlus, Lightbulb, Camera, Maximize2 } from 'lucide-react';

interface PhotoUploadZoneProps {
  onPhotosAdd: (files: FileList | File[]) => void;
  maxPhotos: number;
  currentCount: number;
}

const PhotoUploadZone: React.FC<PhotoUploadZoneProps> = ({
  onPhotosAdd,
  maxPhotos,
  currentCount
}) => {
  const [isDragActive, setIsDragActive] = useState(false);
  const inputRef = useRef<HTMLInputElement>(null);

  const handleDrop = useCallback((e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragActive(false);
    
    const files = e.dataTransfer.files;
    if (files && files.length > 0) {
      const imageFiles = Array.from(files).filter(file => 
        file.type.startsWith('image/')
      );
      if (imageFiles.length > 0) {
        onPhotosAdd(imageFiles.slice(0, maxPhotos - currentCount));
      }
    }
  }, [onPhotosAdd, maxPhotos, currentCount]);

  const handleDragOver = useCallback((e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragActive(true);
  }, []);

  const handleDragLeave = useCallback((e: React.DragEvent<HTMLDivElement>) => {
    e.preventDefault();
    setIsDragActive(false);
  }, []);

  const handleClick = () => {
    inputRef.current?.click();
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = e.target.files;
    if (files && files.length > 0) {
      onPhotosAdd(Array.from(files).slice(0, maxPhotos - currentCount));
    }
    if (inputRef.current) {
      inputRef.current.value = '';
    }
  };

  const isDisabled = currentCount >= maxPhotos;

  return (
    <div className="bg-white dark:bg-slate-900 rounded-lg border border-slate-200 dark:border-slate-800 p-6">
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-semibold flex items-center gap-2">
          <ImagePlus size={20} className="text-blue-500" />
          Property Photos
        </h3>
        <span className="text-sm text-slate-500">
          {currentCount} / {maxPhotos} photos
        </span>
      </div>

      <input
        ref={inputRef}
        type="file"
        accept="image/*"
        multiple
        onChange={handleFileChange}
        className="hidden"
        disabled={isDisabled}
      />

      <div
        onClick={!isDisabled ? handleClick : undefined}
        onDrop={!isDisabled ? handleDrop : undefined}
        onDragOver={!isDisabled ? handleDragOver : undefined}
        onDragLeave={!isDisabled ? handleDragLeave : undefined}
        className={`
          border-2 border-dashed rounded-lg p-8 text-center transition-all
          ${isDragActive 
            ? 'border-blue-500 bg-blue-50 dark:bg-blue-900/20' 
            : 'border-slate-300 dark:border-slate-700 hover:border-blue-400 hover:bg-slate-50 dark:hover:bg-slate-800'
          }
          ${isDisabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'}
        `}
      >
        <div className="flex flex-col items-center gap-3">
          <div className={`
            w-16 h-16 rounded-full flex items-center justify-center
            ${isDragActive ? 'bg-blue-100 dark:bg-blue-900/40' : 'bg-slate-100 dark:bg-slate-800'}
          `}>
            {isDragActive ? (
              <Upload size={28} className="text-blue-500" />
            ) : (
              <ImagePlus size={28} className="text-slate-400" />
            )}
          </div>
          
          {isDragActive ? (
            <p className="font-medium">Drop your photos here</p>
          ) : (
            <>
              <div>
                <p className="font-medium">Drag & drop property photos</p>
                <p className="text-sm text-slate-500 mt-1">or click to browse</p>
              </div>
            </>
          )}
        </div>
      </div>

      <div className="mt-4 grid grid-cols-1 sm:grid-cols-3 gap-3">
        <div className="flex items-start gap-2 p-3 bg-slate-50 dark:bg-slate-800/50 rounded-lg">
          <Lightbulb size={16} className="text-yellow-500 mt-0.5 flex-shrink-0" />
          <div className="text-xs text-slate-600 dark:text-slate-400">
            <span className="font-medium text-slate-900 dark:text-slate-200">Tip:</span> More photos = better 3D
          </div>
        </div>
        <div className="flex items-start gap-2 p-3 bg-slate-50 dark:bg-slate-800/50 rounded-lg">
          <Camera size={16} className="text-blue-500 mt-0.5 flex-shrink-0" />
          <div className="text-xs text-slate-600 dark:text-slate-400">
            <span className="font-medium text-slate-900 dark:text-slate-200">Best:</span> 15+ photos for Gaussian
          </div>
        </div>
        <div className="flex items-start gap-2 p-3 bg-slate-50 dark:bg-slate-800/50 rounded-lg">
          <Maximize2 size={16} className="text-green-500 mt-0.5 flex-shrink-0" />
          <div className="text-xs text-slate-600 dark:text-slate-400">
            <span className="font-medium text-slate-900 dark:text-slate-200">Quality:</span> Use high-res images
          </div>
        </div>
      </div>
    </div>
  );
};

export default PhotoUploadZone;
