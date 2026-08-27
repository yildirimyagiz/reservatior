import React from "react";
import { Ghost, RefreshCcw } from "lucide-react";
import { Button } from "@/components/ui/button";

export interface EmptySearchStateProps {
  onClearFilters: () => void;
}

export function EmptySearchState({ onClearFilters }: EmptySearchStateProps) {
  return (
    <div className="flex flex-col items-center justify-center h-full min-h-[400px] w-full text-center px-4">
      <div className="w-24 h-24 mb-6 rounded-full bg-slate-100 dark:bg-white/5 flex items-center justify-center">
        <Ghost className="w-12 h-12 text-slate-300 dark:text-slate-600" />
      </div>
      <h3 className="text-2xl font-black text-slate-900 dark:text-white mb-2 tracking-tight">
        Sonuç Bulunamadı
      </h3>
      <p className="text-slate-500 max-w-md mb-8">
        Mevcut filtrelerinizle eşleşen bir sonuç bulamadık. Lütfen filtrelerinizi değiştirerek tekrar deneyin.
      </p>
      <Button 
        onClick={onClearFilters} 
        className="bg-brand text-slate-900 dark:text-white hover:bg-brand/90 rounded-xl font-bold px-8 h-12 flex items-center gap-2"
      >
        <RefreshCcw className="w-4 h-4" />
        Filtreleri Temizle
      </Button>
    </div>
  );
}
