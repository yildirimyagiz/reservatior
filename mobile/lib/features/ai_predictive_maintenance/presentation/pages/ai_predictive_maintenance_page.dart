import 'package:flutter/material.dart';

/// AI Predictive Maintenance Page - Predict maintenance needs
class AIPredictiveMaintenancePage extends StatelessWidget {
  const AIPredictiveMaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predictive Maintenance')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Risk Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Maintenance Risk Assessment', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildRiskCard('High Risk', '3', Colors.red)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildRiskCard('Medium Risk', '8', Colors.orange)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildRiskCard('Low Risk', '45', Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          Text('Predicted Issues', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildIssueCard(context, 'HVAC System', 'Requires service in 2 weeks', 'High', Colors.red, '91%'),
          _buildIssueCard(context, 'Plumbing', 'Check water pressure', 'Medium', Colors.orange, '78%'),
          _buildIssueCard(context, 'Electrical', 'Routine inspection due', 'Low', Colors.green, '65%'),
        ],
      ),
    );
  }

  Widget _buildRiskCard(String label, String count, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(BuildContext context, String system, String issue, String priority, Color color, String confidence) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(Icons.build, color: color)),
        title: Text(system),
        subtitle: Text('$issue\nConfidence: $confidence'),
        trailing: Chip(label: Text(priority), backgroundColor: color.withOpacity(0.2), labelStyle: TextStyle(color: color, fontSize: 11)),
        isThreeLine: true,
      ),
    );
  }
}
