import { useState, useEffect } from "react";

// Breakpoint definitions
export const breakpoints = {
  xs: 0,
  sm: 640,
  md: 768,
  lg: 1024,
  xl: 1280,
  "2xl": 1536,
} as const;

export type Breakpoint = keyof typeof breakpoints;

// Hook to get current breakpoint
export function useBreakpoint(): Breakpoint {
  const [breakpoint, setBreakpoint] = useState<Breakpoint>("lg");

  useEffect(() => {
    const updateBreakpoint = () => {
      const width = window.innerWidth;

      if (width >= breakpoints["2xl"]) {
        setBreakpoint("2xl");
      } else if (width >= breakpoints.xl) {
        setBreakpoint("xl");
      } else if (width >= breakpoints.lg) {
        setBreakpoint("lg");
      } else if (width >= breakpoints.md) {
        setBreakpoint("md");
      } else if (width >= breakpoints.sm) {
        setBreakpoint("sm");
      } else {
        setBreakpoint("xs");
      }
    };

    updateBreakpoint();
    window.addEventListener("resize", updateBreakpoint);
    return () => window.removeEventListener("resize", updateBreakpoint);
  }, []);

  return breakpoint;
}

// Hook to get window dimensions
export function useWindowSize() {
  const [windowSize, setWindowSize] = useState({
    width: 0,
    height: 0,
  });

  useEffect(() => {
    function handleResize() {
      setWindowSize({
        width: window.innerWidth,
        height: window.innerHeight,
      });
    }

    handleResize();
    window.addEventListener("resize", handleResize);
    return () => window.removeEventListener("resize", handleResize);
  }, []);

  return windowSize;
}

// Hook to check if screen is mobile
export function useIsMobile() {
  const breakpoint = useBreakpoint();
  return breakpoint === "xs" || breakpoint === "sm";
}

// Hook to check if screen is tablet
export function useIsTablet() {
  const breakpoint = useBreakpoint();
  return breakpoint === "md";
}

// Hook to check if screen is desktop
export function useIsDesktop() {
  const breakpoint = useBreakpoint();
  return breakpoint === "lg" || breakpoint === "xl" || breakpoint === "2xl";
}

// Responsive value utility
export function responsiveValue<T>(
  values: Partial<Record<Breakpoint, T>>,
  defaultValue: T
): T {
  const breakpoint = useBreakpoint();

  // Check breakpoints from largest to smallest
  const orderedBreakpoints: Breakpoint[] = [
    "2xl",
    "xl",
    "lg",
    "md",
    "sm",
    "xs",
  ];

  for (const bp of orderedBreakpoints) {
    if (
      breakpoints[bp] <= breakpoints[breakpoint] &&
      values[bp] !== undefined
    ) {
      return values[bp]!;
    }
  }

  return defaultValue;
}

// Hook for responsive value
export function useResponsiveValue<T>(
  values: Partial<Record<Breakpoint, T>>,
  defaultValue: T
): T {
  return responsiveValue(values, defaultValue);
}

// Media query utilities
export function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    const media = window.matchMedia(query);
    setMatches(media.matches);

    const listener = (event: MediaQueryListEvent) => {
      setMatches(event.matches);
    };

    media.addEventListener("change", listener);
    return () => media.removeEventListener("change", listener);
  }, [query]);

  return matches;
}

// Common media query hooks
export function useIsDarkMode() {
  return useMediaQuery("(prefers-color-scheme: dark)");
}

export function useIsReducedMotion() {
  return useMediaQuery("(prefers-reduced-motion: reduce)");
}

export function useIsHighContrast() {
  return useMediaQuery("(prefers-contrast: high)");
}

// Orientation hook
export function useOrientation() {
  const [orientation, setOrientation] = useState<"portrait" | "landscape">(
    "landscape"
  );

  useEffect(() => {
    const updateOrientation = () => {
      setOrientation(
        window.innerHeight > window.innerWidth ? "portrait" : "landscape"
      );
    };

    updateOrientation();
    window.addEventListener("resize", updateOrientation);
    return () => window.removeEventListener("resize", updateOrientation);
  }, []);

  return orientation;
}

// Device detection utilities
export function useDeviceType() {
  const isMobile = useIsMobile();
  const isTablet = useIsTablet();
  const isDesktop = useIsDesktop();

  return {
    isMobile,
    isTablet,
    isDesktop,
    type: isMobile ? "mobile" : isTablet ? "tablet" : "desktop",
  };
}

// Touch device detection
export function useIsTouchDevice() {
  const [isTouchDevice, setIsTouchDevice] = useState(false);

  useEffect(() => {
    const checkTouch = () => {
      setIsTouchDevice(
        "ontouchstart" in window ||
          navigator.maxTouchPoints > 0 ||
          (navigator as any).msMaxTouchPoints > 0
      );
    };

    checkTouch();
  }, []);

  return isTouchDevice;
}

// Responsive grid utilities
export function useGridColumns(
  defaultColumns: number,
  responsiveColumns?: Partial<Record<Breakpoint, number>>
) {
  return useResponsiveValue(responsiveColumns || {}, defaultColumns);
}

// Responsive spacing utilities
export function useResponsiveSpacing(
  defaultSpacing: number,
  responsiveSpacing?: Partial<Record<Breakpoint, number>>
) {
  return useResponsiveValue(responsiveSpacing || {}, defaultSpacing);
}

// Viewport utilities
export function useViewportHeight(unit: "vh" | "px" = "vh") {
  const [height, setHeight] = useState(0);

  useEffect(() => {
    const updateHeight = () => {
      if (unit === "vh") {
        setHeight(window.innerHeight);
      } else {
        setHeight(window.innerHeight);
      }
    };

    updateHeight();
    window.addEventListener("resize", updateHeight);
    return () => window.removeEventListener("resize", updateHeight);
  }, [unit]);

  return height;
}

export function useViewportWidth(unit: "vw" | "px" = "vw") {
  const [width, setWidth] = useState(0);

  useEffect(() => {
    const updateWidth = () => {
      if (unit === "vw") {
        setWidth(window.innerWidth);
      } else {
        setWidth(window.innerWidth);
      }
    };

    updateWidth();
    window.addEventListener("resize", updateWidth);
    return () => window.removeEventListener("resize", updateWidth);
  }, [unit]);

  return width;
}

// Safe area utilities for mobile devices
export function useSafeAreaInsets() {
  const [insets, setInsets] = useState({
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
  });

  useEffect(() => {
    const updateInsets = () => {
      const computedStyle = getComputedStyle(document.documentElement);
      setInsets({
        top:
          parseInt(computedStyle.getPropertyValue("safe-area-inset-top")) || 0,
        right:
          parseInt(computedStyle.getPropertyValue("safe-area-inset-right")) ||
          0,
        bottom:
          parseInt(computedStyle.getPropertyValue("safe-area-inset-bottom")) ||
          0,
        left:
          parseInt(computedStyle.getPropertyValue("safe-area-inset-left")) || 0,
      });
    };

    updateInsets();
    window.addEventListener("resize", updateInsets);
    return () => window.removeEventListener("resize", updateInsets);
  }, []);

  return insets;
}

// Keyboard detection
export function useKeyboard() {
  const [isKeyboardVisible, setIsKeyboardVisible] = useState(false);
  const [keyboardHeight, setKeyboardHeight] = useState(0);

  useEffect(() => {
    const initialViewportHeight =
      window.visualViewport?.height || window.innerHeight;

    const handleVisualViewportChange = () => {
      if (window.visualViewport) {
        const currentHeight = window.visualViewport.height;
        const heightDifference = initialViewportHeight - currentHeight;

        setIsKeyboardVisible(heightDifference > 150); // Threshold for keyboard detection
        setKeyboardHeight(heightDifference);
      }
    };

    if (window.visualViewport) {
      window.visualViewport.addEventListener(
        "resize",
        handleVisualViewportChange
      );
      return () => {
        if (window.visualViewport) {
          window.visualViewport.removeEventListener(
            "resize",
            handleVisualViewportChange
          );
        }
      };
    }
  }, []);

  return { isKeyboardVisible, keyboardHeight };
}
