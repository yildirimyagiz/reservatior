import { RoomType } from '@/types';

export interface SampleImage {
    id: string;
    url: string;
    label: string;
    roomType: RoomType;
    credit: {
        name: string;
        username: string;
    };
}

export const SAMPLE_IMAGES: SampleImage[] = [
    {
        id: 'sample-living-room',
        url: 'https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?q=80&w=1974&auto=format&fit=crop',
        label: 'Modern Living Room',
        roomType: 'living-room',
        credit: {
            name: 'R-Architecture',
            username: 'rarchitecture'
        }
    },
    {
        id: 'sample-bedroom',
        url: 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=2070&auto=format&fit=crop',
        label: 'Empty Bedroom',
        roomType: 'bedroom',
        credit: {
            name: 'Christopher Jolly',
            username: 'christopher__burns'
        }
    },
    {
        id: 'sample-pool',
        url: 'https://images.unsplash.com/photo-1572331165267-854da2b00cc6?q=80&w=2070&auto=format&fit=crop',
        label: 'Backyard Pool',
        roomType: 'outdoor',
        credit: {
            name: 'Dim Hou',
            username: 'dimhou'
        }
    },
    {
        id: 'sample-office',
        url: 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=2069&auto=format&fit=crop',
        label: 'Empty Office Space',
        roomType: 'office',
        credit: {
            name: 'Nastuh Abootalebi',
            username: 'nastuh'
        }
    }
];
