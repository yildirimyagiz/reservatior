import React from 'react';
import { cn } from '@/lib/utils';

interface LogoProps {
  className?: string;
  showText?: boolean;
}

export function AtlasLogo({ className, showText = true }: LogoProps) {
  return (
    <div className={cn("flex items-center gap-2", className)}>
      {/* Globe Icon */}
      <svg
        width="36"
        height="36"
        viewBox="0 0 36 36"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
        className="shrink-0"
      >
        <defs>
          <linearGradient id="globe-gradient" x1="0" y1="0" x2="36" y2="36" gradientUnits="userSpaceOnUse">
            <stop offset="0%" stopColor="#3b82f6" /> {/* Blue-500 */}
            <stop offset="50%" stopColor="#a855f7" /> {/* Purple-500 */}
            <stop offset="100%" stopColor="#06b6d4" /> {/* Cyan-500 */}
          </linearGradient>
          <linearGradient id="globe-gloss" x1="10" y1="0" x2="26" y2="18" gradientUnits="userSpaceOnUse">
             <stop offset="0%" stopColor="white" stopOpacity="0.8" />
             <stop offset="100%" stopColor="white" stopOpacity="0" />
          </linearGradient>
        </defs>
        
        {/* Main Globe Body */}
        <circle cx="18" cy="18" r="16" fill="url(#globe-gradient)" />
        
        {/* Grid/Latitude Lines (simplified) */}
        <path d="M2 18H34" stroke="white" strokeOpacity="0.2" strokeWidth="1" />
        <path d="M6 9H30" stroke="white" strokeOpacity="0.2" strokeWidth="1" />
        <path d="M6 27H30" stroke="white" strokeOpacity="0.2" strokeWidth="1" />
        
        {/* Longitude Lines (simplified curves) */}
        <ellipse cx="18" cy="18" rx="8" ry="16" stroke="white" strokeOpacity="0.2" fill="none" strokeWidth="1" />
        <line x1="18" y1="2" x2="18" y2="34" stroke="white" strokeOpacity="0.2" strokeWidth="1" />

        {/* Gloss/Shine */}
        <circle cx="12" cy="10" r="6" fill="url(#globe-gloss)" />
      </svg>
      
      {/* Text */}
      {showText && (
        <div className="flex flex-col leading-none">
          <span className="text-xl font-bold tracking-tight text-white">
            <span className="text-cyan-400">Atlas</span>
            <span className="text-purple-400">VS</span>
          </span>
          <span className="text-[9px] font-semibold tracking-widest text-slate-400 uppercase">
            Visual Solutions
          </span>
        </div>
      )}
    </div>
  );
}
