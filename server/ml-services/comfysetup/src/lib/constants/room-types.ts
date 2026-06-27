import { Armchair, Bed, Utensils, ChefHat, Briefcase, Bath, Sun, LucideIcon } from 'lucide-react';
import { RoomType } from '../store/canvas-store';

export const ROOM_OPTIONS: { value: RoomType; label: string; icon: LucideIcon; image: string }[] = [
  {
    value: 'living-room',
    label: 'Living Room',
    icon: Armchair,
    image: '/images/rooms/staged/living-room-1.jpg',
  },
  {
    value: 'bedroom',
    label: 'Bedroom',
    icon: Bed,
    image: '/images/rooms/staged/living-room-2.png',
  },
  {
    value: 'dining-room',
    label: 'Dining Room',
    icon: Utensils,
    image: '/samples/after_dining.png',
  },
  {
    value: 'kitchen',
    label: 'Kitchen',
    icon: ChefHat,
    image: '/images/rooms/staged/living-room-3.png',
  },
  {
    value: 'office',
    label: 'Office',
    icon: Briefcase,
    image: '/images/generated/office-staged.png',
  },
  {
    value: 'bathroom',
    label: 'Bathroom',
    icon: Bath,
    image: '/images/generated/bedroom-staged.png',
  },
  {
    value: 'outdoor',
    label: 'Outdoor',
    icon: Sun,
    image: '/images/generated/living-room-staged.png',
  },
];
