import 'package:flutter/material.dart';

/// Dashboard Page - Analytics and overview
class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.date_range), onPressed: () {}),
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // KPI Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              _buildKPICard(context, 'Revenue', '\$245K', '+12.5%', Icons.attach_money, Colors.green),
              _buildKPICard(context, 'Properties', '156', '+8', Icons.home, Colors.blue),
              _buildKPICard(context, 'Clients', '1,234', '+45', Icons.people, Colors.purple),
              _buildKPICard(context, 'Deals', '24', '+3', Icons.handshake, Colors.orange),
            ],
          ),
          const SizedBox(height: 24),
          
          // Charts
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Revenue Trend', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(height: 200, color: Colors.grey[100], child: const Center(child: Text('Chart: Revenue over time 📈'))),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top Performing Properties', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...List.generate(3, (i) => ListTile(
                    dense: true,
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text('Property ${i + 1}'),
                    trailing: Text('\$${(i + 4) * 100}K', style: const TextStyle(fontWeight: FontWeight.bold)),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(BuildContext context, String title, String value, String change, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                  child: Text(change, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Spacer(),
            Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
