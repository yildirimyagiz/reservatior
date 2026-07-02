export interface LanguageStore {
  currentLanguage: string;
  setLanguage: (code: string) => void;
  t: (key: string) => string;
}
