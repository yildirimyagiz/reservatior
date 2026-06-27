import type { Locale } from '@/types';

export type { Locale };

export const locales: Locale[] = ['en', 'es', 'tr', 'de'];
export const defaultLocale: Locale = 'en';

export const localeNames: Record<Locale, string> = {
    en: 'English',
    tr: 'Türkçe',
    es: 'Español',
    de: 'Deutsch',
};

export type Dictionary = typeof import('./dictionaries/en.json');

const dictionaries: Record<Locale, () => Promise<Dictionary>> = {
    en: () => import('./dictionaries/en.json').then((m) => m.default),
    tr: () => import('./dictionaries/tr.json').then((m) => m.default),
    es: () => import('./dictionaries/es.json').then((m) => m.default),
    de: () => import('./dictionaries/de.json').then((m) => m.default),
};

export async function getDictionary(locale: Locale): Promise<Dictionary> {
    return dictionaries[locale]?.() ?? dictionaries.en();
}

export function isValidLocale(locale: string): locale is Locale {
    return locales.includes(locale as Locale);
}
