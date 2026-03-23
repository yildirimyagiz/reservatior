import 'package:flutter/material.dart';

/// Advanced Features Page - Access to advanced functionality
class AdvancedFeaturesPage extends StatelessWidget {
  const AdvancedFeaturesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Features'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCategory(
            context,
            title: 'AI & Automation',
            icon: Icons.psychology,
            color: Colors.purple,
            features: [
              _FeatureItem('AI Property Valuation', Icons.calculate),
              _FeatureItem('Auto Lead Scoring', Icons.score),
              _FeatureItem('Predictive Analytics', Icons.trending_up),
              _FeatureItem('Smart Recommendations', Icons.recommend),
            ],
          ),
          _buildFeatureCategory(
            context,
            title: 'Integration & API',
            icon: Icons.api,
            color: Colors.blue,
            features: [
              _FeatureItem('API Management', Icons.settings_ethernet),
              _FeatureItem('Webhooks', Icons.webhook),
              _FeatureItem('External Integrations', Icons.extension),
              _FeatureItem('Custom Scripts', Icons.code),
            ],
          ),
          _buildFeatureCategory(
            context,
            title: 'Data & Analytics',
            icon: Icons.analytics,
            color: Colors.green,
            features: [
              _FeatureItem('Advanced Reports', Icons.assessment),
              _FeatureItem('Data Export', Icons.download),
              _FeatureItem('Custom Dashboards', Icons.dashboard_customize),
              _FeatureItem('Market Analysis', Icons.show_chart),
            ],
          ),
          _buildFeatureCategory(
            context,
            title: 'Security & Compliance',
            icon: Icons.security,
            color: Colors.red,
            features: [
              _FeatureItem('Audit Logs', Icons.history),
              _FeatureItem('Compliance Reports', Icons.verified_user),
              _FeatureItem('Data Encryption', Icons.lock),
              _FeatureItem('Access Control', Icons.admin_panel_settings),
            ],
          ),
          _buildFeatureCategory(
            context,
            title: 'Performance & Optimization',
            icon: Icons.speed,
            color: Colors.orange,
            features: [
              _FeatureItem('Cache Management', Icons.cached),
              _FeatureItem('Database Optimization', Icons.storage),
              _FeatureItem('Performance Metrics', Icons.monitor),
              _FeatureItem('System Health', Icons.health_and_safety),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCategory(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<_FeatureItem> features,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: features
            .map((feature) => ListTile(
                  leading: Icon(feature.icon, size: 20),
                  title: Text(feature.title),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening ${feature.title}')),
                    );
                  },
                ))
            .toList(),
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final IconData icon;

  _FeatureItem(this.title, this.icon);
}
