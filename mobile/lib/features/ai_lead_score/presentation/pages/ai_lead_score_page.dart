import 'package:flutter/material.dart';

/// AI Lead Scoring Page - Automatically score and qualify leads
class AILeadScorePage extends StatelessWidget {
  const AILeadScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Lead Scoring'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Score Distribution
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lead Distribution', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildScoreCard(context, 'Hot', '24', Colors.red, '80-100')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildScoreCard(context, 'Warm', '45', Colors.orange, '50-79')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildScoreCard(context, 'Cold', '18', Colors.blue, '0-49')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Recent Leads', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(5, (i) => _buildLeadCard(context, i)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Score Lead'),
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, String label, String count, Color color, String range) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
            Text(range, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadCard(BuildContext context, int index) {
    final scores = [85, 72, 45, 91, 38];
    final colors = [Colors.red, Colors.orange, Colors.blue, Colors.red, Colors.blue];
    final labels = ['Hot', 'Warm', 'Cold', 'Hot', 'Cold'];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index].withOpacity(0.2),
          child: Text('${scores[index]}', style: TextStyle(color: colors[index], fontWeight: FontWeight.bold)),
        ),
        title: Text('Lead ${1000 + index}'),
        subtitle: Text('Contact: John Doe • Budget: \$${(index + 3) * 100}K'),
        trailing: Chip(
          label: Text(labels[index]),
          backgroundColor: colors[index].withOpacity(0.2),
          labelStyle: TextStyle(color: colors[index], fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
