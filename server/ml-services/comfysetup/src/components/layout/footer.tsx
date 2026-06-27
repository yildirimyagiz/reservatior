'use client';

import Link from 'next/link';
import { useParams, usePathname } from 'next/navigation';
import { Twitter, Linkedin, Instagram, Youtube, Mail } from 'lucide-react';
import { AtlasLogo } from '@/components/ui/logo';
import type { Dictionary } from '@/lib/i18n/config';

interface FooterProps {
    dictionary: Dictionary;
}

export function Footer({ dictionary }: FooterProps) {
    const params = useParams();
    const pathname = usePathname();

    if (pathname?.includes('/editor')) {
        return null;
    }
    const locale = params.locale as string;
    const d = dictionary.landing.footer;
    const headerD = dictionary.landing.header;

    const FOOTER_LINKS = {
        services: {
            title: d.sections.services,
            links: [
                { name: headerD.services.staging.label, href: '/editor' },
                { name: headerD.services.redesign.label, href: '/editor?mode=redesign' },
                { name: headerD.services.enhance.label, href: '/editor?mode=enhance' },
                { name: headerD.services.video.label, href: '/editor?mode=video' },
                { name: headerD.services['3d'].label, href: '/editor?mode=3d' },
            ],
        },
        categories: {
            title: d.sections.categories,
            links: [
                { name: dictionary.roomCategories.livingRoom, href: '/editor?room=living-room' },
                { name: dictionary.roomCategories.bedroom, href: '/editor?room=bedroom' },
                { name: dictionary.roomCategories.kitchen, href: '/editor?room=kitchen' },
                { name: dictionary.roomCategories.bathroom, href: '/editor?room=bathroom' },
                { name: dictionary.roomCategories.commercial, href: '/editor?room=commercial' },
            ],
        },
        styles: {
            title: d.sections.styles,
            links: [
                { name: dictionary.styles['modern-minimalist'].name, href: '/editor?style=modern-minimalist' },
                { name: dictionary.styles['scandinavian'].name, href: '/editor?style=scandinavian' },
                { name: dictionary.styles['industrial'].name, href: '/editor?style=industrial' },
                { name: dictionary.styles['luxury'].name, href: '/editor?style=luxury' },
                { name: dictionary.styles['japanese'].name, href: '/editor?style=japanese' },
            ],
        },
        company: {
            title: d.sections.company,
            links: [
                { name: d.companyLinks.about, href: '/about' },
                { name: headerD.nav.pricing, href: '/pricing' },
                { name: d.companyLinks.blog, href: '/blog' },
                { name: d.companyLinks.careers, href: '/careers' },
                { name: d.companyLinks.contact, href: '/contact' },
            ],
        },
        resources: {
            title: d.sections.resources,
            links: [
                { name: headerD.resources.help.label, href: '/help' },
                { name: headerD.resources.docs.label, href: '/docs' },
                { name: headerD.resources.caseStudies.label, href: '/case-studies' },
                { name: 'API', href: '/api' },
                { name: 'Integrations', href: '/integrations' },
            ],
        },
        legal: {
            title: d.sections.legal,
            links: [
                { name: d.legalLinks.privacy, href: '/privacy' },
                { name: d.legalLinks.terms, href: '/terms' },
                { name: d.legalLinks.cookies, href: '/cookies' },
                { name: d.legalLinks.gdpr, href: '/gdpr' },
            ],
        },
    };

    const SOCIAL_LINKS = [
        { name: 'Twitter', href: 'https://twitter.com', icon: Twitter },
        { name: 'LinkedIn', href: 'https://linkedin.com', icon: Linkedin },
        { name: 'Instagram', href: 'https://instagram.com', icon: Instagram },
        { name: 'YouTube', href: 'https://youtube.com', icon: Youtube },
    ];

    return (
        <footer className="relative border-t border-slate-800 bg-slate-950">
            {/* Gradient accent */}
            <div className="absolute top-0 left-1/2 -translate-x-1/2 h-px w-1/2 bg-gradient-to-r from-transparent via-purple-500 to-transparent" />

            <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                {/* Main Footer Content */}
                <div className="py-16 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-8">
                    {Object.entries(FOOTER_LINKS).map(([key, section]) => (
                        <div key={key}>
                            <h3 className="text-sm font-semibold text-white mb-4">
                                {section.title}
                            </h3>
                            <ul className="space-y-3">
                                {section.links.map((link) => (
                                    <li key={link.name}>
                                        <Link
                                            href={link.href.startsWith('http') ? link.href : `/${locale}${link.href}`}
                                            className="text-sm text-slate-400 hover:text-white transition-colors"
                                        >
                                            {link.name}
                                        </Link>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    ))}
                </div>

                {/* Newsletter Section */}
                <div className="py-8 border-t border-slate-800">
                    <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                        <div>
                            <h3 className="text-lg font-semibold text-white mb-1">
                                {d.newsletter.title}
                            </h3>
                            <p className="text-sm text-slate-400">
                                {d.newsletter.subtitle}
                            </p>
                        </div>
                        <form className="flex gap-3">
                            <div className="relative">
                                <Mail className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-slate-500" />
                                <input
                                    type="email"
                                    placeholder={d.newsletter.placeholder}
                                    className="h-11 w-64 rounded-lg border border-slate-700 bg-slate-900 pl-10 pr-4 text-sm text-white placeholder-slate-500 focus:border-purple-500 focus:outline-none focus:ring-1 focus:ring-purple-500"
                                />
                            </div>
                            <button
                                type="submit"
                                className="h-11 px-6 rounded-lg bg-gradient-to-r from-purple-600 to-indigo-600 text-sm font-medium text-white hover:from-purple-500 hover:to-indigo-500 transition-all"
                            >
                                {d.newsletter.button}
                            </button>
                        </form>
                    </div>
                </div>

                {/* Bottom Footer */}
                <div className="py-8 border-t border-slate-800 flex flex-col md:flex-row items-center justify-between gap-4">
                    {/* Logo and Copyright */}
                    <div className="flex items-center gap-4">
                        <Link href={`/${locale}`} className="flex items-center gap-2">
                            <AtlasLogo className="scale-90 origin-left" />
                        </Link>
                        <span className="text-sm text-slate-500">
                            © {new Date().getFullYear()} {d.copyright}
                        </span>
                    </div>

                    {/* Social Links */}
                    <div className="flex items-center gap-4">
                        {SOCIAL_LINKS.map((social) => (
                            <a
                                key={social.name}
                                href={social.href}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="flex h-9 w-9 items-center justify-center rounded-lg bg-slate-800 text-slate-400 hover:bg-slate-700 hover:text-white transition-all"
                            >
                                <social.icon className="h-4 w-4" />
                            </a>
                        ))}
                    </div>
                </div>
            </div>
        </footer>
    );
}
