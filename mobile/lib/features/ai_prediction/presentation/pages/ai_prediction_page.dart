import 'package:flutter/material.dart';

/// AI Prediction Page - Predictive analytics and forecasting
class AIPredictionPage extends StatelessWidget {
  const AIPredictionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Predictions'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Prediction Accuracy
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
                      Text('Model Accuracy', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildAccuracyCard(context, 'Price', '92.5%', Colors.green)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildAccuracyCard(context, 'Demand', '87.3%', Colors.blue)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildAccuracyCard(context, 'Trend', '89.1%', Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Recent Predictions
          Text('Recent Predictions', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildPredictionCard(context, 'Property Price Forecast', 'Expected increase of 8.5% in next quarter', Icons.trending_up, Colors.green, '94% confidence'),
          _buildPredictionCard(context, 'Market Demand', 'High demand predicted for downtown area', Icons.location_city, Colors.blue, '89% confidence'),
          _buildPredictionCard(context, 'Best Time to Sell', 'Optimal selling period: April-June 2026', Icons.calendar_today, Colors.orange, '91% confidence'),
          _buildPredictionCard(context, 'Rental Yield', 'Projected yield: 6.2% annually', Icons.attach_money, Colors.purple, '87% confidence'),
        ],
      ),
    );
  }

  Widget _buildAccuracyCard(BuildContext context, String label, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionCard(BuildContext context, String title, String description, IconData icon, Color color, String confidence) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 4),
            Text(confidence, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
