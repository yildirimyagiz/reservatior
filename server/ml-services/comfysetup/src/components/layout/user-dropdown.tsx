'use client';

import { useState, useRef, useEffect } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { signOut, useSession } from 'next-auth/react';
import { motion, AnimatePresence } from 'framer-motion';
import {
    User,
    Settings,
    CreditCard,
    LogOut,
    ChevronDown,
    Sparkles,
    Image,
    History,
    HelpCircle,
} from 'lucide-react';
import { cn } from '@/lib/utils';

export function UserDropdown() {
    const params = useParams();
    const locale = params.locale as string;
    const { data: session, status } = useSession();
    const [isOpen, setIsOpen] = useState(false);
    const dropdownRef = useRef<HTMLDivElement>(null);

    // Close dropdown when clicking outside
    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
                setIsOpen(false);
            }
        };

        document.addEventListener('mousedown', handleClickOutside);
        return () => document.removeEventListener('mousedown', handleClickOutside);
    }, []);

    if (status === 'loading') {
        return (
            <div className="h-9 w-9 rounded-full bg-slate-800 animate-pulse" />
        );
    }

    if (!session?.user) {
        return (
            <Link
                href={`/${locale}/auth/signin`}
                className="text-sm font-medium text-slate-400 hover:text-white transition-colors"
            >
                Sign In
            </Link>
        );
    }

    const user = session.user;
    const initials = user.name
        ? user.name.split(' ').map((n) => n[0]).join('').toUpperCase().slice(0, 2)
        : user.email?.slice(0, 2).toUpperCase() || 'U';

    const menuItems = [
        {
            group: 'Account',
            items: [
                { label: 'Profile', href: `/${locale}/account/profile`, icon: User },
                { label: 'Settings', href: `/${locale}/account/settings`, icon: Settings },
                { label: 'Billing', href: `/${locale}/account/billing`, icon: CreditCard },
            ],
        },
        {
            group: 'Workspace',
            items: [
                { label: 'My Designs', href: `/${locale}/designs`, icon: Image },
                { label: 'History', href: `/${locale}/history`, icon: History },
                { label: 'Credits', href: `/${locale}/credits`, icon: Sparkles, badge: '47' },
            ],
        },
        {
            group: 'Support',
            items: [
                { label: 'Help Center', href: `/${locale}/help`, icon: HelpCircle },
            ],
        },
    ];

    const handleSignOut = async () => {
        await signOut({ callbackUrl: `/${locale}` });
    };

    return (
        <div ref={dropdownRef} className="relative">
            <button
                onClick={() => setIsOpen(!isOpen)}
                className={cn(
                    "flex items-center gap-2 p-1 pr-3 rounded-full transition-all",
                    "hover:bg-slate-800/50",
                    isOpen && "bg-slate-800/50"
                )}
            >
                {user.image ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                        src={user.image}
                        alt={user.name || 'User'}
                        className="h-8 w-8 rounded-full object-cover ring-2 ring-purple-500/50"
                    />
                ) : (
                    <div className="flex h-8 w-8 items-center justify-center rounded-full bg-gradient-to-br from-purple-600 to-indigo-600 text-sm font-bold text-white">
                        {initials}
                    </div>
                )}
                <ChevronDown
                    className={cn(
                        "h-4 w-4 text-slate-400 transition-transform duration-200",
                        isOpen && "rotate-180"
                    )}
                />
            </button>

            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ opacity: 0, y: 10, scale: 0.95 }}
                        animate={{ opacity: 1, y: 0, scale: 1 }}
                        exit={{ opacity: 0, y: 10, scale: 0.95 }}
                        transition={{ duration: 0.15 }}
                        className="absolute right-0 top-full mt-2 w-72 rounded-2xl border border-slate-800 bg-slate-950/95 p-2 shadow-2xl backdrop-blur-xl"
                    >
                        {/* User info header */}
                        <div className="px-3 py-3 border-b border-slate-800 mb-2">
                            <div className="flex items-center gap-3">
                                {user.image ? (
                                    // eslint-disable-next-line @next/next/no-img-element
                                    <img
                                        src={user.image}
                                        alt={user.name || 'User'}
                                        className="h-12 w-12 rounded-full object-cover ring-2 ring-purple-500/30"
                                    />
                                ) : (
                                    <div className="flex h-12 w-12 items-center justify-center rounded-full bg-gradient-to-br from-purple-600 to-indigo-600 text-lg font-bold text-white">
                                        {initials}
                                    </div>
                                )}
                                <div className="flex-1 min-w-0">
                                    <p className="text-sm font-medium text-white truncate">
                                        {user.name || 'User'}
                                    </p>
                                    <p className="text-xs text-slate-500 truncate">
                                        {user.email}
                                    </p>
                                </div>
                            </div>

                            {/* Credits badge */}
                            <div className="mt-3 flex items-center justify-between p-2 rounded-lg bg-gradient-to-r from-purple-600/10 to-indigo-600/10 border border-purple-500/20">
                                <div className="flex items-center gap-2">
                                    <Sparkles className="h-4 w-4 text-purple-400" />
                                    <span className="text-xs text-slate-300">Credits remaining</span>
                                </div>
                                <span className="text-sm font-bold text-purple-400">47</span>
                            </div>
                        </div>

                        {/* Menu groups */}
                        {menuItems.map((group, groupIndex) => (
                            <div key={group.group} className={cn(groupIndex > 0 && "mt-2 pt-2 border-t border-slate-800")}>
                                <p className="px-3 py-1 text-[10px] font-semibold uppercase tracking-wider text-slate-600">
                                    {group.group}
                                </p>
                                {group.items.map((item) => (
                                    <Link
                                        key={item.href}
                                        href={item.href}
                                        onClick={() => setIsOpen(false)}
                                        className="flex items-center justify-between px-3 py-2 rounded-lg text-sm text-slate-300 hover:bg-slate-800/50 hover:text-white transition-colors"
                                    >
                                        <div className="flex items-center gap-3">
                                            <item.icon className="h-4 w-4 text-slate-500" />
                                            {item.label}
                                        </div>
                                        {item.badge && (
                                            <span className="px-2 py-0.5 rounded-full bg-purple-500/20 text-xs font-medium text-purple-400">
                                                {item.badge}
                                            </span>
                                        )}
                                    </Link>
                                ))}
                            </div>
                        ))}

                        {/* Sign out */}
                        <div className="mt-2 pt-2 border-t border-slate-800">
                            <button
                                onClick={handleSignOut}
                                className="flex w-full items-center gap-3 px-3 py-2 rounded-lg text-sm text-red-400 hover:bg-red-500/10 transition-colors"
                            >
                                <LogOut className="h-4 w-4" />
                                Sign out
                            </button>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
