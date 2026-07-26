/**
 * src/lib/seo/keyword-store.ts
 * ─────────────────────────────────────────────────────────────────────────────
 * Zustand store — keyword sinyallerini tutar, debounce ile backend'e gönderir.
 * Browser-only (localStorage persistence).
 */

import { create } from "zustand";
import {
  type KeywordSignal,
  type KeywordScore,
  buildSignal,
  persistSignal,
  loadStoredSignals,
  scoreSignals,
  type SignalSource,
} from "./keyword-engine";

const API_ENDPOINT = "/api/keyword-signals";
const FLUSH_DEBOUNCE_MS = 3000;  // 3 saniye bekleyip batch gönder
const MAX_PENDING = 50;

interface KeywordStoreState {
  signals: KeywordSignal[];
  topScores: KeywordScore[];
  pendingFlush: KeywordSignal[];
  flushTimer: ReturnType<typeof setTimeout> | null;

  // Actions
  capture: (
    term: string,
    source: SignalSource,
    locale: string,
    overrides?: Partial<KeywordSignal>
  ) => void;
  rehydrate: () => void;
  getTopN: (n?: number, locale?: string) => KeywordScore[];
  flush: () => Promise<void>;
}

export const useKeywordStore = create<KeywordStoreState>((set, get) => ({
  signals: [],
  topScores: [],
  pendingFlush: [],
  flushTimer: null,

  /**
   * Yeni bir keyword sinyali yakala, localStorage'a yaz,
   * debounce ile backend'e gönder.
   */
  capture(term, source, locale, overrides) {
    const trimmed = term.trim();
    if (!trimmed || trimmed.length < 2) return;

    const signal = buildSignal(trimmed, source, locale, overrides);
    persistSignal(signal);

    set((state) => {
      const signals = [...state.signals, signal];
      const topScores = scoreSignals(signals).slice(0, 20);
      const pending = [...state.pendingFlush, signal].slice(-MAX_PENDING);

      // Debounce flush
      if (state.flushTimer) clearTimeout(state.flushTimer);
      const flushTimer = setTimeout(() => get().flush(), FLUSH_DEBOUNCE_MS);

      return { signals, topScores, pendingFlush: pending, flushTimer };
    });
  },

  /**
   * Sayfa yüklenince localStorage'dan önceki sinyalleri yükle.
   */
  rehydrate() {
    const stored = loadStoredSignals();
    const topScores = scoreSignals(stored).slice(0, 20);
    set({ signals: stored, topScores });
  },

  /**
   * En yüksek değerli keyword'leri döndür.
   */
  getTopN(n = 10, locale) {
    const { topScores } = get();
    const filtered = locale
      ? topScores.filter((s) => s.locale === locale)
      : topScores;
    return filtered.slice(0, n);
  },

  /**
   * Bekleyen sinyalleri backend'e gönder.
   * Başarısız olursa pending'de kalır, sessizce geçer.
   */
  async flush() {
    const { pendingFlush } = get();
    if (pendingFlush.length === 0) return;

    set({ pendingFlush: [], flushTimer: null });

    try {
      await fetch(API_ENDPOINT, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ signals: pendingFlush }),
        // fire-and-forget, low priority
        keepalive: true,
      });
    } catch {
      // Network error → sessizce geç, localStorage'da zaten var
    }
  },
}));
