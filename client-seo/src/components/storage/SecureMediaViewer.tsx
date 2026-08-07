"use client";

import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

export interface SecureMediaViewerProps {
  mediaId: string;
  type: 'VIDEO' | 'PDF' | 'IMAGE';
  className?: string;
}

export const SecureMediaViewer: React.FC<SecureMediaViewerProps> = ({ mediaId, type, className = '' }) => {
  const { t } = useTranslation();
  const [presignedUrl, setPresignedUrl] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    // Simulate calling the Storage OS gateway to get a short-lived pre-signed URL
    const fetchSignedUrl = async () => {
      try {
        setLoading(true);
        // In reality, this would be an API call like:
        // const response = await fetch(`/api/storage/v1/presigned?id=${mediaId}`);
        // const data = await response.json();
        
        // Mocking the delay and response
        await new Promise(resolve => setTimeout(resolve, 800));
        
        // Mock secure URL
        setPresignedUrl(`https://storage-os.reservatior.com/secure/${mediaId}?token=mock-token-${Date.now()}&expires=300`);
      } catch (err) {
        setError(t('os.storage.failed', { defaultValue: 'Failed to securely load media. You may not have permission.' }));
      } finally {
        setLoading(false);
      }
    };

    fetchSignedUrl();
  }, [mediaId]);

  if (loading) {
    return <div className={`animate-pulse bg-gray-200 rounded flex items-center justify-center ${className}`}>
      <span className="text-gray-500 font-medium">{t('os.storage.authorizing', { defaultValue: 'Authorizing Media Request...' })}</span>
    </div>;
  }

  if (error || !presignedUrl) {
    return <div className={`bg-red-50 text-red-600 rounded flex items-center justify-center p-4 text-center border border-red-200 ${className}`}>
      {error || t('os.storage.unavailable', { defaultValue: 'Media unavailable' })}
    </div>;
  }

  // Render based on media type
  if (type === 'VIDEO') {
    return (
      <div className={`relative bg-black rounded overflow-hidden ${className}`}>
        {/* Placeholder for HLS.js or video.js video element */}
        <div className="absolute inset-0 flex items-center justify-center z-10 pointer-events-none">
          <div className="w-16 h-16 rounded-full bg-white/20 backdrop-blur-sm flex items-center justify-center">
            <div className="w-0 h-0 border-t-8 border-b-8 border-l-[14px] border-t-transparent border-b-transparent border-l-white ml-1"></div>
          </div>
        </div>
        <div className="w-full h-full object-cover opacity-60 flex items-center justify-center text-white text-xs">
          {t('os.storage.stream_active', { defaultValue: '[Storage OS HLS Stream Active]' })}
        </div>
      </div>
    );
  }

  if (type === 'IMAGE') {
    return (
      <div className={`relative bg-gray-100 rounded overflow-hidden ${className}`}>
        {/* eslint-disable-next-line @next/next/no-img-element */}
        <img 
          src={presignedUrl} 
          alt="Secure Media" 
          className="w-full h-full object-cover" 
          onError={(e) => { (e.target as HTMLImageElement).src = 'data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiPjxyZWN0IHdpZHRoPSIxMDAlIiBoZWlnaHQ9IjEwMCUiIGZpbGw9IiNlNWU3ZWIiLz48dGV4dCB4PSI1MCUiIHk9IjUwJSIgZm9udC1mYW1pbHk9InNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMTQiIGZpbGw9IiM5Y2EzYWYiIHRleHQtYW5jaG9yPSJtaWRkbGUiIGR5PSIuM2VtIj5TZWN1cmUgSW1hZ2UgTW9jazwvdGV4dD48L3N2Zz4='; }}
        />
        <div className="absolute bottom-2 right-2 bg-black/60 text-white text-[10px] px-2 py-1 rounded backdrop-blur-sm">
          {t('os.storage.expires', { defaultValue: 'URL Expires in 5m' })}
        </div>
      </div>
    );
  }

  if (type === 'PDF') {
    return (
      <div className={`bg-gray-100 rounded flex flex-col items-center justify-center border border-gray-200 ${className}`}>
        <svg className="w-12 h-12 text-red-500 mb-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
          <path fillRule="evenodd" d="M4 4a2 2 0 012-2h4.586A2 2 0 0112 2.586L15.414 6A2 2 0 0116 7.414V16a2 2 0 01-2 2H6a2 2 0 01-2-2V4zm2 6a1 1 0 011-1h6a1 1 0 110 2H7a1 1 0 01-1-1zm1 3a1 1 0 100 2h6a1 1 0 100-2H7z" clipRule="evenodd"></path>
        </svg>
        <span className="text-gray-700 font-medium text-sm">{t('os.storage.secure_doc', { defaultValue: 'Secure Document (Watermarked)' })}</span>
        <button className="mt-4 px-4 py-1.5 bg-gray-800 text-white rounded text-sm hover:bg-gray-700">
          {t('os.storage.open_viewer', { defaultValue: 'Open Viewer' })}
        </button>
      </div>
    );
  }

  return null;
};
