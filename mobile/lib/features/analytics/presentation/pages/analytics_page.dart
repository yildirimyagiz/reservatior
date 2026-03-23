import 'package:flutter/material.dart';

/// Analytics Page - Detailed analytics and reports
class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Time Range Selector
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ChoiceChip(label: const Text('Today'), selected: false, onSelected: (_) {}),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Week'), selected: false, onSelected: (_) {}),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Month'), selected: true, onSelected: (_) {}),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Year'), selected: false, onSelected: (_) {}),
                const SizedBox(width: 8),
                ChoiceChip(label: const Text('Custom'), selected: false, onSelected: (_) {}),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Performance Metrics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Performance Metrics', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildMetric('Conversion Rate', '24.5%', 0.75, Colors.green),
                  _buildMetric('Avg Response Time', '2.3 hrs', 0.85, Colors.blue),
                  _buildMetric('Customer Satisfaction', '4.8/5.0', 0.96, Colors.purple),
                  _buildMetric('Deal Success Rate', '68%', 0.68, Colors.orange),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Traffic Sources
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Traffic Sources', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildTrafficSource('Direct', '45%', Colors.blue),
                  _buildTrafficSource('Social Media', '30%', Colors.purple),
                  _buildTrafficSource('Search Engines', '20%', Colors.green),
                  _buildTrafficSource('Referrals', '5%', Colors.orange),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Activity Chart
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Activity Overview', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(height: 200, color: Colors.grey[100], child: const Center(child: Text('Chart: Activity heatmap 📊'))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.grey[200], color: color, minHeight: 6, borderRadius: BorderRadius.circular(3)),
        ],
      ),
    );
  }

  Widget _buildTrafficSource(String source, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(child: Text(source)),
          Text(percentage, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
