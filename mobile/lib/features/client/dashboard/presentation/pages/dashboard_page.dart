import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dashboard Page - Analytics and overview
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mobile.auto.feature_dashboard_title'.tr()),
        actions: [
          IconButton(icon: Icon(Icons.date_range), onPressed: () {}),
          IconButton(icon: Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
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
              _buildKPICard(
                context,
                'Revenue',
                '\$245K',
                '+12.5%',
                Icons.attach_money,
                Colors.green,
              ),
              _buildKPICard(
                context,
                'Properties',
                '156',
                '+8',
                Icons.home,
                Colors.blue,
              ),
              _buildKPICard(
                context,
                'Clients',
                '1,234',
                '+45',
                Icons.people,
                Colors.purple,
              ),
              _buildKPICard(
                context,
                'Deals',
                '24',
                '+3',
                Icons.handshake,
                Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 24),

          // Charts
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.revenue_trend'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    color: Colors.grey[100],
                    child: Center(
                      child: Text('mobile.auto.chart_revenue_over_time'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),

          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.top_performing_properties'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  ...List.generate(
                    3,
                    (i) => ListTile(
                      dense: true,
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text('Property ${i + 1}'),
                      trailing: Text(
                        '\$${(i + 4) * 100}K',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard(
    BuildContext context,
    String title,
    String value,
    String change,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    change,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
