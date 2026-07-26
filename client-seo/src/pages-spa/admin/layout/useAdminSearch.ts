import { useState, useEffect, useCallback, useRef } from "react";
import { useRouter } from "next/navigation";
import type { NavItem } from "./admin-nav-config";

export interface SearchResult {
  id: string;
  type: 'property' | 'user' | 'booking' | 'tenant' | 'guest' | 'contract' | 'page';
  title: string;
  subtitle?: string;
  href: string;
  icon: React.ComponentType<{ className?: string }>;
  category: string;
}

export function useAdminSearch(adminNavigation: NavItem[]) {
  const [searchQuery, setSearchQuery] = useState("");
  const [searchOpen, setSearchOpen] = useState(false);
  const [searchResults, setSearchResults] = useState<SearchResult[]>([]);
  const [searchHistory, setSearchHistory] = useState<string[]>([]);
  const [selectedIndex, setSelectedIndex] = useState(0);
  const searchRef = useRef<HTMLDivElement>(null);
  const inputRef = useRef<HTMLInputElement>(null);
  const router = useRouter();

  useEffect(() => {
    const savedHistory = localStorage.getItem('admin_search_history');
    if (savedHistory) {
      setSearchHistory(JSON.parse(savedHistory));
    }
  }, []);

  const saveToHistory = useCallback((query: string) => {
    if (!query.trim()) return;
    setSearchHistory(prev => {
      const newHistory = [query, ...prev.filter(q => q !== query)].slice(0, 10);
      localStorage.setItem('admin_search_history', JSON.stringify(newHistory));
      return newHistory;
    });
  }, []);

  const performSearch = useCallback((query: string) => {
    if (!query.trim()) {
      setSearchResults([]);
      return;
    }

    const q = query.toLowerCase();
    const results: SearchResult[] = [];

    const searchInNav = (items: NavItem[], category: string) => {
      items.forEach(item => {
        if (item.title.toLowerCase().includes(q)) {
          if (item.href) {
            results.push({
              id: item.href,
              type: 'page',
              title: item.title,
              href: item.href,
              icon: item.icon,
              category
            });
          }
        }
        if (item.children) {
          searchInNav(item.children, category);
        }
      });
    };

    searchInNav(adminNavigation, 'Navigation');

    if (q.includes('property') || q.includes('mülk') || q.includes('ev')) {
      results.push(
        { id: 'p1', type: 'property', title: 'Luxury Apartment Istanbul', subtitle: 'Beyoğlu, İstanbul', href: '/admin/properties/1', icon: adminNavigation[0]?.icon || (() => null), category: 'Properties' },
        { id: 'p2', type: 'property', title: 'Villa Antalya', subtitle: 'Kaleiçi, Antalya', href: '/admin/properties/2', icon: adminNavigation[0]?.icon || (() => null), category: 'Properties' }
      );
    }

    if (q.includes('user') || q.includes('kullanıcı') || q.includes('müşteri')) {
      results.push(
        { id: 'u1', type: 'user', title: 'John Doe', subtitle: 'john@example.com', href: '/admin/users/1', icon: adminNavigation[0]?.icon || (() => null), category: 'Users' }
      );
    }

    if (q.includes('booking') || q.includes('rezervasyon')) {
      results.push(
        { id: 'b1', type: 'booking', title: 'Booking #12345', subtitle: 'Jan 15 - Jan 20, 2024', href: '/admin/bookings/12345', icon: adminNavigation[0]?.icon || (() => null), category: 'Bookings' }
      );
    }

    if (q.includes('tenant') || q.includes('kiracı')) {
      results.push(
        { id: 't1', type: 'tenant', title: 'Ahmet Yılmaz', subtitle: 'Verified', href: '/admin/tenants/1', icon: adminNavigation[0]?.icon || (() => null), category: 'Tenants' }
      );
    }

    if (q.includes('guest') || q.includes('misafir')) {
      results.push(
        { id: 'g1', type: 'guest', title: 'Maria Garcia', subtitle: '5 bookings', href: '/admin/guests/1', icon: adminNavigation[0]?.icon || (() => null), category: 'Guests' }
      );
    }

    if (q.includes('contract') || q.includes('sözleşme')) {
      results.push(
        { id: 'c1', type: 'contract', title: 'Contract #789', subtitle: 'Active', href: '/admin/contracts/789', icon: adminNavigation[0]?.icon || (() => null), category: 'Contracts' }
      );
    }

    setSearchResults(results.slice(0, 10));
    setSelectedIndex(0);
  }, [adminNavigation]);

  useEffect(() => {
    const timer = setTimeout(() => {
      performSearch(searchQuery);
    }, 300);
    return () => clearTimeout(timer);
  }, [searchQuery, performSearch]);

  const handleKeyDown = useCallback((e: React.KeyboardEvent) => {
    if (!searchOpen || searchResults.length === 0) return;

    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault();
        setSelectedIndex(prev => (prev + 1) % searchResults.length);
        break;
      case 'ArrowUp':
        e.preventDefault();
        setSelectedIndex(prev => (prev - 1 + searchResults.length) % searchResults.length);
        break;
      case 'Enter':
        e.preventDefault();
        if (searchResults[selectedIndex]) {
          router.push(searchResults[selectedIndex].href);
          setSearchOpen(false);
          saveToHistory(searchQuery);
          setSearchQuery('');
        }
        break;
      case 'Escape':
        e.preventDefault();
        setSearchOpen(false);
        break;
    }
  }, [searchOpen, searchResults, selectedIndex, router, searchQuery, saveToHistory]);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (searchRef.current && !searchRef.current.contains(event.target as Node)) {
        setSearchOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const handleSearchClick = (result: SearchResult) => {
    router.push(result.href);
    setSearchOpen(false);
    saveToHistory(searchQuery);
    setSearchQuery('');
  };

  const clearHistory = () => {
    setSearchHistory([]);
    localStorage.removeItem('admin_search_history');
  };

  return {
    searchQuery,
    setSearchQuery,
    searchOpen,
    setSearchOpen,
    searchResults,
    searchHistory,
    selectedIndex,
    searchRef,
    inputRef,
    handleKeyDown,
    handleSearchClick,
    clearHistory,
  };
}
