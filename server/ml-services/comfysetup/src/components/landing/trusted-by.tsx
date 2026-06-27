"use client";


// Using text placeholders for brands, normally these would be SVGs
const brands = [
  "Sotheby's",
  "Keller Williams",
  "RE/MAX",
  "Coldwell Banker",
  "Century 21",
  "Compass",
  "Zillow",
  "Redfin"
];

export function TrustedBy() {
  return (
    <section className="py-10 bg-slate-950 border-b border-white/5 overflow-hidden">
      <div className="container mx-auto px-4 mb-6 text-center">
        <p className="text-sm font-semibold text-slate-500 uppercase tracking-widest">
          Trusted by top real estate professionals
        </p>
      </div>
      
      <div className="relative flex overflow-x-hidden group">
        <div className="animate-marquee whitespace-nowrap flex gap-16 px-8 items-center">
            {/* Double the list to create seamless loop */}
            {[...brands, ...brands].map((brand, i) => (
                <span key={i} className="text-2xl font-bold text-slate-700/50 hover:text-slate-500 transition-colors cursor-default select-none">
                    {brand}
                </span>
            ))}
        </div>
        
        {/* Gradients to fade edges */}
        <div className="absolute top-0 left-0 w-32 h-full bg-gradient-to-r from-slate-950 to-transparent z-10" />
        <div className="absolute top-0 right-0 w-32 h-full bg-gradient-to-l from-slate-950 to-transparent z-10" />
      </div>
    </section>
  );
}
