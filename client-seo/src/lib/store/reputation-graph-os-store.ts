import { create } from 'zustand';
import { ReputationNode, ReputationEdge, ReputationPath, Community } from '../api/reputation-graph-os';

interface ReputationGraphOSState {
  nodes: ReputationNode[];
  edges: ReputationEdge[];
  paths: ReputationPath[];
  communities: Community[];
  loading: boolean;
  error: string | null;
  buildGraph: (entityId: string) => Promise<void>;
  calculateInfluence: (entityId: string) => Promise<void>;
  calculateReputation: (entityId: string) => Promise<void>;
  findPath: (fromId: string, toId: string) => Promise<void>;
  detectCommunities: (orgId?: string) => Promise<void>;
}

export const useReputationGraphOSStore = create<ReputationGraphOSState>((set) => ({
  nodes: [],
  edges: [],
  paths: [],
  communities: [],
  loading: false,
  error: null,

  buildGraph: async (entityId: string) => {
    set({ loading: true, error: null });
    try {
      const { reputationGraphOSApi } = await import('../api/reputation-graph-os');
      const { nodes, edges } = await reputationGraphOSApi.buildGraph(entityId);
      set({ nodes, edges, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateInfluence: async (entityId: string) => {
    set({ loading: true, error: null });
    try {
      const { reputationGraphOSApi } = await import('../api/reputation-graph-os');
      await reputationGraphOSApi.calculateInfluence(entityId);
      set({ loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  calculateReputation: async (entityId: string) => {
    set({ loading: true, error: null });
    try {
      const { reputationGraphOSApi } = await import('../api/reputation-graph-os');
      await reputationGraphOSApi.calculateReputation(entityId);
      set({ loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  findPath: async (fromId: string, toId: string) => {
    set({ loading: true, error: null });
    try {
      const { reputationGraphOSApi } = await import('../api/reputation-graph-os');
      const path = await reputationGraphOSApi.findPath(fromId, toId);
      set(state => ({ paths: [...state.paths, path], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  detectCommunities: async (orgId?: string) => {
    set({ loading: true, error: null });
    try {
      const { reputationGraphOSApi } = await import('../api/reputation-graph-os');
      const communities = await reputationGraphOSApi.detectCommunities(orgId);
      set({ communities, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
