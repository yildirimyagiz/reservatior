import 'package:flutter/material.dart';

/// AI Market Analysis Page - Market trends and predictions
class AIMarketAnalysisPage extends StatelessWidget {
  const AIMarketAnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Market Analysis'),
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Market Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trending_up, color: Colors.green),
                      const SizedBox(width: 8),
                      Text('Market Overview', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildMetric(context, 'Avg Price', '\$485K', '+5.2%', true)),
                      Expanded(child: _buildMetric(context, 'Inventory', '2,456', '-3.1%', false)),
                      Expanded(child: _buildMetric(context, 'Days on Market', '28', '-2d', true)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Price Trends Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Trends (Last 12 Months)', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                    child: const Center(child: Text('Chart Placeholder\n📈 Showing upward trend')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // AI Predictions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.purple),
                      const SizedBox(width: 8),
                      Text('AI Predictions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildPrediction('Next Month', '+2.1%', 'Prices expected to rise', Colors.green),
                  _buildPrediction('Next Quarter', '+5.5%', 'Strong market growth', Colors.green),
                  _buildPrediction('Next 6 Months', '+8.2%', 'Sustained upward trend', Colors.green),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Hot Neighborhoods
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hot Neighborhoods', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...['Downtown', 'Riverside', 'Midtown', 'Lakeside'].map((area) => ListTile(
                    dense: true,
                    leading: const Icon(Icons.local_fire_department, color: Colors.orange),
                    title: Text(area),
                    trailing: const Text('+12%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                  )).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(BuildContext context, String label, String value, String change, bool isPositive) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPrediction(String period, String change, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.trending_up, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(period, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(change, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
