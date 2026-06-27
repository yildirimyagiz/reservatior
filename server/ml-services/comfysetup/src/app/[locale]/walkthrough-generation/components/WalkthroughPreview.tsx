"use client";

import React from 'react';
import { Play, Video } from 'lucide-react';

interface WalkthroughPreviewProps {
  videoUrl: string | null;
  isProcessing: boolean;
  pipelineUsed?: string;
}

const WalkthroughPreview: React.FC<WalkthroughPreviewProps> = ({
  videoUrl,
  isProcessing
  // pipelineUsed // Could be used for overlay info
}) => {
  if (!videoUrl && !isProcessing) return null;

  return (
    <div className="bg-white dark:bg-slate-900 rounded-lg border border-slate-200 dark:border-slate-800 p-6">
      <h3 className="text-lg font-semibold mb-4 flex items-center gap-2">
        <Play size={20} className="text-blue-500" />
        Preview
      </h3>
      
      <div className="relative aspect-video bg-black rounded-lg overflow-hidden flex items-center justify-center">
        {isProcessing ? (
           <div className="text-center">
             <Video size={48} className="text-white/20 mx-auto animate-pulse" />
             <p className="text-white/50 mt-4 text-sm">Generating Walkthrough...</p>
             <p className="text-white/30 text-xs mt-1">Estimating geometry & camera path</p>
           </div>
        ) : videoUrl ? (
          <video 
            src={videoUrl} 
            controls 
            className="w-full h-full"
            playsInline
          />
        ) : null}
      </div>
    </div>
  );
};

export default WalkthroughPreview;
