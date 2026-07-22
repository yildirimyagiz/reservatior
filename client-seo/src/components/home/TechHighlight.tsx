import Image from "next/image";
import { useTranslation } from "react-i18next";
import { MOCK_PROPERTIES } from "@/lib/mock-data";
export function TechHighlight() {
  const {
    t
  } = useTranslation();
  return <section className="py-24 bg-secondary/30 border-y border-border relative overflow-hidden">
      <div className="container mx-auto px-4 md:px-6 relative z-10">
        <div className="grid md:grid-cols-2 gap-16 items-center">
          <div>
            <div className="inline-block px-3 py-1 rounded-full bg-primary/10 text-primary text-sm font-medium mb-6">{t("client.src.aipowered_transformation")}</div>
            <h2 className="text-2xl md:text-3xl font-display font-medium mb-4 tracking-wide leading-tight">{t("client.src.from_photos_to")}<br />
              <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-purple-400">{t("client.src.cinematic_video")}</span>
            </h2>
            <p className="text-lg text-muted-foreground mb-8">{t("client.src.our_proprietary_reasoning_models")}</p>

            <ul className="space-y-4 mb-8">
              {["Intelligent room sequencing", "Automated motion & parallax", "Region-aware styling templates", "Multilingual voiceover generation"].map((item, i) => <li key={i} className="flex items-center gap-3">
                  <div className="h-6 w-6 rounded-full bg-green-500/20 flex items-center justify-center text-green-500">
                    <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                  </div>
                  <span className="text-foreground/80">{item}</span>
                </li>)}
            </ul>
          </div>

          <div className="relative">
            <div className="absolute -inset-4 bg-gradient-to-r from-blue-500 to-purple-600 rounded-3xl opacity-20 blur-2xl animate-pulse" />
            <div className="relative bg-card border border-border rounded-2xl overflow-hidden shadow-2xl">
              <Image src={MOCK_PROPERTIES[0].images[3]} alt={t("client.src.ai_tech_interface")} width={1200} height={800} loading="lazy" sizes="(max-width: 768px) 100vw, 50vw" className="w-full h-auto" />
              <div className="absolute inset-0 flex items-center justify-center bg-black/40">
                <div className="bg-white/10 backdrop-blur-md border border-white/20 p-6 rounded-2xl text-center">
                  <p className="text-white font-mono text-sm mb-2">{t("client.src.analyzing_scene_depth")}</p>
                  <div className="w-48 h-2 bg-white/20 rounded-full overflow-hidden">
                    <div className="h-full bg-primary w-[70%]" />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>;
}