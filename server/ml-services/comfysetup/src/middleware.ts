import NextAuth from "next-auth";
import { authConfig } from "@/lib/auth.config";
import { locales, defaultLocale } from "@/lib/i18n/config";

const { auth } = NextAuth(authConfig);

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico|.*\\..*).*)"],
};

export default auth(async (req) => {
  const pathname = req.nextUrl.pathname;

  // 1. Check if pathname is missing a locale
  const pathnameIsMissingLocale = locales.every(
    (locale) => !pathname.startsWith(`/${locale}/`) && pathname !== `/${locale}`
  );

  // Redirect to default locale if missing
  if (pathnameIsMissingLocale) {
    return Response.redirect(
      new URL(`/${defaultLocale}${pathname}`, req.url)
    );
  }

  // 2. Auth Logic
  const isLoggedIn = !!req.auth;
  const isOnDashboard = pathname.includes("/dashboard");
  const isOnAdmin = pathname.includes("/admin");
  const isOnAuth = pathname.includes("/auth");

  // Admin protection
  if (isOnAdmin) {
    if (!isLoggedIn) {
      const locale = pathname.split('/')[1];
      return Response.redirect(new URL(`/${locale}/auth/signin`, req.nextUrl));
    }
    // Role check will be done server-side in requireAdmin()
    return Promise.resolve();
  }

  if (isOnDashboard) {
    if (isLoggedIn) return Promise.resolve();
    // Extract locale from pathname
    const locale = pathname.split('/')[1];
    return Response.redirect(new URL(`/${locale}/auth/signin`, req.nextUrl));
  }

  if (isOnAuth) {
    if (isLoggedIn) {
      const locale = pathname.split('/')[1];
      return Response.redirect(new URL(`/${locale}/dashboard`, req.nextUrl));
    }
    return Promise.resolve();
  }

  return Promise.resolve();
});
