import { create } from 'zustand';
import { AIAgent, AgentTask, AgentRole, AgentStatus, TaskPriority, TaskStatus } from '../api/ai-agent-os';

interface AIAgentOSState {
  agents: AIAgent[];
  tasks: AgentTask[];
  loading: boolean;
  error: string | null;
  createAgent: (data: Omit<AIAgent, 'id' | 'lastActive'>) => Promise<void>;
  getAgent: (agentId: string) => Promise<void>;
  getAvailableAgents: (role: AgentRole) => Promise<void>;
  assignTask: (data: Omit<AgentTask, 'id' | 'status' | 'startedAt' | 'completedAt' | 'actualDuration'>) => Promise<void>;
  getAgentPerformance: (agentId: string) => Promise<void>;
  scaleAgents: (role: AgentRole, targetCount: number) => Promise<void>;
}

export const useAIAgentOSStore = create<AIAgentOSState>((set) => ({
  agents: [],
  tasks: [],
  loading: false,
  error: null,

  createAgent: async (data) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      const agent = await aiAgentOSApi.createAgent(data);
      set(state => ({ agents: [...state.agents, agent], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getAgent: async (agentId: string) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      const agent = await aiAgentOSApi.getAgent(agentId);
      set(state => ({
        agents: state.agents.map(a => a.id === agentId ? agent : a),
        loading: false,
      }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getAvailableAgents: async (role: AgentRole) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      const agents = await aiAgentOSApi.getAvailableAgents(role);
      set({ agents, loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  assignTask: async (data) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      const task = await aiAgentOSApi.assignTask(data);
      set(state => ({ tasks: [...state.tasks, task], loading: false }));
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  getAgentPerformance: async (agentId: string) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      await aiAgentOSApi.getAgentPerformance(agentId);
      set({ loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },

  scaleAgents: async (role: AgentRole, targetCount: number) => {
    set({ loading: true, error: null });
    try {
      const { aiAgentOSApi } = await import('../api/ai-agent-os');
      await aiAgentOSApi.scaleAgents(role, targetCount);
      set({ loading: false });
    } catch (error: any) {
      set({ error: error.message, loading: false });
    }
  },
}));
