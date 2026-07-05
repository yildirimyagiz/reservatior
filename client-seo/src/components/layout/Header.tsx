"use client";

import { t } from "i18next";
import { useTranslation } from "react-i18next";
import { useState } from 'react';
import { Link } from '@/lib/react-router-shim';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { Avatar, AvatarFallback, AvatarImage } from '@/components/ui/avatar';
import { Bell, Search, Settings, User, LogOut, Moon, Sun, Menu, X, HelpCircle, CreditCard, Shield, Globe, Sparkles } from 'lucide-react';
import { useIsMobile } from '@/components/hooks/use-mobile';
import LanguageSelector from '@/components/ui/LanguageSelector';
import RegionSelector from './RegionSelector';
export default function Header() {
  const {
    t
  } = useTranslation();
  const [notifications] = useState(3);
  const [showProfile, setShowProfile] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);
  const [darkMode, setDarkMode] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const isMobile = useIsMobile();
  const notificationItems = [{
    id: 1,
    title: t("client.src.new_property_listing"),
    description: t("client.src.sunset_apartments_unit_4b"),
    time: '5 minutes ago',
    read: false,
    type: 'property'
  }, {
    id: 2,
    title: t("client.src.lease_renewal_reminder"),
    description: t("client.src.3_leases_expiring_this"),
    time: '1 hour ago',
    read: false,
    type: 'lease'
  }, {
    id: 3,
    title: t("client.src.payment_received"),
    description: t("client.src.2500_payment_from_john"),
    time: '2 hours ago',
    read: true,
    type: 'payment'
  }];
  const profileItems = [{
    icon: User,
    label: t("client.src.profile"),
    href: '/profile'
  }, {
    icon: Sparkles,
    label: t("client.src.neural_features"),
    href: '/features'
  }, {
    icon: Settings,
    label: t("client.src.settings"),
    href: '/settings'
  }, {
    icon: CreditCard,
    label: t("client.src.billing"),
    href: '/billing'
  }, {
    icon: Shield,
    label: t("client.src.security"),
    href: '/security'
  }, {
    icon: HelpCircle,
    label: t("client.src.help_center"),
    href: '/help'
  }, {
    icon: LogOut,
    label: t("client.src.logout"),
    href: '/logout'
  }];
  return <header className="bg-white border-b border-gray-200 px-4 py-3 relative z-10">
      <div className="flex items-center justify-between">
        {/* Left side - Mobile menu toggle and search */}
        <div className="flex items-center gap-4">
          {isMobile && <Button variant="ghost" size="sm" onClick={() => setMobileMenuOpen(!mobileMenuOpen)}>
              {mobileMenuOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
            </Button>}
          
          <div className="relative">
            <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 w-4 h-4 text-gray-400" />
            <input type="text" placeholder={t("client.src.search_properties_tenants_or")} className="w-64 lg:w-96 pl-10 pr-4 py-2 text-sm border border-gray-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent" />
          </div>
        </div>

        {/* Right side - Actions */}
        <div className="flex items-center gap-3">
          {/* Dark Mode Toggle */}
          <Button variant="ghost" size="sm" onClick={() => setDarkMode(!darkMode)} className="hidden lg:flex">
            {darkMode ? <Sun className="w-4 h-4" /> : <Moon className="w-4 h-4" />}
          </Button>

          {/* Region Selector */}
          <RegionSelector />

          {/* Language Selector */}
          <LanguageSelector />

          {/* Notifications */}
          <div className="relative">
            <Button variant="ghost" size="sm" onClick={() => setShowNotifications(!showNotifications)} className="relative">
              <Bell className="w-5 h-5" />
              {notifications > 0 && <Badge className="absolute -top-1 -right-1 w-5 h-5 bg-red-500 text-white text-xs flex items-center justify-center">
                  {notifications}
                </Badge>}
            </Button>

            {/* Notifications Dropdown */}
            {showNotifications && <div className="absolute right-0 mt-2 w-80 bg-white rounded-lg shadow-lg border border-gray-200 z-50">
                <div className="p-4 border-b border-gray-200">
                  <div className="flex items-center justify-between">
                    <h3 className="font-semibold">{t("client.src.notifications")}</h3>
                    <Button variant="ghost" size="sm" className="text-xs">{t("client.src.mark_all_as_read")}</Button>
                  </div>
                </div>
                <div className="max-h-96 overflow-y-auto">
                  {notificationItems.map(notification => <div key={notification.id} className={`p-4 border-b border-gray-100 hover:bg-gray-50 cursor-pointer ${!notification.read ? 'bg-purple-50' : ''}`}>
                      <div className="flex items-start gap-3">
                        <div className={`w-2 h-2 rounded-full mt-2 ${!notification.read ? 'bg-purple-600' : 'bg-gray-300'}`}></div>
                        <div className="flex-1">
                          <p className="font-medium text-sm">{notification.title}</p>
                          <p className="text-xs text-gray-600 mt-1">{notification.description}</p>
                          <p className="text-xs text-gray-400 mt-1">{notification.time}</p>
                        </div>
                      </div>
                    </div>)}
                </div>
                <div className="p-4 border-t border-gray-200">
                  <Button variant="ghost" size="sm" className="w-full">{t("client.src.view_all_notifications")}</Button>
                </div>
              </div>}
          </div>

          {/* Profile */}
          <div className="relative">
            <Button variant="ghost" size="sm" onClick={() => setShowProfile(!showProfile)} className="flex items-center gap-2">
              <Avatar className="w-8 h-8">
                <AvatarImage src="/api/placeholder/avatar.jpg" />
                <AvatarFallback>{t("client.src.jd")}</AvatarFallback>
              </Avatar>
              <div className="hidden lg:block text-left">
                <p className="text-sm font-medium">{t("client.src.john_doe")}</p>
                <p className="text-xs text-gray-500">{t("client.src.administrator")}</p>
              </div>
            </Button>

            {/* Profile Dropdown */}
            {showProfile && <div className="absolute right-0 mt-2 w-56 bg-white rounded-lg shadow-lg border border-gray-200 z-50">
                <div className="p-4 border-b border-gray-200">
                  <div className="flex items-center gap-3">
                    <Avatar className="w-10 h-10">
                      <AvatarImage src="/api/placeholder/avatar.jpg" />
                      <AvatarFallback>{t("client.src.jd")}</AvatarFallback>
                    </Avatar>
                    <div>
                      <p className="font-medium">{t("client.src.john_doe")}</p>
                      <p className="text-sm text-gray-500">{t("client.src.johndoeexamplecom")}</p>
                    </div>
                  </div>
                </div>
                <div className="py-2">
                  {profileItems.map((item, index) => <Link key={index} to={item.href} className="flex items-center gap-3 px-4 py-2 text-sm text-gray-700 hover:bg-gray-50 transition-colors">
                      <item.icon className="w-4 h-4" />
                      <span>{item.label}</span>
                    </Link>)}
                </div>
                <div className="p-4 border-t border-gray-200">
                  <div className="flex items-center justify-between text-xs text-gray-500">
                    <span>{t("client.src.version_100")}</span>
                    <div className="flex items-center gap-1">
                      <Globe className="w-3 h-3" />
                      <span>{t("client.src.en")}</span>
                    </div>
                  </div>
                </div>
              </div>}
          </div>
        </div>
      </div>

      {/* Mobile Menu */}
      {isMobile && mobileMenuOpen && <div className="absolute top-full left-0 right-0 bg-white border-b border-gray-200 z-50">
          <div className="p-4 space-y-2">
            <Link to="/property" className="block px-3 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">{t("client.src.properties")}</Link>
            <Link to="/financial" className="block px-3 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">{t("client.src.financial")}</Link>
            <Link to="/tenants" className="block px-3 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">{t("client.src.tenants")}</Link>
            <Link to="/admin" className="block px-3 py-2 rounded-lg text-sm font-medium text-gray-700 hover:bg-gray-50">{t("client.src.admin")}</Link>
          </div>
        </div>}
    </header>;
}