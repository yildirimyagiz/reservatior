"use client";

import { motion } from "framer-motion";
import Image from "next/image";

const styles = [
  {
    name: "Modern",
    image: "https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&q=80&w=600",
    description: "Sleek lines and minimal clutter"
  },
  {
    name: "Scandinavian",
    image: "https://images.unsplash.com/photo-1595515106969-1ce29566ff1c?auto=format&fit=crop&q=80&w=600",
    description: "Light, airy, and functional"
  },
  {
    name: "Industrial",
    image: "https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&q=80&w=600",
    description: "Raw textures and exposed elements"
  },
  {
    name: "Bohemian",
    image: "https://images.unsplash.com/photo-1522444195799-478538b28823?auto=format&fit=crop&q=80&w=600",
    description: "Eclectic patterns and organic vibes"
  },
  {
    name: "Minimalist",
    image: "https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&q=80&w=600",
    description: "Essential elements only"
  },
  {
    name: "Mid-Century",
    image: "https://images.unsplash.com/photo-1567225557594-88d73e55f2cb?auto=format&fit=crop&q=80&w=600",
    description: "Retro meets modern"
  }
];

export function StyleGallery() {
  return (
    <section className="py-24 bg-slate-950">
      <div className="container mx-auto px-4 max-w-7xl">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-purple-400 to-pink-400 mb-4">
            Explore 75+ Design Styles
          </h2>
          <p className="text-slate-400 max-w-2xl mx-auto text-lg">
            From classic to contemporary, our AI understands and applies the perfect aesthetic to every room.
          </p>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-4">
          {styles.map((style, index) => (
            <motion.div
              key={style.name}
              initial={{ opacity: 0, scale: 0.9 }}
              whileInView={{ opacity: 1, scale: 1 }}
              transition={{ delay: index * 0.1 }}
              viewport={{ once: true }}
              className="group relative aspect-[3/4] rounded-xl overflow-hidden cursor-pointer"
            >
              <Image
                src={style.image}
                alt={style.name}
                fill
                className="object-cover transition-transform duration-500 group-hover:scale-110"
              />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent opacity-80 group-hover:opacity-100 transition-opacity" />
              
              <div className="absolute bottom-0 left-0 p-4 w-full">
                <h3 className="text-white font-bold text-lg mb-1">{style.name}</h3>
                <p className="text-white/70 text-xs transform translate-y-4 opacity-0 group-hover:translate-y-0 group-hover:opacity-100 transition-all duration-300">
                  {style.description}
                </p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
