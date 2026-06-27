'use client';

import { useState, useRef, useEffect } from 'react';
import { useRouter, usePathname, useParams } from 'next/navigation';
import { motion, AnimatePresence } from 'framer-motion';
import { Globe, Check } from 'lucide-react';
import { locales, localeNames, type Locale } from '@/lib/i18n/config';
import { cn } from '@/lib/utils';

export function LanguageSwitcher() {
    const [isOpen, setIsOpen] = useState(false);
    const ref = useRef<HTMLDivElement>(null);
    const router = useRouter();
    const pathname = usePathname();
    const params = useParams();
    const currentLocale = (params.locale as Locale) || 'en';

    useEffect(() => {
        const handleClickOutside = (e: MouseEvent) => {
            if (ref.current && !ref.current.contains(e.target as Node)) {
                setIsOpen(false);
            }
        };
        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    const handleLocaleChange = (locale: Locale) => {
        const newPath = pathname.replace(`/${currentLocale}`, `/${locale}`);
        router.push(newPath);
        setIsOpen(false);
    };

    return (
        <div className="relative" ref={ref}>
            <button
                onClick={() => setIsOpen(!isOpen)}
                className="flex items-center gap-2 rounded-lg border border-slate-700 bg-slate-800/50 px-3 py-2 text-sm text-slate-300 transition-colors hover:border-slate-600 hover:text-white"
            >
                <Globe className="h-4 w-4" />
                <span className="hidden sm:inline">{localeNames[currentLocale]}</span>
            </button>

            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -10 }}
                        transition={{ duration: 0.15 }}
                        className="absolute right-0 mt-2 w-40 rounded-lg border border-slate-700 bg-slate-800 py-1 shadow-xl"
                    >
                        {locales.map((locale) => (
                            <button
                                key={locale}
                                onClick={() => handleLocaleChange(locale)}
                                className={cn(
                                    'flex w-full items-center justify-between px-4 py-2 text-left text-sm transition-colors',
                                    locale === currentLocale
                                        ? 'bg-purple-600/20 text-purple-300'
                                        : 'text-slate-300 hover:bg-slate-700'
                                )}
                            >
                                {localeNames[locale]}
                                {locale === currentLocale && <Check className="h-4 w-4" />}
                            </button>
                        ))}
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
