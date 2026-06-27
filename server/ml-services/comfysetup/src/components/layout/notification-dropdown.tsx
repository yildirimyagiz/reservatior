'use client';

import { useState, useRef, useEffect } from 'react';
import Link from 'next/link';
import { useParams } from 'next/navigation';
import { motion, AnimatePresence } from 'framer-motion';
import {
    Bell,
    Check,
    CheckCheck,
    Image,
    Sparkles,
    CreditCard,
    AlertCircle,
    X,
    Settings,
    Shield,
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { formatDistanceToNow } from 'date-fns';
import { toast } from 'sonner';

interface Notification {
    id: string;
    type: 'GENERATION' | 'CREDIT' | 'SYSTEM' | 'PROMO' | 'SECURITY';
    title: string;
    message: string;
    read: boolean;
    createdAt: string; // Serialized from API
    link?: string;
    imageUrl?: string;
}

const notificationIcons = {
    GENERATION: Image,
    CREDIT: CreditCard,
    SYSTEM: AlertCircle,
    PROMO: Sparkles,
    SECURITY: Shield,
};

const notificationColors = {
    GENERATION: 'text-green-400 bg-green-500/20',
    CREDIT: 'text-amber-400 bg-amber-500/20',
    SYSTEM: 'text-blue-400 bg-blue-500/20',
    PROMO: 'text-purple-400 bg-purple-500/20',
    SECURITY: 'text-red-400 bg-red-500/20',
};

export function NotificationDropdown() {
    const params = useParams();
    const locale = params.locale as string;
    const [isOpen, setIsOpen] = useState(false);
    const [notifications, setNotifications] = useState<Notification[]>([]);
    const [loading, setLoading] = useState(true);
    const dropdownRef = useRef<HTMLDivElement>(null);

    const unreadCount = notifications.filter((n) => !n.read).length;

    // Fetch notifications
    useEffect(() => {
        const fetchNotifications = async () => {
            try {
                const res = await fetch('/api/notifications');
                if (res.ok) {
                    const data = await res.json();
                    setNotifications(data);
                }
            } catch (error) {
                console.error('Failed to fetch notifications', error);
            } finally {
                setLoading(false);
            }
        };

        if (isOpen) {
            fetchNotifications();
            // In a real app, you might poll here or use SSE/WebSockets
        } else {
            // Initial fetch for badge count
            fetchNotifications();
        }
    }, [isOpen]);

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

    const markAsRead = async (id: string) => {
        // Optimistic update
        setNotifications((prev) =>
            prev.map((n) => (n.id === id ? { ...n, read: true } : n))
        );

        try {
            await fetch(`/api/notifications/${id}`, {
                method: 'PATCH',
                body: JSON.stringify({ read: true }),
            });
        } catch (error) {
            console.error('Failed to mark read', error);
            toast.error("Failed to update notification");
        }
    };

    const markAllAsRead = async () => {
        // Optimistic update
        const unreadIds = notifications.filter(n => !n.read).map(n => n.id);
        setNotifications((prev) => prev.map((n) => ({ ...n, read: true })));

        try {
            await Promise.all(unreadIds.map(id => 
                fetch(`/api/notifications/${id}`, {
                    method: 'PATCH',
                    body: JSON.stringify({ read: true }),
                })
            ));
            toast.success("All notifications marked as read");
        } catch (error) {
            console.error('Failed to mark all read', error);
            toast.error("Failed to update notifications");
            // Revert changes could happen here if needed, but low priority for read status
        }
    };

    const removeNotification = async (id: string) => {
        // Optimistic update
        const previous = notifications;
        setNotifications((prev) => prev.filter((n) => n.id !== id));

        try {
            const res = await fetch(`/api/notifications/${id}`, { method: 'DELETE' });
            if (!res.ok) throw new Error('Failed to delete');
        } catch (error) {
            console.error('Failed to delete', error);
            toast.error("Failed to delete notification");
            setNotifications(previous);
        }
    };

    return (
        <div ref={dropdownRef} className="relative">
            <button
                onClick={() => setIsOpen(!isOpen)}
                className={cn(
                    "relative flex h-9 w-9 items-center justify-center rounded-full transition-all",
                    "hover:bg-slate-800/50",
                    isOpen && "bg-slate-800/50"
                )}
            >
                <Bell className="h-5 w-5 text-slate-400" />
                {unreadCount > 0 && (
                    <span className="absolute -top-0.5 -right-0.5 flex h-5 w-5 items-center justify-center rounded-full bg-red-500 text-[10px] font-bold text-white">
                        {unreadCount > 9 ? '9+' : unreadCount}
                    </span>
                )}
            </button>

            <AnimatePresence>
                {isOpen && (
                    <motion.div
                        initial={{ opacity: 0, y: 10, scale: 0.95 }}
                        animate={{ opacity: 1, y: 0, scale: 1 }}
                        exit={{ opacity: 0, y: 10, scale: 0.95 }}
                        transition={{ duration: 0.15 }}
                        className="absolute right-0 top-full mt-2 w-96 rounded-2xl border border-slate-800 bg-slate-950/95 shadow-2xl backdrop-blur-xl overflow-hidden"
                    >
                        {/* Header */}
                        <div className="flex items-center justify-between px-4 py-3 border-b border-slate-800">
                            <h3 className="text-sm font-semibold text-white">Notifications</h3>
                            <div className="flex items-center gap-2">
                                {unreadCount > 0 && (
                                    <button
                                        onClick={markAllAsRead}
                                        className="flex items-center gap-1 text-xs text-purple-400 hover:text-purple-300"
                                    >
                                        <CheckCheck className="h-3.5 w-3.5" />
                                        Mark all read
                                    </button>
                                )}
                                <Link
                                    href={`/${locale}/settings/notifications`}
                                    onClick={() => setIsOpen(false)}
                                    className="p-1 text-slate-500 hover:text-white"
                                >
                                    <Settings className="h-4 w-4" />
                                </Link>
                            </div>
                        </div>

                        {/* Notification list */}
                        <div className="max-h-96 overflow-y-auto">
                            {loading && notifications.length === 0 ? (
                                <div className="flex flex-col items-center justify-center py-8 text-slate-500">
                                  <div className="h-6 w-6 animate-spin rounded-full border-2 border-purple-500 border-t-transparent" />
                                </div>
                            ) : notifications.length === 0 ? (
                                <div className="flex flex-col items-center justify-center py-12 text-slate-500">
                                    <Bell className="h-12 w-12 mb-3 text-slate-700" />
                                    <p className="text-sm">No notifications yet</p>
                                </div>
                            ) : (
                                <div className="divide-y divide-slate-800/50">
                                    {notifications.map((notification) => {
                                        const Icon = notificationIcons[notification.type] || AlertCircle;
                                        const colorClass = notificationColors[notification.type] || notificationColors.SYSTEM;

                                        return (
                                            <div
                                                key={notification.id}
                                                className={cn(
                                                    "relative group",
                                                    !notification.read && "bg-purple-500/5"
                                                )}
                                            >
                                                <Link
                                                    href={notification.link ? `/${locale}${notification.link}` : '#'}
                                                    onClick={() => {
                                                        markAsRead(notification.id);
                                                        if (notification.link) setIsOpen(false);
                                                    }}
                                                    className="flex gap-3 p-4 hover:bg-slate-800/30 transition-colors"
                                                >
                                                    {/* Icon or image */}
                                                    {notification.imageUrl ? (
                                                        // eslint-disable-next-line @next/next/no-img-element
                                                        <img
                                                            src={notification.imageUrl}
                                                            alt=""
                                                            className="h-12 w-12 rounded-lg object-cover"
                                                        />
                                                    ) : (
                                                        <div className={cn("flex h-10 w-10 shrink-0 items-center justify-center rounded-lg", colorClass)}>
                                                            <Icon className="h-5 w-5" />
                                                        </div>
                                                    )}

                                                    {/* Content */}
                                                    <div className="flex-1 min-w-0">
                                                        <div className="flex items-start justify-between gap-2">
                                                            <p className="text-sm font-medium text-white">
                                                                {notification.title}
                                                            </p>
                                                            {!notification.read && (
                                                                <span className="h-2 w-2 shrink-0 rounded-full bg-purple-500 mt-1.5" />
                                                            )}
                                                        </div>
                                                        <p className="text-xs text-slate-400 line-clamp-2 mt-0.5">
                                                            {notification.message}
                                                        </p>
                                                        <p className="text-[10px] text-slate-600 mt-1">
                                                            {formatDistanceToNow(new Date(notification.createdAt), { addSuffix: true })}
                                                        </p>
                                                    </div>
                                                </Link>

                                                {/* Actions on hover */}
                                                <div className="absolute top-2 right-2 flex items-center gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                                    {!notification.read && (
                                                        <button
                                                            onClick={(e) => {
                                                                e.preventDefault();
                                                                e.stopPropagation();
                                                                markAsRead(notification.id);
                                                            }}
                                                            className="p-1 rounded-md bg-slate-800 text-slate-400 hover:text-white"
                                                            title="Mark as read"
                                                        >
                                                            <Check className="h-3.5 w-3.5" />
                                                        </button>
                                                    )}
                                                    <button
                                                        onClick={(e) => {
                                                            e.preventDefault();
                                                            e.stopPropagation();
                                                            removeNotification(notification.id);
                                                        }}
                                                        className="p-1 rounded-md bg-slate-800 text-slate-400 hover:text-red-400"
                                                        title="Remove"
                                                    >
                                                        <X className="h-3.5 w-3.5" />
                                                    </button>
                                                </div>
                                            </div>
                                        );
                                    })}
                                </div>
                            )}
                        </div>

                        {/* Footer */}
                        <div className="p-3 border-t border-slate-800">
                            <Link
                                href={`/${locale}/notifications`}
                                onClick={() => setIsOpen(false)}
                                className="block w-full py-2 text-center text-sm text-purple-400 hover:text-purple-300 rounded-lg hover:bg-slate-800/50 transition-colors"
                            >
                                View all notifications
                            </Link>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
}
