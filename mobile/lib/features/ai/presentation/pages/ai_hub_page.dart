import 'package:flutter/material.dart';

/// AI Hub - Central dashboard for all AI features
class AIHubPage extends StatelessWidget {
  const AIHubPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // AI Chat Section
          _buildSectionHeader(context, 'AI Chat & Communication'),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'AI Chatbot',
            description: 'Intelligent conversation assistant',
            icon: Icons.chat_bubble,
            gradient: const LinearGradient(
              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            ),
            onTap: () => _navigateTo(context, '/ai/chat'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Chat Handoff',
            description: 'Transfer chats to human agents',
            icon: Icons.transfer_within_a_station,
            gradient: const LinearGradient(
              colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
            ),
            onTap: () => _navigateTo(context, '/ai/chat-handoff'),
          ),

          const SizedBox(height: 24),

          // AI Analysis Section
          _buildSectionHeader(context, 'AI Analysis & Intelligence'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildCompactFeatureCard(
                  context,
                  title: 'Property Valuation',
                  icon: Icons.calculate,
                  color: Colors.blue,
                  onTap: () => _navigateTo(context, '/ai/valuation'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCompactFeatureCard(
                  context,
                  title: 'Market Analysis',
                  icon: Icons.analytics,
                  color: Colors.green,
                  onTap: () => _navigateTo(context, '/ai/market'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildCompactFeatureCard(
                  context,
                  title: 'Lead Scoring',
                  icon: Icons.score,
                  color: Colors.orange,
                  onTap: () => _navigateTo(context, '/ai/lead-scoring'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildCompactFeatureCard(
                  context,
                  title: 'Fraud Detection',
                  icon: Icons.security,
                  color: Colors.red,
                  onTap: () => _navigateTo(context, '/ai/fraud'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // AI Content Generation
          _buildSectionHeader(context, 'AI Content & Automation'),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Property Descriptions',
            description: 'Auto-generate compelling descriptions',
            icon: Icons.description,
            gradient: const LinearGradient(
              colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
            ),
            onTap: () => _navigateTo(context, '/ai/descriptions'),
          ),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Image Analysis',
            description: 'Analyze property images with AI',
            icon: Icons.image_search,
            gradient: const LinearGradient(
              colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
            ),
            onTap: () => _navigateTo(context, '/ai/image-analysis'),
          ),

          const SizedBox(height: 24),

          // AI Recommendations
          _buildSectionHeader(context, 'Smart Recommendations'),
          const SizedBox(height: 12),
          _buildFeatureCard(
            context,
            title: 'Property Recommendations',
            description: 'AI-powered property matching',
            icon: Icons.recommend,
            gradient: const LinearGradient(
              colors: [Color(0xFFfa709a), Color(0xFFfee140)],
            ),
            onTap: () => _navigateTo(context, '/ai/recommendations'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening $route')),
    );
  }
}
