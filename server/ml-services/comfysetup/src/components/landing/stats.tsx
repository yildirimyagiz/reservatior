"use client";

import { motion } from "framer-motion";

const stats = [
  { label: "Photos Staged", value: "10M+" },
  { label: "Real Estate Agents", value: "50k+" },
  { label: "Countries Served", value: "120+" },
  { label: "Customer Satisfaction", value: "99%" },
];

export function Stats() {
  return (
    <section className="py-12 bg-slate-900 border-y border-white/5">
      <div className="container mx-auto px-4 max-w-7xl">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8 text-center">
          {stats.map((stat, index) => (
            <motion.div
              key={stat.label}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              transition={{ delay: index * 0.1 }}
              viewport={{ once: true }}
            >
              <div className="text-4xl md:text-5xl font-bold text-white mb-2 font-display">
                {stat.value}
              </div>
              <div className="text-slate-400 text-sm md:text-base uppercase tracking-wider font-medium">
                {stat.label}
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}
