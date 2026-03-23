// API Endpoints configuration for Elysia Server Integration
class ApiEndpoints {
  // Base URL - Development
  static const String _baseUrl = 'http://localhost:3000';
  
  // Base URL - Production (uncomment for production)
  // static const String _baseUrl = 'https://api.estateai.app';
  
  // Health check (public endpoint - no auth required)
  static const String health = '$_baseUrl/health';
  
  // Auth endpoints
  static const String auth = '/auth';
  static const String register = '$_baseUrl/api/v1/auth/register';
  static const String login = '$_baseUrl/api/v1/auth/login';
  static const String refresh = '$_baseUrl/api/v1/auth/refresh';
  static const String logout = '$_baseUrl/api/v1/auth/logout';
  static const String me = '$_baseUrl/api/v1/auth/me';
  static const String sessions = '$_baseUrl/api/v1/auth/sessions';
  static const String apiKeys = '$_baseUrl/api/v1/auth/api-keys';
  
  // Core Business endpoints
  static const String organizations = '$_baseUrl/api/v1/organizations';
  static const String users = '$_baseUrl/api/v1/users';
  static const String contacts = '$_baseUrl/api/v1/contacts';
  static const String leads = '$_baseUrl/api/v1/leads';
  static const String deals = '$_baseUrl/api/v1/deals';
  static const String commissions = '$_baseUrl/api/v1/commissions';
  
  // Property endpoints
  static const String properties = '$_baseUrl/api/v1/properties';
  static const String listings = '$_baseUrl/api/v1/listings';
  static const String bookings = '$_baseUrl/api/v1/bookings';
  static const String leases = '$_baseUrl/api/v1/leases';
  static const String reservations = '$_baseUrl/api/v1/reservations';
  static const String contracts = '$_baseUrl/api/v1/contracts';
  
  // Agent & Agency endpoints
  static const String agencies = '$_baseUrl/api/v1/agencies';
  static const String agents = '$_baseUrl/api/v1/agents';
  static const String agentAssignments = '$_baseUrl/api/v1/Agent-assignments';
  static const String agentPerformance = '$_baseUrl/api/v1/Agent-performance';
  static const String agentTeams = '$_baseUrl/api/v1/Agent-teams';
  static const String agentTeamMembers = '$_baseUrl/api/v1/Agent-team-members';
  
  // Financial endpoints
  static const String financials = '$_baseUrl/api/v1/financials';
  static const String payments = '$_baseUrl/api/v1/payments';
  static const String escrow = '$_baseUrl/api/v1/escrow';
  static const String mortgages = '$_baseUrl/api/v1/mortgages';
  static const String quotes = '$_baseUrl/api/v1/quotes';
  static const String pricingRules = '$_baseUrl/api/v1/pricing-rules';
  static const String currencies = '$_baseUrl/api/v1/currencies';
  static const String exchangeRates = '$_baseUrl/api/v1/exchange-rates';
  
  // Management endpoints
  static const String tasks = '$_baseUrl/api/v1/tasks';
  static const String appointments = '$_baseUrl/api/v1/appointments';
  static const String maintenance = '$_baseUrl/api/v1/maintenance';
  static const String documents = '$_baseUrl/api/v1/documents';
  static const String notifications = '$_baseUrl/api/v1/notifications';
  static const String reports = '$_baseUrl/api/v1/reports';
  static const String webhooks = '$_baseUrl/api/v1/webhooks';
  static const String audit = '$_baseUrl/api/v1/audit';
  
  // AI & Analytics endpoints
  static const String ai = '$_baseUrl/api/v1/ai';
  static const String aiModels = '$_baseUrl/api/v1/ai-models';
  static const String aiPredictions = '$_baseUrl/api/v1/ai-predictions';
  static const String analytics = '$_baseUrl/api/v1/analytics';
  static const String mls = '$_baseUrl/api/v1/mls';
  
  // AI Chat & Service endpoints
  static const String aiChatSessions = '$_baseUrl/api/v1/ai/sessions';
  static String aiChatSessionById(String id) => '$_baseUrl/api/v1/ai/sessions/$id';
  static String aiChatMessages(String sessionId) => '$_baseUrl/api/v1/ai/sessions/$sessionId/messages';
  static const String aiValuations = '$_baseUrl/api/v1/ai/valuations';
  static const String aiPriceOptimizations = '$_baseUrl/api/v1/ai/price-optimizations';
  static const String aiLeadScores = '$_baseUrl/api/v1/ai/Lead-scores';
  static const String aiMarketAnalyses = '$_baseUrl/api/v1/ai/market-analyses';
  static const String aiFraudDetections = '$_baseUrl/api/v1/ai/fraud-detections';
  static const String aiRecommendations = '$_baseUrl/api/v1/ai/recommendations';
  static const String aiDashboard = '$_baseUrl/api/v1/ai/dashboard';
  static const String aiDashboardModels = '$_baseUrl/api/v1/ai/dashboard/models';
  static const String aiDashboardAnalytics = '$_baseUrl/api/v1/ai/dashboard/Analytics';
  
  // AI Extended endpoints
  static const String aiExtended = '$_baseUrl/api/v1/ai-extended';
  static const String aiExtModels = '$_baseUrl/api/v1/ai-extended/models';
  static String aiExtModelById(String id) => '$_baseUrl/api/v1/ai-extended/models/$id';
  static const String aiExtDeployments = '$_baseUrl/api/v1/ai-extended/deployments';
  static String aiExtDeploymentById(String id) => '$_baseUrl/api/v1/ai-extended/deployments/$id';
  static const String aiExtPropDescriptions = '$_baseUrl/api/v1/ai-extended/Property-descriptions';
  static const String projectsExtended = '$_baseUrl/api/v1/projects-extended';
  static const String systemExtended = '$_baseUrl/api/v1/system-extended';
  static const String legalExtended = '$_baseUrl/api/v1/legal-extended';
  static const String remaining = '$_baseUrl/api/v1/remaining';
  
  // Utility endpoints
  static const String mobileDevices = '$_baseUrl/api/v1/mobile-devices';
  static const String keyManagement = '$_baseUrl/api/v1/key-management';
  static const String propertyInventory = '$_baseUrl/api/v1/Property-inventory';
  static const String propertyMedia = '$_baseUrl/api/v1/Property-media';
  static const String crmExtended = '$_baseUrl/api/v1/crm-extended';
}

// Endpoint paths for dynamic construction
class EndpointPaths {
  static const String auth = '/auth';
  static const String organizations = '/organizations';
  static const String users = '/users';
  static const String properties = '/properties';
  static const String listings = '/listings';
  static const String contacts = '/contacts';
  static const String leads = '/leads';
  static const String bookings = '/bookings';
  static const String leases = '/leases';
  static const String appointments = '/appointments';
  static const String tasks = '/tasks';
  static const String maintenance = '/maintenance';
  static const String documents = '/documents';
  static const String financials = '/financials';
  static const String notifications = '/notifications';
  static const String reports = '/reports';
  static const String webhooks = '/webhooks';
  static const String audit = '/audit';
  static const String reservations = '/reservations';
  static const String deals = '/deals';
  static const String commissions = '/commissions';
  static const String escrow = '/escrow';
  static const String ai = '/ai';
  static const String mls = '/mls';
  static const String agencies = '/agencies';
  static const String agents = '/agents';
  static const String payments = '/payments';
  static const String mortgages = '/mortgages';
  static const String quotes = '/quotes';
  static const String contracts = '/contracts';
  static const String marketing = '/marketing';
  static const String integrations = '/integrations';
  static const String admin = '/admin';
  static const String system = '/system';
  static const String video = '/video';
  static const String tags = '/tags';
  static const String subscriptions = '/subscriptions';
  static const String templates = '/templates';
  static const String analytics = '/analytics';
  static const String mobileDevices = '/mobile-devices';
  static const String apiKeys = '/api-keys';
  static const String salesProcess = '/sales-process';
  static const String propertyManagement = '/Property-management';
  static const String hoa = '/hoa';
  static const String legalCompliance = '/legal-compliance';
  static const String cx = '/cx';
  static const String turkey = '/turkey';
  static const String banking = '/banking';
  static const String str = '/str';
  static const String marketAnalysis = '/market-analysis';
  static const String socialImpact = '/social-impact';
  static const String agencyRoutes = '/agencies';
  static const String includedServices = '/included-services';
  static const String extraCharges = '/extra-charges';
  static const String tenants = '/tenants';
  static const String pricingRules = '/pricing-rules';
  static const String reservationRoutes = '/reservations';
  static const String calendar = '/calendar';
  static const String messages = '/messages';
  static const String locations = '/locations';
  static const String projects = '/projects';
  static const String events = '/events';
  static const String social = '/social';
  static const String achievements = '/achievements';
  static const String propertyMedia = '/Property-media';
  static const String crmExtended = '/crm-extended';
  static const String communications = '/communications';
  static const String financeExtended = '/finance-extended';
  static const String authExtended = '/auth-extended';
  static const String listingsExtended = '/listings-extended';
  static const String aiExtended = '/ai-extended';
  static const String projectsExtended = '/projects-extended';
  static const String systemExtended = '/system-extended';
  static const String legalExtended = '/legal-extended';
  static const String remaining = '/remaining';
  static const String keyManagement = '/key-management';
  static const String propertyInventory = '/Property-inventory';
}
