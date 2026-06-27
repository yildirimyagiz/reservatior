import { getDictionary, isValidLocale } from '@/lib/i18n/config';
import { notFound } from 'next/navigation';
import { HeroSection } from '@/components/landing/hero-section';
import { StylesGallery } from '@/components/landing/styles-gallery';
import { FeatureShowcase } from '@/components/landing/feature-showcase';
import { SolutionShowcase } from '@/components/landing/solution-showcase';
import { HowItWorks } from '@/components/landing/how-it-works';
import { CTA } from '@/components/landing/cta';
import { Testimonials } from '@/components/landing/testimonials';
import { FAQ } from '@/components/landing/faq';

interface PageProps {
    params: Promise<{ locale: string }>;
}

export default async function HomePage({ params }: PageProps) {
    const { locale } = await params;

    if (!isValidLocale(locale)) {
        notFound();
    }

    const dictionary = await getDictionary(locale);

    return (
        <>
            <HeroSection dictionary={dictionary} />
            <FeatureShowcase dictionary={dictionary} />
            <SolutionShowcase dictionary={dictionary} />
            <StylesGallery dictionary={dictionary} />
            {/* <CategoryGrid /> */}
            {/* <EcommerceSection /> */}
            <Testimonials dictionary={dictionary} />
            <HowItWorks dictionary={dictionary} />
            <FAQ dictionary={dictionary} />
            <CTA dictionary={dictionary} />
        </>
    );
}
