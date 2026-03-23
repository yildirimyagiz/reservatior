import 'package:flutter/material.dart';

/// Admin Dashboard - Main control panel for administrators
class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildDashboardCard(
            context,
            title: 'Users',
            icon: Icons.people,
            color: Colors.blue,
            value: '1,234',
            onTap: () => _navigateTo(context, '/admin/users'),
          ),
          _buildDashboardCard(
            context,
            title: 'Agencies',
            icon: Icons.business,
            color: Colors.green,
            value: '56',
            onTap: () => _navigateTo(context, '/admin/agencies'),
          ),
          _buildDashboardCard(
            context,
            title: 'Properties',
            icon: Icons.home,
            color: Colors.orange,
            value: '789',
            onTap: () => _navigateTo(context, '/admin/properties'),
          ),
          _buildDashboardCard(
            context,
            title: 'Transactions',
            icon: Icons.attach_money,
            color: Colors.purple,
            value: '\$45K',
            onTap: () => _navigateTo(context, '/admin/transactions'),
          ),
          _buildDashboardCard(
            context,
            title: 'Reports',
            icon: Icons.analytics,
            color: Colors.red,
            value: '12',
            onTap: () => _navigateTo(context, '/admin/reports'),
          ),
          _buildDashboardCard(
            context,
            title: 'Settings',
            icon: Icons.settings,
            color: Colors.teal,
            value: '',
            onTap: () => _navigateTo(context, '/admin/settings'),
          ),
          _buildDashboardCard(
            context,
            title: 'Compliance',
            icon: Icons.verified_user,
            color: Colors.indigo,
            value: '98%',
            onTap: () => _navigateTo(context, '/admin/compliance'),
          ),
          _buildDashboardCard(
            context,
            title: 'Analytics',
            icon: Icons.bar_chart,
            color: Colors.cyan,
            value: '',
            onTap: () => _navigateTo(context, '/admin/analytics'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required String value,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (value.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, String route) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to $route')),
    );
  }
}
