"use client";

import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

export interface DigitalTwinViewerProps {
  modelId: string;
  className?: string;
}

export const DigitalTwinViewer: React.FC<DigitalTwinViewerProps> = ({ modelId, className = '' }) => {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(true);
  const [loadingProgress, setLoadingProgress] = useState(0);

  useEffect(() => {
    // Simulate loading a heavy 3D GLTF/BIM model
    const interval = setInterval(() => {
      setLoadingProgress(prev => {
        if (prev >= 100) {
          clearInterval(interval);
          setLoading(false);
          return 100;
        }
        return prev + Math.floor(Math.random() * 15) + 5;
      });
    }, 200);

    return () => clearInterval(interval);
  }, [modelId]);

  return (
    <div className={`relative bg-gray-900 rounded-xl overflow-hidden border border-gray-800 shadow-inner flex flex-col ${className}`}>
      
      {/* UI Overlay */}
      <div className="absolute top-4 left-4 z-20 flex gap-2">
        <div className="bg-black/60 backdrop-blur-md text-white px-3 py-1.5 rounded border border-white/10 text-xs font-semibold flex items-center">
          <div className="w-2 h-2 rounded-full bg-green-400 mr-2 animate-pulse"></div>
          {t('os.digital_twin.connected', { defaultValue: 'Digital Twin Connected' })}
        </div>
        <div className="bg-indigo-600/80 backdrop-blur-md text-white px-3 py-1.5 rounded text-xs font-semibold">
          {t('os.digital_twin.model', { defaultValue: 'Model' })}: {modelId}
        </div>
      </div>

      <div className="absolute bottom-4 right-4 z-20 flex flex-col gap-2">
        <button className="w-8 h-8 rounded-full bg-black/60 backdrop-blur-md border border-white/20 text-white flex items-center justify-center hover:bg-black/80 transition-colors">
          +
        </button>
        <button className="w-8 h-8 rounded-full bg-black/60 backdrop-blur-md border border-white/20 text-white flex items-center justify-center hover:bg-black/80 transition-colors">
          -
        </button>
      </div>

      <div className="absolute bottom-4 left-4 z-20 flex gap-2">
        <button className="px-3 py-1.5 rounded bg-black/60 backdrop-blur-md border border-white/20 text-white text-xs hover:bg-black/80 transition-colors">
          {t('os.digital_twin.floorplan', { defaultValue: 'Floorplan Mode' })}
        </button>
        <button className="px-3 py-1.5 rounded bg-black/60 backdrop-blur-md border border-white/20 text-white text-xs hover:bg-black/80 transition-colors">
          {t('os.digital_twin.measurements', { defaultValue: 'Measurements' })}
        </button>
      </div>

      {/* 3D Canvas Area (Simulated) */}
      <div className="flex-1 w-full h-full relative">
        {loading ? (
          <div className="absolute inset-0 flex flex-col items-center justify-center z-10 bg-gray-900">
            <div className="w-16 h-16 border-4 border-indigo-500 border-t-transparent rounded-full animate-spin mb-4"></div>
            <div className="text-white font-medium">{t('os.digital_twin.initializing', { defaultValue: 'Initializing WebGL Engine...' })}</div>
            <div className="text-gray-400 text-sm mt-2">{t('os.digital_twin.loading_geometry', { defaultValue: 'Loading Model Geometry' })} ({loadingProgress}%)</div>
            <div className="w-64 h-1 bg-gray-800 rounded-full mt-4 overflow-hidden">
              <div 
                className="h-full bg-indigo-500 transition-all duration-300 ease-out"
                style={{ width: `${loadingProgress}%` }}
              ></div>
            </div>
          </div>
        ) : (
          <div className="absolute inset-0 flex items-center justify-center">
            {/* This is a CSS grid representation of a 3D wireframe room for the mock */}
            <div className="relative w-full h-full perspective-1000">
              <div className="absolute inset-0 opacity-20 pointer-events-none select-none overflow-hidden flex items-center justify-center">
                <div className="w-[80%] h-[80%] border border-indigo-500/50 rotate-x-60 rotate-z-45 transform-style-preserve-3d relative flex items-center justify-center transition-transform duration-10000 ease-linear hover:rotate-z-[90deg]">
                  <div className="absolute w-[60%] h-[60%] border border-indigo-400/80 translate-z-32"></div>
                  <div className="absolute w-full h-full border border-indigo-500/30 grid grid-cols-4 grid-rows-4">
                    {Array.from({length: 16}).map((_, i) => (
                      <div key={i} className="border border-indigo-500/20"></div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
            
            <div className="z-10 text-center">
              <div className="text-indigo-300 font-mono text-sm">{t('os.digital_twin.canvas_simulated', { defaultValue: '[WebGL Canvas Simulated]' })}</div>
              <div className="text-gray-500 text-xs mt-1">{t('os.digital_twin.ready_threejs', { defaultValue: 'Ready for Three.js / model-viewer integration' })}</div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
