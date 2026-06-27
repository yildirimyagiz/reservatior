import { notFound } from 'next/navigation';
import { getDictionary, isValidLocale } from '@/lib/i18n/config';
import { Header } from '@/components/layout/header';
import { Footer } from '@/components/layout/footer';
import { Toaster } from 'sonner';
import { Providers } from '@/components/providers';

interface LocaleLayoutProps {
    children: React.ReactNode;
    params: Promise<{ locale: string }>;
}

export default async function LocaleLayout({ children, params }: LocaleLayoutProps) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    const dictionary = await getDictionary(locale);

    return (
        <Providers>
            <Header dictionary={dictionary} />
            <main className="min-h-screen">{children}</main>
            <Footer dictionary={dictionary} />
            <Toaster position="bottom-right" theme="dark" />
        </Providers>
    );
}

export function generateStaticParams() {
    return [
        { locale: 'en' },
        { locale: 'es' },
        { locale: 'tr' },
        { locale: 'de' },
    ];
}
