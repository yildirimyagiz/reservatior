"use client";

import { useParams as nextUseParams, useRouter, useSearchParams as nextUseSearchParams, usePathname as nextUsePathname } from 'next/navigation';
import { createContext, ReactNode, useEffect } from 'react';
import Link from 'next/link';

// Shim for react-router-dom to work with Next.js
// Custom Link component that accepts both 'to' and 'href' props
export function LinkComponent({ to, href, children, ...props }: any) {
  return (
    <Link href={to || href} {...props}>
      {children}
    </Link>
  );
}

export { LinkComponent as Link };

export function Navigate({ to, replace }: { to: string; replace?: boolean }) {
  const navigate = useNavigate();
  useEffect(() => {
    navigate(to);
  }, [to, replace, navigate]);
  return null;
}

export function Outlet({ children }: { children?: React.ReactNode }) {
  return children ? <>{children}</> : null;
}

export function useNavigate() {
  const router = useRouter();
  
  return (to: string | number, options?: any) => {
    if (typeof to === 'number') {
      if (to === -1) {
        router.back();
      } else {
        // For other numbers, we could implement forward navigation
        // but for now, just go back
        router.back();
      }
    } else {
      router.push(to);
    }
  };
}

export function useParams<T = Record<string, string>>(): T {
  return nextUseParams() as T;
}

export function useLocation() {
  const pathname = nextUsePathname();
  const searchParams = nextUseSearchParams();
  
  return {
    pathname: pathname,
    search: searchParams.toString(),
    hash: '',
    state: null,
    key: 'default'
  };
}

export function useSearchParams(): any {
  const searchParams = nextUseSearchParams();
  const setParams = () => {};
  const arr: any = [searchParams, setParams];
  // Attach URLSearchParams helper methods to the array itself for non-destructured usage
  arr.get = (name: string) => searchParams.get(name);
  arr.has = (name: string) => searchParams.has(name);
  arr.forEach = (callback: any) => searchParams.forEach(callback);
  arr.entries = () => searchParams.entries();
  arr.keys = () => searchParams.keys();
  arr.values = () => searchParams.values();
  arr.toString = () => searchParams.toString();
  return arr;
}

// Context for navigation
const NavigationContext = createContext<any>(null);

export function NavigationProvider({ children }: { children: ReactNode }) {
  const router = useRouter();
  const params = nextUseParams();
  const searchParams = nextUseSearchParams();
  
  const value = {
    router,
    params,
    searchParams
  };
  
  return (
    <NavigationContext.Provider value={value}>
      {children}
    </NavigationContext.Provider>
  );
}
