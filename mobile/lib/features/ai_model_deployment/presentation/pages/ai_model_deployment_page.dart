import 'package:flutter/material.dart';

/// AI Model Deployment Page - Deploy and manage AI models
class AIModelDeploymentPage extends StatelessWidget {
  const AIModelDeploymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Deployment'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Deployment Stats
          Row(
            children: [
              Expanded(child: _buildStatCard(context, 'Deployed', '12', Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, 'Staging', '3', Colors.orange)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, 'Failed', '1', Colors.red)),
            ],
          ),
          const SizedBox(height: 24),
          
          Text('Active Deployments', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(4, (i) => _buildDeploymentCard(context, i)),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildDeploymentCard(BuildContext context, int index) {
    final models = ['Property Valuation v2.1', 'Lead Scoring v1.5', 'Market Predictor v3.0', 'Fraud Detection v2.0'];
    final statuses = ['Running', 'Running', 'Updating', 'Running'];
    final colors = [Colors.green, Colors.green, Colors.orange, Colors.green];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index].withOpacity(0.2),
          child: Icon(Icons.smart_toy, color: colors[index]),
        ),
        title: Text(models[index]),
        subtitle: Text('Deployed ${index + 2} days ago • ${100 - index * 5} requests/min'),
        trailing: Chip(
          label: Text(statuses[index]),
          backgroundColor: colors[index].withOpacity(0.2),
          labelStyle: TextStyle(color: colors[index], fontSize: 11),
        ),
      ),
    );
  }
}
