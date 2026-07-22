"use client";

import { useEffect, useRef } from "react";

type CleanupFn = () => void;

export function useBfcache(onFreeze?: CleanupFn, onResume?: () => void) {
  const freezeRef = useRef(onFreeze);
  const resumeRef = useRef(onResume);
  freezeRef.current = onFreeze;
  resumeRef.current = onResume;

  useEffect(() => {
    const handlePageHide = () => freezeRef.current?.();
    const handlePageShow = (e: PageTransitionEvent) => {
      if (e.persisted) resumeRef.current?.();
    };
    window.addEventListener("pagehide", handlePageHide);
    window.addEventListener("pageshow", handlePageShow);
    return () => {
      window.removeEventListener("pagehide", handlePageHide);
      window.removeEventListener("pageshow", handlePageShow);
    };
  }, []);
}
