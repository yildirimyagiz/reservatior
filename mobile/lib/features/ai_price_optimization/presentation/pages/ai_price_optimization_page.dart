import 'package:flutter/material.dart';

/// AI Price Optimization Page - Optimize property pricing
class AIPriceOptimizationPage extends StatelessWidget {
  const AIPriceOptimizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Optimization')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Current vs Optimal
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Analysis', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('Current Price', style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 8),
                            Text('\$450,000', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward, size: 32),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Optimal Price', style: Theme.of(context).textTheme.bodySmall),
                            const SizedBox(height: 8),
                            Text('\$485,000', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Icon(Icons.trending_up, color: Colors.green),
                        const SizedBox(width: 8),
                        Text('Potential increase: +\$35,000 (+7.8%)', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Factors
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Key Factors', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildFactor('Market Demand', 0.85, Colors.green),
                  _buildFactor('Location Premium', 0.72, Colors.blue),
                  _buildFactor('Property Condition', 0.90, Colors.purple),
                  _buildFactor('Comparable Sales', 0.68, Colors.orange),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFactor(String label, double score, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('${(score * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: score, backgroundColor: Colors.grey[200], color: color, minHeight: 6, borderRadius: BorderRadius.circular(3)),
        ],
      ),
    );
  }
}
