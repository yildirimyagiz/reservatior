'use client';

import { useCanvasStore } from '@/lib/store/canvas-store';
import { cn } from '@/lib/utils';
import { Bed, Armchair, Briefcase, Utensils, ChefHat, Bath, Sun, Activity, Plus } from 'lucide-react';

import { RoomType } from '@/lib/store/canvas-store';

import { LucideIcon } from 'lucide-react';

const ROOMS: { value: RoomType; label: string; icon: LucideIcon }[] = [
    { value: 'living-room', label: 'Living Room', icon: Armchair },
    { value: 'bedroom', label: 'Bedroom', icon: Bed },
    { value: 'dining-room', label: 'Dining', icon: Utensils },
    { value: 'kitchen', label: 'Kitchen', icon: ChefHat },
    { value: 'office', label: 'Office', icon: Briefcase },
    { value: 'bathroom', label: 'Bath', icon: Bath },
    { value: 'outdoor', label: 'Outdoor', icon: Sun },
    { value: 'kids-room', label: 'Kids Room', icon: Bed }, // Reusing Bed for now or find better
    { value: 'home-gym', label: 'Gym', icon: Activity },
    { value: 'add-room', label: 'Add Room', icon: Plus },
];

export function RoomSelector() {
    const { roomType, setRoomType } = useCanvasStore();

    return (
        <div className="space-y-3">
             <label className="text-sm font-medium text-slate-300">Room Type</label>
             
             <div className="flex gap-2 overflow-x-auto pb-2 scrollbar-hide snap-x">
                {ROOMS.map((item) => (
                    <button
                        key={item.value}
                        onClick={() => setRoomType(item.value)}
                        className={cn(
                            "flex-shrink-0 flex flex-col items-center justify-center w-20 h-20 rounded-xl transition-all duration-200 snap-center border",
                            roomType === item.value 
                                ? "bg-purple-600/20 border-purple-500 text-white" 
                                : "bg-slate-800 border-slate-700 text-slate-400 hover:bg-slate-700 hover:border-slate-600"
                        )}
                    >
                        <item.icon className={cn(
                            "mb-2 w-6 h-6",
                            roomType === item.value ? "text-purple-400" : "text-slate-500"
                        )} />
                        <span className="text-[10px] font-medium">{item.label}</span>
                    </button>
                ))}
             </div>
        </div>
    );
}
