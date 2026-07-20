export interface LocalizationOSAPIContract {
  createCountry(params: any): Promise<any>;
  getCountry(id: string): Promise<any>;
  updateCountry(id: string, params: any): Promise<any>;
  translateText(params: any): Promise<any>;
  updateExchangeRate(params: any): Promise<any>;
  addLanguage(params: any): Promise<any>;
  addCurrency(params: any): Promise<any>;
  getAnalytics(params: any): Promise<any>;
}

export interface CountryResponse {
  id: string;
  countryCode: string;
  name: string;
  defaultLanguage: string;
  defaultCurrency: string;
  status: string;
}

export interface TranslationResponse {
  id: string;
  originalText: string;
  translatedText: string;
  sourceLanguage: string;
  targetLanguage: string;
  status: string;
}
