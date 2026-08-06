/**
 * UI + i18n conventions for public & admin (client-seo).
 *
 * Theme tokens (prefer these over raw slate/purple/hex):
 *   bg-background | bg-card | bg-muted | bg-primary | bg-brand
 *   text-foreground | text-muted-foreground | text-primary | text-brand
 *   text-success | text-warning | text-info | text-destructive
 *   border-border
 *
 * Layout helpers (globals.css @layer components):
 *   ui-page | ui-page-header | ui-title | ui-subtitle | ui-panel | ui-kpi
 *   ui-btn-primary | ui-btn-brand | ui-status-*
 *
 * Translation keys (keySeparator is false → flat dotted strings):
 *   common.*                 shared actions/status/fields
 *   public.nav.* / public.cta.*
 *   footer.*                 site footer
 *   auth.login.* / auth.signup.*
 *   admin.nav.*              admin sidebar (legacy: admin_layout_*)
 *   client.nav.*             client app sidebar
 *   {os_name}.*              e.g. analytics_os.title, booking_os.subtitle
 *   admin_{module}_{action}  legacy flat admin page keys (still valid)
 *   client.src.*             legacy page copy (prefer common/client.nav)
 *
 * Always call: t("namespace.key", "English fallback")
 */

export const UI = {
  page: "ui-page",
  pageHeader: "ui-page-header",
  title: "ui-title",
  subtitle: "ui-subtitle",
  panel: "ui-panel",
  kpi: "ui-kpi",
  muted: "ui-muted",
  btnPrimary: "ui-btn-primary",
  btnBrand: "ui-btn-brand",
} as const;

export const I18N = {
  common: {
    loading: "common.loading",
    save: "common.save",
    cancel: "common.cancel",
    delete: "common.delete",
    edit: "common.edit",
    search: "common.search",
    refresh: "common.refresh",
    error: "common.error_generic",
    success: "common.success_generic",
    noData: "common.no_data",
  },
  public: {
    home: "public.nav.home",
    features: "public.nav.features",
    about: "public.nav.about",
    login: "public.nav.login",
    signup: "public.nav.signup",
    getStarted: "public.cta.get_started",
    explore: "public.cta.explore",
  },
  auth: {
    loginTitle: "auth.login.title",
    loginSubtitle: "auth.login.subtitle",
    signupTitle: "auth.signup.title",
    signupSubtitle: "auth.signup.subtitle",
    createAccount: "auth.signup.create_account",
  },
  footer: {
    platform: "footer.platform",
    support: "footer.support",
    connect: "footer.connect",
    mission: "footer.mission",
  },
  adminNav: {
    dashboard: "admin.nav.admin_dashboard",
    prefix: "admin.nav.",
  },
  clientNav: {
    dashboard: "client.nav.dashboard",
    prefix: "client.nav.",
  },
} as const;
