import React, { useEffect } from 'react';
import { useRegionsStore } from '@/lib/store/regions-store';
import { Globe } from 'lucide-react';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';
import { Button } from '@/components/ui/button';

export default function RegionSelector() {
  const { regions, selectedRegion, loadRegions, setSelectedRegion } = useRegionsStore();

  useEffect(() => {
    loadRegions();
  }, [loadRegions]);

  if (!selectedRegion) {
    return (
      <Button variant="ghost" size="sm" className="hidden lg:flex" disabled>
        <Globe className="w-4 h-4 mr-2" />
        Loading...
      </Button>
    );
  }

  return (
    <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="ghost" size="sm" className="hidden lg:flex items-center gap-2">
          <Globe className="w-4 h-4" />
          <span className="font-semibold text-xs tracking-wider">
            {selectedRegion.countryCode.toUpperCase()}
          </span>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end" className="w-48 bg-card dark:bg-card border border-gray-200 dark:border-white/10 z-50">
        {regions.map((region) => (
          <DropdownMenuItem
            key={region.countryCode}
            onClick={() => setSelectedRegion(region.countryCode)}
            className="cursor-pointer text-xs font-semibold tracking-wider hover:bg-gray-100 dark:hover:bg-white/5"
          >
            <div className="flex items-center gap-2 w-full justify-between">
              <span>{region.countryName}</span>
              <span className="text-gray-400">{region.countryCode.toUpperCase()}</span>
            </div>
          </DropdownMenuItem>
        ))}
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
