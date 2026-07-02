import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { Button } from "@/components/ui/button";
import { DropdownMenu, DropdownMenuContent, DropdownMenuTrigger } from "@/components/ui/dropdown-menu";
import { Globe, Check, ChevronDown } from "lucide-react";
import { useAuth } from "@/lib/auth/hooks";
import { userPreferencesApi } from "@/lib/api/user-preferences";
import { useRegionsStore } from "@/lib/store/regions-store";
import { LANGUAGES } from "@/lib/languages";
const countries = [{
  code: "TR",
  name: "Turkey",
  flag: "🇹🇷"
}, {
  code: "US",
  name: "United States",
  flag: "🇺🇸"
}, {
  code: "GB",
  name: "United Kingdom",
  flag: "🇬🇧"
}, {
  code: "DE",
  name: "Germany",
  flag: "🇩🇪"
}, {
  code: "FR",
  name: "France",
  flag: "🇫🇷"
}];
const currencies = [{
  code: "TRY",
  name: "TL (₺)",
  symbol: "₺"
}, {
  code: "USD",
  name: "USD ($)",
  symbol: "$"
}, {
  code: "EUR",
  name: "EUR (€)",
  symbol: "€"
}, {
  code: "GBP",
  name: "GBP (£)",
  symbol: "£"
}];
export default function GlobalPreferencesSelector() {
  const {
    t
  } = useTranslation();
  const {
    i18n
  } = useTranslation();
  const {
    user,
    setUser
  } = useAuth();
  const { setSelectedRegion } = useRegionsStore();

  // Load initial states from localStorage or user context
  const [selectedCountry, setSelectedCountry] = useState(() => {
    return localStorage.getItem("reservatior_country") || "TR";
  });
  const [selectedLanguage, setSelectedLanguage] = useState(() => {
    return localStorage.getItem("reservatior_lang") || i18n.language || "tr";
  });
  const [selectedCurrency, setSelectedCurrency] = useState(() => {
    return localStorage.getItem("reservatior_currency") || "TRY";
  });
  const [activeSection, setActiveSection] = useState<"country" | "language" | "currency">("country");

  // Keep i18n synchronized with selected language
  useEffect(() => {
    if (selectedLanguage && i18n.language !== selectedLanguage) {
      i18n.changeLanguage(selectedLanguage);
    }
  }, [selectedLanguage]);
  const handleCountryChange = async (code: string) => {
    setSelectedCountry(code);
    localStorage.setItem("reservatior_country", code);
    
    // Auto-update language based on selected country
    let newLang = selectedLanguage;
    switch (code) {
      case "TR": newLang = "tr"; break;
      case "US": newLang = "en"; break;
      case "GB": newLang = "en"; break;
      case "DE": newLang = "de"; break;
      case "FR": newLang = "fr"; break;
    }
    
    if (newLang !== selectedLanguage) {
      setSelectedLanguage(newLang);
      localStorage.setItem("reservatior_lang", newLang);
      i18n.changeLanguage(newLang);
    }

    // Auto-update currency based on selected country
    let newCurrency = selectedCurrency;
    switch (code) {
      case "TR": newCurrency = "TRY"; break;
      case "US": newCurrency = "USD"; break;
      case "GB": newCurrency = "GBP"; break;
      case "DE": newCurrency = "EUR"; break;
      case "FR": newCurrency = "EUR"; break;
    }

    if (newCurrency !== selectedCurrency) {
      setSelectedCurrency(newCurrency);
      localStorage.setItem("reservatior_currency", newCurrency);
    }
    
    // Update global regions store
    setSelectedRegion(code);

    // Sync with backend if user is authenticated
    if (user) {
      try {
        await userPreferencesApi.bulkUpdate(user.id, {
          timezone: code === "TR" ? "Europe/Istanbul" : "America/New_York"
        });
      } catch (err) {
        console.error("Backend preference update failed:", err);
      }
    }
  };
  const handleLanguageChange = async (code: string) => {
    setSelectedLanguage(code);
    localStorage.setItem("reservatior_lang", code);
    i18n.changeLanguage(code);
    if (user) {
      try {
        await userPreferencesApi.bulkUpdate(user.id, {
          language: code
        });
        const updatedPreferences = {
          ...user.preferences,
          language: code
        };
        setUser({
          ...user,
          preferences: updatedPreferences as any
        });
      } catch (err) {
        console.error("Backend language preference update failed:", err);
      }
    }
  };
  const handleCurrencyChange = async (code: string) => {
    setSelectedCurrency(code);
    localStorage.setItem("reservatior_currency", code);
    if (user) {
      try {
        await userPreferencesApi.bulkUpdate(user.id, {
          currency: code
        });
        const updatedPreferences = {
          ...user.preferences,
          currency: code
        };
        setUser({
          ...user,
          preferences: updatedPreferences as any
        });
      } catch (err) {
        console.error("Backend currency preference update failed:", err);
      }
    }
  };
  const currentCountryObj = countries.find(c => c.code === selectedCountry) || countries[0];
  const currentLangObj = LANGUAGES.find(l => l.code === selectedLanguage) || LANGUAGES[0];
  const currentCurrencyObj = currencies.find(curr => curr.code === selectedCurrency) || currencies[0];
  return <DropdownMenu>
      <DropdownMenuTrigger asChild>
        <Button variant="outline" size="sm" className="flex items-center gap-1.5 px-2.5 h-10 rounded-xl bg-white/5 border-white/5 hover:bg-white/10 text-white font-medium text-xs transition-all shrink-0">
          <Globe className="w-3.5 h-3.5 text-blue-400" />
          <span className="text-sm">{currentLangObj.flag}</span>
          <span className="uppercase text-[10px] font-semibold text-slate-400">{currentLangObj.code}</span>
          <ChevronDown className="w-3 h-3 text-slate-400" />
        </Button>
      </DropdownMenuTrigger>
      
      <DropdownMenuContent align="end" className="w-80 p-4 bg-[#14151a]/95 border border-white/5 backdrop-blur-2xl rounded-2xl shadow-2xl z-50 text-white focus:outline-none">
        {/* Navigation Tabs */}
        <div className="flex bg-white/5 p-1 rounded-xl gap-1 mb-4 border border-white/5">
          <button onClick={() => setActiveSection("country")} className={`flex-1 py-1.5 text-[10px] font-black uppercase tracking-widest rounded-lg transition-all ${activeSection === "country" ? "bg-white/10 text-white" : "text-slate-500 hover:text-white"}`}>{t("client.src.country")}</button>
          <button onClick={() => setActiveSection("language")} className={`flex-1 py-1.5 text-[10px] font-black uppercase tracking-widest rounded-lg transition-all ${activeSection === "language" ? "bg-white/10 text-white" : "text-slate-500 hover:text-white"}`}>{t("client.src.language")}</button>
          <button onClick={() => setActiveSection("currency")} className={`flex-1 py-1.5 text-[10px] font-black uppercase tracking-widest rounded-lg transition-all ${activeSection === "currency" ? "bg-white/10 text-white" : "text-slate-500 hover:text-white"}`}>{t("client.src.currency")}</button>
        </div>

        {/* Section Contents */}
        <div className="space-y-1 max-h-56 overflow-y-auto pr-1">
          {activeSection === "country" && countries.map(item => <button key={item.code} onClick={() => handleCountryChange(item.code)} className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl hover:bg-white/5 transition-all text-left text-xs ${selectedCountry === item.code ? "bg-blue-600/10 text-blue-400" : "text-slate-300"}`}>
                <div className="flex items-center gap-3">
                  <span className="text-base">{item.flag}</span>
                  <span className="font-bold">{item.name} ({item.code})</span>
                </div>
                {selectedCountry === item.code && <Check className="w-4 h-4 text-blue-400" />}
              </button>)}

          {activeSection === "language" && LANGUAGES.map(item => <button key={item.code} onClick={() => handleLanguageChange(item.code)} className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl hover:bg-white/5 transition-all text-left text-xs ${selectedLanguage === item.code ? "bg-blue-600/10 text-blue-400" : "text-slate-300"}`}>
                <div className="flex items-center gap-3">
                  <span className="text-base">{item.flag}</span>
                  <span className="font-bold">{item.name}</span>
                </div>
                {selectedLanguage === item.code && <Check className="w-4 h-4 text-blue-400" />}
              </button>)}

          {activeSection === "currency" && currencies.map(item => <button key={item.code} onClick={() => handleCurrencyChange(item.code)} className={`w-full flex items-center justify-between px-3 py-2.5 rounded-xl hover:bg-white/5 transition-all text-left text-xs ${selectedCurrency === item.code ? "bg-blue-600/10 text-blue-400" : "text-slate-300"}`}>
                <div className="flex items-center gap-3 font-bold">
                  <span className="w-6 h-6 rounded-lg bg-white/5 flex items-center justify-center text-xs text-slate-400">
                    {item.symbol}
                  </span>
                  <span>{item.name}</span>
                </div>
                {selectedCurrency === item.code && <Check className="w-4 h-4 text-blue-400" />}
              </button>)}
        </div>
      </DropdownMenuContent>
    </DropdownMenu>;
}