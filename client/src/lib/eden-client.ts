import { treaty } from "@elysiajs/eden";
// import type { App } from "../../../server/src/index";

const API_BASE_URL = import.meta.env.VITE_API_URL || "";

// Disable deep recursive Elysia type inference for TS build stability (OOM prevention)
export const edenClient = treaty<any>(API_BASE_URL);

export type EdenClient = typeof edenClient;
