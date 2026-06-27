'use client';

import { motion } from 'framer-motion';
import { Home, Image as ImageIcon, FileText, Video } from 'lucide-react';

const features = [
    {
        icon: Home,
        label: "Virtual Staging",
        active: true
    },
    {
        icon: ImageIcon,
        label: "Image to Video",
        active: false
    },
    {
        icon: FileText,
        label: "Pamphlet",
        active: false
    },
    {
        icon: Video,
        label: "Ready to Reel",
        active: false
    }
];

export function CircularNav() {
    return (
        <div className="flex justify-center gap-6 md:gap-12 py-12 flex-wrap">
            {features.map((feature, index) => (
                <div key={index} className="flex flex-col items-center gap-4 group cursor-pointer">
                    <motion.div
                        whileHover={{ scale: 1.05 }}
                        className={`relative w-32 h-32 md:w-40 md:h-40 rounded-full flex items-center justify-center border-4 ${feature.active
                            ? "border-transparent bg-gradient-to-b from-blue-900/50 to-indigo-900/50"
                            : "border-slate-700/50 bg-slate-900/50"
                            }`}
                    >
                        {/* Gradient Border for active state */}
                        {feature.active && (
                            <div className="absolute inset-0 rounded-full border-4 border-transparent [background:linear-gradient(white,white)_padding-box,linear-gradient(to_bottom,cyan,purple)_border-box] pointer-events-none" />
                        )}

                        {/* Hover Glow */}
                        <div className="absolute inset-0 rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-300 shadow-[0_0_30px_rgba(56,189,248,0.3)]" />

                        {/* Placeholder Content/Icon - In real design this would be an image preview */}
                        <div className="relative z-10 p-6">
                            <feature.icon className={`w-12 h-12 ${feature.active ? 'text-white' : 'text-slate-400'}`} />
                        </div>
                    </motion.div>
                    <span className={`text-lg font-medium ${feature.active ? 'text-white' : 'text-slate-400'}`}>
                        {feature.label}
                    </span>
                </div>
            ))}
        </div>
    );
}
