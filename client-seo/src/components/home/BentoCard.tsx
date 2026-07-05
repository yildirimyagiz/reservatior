import Image from "next/image";
import Link from "next/link";
import { useTranslation } from "react-i18next";
import { MapPin } from "lucide-react";

export function BentoCard({ prop, className, large = false }: { prop: any; className?: string; large?: boolean }) {
  const { t } = useTranslation();
  if (!prop) return null;
  return (
    <Link href={`/property/${prop.id || "#"}`} className={`group relative rounded-3xl overflow-hidden block ${className}`}>
      <Image
        src={prop.image}
        alt={prop.title}
        fill
        sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
        className="object-cover transition-transform duration-1000 group-hover:scale-105"
      />
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-black/10 transition-opacity duration-500 group-hover:opacity-80" />
      
      {/* Tag */}
      <div className="absolute top-6 left-6">
        <span className="px-3 py-1 bg-white/20 backdrop-blur-md border border-white/20 text-white text-xs font-black uppercase tracking-widest rounded-full">
          {prop.tag || "FEATURED"}
        </span>
      </div>
      
      {/* Content */}
      <div className="absolute bottom-0 left-0 w-full p-6 md:p-8 flex flex-col justify-end">
        <h3 className={`${large ? "text-3xl md:text-5xl mb-3" : "text-xl md:text-2xl mb-2"} font-black text-white leading-tight`}>{prop.title}</h3>
        <div className="flex items-center gap-2 text-white/80 font-medium mb-4">
          <MapPin className="w-4 h-4" /> {prop.location}
        </div>
        
        <div className="flex items-center justify-between mt-auto">
          <div className="flex items-center gap-4 text-white font-bold text-sm">
            <span>{prop.beds} BEDS</span>
            <span className="w-1 h-1 bg-white/50 rounded-full" />
            <span>{prop.baths} BATHS</span>
          </div>
          <span className={`${large ? "text-2xl" : "text-xl"} font-black text-white bg-white/10 px-4 py-2 rounded-xl backdrop-blur-md`}>{prop.price}</span>
        </div>
      </div>
    </Link>
  );
}
