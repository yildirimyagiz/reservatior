'use client';

import { useState, useCallback } from 'react';
import { motion } from 'framer-motion';
import { Upload, Image as ImageIcon, X } from 'lucide-react';
import { cn } from '@/lib/utils';

interface DropzoneProps {
    onImageUpload: (imageData: string, fileName: string) => void;
    currentImage: string | null;
    onClear: () => void;
    dictionary: {
        uploadRoom: string;
        dragDrop: string;
    };
}

export function Dropzone({
    onImageUpload,
    currentImage,
    onClear,
    dictionary,
}: DropzoneProps) {
    const [isDragging, setIsDragging] = useState(false);

    const handleFile = useCallback(
        (file: File) => {
            if (!file.type.startsWith('image/')) return;

            const reader = new FileReader();
            reader.onload = (e) => {
                const result = e.target?.result as string;
                onImageUpload(result, file.name);
            };
            reader.readAsDataURL(file);
        },
        [onImageUpload]
    );

    const handleDrop = useCallback(
        (e: React.DragEvent) => {
            e.preventDefault();
            setIsDragging(false);

            const file = e.dataTransfer.files[0];
            if (file) handleFile(file);
        },
        [handleFile]
    );

    const handleDragOver = (e: React.DragEvent) => {
        e.preventDefault();
        setIsDragging(true);
    };

    const handleDragLeave = () => {
        setIsDragging(false);
    };

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (file) handleFile(file);
    };

    if (currentImage) {
        return (
            <div className="relative overflow-hidden rounded-xl border border-slate-700">
                {/* eslint-disable-next-line @next/next/no-img-element */}
                <img
                    src={currentImage}
                    alt="Uploaded room"
                    className="h-auto w-full object-cover"
                    style={{ maxHeight: '400px' }}
                />
                <button
                    onClick={onClear}
                    className="absolute right-2 top-2 rounded-lg bg-slate-900/80 p-2 text-white backdrop-blur-sm transition-colors hover:bg-red-500"
                >
                    <X className="h-4 w-4" />
                </button>
            </div>
        );
    }

    return (
        <motion.label
            onDrop={handleDrop}
            onDragOver={handleDragOver}
            onDragLeave={handleDragLeave}
            className={cn(
                'flex cursor-pointer flex-col items-center justify-center rounded-xl border-2 border-dashed p-12 transition-colors',
                isDragging
                    ? 'border-purple-500 bg-purple-500/10'
                    : 'border-slate-700 bg-slate-800/30 hover:border-slate-600 hover:bg-slate-800/50'
            )}
            whileHover={{ scale: 1.01 }}
            whileTap={{ scale: 0.99 }}
        >
            <input
                type="file"
                accept="image/*"
                onChange={handleInputChange}
                className="hidden"
            />
            <div className="mb-4 flex h-14 w-14 items-center justify-center rounded-full bg-slate-700/50">
                {isDragging ? (
                    <ImageIcon className="h-7 w-7 text-purple-400" />
                ) : (
                    <Upload className="h-7 w-7 text-slate-400" />
                )}
            </div>
            <p className="mb-1 text-sm font-medium text-white">
                {dictionary.uploadRoom}
            </p>
            <p className="text-xs text-slate-400">{dictionary.dragDrop}</p>
        </motion.label>
    );
}
