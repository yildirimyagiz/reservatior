"use client";

import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Input } from '@/components/ui/input';
import { Calendar } from '@/components/ui/calendar';
import { ScrollArea } from '@/components/ui/scroll-area';
import { 
  Calendar as CalendarIcon,
  Search,
  Plus,
  Edit,
  Trash2,
  Users,
  Clock,
  DollarSign,
  AlertCircle,
  CheckCircle,
  Activity,
  Zap,
  ArrowUpRight,
  MapPin,
  Building,
  Star,
  Shield,
  Layers,
  Cpu
} from 'lucide-react';
import { PageShell } from '../layout/PageShell';
import { motion, AnimatePresence } from 'framer-motion';
import { cn } from '@/lib/utils';
import { useTranslation } from 'react-i18next';

export default function Availability() {
  const { t } = useTranslation();
  const [selectedProperty, setSelectedProperty] = useState(1);
  const [selectedDate, setSelectedDate] = useState<Date | undefined>(new Date());
  const [searchQuery, setSearchQuery] = useState('');

  const properties = [
    {
      id: 1,
      name: 'SUNSET NEURAL NODE - 4B',
      type: 'apartment',
      address: '123 MAIN ST, HUB-ALPHA',
      status: 'active',
      totalUnits: 1,
      availableUnits: 1,
      occupancy: 85,
      monthlyRevenue: '$2,500',
      rating: 4.8,
      amenities: ['NEURAL LINK', 'GRID POWER', 'SECURE ACCESS'],
    },
    {
      id: 2,
      name: 'OCEAN VISTA TERMINAL - 2A',
      type: 'villa',
      address: '456 BEACH RD, HUB-BETA',
      status: 'active',
      totalUnits: 1,
      availableUnits: 0,
      occupancy: 100,
      monthlyRevenue: '$4,200',
      rating: 4.9,
      amenities: ['FIBER OPTIC', 'BIO-METRIC', 'OCEAN SHIELD'],
    },
    {
      id: 3,
      name: 'DOWNTOWN LOGIC LOFT - 1C',
      type: 'loft',
      address: '789 DOWNTOWN AVE, HUB-GAMMA',
      status: 'maintenance',
      totalUnits: 1,
      availableUnits: 1,
      occupancy: 0,
      monthlyRevenue: '$3,100',
      rating: 4.6,
      amenities: ['QUANTUM WIFI', 'AUTO-MAINTAIN', 'CITY MESH'],
    }
  ];

  const availabilityData = [
    { id: 1, propertyId: 1, date: '2024-01-20', status: 'available', price: '$150/NIGHT', notes: 'PEAK NODE DEMAND' },
    { id: 2, propertyId: 1, date: '2024-01-21', status: 'occupied', price: '$150/NIGHT', notes: 'GUEST: SUBJECT-A' },
    { id: 3, propertyId: 1, date: '2024-01-22', status: 'blocked', price: '$150/NIGHT', notes: 'SYSTEM MAINTENANCE' },
  ];

  const currentProperty = properties.find(p => p.id === selectedProperty);

  const stats = [
    { label: t('availability.connectedNodes'), value: properties.length },
    { label: t('availability.avgOccupancy'), value: "92.4%" },
    { label: t('availability.revenueDelta'), value: "+14.2%", color: "text-emerald-400" },
    { label: t('availability.threatLevel'), value: "STABLE", color: "text-blue-500" },
  ];

  return (
    <PageShell 
      title={t('availability.title')} 
      description={t('availability.desc')}
      stats={stats}
      onSearchChange={setSearchQuery}
      searchValue={searchQuery}
    >
      <div className="flex flex-col lg:flex-row gap-10 h-[calc(100vh-280px)]">
        {/* Properties Sidebar */}
        <div className="w-full lg:w-96 flex flex-col gap-6 bg-[#1a1b1e]/40 border border-white/5 border-l border-t rounded-[40px] overflow-hidden backdrop-blur-3xl shadow-3xl">
          <div className="p-8 border-b border-white/5">
             <div className="flex items-center justify-between">
                <h3 className="text-[10px] font-black text-slate-500 tracking-widest italic flex items-center gap-2">
                   <Layers className="w-3.5 h-3.5" /> {t('availability.repository')}
                </h3>
                <Button variant="ghost" className="h-8 w-8 p-0 rounded-lg border border-white/5 bg-white/2 hover:text-white">
                   <Plus className="w-3 h-3" />
                </Button>
             </div>
          </div>
          
          <ScrollArea className="flex-1">
            <div className="p-4 space-y-4">
              {properties.map((property) => (
                <motion.div
                  key={property.id}
                  whileHover={{ scale: 1.02 }}
                  onClick={() => setSelectedProperty(property.id)}
                  className={cn(
                    "p-6 rounded-[28px] cursor-pointer transition-all border group",
                    selectedProperty === property.id
                      ? "bg-blue-600/10 border-blue-500/30 shadow-2xl shadow-blue-500/10"
                      : "bg-white/2 border-white/5 hover:bg-white/5"
                  )}
                >
                  <div className="flex items-start gap-4">
                    <div className={cn(
                      "w-12 h-12 rounded-2xl flex items-center justify-center transition-transform group-hover:scale-110",
                      selectedProperty === property.id ? "bg-blue-600 text-white" : "bg-black/40 text-slate-500 border border-white/5"
                    )}>
                      <Building className="w-6 h-6" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="font-black text-white italic text-sm tracking-tight truncate leading-none">{property.name}</p>
                      <p className="text-[9px] font-bold text-slate-500 tracking-widest mt-1.5 italic truncate">{property.address}</p>
                      
                      <div className="flex items-center justify-between mt-5">
                         <Badge className="bg-emerald-500/10 text-emerald-400 border-none text-[8px] font-black tracking-widest italic py-0.5">
                            {property.status}
                         </Badge>
                         <div className="flex items-center gap-1.5">
                            <Star className="w-2.5 h-2.5 fill-amber-500 text-amber-500" />
                            <span className="text-[10px] font-black text-white italic">{property.rating}</span>
                         </div>
                      </div>
                    </div>
                  </div>
                </motion.div>
              ))}
            </div>
          </ScrollArea>
        </div>

        {/* Availability Details */}
        <div className="flex-1 space-y-10 overflow-y-auto pr-4 scrollbar-hide">
          {currentProperty && (
            <AnimatePresence mode="wait">
              <motion.div 
                key={currentProperty.id}
                initial={{ opacity: 0, x: 20 }}
                animate={{ opacity: 1, x: 0 }}
                exit={{ opacity: 0, x: -20 }}
                className="space-y-10"
              >
                {/* Visual Header */}
                <div className="p-10 bg-gradient-to-br from-blue-600/10 via-transparent to-transparent border border-white/5 rounded-[40px] relative overflow-hidden">
                   <div className="absolute top-0 right-0 p-10 opacity-5">
                      <Cpu className="w-64 h-64 text-blue-500" />
                   </div>
                   <div className="relative z-10 space-y-6">
                      <div className="flex items-center gap-3">
                         <div className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
                         <span className="text-[10px] font-black text-emerald-400 tracking-widest italic">{t('availability.nodeOnline')}</span>
                      </div>
                      <h2 className="text-4xl font-black text-white italic tracking-tighter">{currentProperty.name}</h2>
                      <div className="flex flex-wrap gap-4">
                         {currentProperty.amenities.map(a => (
                           <div key={a} className="flex items-center gap-2 bg-black/40 px-4 py-2 rounded-xl border border-white/5">
                              <Shield className="w-3 h-3 text-blue-500" />
                              <span className="text-[9px] font-black text-slate-400 italic tracking-widest">{a}</span>
                           </div>
                         ))}
                      </div>
                   </div>
                </div>

                {/* Grid Management */}
                <div className="grid grid-cols-1 xl:grid-cols-2 gap-10">
                   <div className="bg-[#1a1b1e]/40 border border-white/5 rounded-[40px] p-8 space-y-8 backdrop-blur-3xl shadow-3xl">
                      <div className="flex items-center justify-between border-b border-white/5 pb-6">
                         <h3 className="text-sm font-black text-white italic tracking-widest">{t('availability.protocolCalendar')}</h3>
                         <Button variant="outline" className="h-10 px-4 rounded-xl border-white/5 bg-white/2 text-[9px] font-black italic tracking-widest hover:text-white">
                            <Zap className="w-3 h-3 text-blue-500 mr-2" /> {t('recalibrate')}
                         </Button>
                      </div>
                      <Calendar
                        mode="single"
                        selected={selectedDate}
                        onSelect={setSelectedDate}
                        className="bg-transparent text-white font-display border-none pointer-events-auto"
                      />
                   </div>

                   <div className="space-y-6">
                      <div className="flex items-center justify-between">
                         <h3 className="text-sm font-black text-white italic tracking-widest">{t('availability.nodeStatusLogs')}</h3>
                         <Button className="h-10 px-6 rounded-xl bg-blue-600 hover:bg-blue-500 text-white font-black text-[9px] italic tracking-widest shadow-xl shadow-blue-600/20">
                            <Plus className="w-3 h-3 mr-2" /> {t('blockDates')}
                         </Button>
                      </div>
                      <div className="space-y-4">
                         {availabilityData.map(log => (
                           <motion.div 
                             key={log.id} 
                             whileHover={{ x: 5 }}
                             className="p-6 bg-black/40 border border-white/5 rounded-[28px] flex items-center justify-between group"
                           >
                              <div className="flex items-center gap-5">
                                 <div className={cn(
                                   "w-12 h-12 rounded-2xl flex items-center justify-center border",
                                   log.status === 'available' ? "bg-emerald-500/10 border-emerald-500/20 text-emerald-400" :
                                   log.status === 'occupied' ? "bg-blue-500/10 border-blue-500/20 text-blue-400" :
                                   "bg-red-500/10 border-red-500/20 text-red-400"
                                 )}>
                                    {log.status === 'available' ? <CheckCircle className="w-6 h-6" /> : <Clock className="w-6 h-6" />}
                                 </div>
                                 <div>
                                    <div className="text-sm font-black text-white italic tracking-tight">{log.date}</div>
                                    <div className="text-[9px] font-bold text-slate-500 mt-1 italic tracking-widest">{log.notes}</div>
                                 </div>
                              </div>
                              <div className="text-right">
                                 <div className="text-lg font-black text-white italic font-mono leading-none">{log.price}</div>
                                 <Badge className="bg-white/2 border-white/5 text-[8px] font-bold text-slate-500 mt-2">{log.status}</Badge>
                              </div>
                           </motion.div>
                         ))}
                      </div>
                   </div>
                </div>
              </motion.div>
            </AnimatePresence>
          )}
        </div>
      </div>
    </PageShell>
  );
}
