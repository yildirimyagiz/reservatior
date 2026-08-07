import "server-only";
import fs from "fs";
import path from "path";
import i18n from "./index";

// SSR sırasında locale JSON'ları public URL üzerinden HTTP ile değil, dosya
// sisteminden senkron yüklenir. Böylece SSR her zaman deterministik 'en'
// içerik üretir (nginx → web istek döngüsü / asılma riski olmadan).
export function loadLocaleOnServer(locale?: string): void {
  const langs = locale && locale !== "en" ? [locale, "en"] : ["en"];
  for (const lang of langs) {
    try {
      if (i18n.hasResourceBundle(lang, "translation")) continue;
      const p = path.join(process.cwd(), "public", "locales", `${lang}.json`);
      const data = JSON.parse(fs.readFileSync(p, "utf8"));
      i18n.addResourceBundle(lang, "translation", data, true, true);
    } catch (e) {
      console.error(`[i18n] failed to preload locale ${lang}`, (e as Error).message);
    }
  }
}
