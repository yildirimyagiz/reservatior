import React, { useState } from 'react';
import { m } from 'framer-motion';
import { Lock, Unlock, Thermometer, Shield, ShieldAlert, Wind, Droplets, Battery, Wifi, Activity } from 'lucide-react';

export default function SmartPropertyControl() {
  const [isLocked, setIsLocked] = useState(true);
  const [temperature, setTemperature] = useState(72);
  const [securityActive, setSecurityActive] = useState(true);

  return (
    <div className="min-h-screen bg-muted dark:bg-[#050505] text-foreground dark:text-foreground p-6 md:p-12 font-sans">
      
      {/* Header Section */}
      <m.div 
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="mb-12"
      >
        <div className="flex items-center gap-3 mb-4">
          <div className="w-12 h-12 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center text-success dark:text-success">
            <Activity className="w-6 h-6" />
          </div>
          <h1 className="text-4xl md:text-5xl font-black tracking-tight">Suite Controls</h1>
        </div>
        <p className="text-lg text-muted-foreground dark:text-muted-foreground max-w-2xl leading-relaxed">
          Manage your environment. From smart locks to climate control, everything is seamlessly integrated for your comfort and safety.
        </p>
      </m.div>

      {/* Grid Layout */}
      <div className="grid grid-cols-1 md:grid-cols-12 gap-6">
        
        {/* Smart Lock Widget */}
        <m.div 
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          className="col-span-1 md:col-span-5 relative overflow-hidden rounded-3xl p-8 bg-card dark:bg-card/50 border border-border dark:border-border shadow-xl flex flex-col justify-between"
          style={{ minHeight: '320px' }}
        >
          <div className="absolute top-0 right-0 w-64 h-64 bg-brand/100/10 rounded-full blur-[80px] pointer-events-none" />
          
          <div className="flex justify-between items-start mb-12">
            <div>
              <h3 className="text-2xl font-bold mb-1">Front Door</h3>
              <p className="text-muted-foreground dark:text-muted-foreground text-sm flex items-center gap-2">
                <Wifi className="w-3.5 h-3.5" /> Connected
              </p>
            </div>
            <div className="flex items-center gap-1.5 px-3 py-1 bg-muted dark:bg-muted rounded-full text-xs font-bold">
              <Battery className="w-3.5 h-3.5 text-success" /> 84%
            </div>
          </div>

          <div className="flex justify-center mb-8">
            <button 
              onClick={() => setIsLocked(!isLocked)}
              className={`w-32 h-32 rounded-full flex flex-col items-center justify-center gap-2 transition-all duration-500 ${
                isLocked 
                  ? 'bg-blue-600 shadow-[0_0_40px_rgba(37,99,235,0.4)] text-white' 
                  : 'bg-success shadow-[0_0_40px_rgba(16,185,129,0.4)] text-white'
              }`}
            >
              <m.div
                initial={false}
                animate={{ rotate: isLocked ? 0 : 180, scale: isLocked ? 1 : 1.1 }}
                transition={{ type: "spring", stiffness: 200, damping: 15 }}
              >
                {isLocked ? <Lock className="w-10 h-10" /> : <Unlock className="w-10 h-10" />}
              </m.div>
              <span className="font-bold text-sm tracking-wide uppercase">
                {isLocked ? 'Locked' : 'Unlocked'}
              </span>
            </button>
          </div>
          <p className="text-center text-xs text-muted-foreground dark:text-muted-foreground uppercase tracking-widest font-bold">
            Tap to toggle lock
          </p>
        </m.div>

        {/* Climate Control Widget */}
        <m.div 
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.1 }}
          className="col-span-1 md:col-span-7 rounded-3xl p-8 bg-card dark:bg-card/50 border border-border dark:border-border shadow-xl"
          style={{ minHeight: '320px' }}
        >
          <div className="flex justify-between items-start mb-8">
            <div>
              <h3 className="text-2xl font-bold mb-1">Climate</h3>
              <p className="text-muted-foreground dark:text-muted-foreground text-sm flex items-center gap-2">
                <Thermometer className="w-3.5 h-3.5" /> Auto Mode
              </p>
            </div>
            <div className="flex gap-4">
              <div className="flex items-center gap-1.5 px-3 py-1 bg-muted dark:bg-muted rounded-full text-xs font-bold text-muted-foreground dark:text-muted-foreground">
                <Droplets className="w-3.5 h-3.5 text-brand" /> 45%
              </div>
              <div className="flex items-center gap-1.5 px-3 py-1 bg-muted dark:bg-muted rounded-full text-xs font-bold text-muted-foreground dark:text-muted-foreground">
                <Wind className="w-3.5 h-3.5 text-muted-foreground" /> Auto
              </div>
            </div>
          </div>

          <div className="flex flex-col md:flex-row items-center justify-between gap-8 h-full pb-8">
            
            {/* Thermostat Dial */}
            <div className="relative w-48 h-48 flex items-center justify-center">
              {/* Dial Track */}
              <svg className="absolute inset-0 w-full h-full" viewBox="0 0 100 100">
                <circle cx="50" cy="50" r="45" fill="none" stroke="currentColor" strokeWidth="2" className="text-foreground dark:text-foreground" />
                <circle cx="50" cy="50" r="45" fill="none" stroke="url(#gradient)" strokeWidth="6" strokeDasharray="283" strokeDashoffset={283 - (283 * ((temperature - 60) / 30))} strokeLinecap="round" className="transition-all duration-500" />
                <defs>
                  <linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="0%">
                    <stop offset="0%" stopColor="#3b82f6" />
                    <stop offset="100%" stopColor="#ef4444" />
                  </linearGradient>
                </defs>
              </svg>
              <div className="text-center">
                <span className="text-5xl font-black">{temperature}°</span>
                <span className="block text-sm text-muted-foreground dark:text-muted-foreground mt-1 font-bold">Target</span>
              </div>
            </div>

            {/* Controls */}
            <div className="flex md:flex-col gap-4">
              <button 
                onClick={() => setTemperature(Math.min(90, temperature + 1))}
                className="w-16 h-16 rounded-2xl bg-muted dark:bg-muted hover:bg-red-50 dark:hover:bg-red-900/20 flex items-center justify-center text-2xl font-bold transition-colors text-muted-foreground dark:text-muted-foreground hover:text-red-600 dark:hover:text-red-400"
              >
                +
              </button>
              <button 
                onClick={() => setTemperature(Math.max(60, temperature - 1))}
                className="w-16 h-16 rounded-2xl bg-muted dark:bg-muted hover:bg-brand/10 dark:hover:bg-blue-900/20 flex items-center justify-center text-2xl font-bold transition-colors text-muted-foreground dark:text-muted-foreground hover:text-brand dark:hover:text-brand"
              >
                -
              </button>
            </div>
          </div>
        </m.div>

        {/* Security & Sensors Widget */}
        <m.div 
          initial={{ opacity: 0, scale: 0.95 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ delay: 0.2 }}
          className="col-span-1 md:col-span-12 rounded-3xl p-8 bg-card dark:bg-card text-white dark:text-foreground shadow-xl flex flex-col md:flex-row justify-between items-center gap-6"
        >
          <div className="flex items-center gap-6">
            <div className={`w-16 h-16 rounded-full flex items-center justify-center ${securityActive ? 'bg-success/20 text-success dark:bg-blue-100' : 'bg-red-500/20 text-red-500 dark:bg-red-100'}`}>
              {securityActive ? <Shield className="w-8 h-8" /> : <ShieldAlert className="w-8 h-8" />}
            </div>
            <div>
              <h3 className="text-2xl font-bold mb-1">Privacy & Security</h3>
              <p className="text-muted-foreground dark:text-muted-foreground text-sm">
                {securityActive ? 'All systems nominal. Noise levels normal.' : 'System alerts active. Please check.'}
              </p>
            </div>
          </div>

          <div className="flex items-center gap-8">
            <div className="text-center">
              <span className="block text-2xl font-black mb-1">32 dB</span>
              <span className="text-xs uppercase tracking-wider text-muted-foreground dark:text-muted-foreground font-bold">Noise Level</span>
            </div>
            <div className="w-px h-12 bg-muted dark:bg-muted" />
            <button 
              onClick={() => setSecurityActive(!securityActive)}
              className="px-8 py-3 rounded-xl bg-white/10 dark:bg-muted hover:bg-white/20 dark:hover:bg-muted font-bold transition-colors"
            >
              {securityActive ? 'Deactivate' : 'Activate'}
            </button>
          </div>
        </m.div>

      </div>

    </div>
  );
}
