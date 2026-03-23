import 'package:flutter/material.dart';

/// AI Model Management Page - Manage and monitor AI models
class AIModelPage extends StatelessWidget {
  const AIModelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Models'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Model Stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Active Models', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildStat(context, 'Total', '8')),
                      Expanded(child: _buildStat(context, 'Active', '7')),
                      Expanded(child: _buildStat(context, 'Training', '1')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Models', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...['Property Valuation', 'Lead Scoring', 'Market Prediction', 'Image Analysis', 'Fraud Detection'].map((name) => 
            _buildModelCard(context, name)
          ).toList(),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildModelCard(BuildContext context, String name) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.model_training)),
        title: Text(name),
        subtitle: const Text('Accuracy: 94.5% • Last updated: 2 days ago'),
        trailing: Chip(
          label: const Text('Active'),
          backgroundColor: Colors.green.withOpacity(0.2),
          labelStyle: const TextStyle(color: Colors.green, fontSize: 11),
        ),
      ),
    );
  }
}
