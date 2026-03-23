import 'package:flutter/material.dart';

/// AI Investment Analysis Page - Investment opportunities and ROI predictions
class AIInvestmentAnalysisPage extends StatelessWidget {
  const AIInvestmentAnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Investment Analysis'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ROI Overview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Investment Potential', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildROICard(context, 'Est. ROI', '12.5%', Colors.green)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildROICard(context, 'Payback', '6.2 yrs', Colors.blue)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildROICard(context, 'Risk', 'Medium', Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Top Opportunities
          Text('Top Investment Opportunities', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(3, (i) => _buildOpportunityCard(context, i)),
        ],
      ),
    );
  }

  Widget _buildROICard(BuildContext context, String label, String value, Color color) {
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

  Widget _buildOpportunityCard(BuildContext context, int index) {
    final rois = ['14.2%', '11.8%', '10.5%'];
    final prices = ['\$450K', '\$380K', '\$525K'];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.withOpacity(0.2),
          child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Text('Property ${index + 1}'),
        subtitle: Text('Price: ${prices[index]} • Location: Downtown'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('ROI', style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            Text(rois[index], style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
