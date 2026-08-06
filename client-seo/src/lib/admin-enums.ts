import type { TFunction } from "i18next";

const normalize = (value: string) => value.toLowerCase().replace(/[^a-z0-9]+/g, "_");

export function tEnum(t: TFunction, value?: string | null): string {
  if (!value) return "";
  return t(`admin_enum_${normalize(value)}`, { defaultValue: value });
}
