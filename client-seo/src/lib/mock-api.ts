// Mock API handlers for development
import { MOCK_PROPERTIES, MOCK_USERS } from "./mock-data";

// Mock API endpoint handlers
export const mockApiHandlers = {
  "/api/properties": {
    GET: () => ({
      status: 200,
      data: MOCK_PROPERTIES,
    }),
    POST: (data: any) => ({
      status: 201,
      data: { ...data, id: Date.now().toString() },
    }),
  },
  "/api/properties/:id": {
    GET: (id: string) => {
      const property = MOCK_PROPERTIES.find((p) => p.id === id);
      return property
        ? { status: 200, data: property }
        : { status: 404, data: { error: "Property not found" } };
    },
  },
  "/api/users": {
    GET: () => ({
      status: 200,
      data: MOCK_USERS,
    }),
    POST: (data: any) => ({
      status: 201,
      data: { ...data, id: Date.now().toString() },
    }),
  },
  "/api/users/:id": {
    GET: (id: string) => {
      const user = MOCK_USERS.find((u) => u.id === id);
      return user
        ? { status: 200, data: user }
        : { status: 404, data: { error: "User not found" } };
    },
  },
};

// Enhanced fetch with mock API fallback
export const mockFetch = (
  input: RequestInfo | URL,
  init?: RequestInit
): Promise<Response> => {
  const url = typeof input === "string" ? input : input.toString();

  // Check if this is an API call that should be mocked
  for (const [endpoint, handlers] of Object.entries(mockApiHandlers)) {
    const endpointRegex = new RegExp(endpoint.replace(":id", "([^/]+)"));
    const match = url.match(endpointRegex);

    if (match) {
      const method = init?.method || "GET";
      const handler = (handlers as any)[method];

      if (handler) {
        const id = match[1];
        const result = id ? handler(id) : handler();

        return Promise.resolve(
          new Response(JSON.stringify(result.data), {
            status: result.status,
            headers: {
              "Content-Type": "application/json",
            },
          })
        );
      }
    }
  }

  // For non-API calls, use the original fetch
  return fetch(input, init);
};
