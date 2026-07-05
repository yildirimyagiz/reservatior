"use client";

import { useState, useMemo, JSXElementConstructor, Key, ReactElement, ReactNode } from "react";
import { Building2, Info, CheckCircle2, AlertCircle, Home, FileText, User } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { HoverCard, HoverCardContent, HoverCardTrigger } from "@/components/ui/hover-card";

// Simulated Data for Demo (representing the 1066 imports from Büyükyalı & Quasar)
const MOCK_PROJECTS = [
  { id: "buyukyali", name: "Büyükyalı İstanbul", blocks: ["A", "B", "C", "D"], totalFloors: 15, aptsPerFloor: 6 },
  { id: "uphilcourt", name: "Uphilcourt Bahçeşehir", blocks: ["Kule 1", "Kule 2", "Yatay 1", "Yatay 2"], totalFloors: 25, aptsPerFloor: 8 },
  { id: "tema", name: "Tema İstanbul", blocks: ["A", "B", "C", "D", "E"], totalFloors: 30, aptsPerFloor: 10 },
  { id: "kemercountry", name: "Kemer Country", blocks: ["Orman Evleri", "Göl Evleri", "Yalılar"], totalFloors: 3, aptsPerFloor: 4 },
  { id: "aquacity", name: "Aqua City", blocks: ["A1", "A2", "A3", "B1", "B2"], totalFloors: 12, aptsPerFloor: 6 },
  { id: "metropol", name: "Metropol İstanbul", blocks: ["A Kule", "B Kule", "C Kule", "AVM Üstü"], totalFloors: 50, aptsPerFloor: 12 },
  { id: "nishadalar", name: "Nish Adalar", blocks: ["Panorama 1", "Panorama 2", "Ada 1", "Ada 2"], totalFloors: 20, aptsPerFloor: 8 },
  { id: "mallofistanbul", name: "Mall of İstanbul", blocks: ["Rezidans 1", "Rezidans 2", "Rezidans 3", "Rezidans 4"], totalFloors: 35, aptsPerFloor: 10 },
  { id: "istinyepark", name: "İstinye Park Residans", blocks: ["Blok 1", "Blok 2", "Blok 3"], totalFloors: 6, aptsPerFloor: 4 },
  { id: "maya", name: "Maya Residence", blocks: ["A", "B", "C"], totalFloors: 10, aptsPerFloor: 4 },
  { id: "terracefulya", name: "Terrace Fulya", blocks: ["Center", "Life", "Club"], totalFloors: 18, aptsPerFloor: 6 },
  { id: "validebag", name: "Validebağ Konakları", blocks: ["A1", "A2", "B1", "B2"], totalFloors: 8, aptsPerFloor: 4 },
  { id: "quasar", name: "Quasar İstanbul", blocks: ["Residans", "Fairmont"], totalFloors: 42, aptsPerFloor: 4 },
  { id: "acarkent", name: "Acarkent", blocks: ["Boğazüstü A", "Boğazüstü B", "Acar Size 1"], totalFloors: 4, aptsPerFloor: 2 },
  { id: "maslak42", name: "Maslak 42 A Kule", blocks: ["A Kule"], totalFloors: 42, aptsPerFloor: 8 },
  { id: "savoy", name: "Savoy Ulus", blocks: ["Blok 1", "Blok 2", "Blok 3"], totalFloors: 6, aptsPerFloor: 4 },
  { id: "queenbomonti", name: "Sinpaş Queen Bomonti", blocks: ["Crown Tower"], totalFloors: 48, aptsPerFloor: 29 },
  { id: "skyland", name: "Skyland İstanbul", blocks: ["Rezidans Kulesi", "Ofis Kulesi"], totalFloors: 65, aptsPerFloor: 16 },
  { id: "vadiistanbul", name: "Vadi İstanbul", blocks: ["Teras", "Bulvar", "Park"], totalFloors: 22, aptsPerFloor: 12 },
  { id: "uluslotus", name: "Ulus Lotus Sitesi", blocks: ["A Blok", "B Blok", "C Blok"], totalFloors: 5, aptsPerFloor: 2 },
  { id: "upcityflats", name: "Upcity Flats Kartal", blocks: ["Kule 1", "Kule 2"], totalFloors: 15, aptsPerFloor: 12 },
  { id: "upcityresidence", name: "Upcity Residence", blocks: ["Residance Blok"], totalFloors: 20, aptsPerFloor: 15 },
  { id: "polattower", name: "Polat Tower Residence", blocks: ["Residence"], totalFloors: 42, aptsPerFloor: 11 },
];

export default function DigitalTwinDashboard() {
  const [activeProject, setActiveProject] = useState(MOCK_PROJECTS[0]);
  const [activeBlock, setActiveBlock] = useState(activeProject.blocks[3]); // Default D
  
  const generateApartmentMap = useMemo(() => {
    const map: any[] = [];
    for (let f = activeProject.totalFloors; f >= 1; f--) {
      const floorApts = [];
      for (let a = 1; a <= activeProject.aptsPerFloor; a++) {
        // Calculate apt number (e.g. 1st floor = 1..6, 2nd floor = 7..12)
        const aptNo = (f - 1) * activeProject.aptsPerFloor + a;
        
        let status = "available"; // default
        let owner = null;

        // Hardcode our D-66 example to show the concept
        if (activeProject.id === "buyukyali" && activeBlock === "D" && aptNo === 66) {
          status = "sold";
          owner = "MISHARI Z H ALKHALID";
        } else if (aptNo % 7 === 0) {
          status = "dispute";
          owner = "Hukuki Süreçte";
        } else if (aptNo % 3 === 0) {
          status = "sold";
          owner = "Körfez Yatırım Fonu (QIA)";
        }

        floorApts.push({ aptNo, status, owner, floor: f });
      }
      map.push({ floor: f, apartments: floorApts });
    }
    return map;
  }, [activeProject, activeBlock]);

  const getStatusColor = (status: string) => {
    switch (status) {
      case "sold": return "bg-green-500/20 border-green-500/50 text-green-400";
      case "dispute": return "bg-red-500/20 border-red-500/50 text-red-400";
      default: return "bg-slate-800/50 border-slate-700/50 text-slate-500";
    }
  };

  return (
    <div className="min-h-screen bg-[#0A0A0B] text-slate-200 pt-24 font-sans space-y-6">
      <div className="max-w-7xl mx-auto space-y-8">
        
        {/* Header Section */}
        <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-4">
          <div>
            <div className="flex items-center gap-3 mb-2">
              <div className="w-10 h-10 rounded-xl bg-slate-500/10 border border-slate-500/20 flex items-center justify-center">
                <Building2 className="w-5 h-5 text-slate-400" />
              </div>
              <h1 className="text-3xl font-light tracking-tight text-white">Digital Twin Matrix</h1>
            </div>
            <p className="text-slate-400">Gerçek Zamanlı Bina Durumu ve Mal Sahibi Analizi</p>
          </div>
          
          <div className="flex gap-2 bg-[#1A1C20] p-1.5 rounded-xl border border-slate-800/50 overflow-x-auto max-w-[60vw] scrollbar-hide">
            {MOCK_PROJECTS.map((proj) => (
              <button
                key={proj.id}
                onClick={() => {
                  setActiveProject(proj);
                  setActiveBlock(proj.blocks[0]);
                }}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-all ${
                  activeProject.id === proj.id
                    ? "bg-slate-500/10 text-slate-400 border border-slate-500/20"
                    : "text-slate-400 hover:text-white"
                }`}
              >
                {proj.name}
              </button>
            ))}
          </div>
        </div>

        {/* Main Content Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
          
          {/* Blocks Sidebar */}
          <div className="space-y-4">
            <h3 className="text-sm font-medium text-slate-500 uppercase tracking-wider mb-4">Bloklar</h3>
            <div className="flex flex-col gap-2">
              {activeProject.blocks.map((block) => (
                <button
                  key={block}
                  onClick={() => setActiveBlock(block)}
                  className={`p-4 rounded-xl flex items-center justify-between border transition-all ${
                    activeBlock === block
                      ? "bg-[#1A1C20] border-slate-500/30 shadow-[0_0_15px_rgba(59,130,246,0.1)]"
                      : "bg-[#111315] border-transparent hover:border-slate-800"
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <Building2 className={`w-5 h-5 ${activeBlock === block ? "text-slate-400" : "text-slate-600"}`} />
                    <span className={`font-medium ${activeBlock === block ? "text-white" : "text-slate-400"}`}>
                      {block} Blok
                    </span>
                  </div>
                  {block === "D" && activeProject.id === "buyukyali" && (
                    <span className="w-2 h-2 rounded-full bg-green-500 animate-pulse"></span>
                  )}
                </button>
              ))}
            </div>

            <div className="mt-8 p-5 rounded-xl bg-gradient-to-b from-[#1A1C20] to-[#0A0A0B] border border-slate-800/50">
              <h4 className="text-sm font-medium text-slate-300 mb-4">Gösterge Tablosu</h4>
              <div className="space-y-3">
                <div className="flex items-center gap-3 text-sm text-slate-400">
                  <div className="w-3 h-3 rounded-lg bg-green-500/20 border border-green-500/50" />
                  Satıldı / Sahipli
                </div>
                <div className="flex items-center gap-3 text-sm text-slate-400">
                  <div className="w-3 h-3 rounded-lg bg-red-500/20 border border-red-500/50" />
                  Hukuki İhtilaf (Escrow Blokajı)
                </div>
                <div className="flex items-center gap-3 text-sm text-slate-400">
                  <div className="w-3 h-3 rounded-lg bg-slate-800 border border-slate-700" />
                  Boş / Kiralık
                </div>
              </div>
            </div>
          </div>

          {/* Building Facade View */}
          <div className="lg:col-span-3">
            <div className="bg-[#111315]/80 backdrop-blur-md rounded-2xl border border-slate-800/80 p-8 shadow-2xl relative overflow-hidden">
              {/* Architectural Accents */}
              <div className="absolute top-0 left-1/2 -translate-x-1/2 w-3/4 h-1 bg-gradient-to-r from-transparent via-slate-500/20 to-transparent" />
              
              <div className="flex justify-between items-center mb-8 pb-4 border-b border-slate-800/50">
                <h2 className="text-xl font-medium text-white flex items-center gap-2">
                  <Home className="w-5 h-5 text-slate-400" />
                  {activeProject.name} - {activeBlock} Blok Cephesi
                </h2>
                <div className="text-sm text-slate-500">{activeProject.totalFloors} Kat</div>
              </div>

              <div className="space-y-2 relative">
                <AnimatePresence mode="wait">
                  <motion.div
                    key={`${activeProject.id}-${activeBlock}`}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    transition={{ duration: 0.3 }}
                    className="flex flex-col gap-2"
                  >
                    {generateApartmentMap.map((floor) => (
                      <div key={`floor-${floor.floor}`} className="flex items-center gap-4 group">
                        {/* Floor Number Indicator */}
                        <div className="w-12 text-right text-xs font-medium text-slate-600 group-hover:text-slate-400 transition-colors">
                          {floor.floor}. Kat
                        </div>
                        
                        {/* Apartments on this floor */}
                        <div className="flex-1 flex flex-wrap gap-2">
                          {floor.apartments.map((apt: { aptNo: number; status: string; owner: string | null; }) => (
                            <HoverCard key={apt.aptNo} openDelay={100} closeDelay={100}>
                              <HoverCardTrigger asChild>
                                <div 
                                  className={`w-12 h-12 rounded-lg border flex flex-col items-center justify-center cursor-pointer transition-all duration-300 hover:scale-105 ${getStatusColor(apt.status)}`}
                                >
                                  <span className="text-xs font-semibold opacity-80">{apt.aptNo}</span>
                                  {apt.status === "sold" && <CheckCircle2 className="w-3 h-3 mt-1 opacity-70" />}
                                  {apt.status === "dispute" && <AlertCircle className="w-3 h-3 mt-1 opacity-70" />}
                                </div>
                              </HoverCardTrigger>
                              <HoverCardContent 
                                side="top" 
                                className="w-80 bg-[#1A1C20]/95 backdrop-blur-xl border-slate-700/50 p-4 shadow-2xl rounded-xl"
                              >
                                <div className="space-y-4">
                                  <div className="flex justify-between items-start">
                                    <div>
                                      <h4 className="text-sm font-semibold text-white">{activeBlock}-{apt.aptNo} Numaralı Daire</h4>
                                      <p className="text-xs text-slate-400">{activeProject.name}</p>
                                    </div>
                                    <div className={`px-2 py-1 rounded-lg text-[10px] font-bold uppercase ${apt.status === 'sold' ? 'bg-green-500/20 text-green-400' : apt.status === 'dispute' ? 'bg-red-500/20 text-red-400' : 'bg-slate-700 text-slate-300'}`}>
                                      {apt.status}
                                    </div>
                                  </div>
                                  
                                  {apt.owner ? (
                                    <div className="bg-[#111315] p-3 rounded-lg border border-slate-800 space-y-2">
                                      <div className="flex items-center gap-2 text-sm text-slate-300">
                                        <User className="w-4 h-4 text-slate-400" />
                                        <span>Sahibi: <strong className="text-white">{apt.owner}</strong></span>
                                      </div>
                                      <div className="flex items-center gap-2 text-sm text-slate-300">
                                        <FileText className="w-4 h-4 text-slate-500" />
                                        <span>Tapu/Sözleşme ID: #TR-{apt.aptNo}{activeBlock}YU</span>
                                      </div>
                                    </div>
                                  ) : (
                                    <div className="text-sm text-slate-400 italic flex items-center gap-2">
                                      <Info className="w-4 h-4" />
                                      Satışa Hazır / Portföyde
                                    </div>
                                  )}
                                  
                                  {apt.status === 'sold' && apt.owner === "MISHARI Z H ALKHALID" && (
                                    <div className="pt-2 border-t border-slate-700/50 flex justify-between items-center text-xs">
                                      <span className="text-slate-400">Escrow Durumu</span>
                                      <span className="text-green-400 flex items-center gap-1"><CheckCircle2 className="w-3 h-3"/> Fon Onaylandı</span>
                                    </div>
                                  )}
                                </div>
                              </HoverCardContent>
                            </HoverCard>
                          ))}
                        </div>
                      </div>
                    ))}
                  </motion.div>
                </AnimatePresence>
                
                {/* Ground Line */}
                <div className="flex-1 h-3 bg-gradient-to-r from-green-500/20 via-slate-800 to-red-500/20 rounded-full overflow-hidden mt-4" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
