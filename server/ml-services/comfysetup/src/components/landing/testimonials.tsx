"use client";

import { Star } from "lucide-react";
import Image from "next/image";
import { motion } from "framer-motion";
import type { Dictionary } from '@/lib/i18n/config';

interface TestimonialsProps {
  dictionary: Dictionary;
}

export function Testimonials({ dictionary }: TestimonialsProps) {
  const d = dictionary.landing.testimonials;

  // We keep the images and ratings here, but content comes from d.items
  const reviews = [
    {
      ...d.items[0],
      image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=150&h=150",
      rating: 5
    },
    {
      ...d.items[1],
      image: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=150&h=150",
      rating: 5
    },
    {
      ...d.items[2],
      image: "https://images.unsplash.com/photo-1580489944761-15a19d654956?auto=format&fit=crop&q=80&w=150&h=150",
      rating: 5
    }
  ];

  return (
    <section className="py-24 bg-slate-950 border-t border-slate-900">
      <div className="container mx-auto px-4 max-w-7xl">
        <div className="text-center mb-16">
          <h2 className="text-3xl md:text-5xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-purple-200 to-blue-200 mb-4">
            {d.title}
          </h2>
          <p className="text-slate-400 max-w-2xl mx-auto text-lg">
            {d.subtitle}
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {reviews.map((review, index) => (
            <motion.div
              key={review.name}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              viewport={{ once: true }}
              className="bg-slate-900/50 p-8 rounded-2xl border border-white/5 relative"
            >
              {/* Quote Icon Background */}
              <div className="absolute top-6 right-8 text-8xl text-purple-900/20 font-serif leading-none select-none">
                &quot;
              </div>

              <div className="flex gap-1 mb-6">
                {[...Array(review.rating)].map((_, i) => (
                  <Star key={i} className="w-5 h-5 text-yellow-500 fill-yellow-500" />
                ))}
              </div>

              <p className="text-slate-300 text-lg mb-8 relative z-10 leading-relaxed">
                &quot;{review.content}&quot;
              </p>

              <div className="flex items-center gap-4">
                <div className="relative w-12 h-12 rounded-full overflow-hidden border-2 border-slate-700">
                  <Image
                    src={review.image}
                    alt={review.name}
                    fill
                    className="object-cover"
                  />
                </div>
                <div>
                  <div className="text-white font-semibold">{review.name}</div>
                  <div className="text-slate-500 text-sm">{review.role}</div>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
