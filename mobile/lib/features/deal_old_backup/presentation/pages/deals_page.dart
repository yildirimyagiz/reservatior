import 'package:flutter/material.dart';

/// Deals Page - Manage property deals and transactions
class DealsPage extends StatelessWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deals'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          IconButton(icon: const Icon(Icons.analytics), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Pipeline Stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deal Pipeline', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildPipelineStage(context, 'Prospecting', '12', Colors.blue)),
                      Expanded(child: _buildPipelineStage(context, 'Negotiation', '8', Colors.orange)),
                      Expanded(child: _buildPipelineStage(context, 'Closing', '5', Colors.green)),
                      Expanded(child: _buildPipelineStage(context, 'Won', '24', Colors.purple)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Revenue Stats
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Total Value', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text('\$2.4M', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Commission', style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text('\$72K', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Active Deals
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Deals', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(5, (i) => _buildDealCard(context, i)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Deal'),
      ),
    );
  }

  Widget _buildPipelineStage(BuildContext context, String label, String count, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildDealCard(BuildContext context, int index) {
    final stages = ['Prospecting', 'Negotiation', 'Closing', 'Negotiation', 'Closing'];
    final colors = [Colors.blue, Colors.orange, Colors.green, Colors.orange, Colors.green];
    final values = ['\$450K', '\$380K', '\$525K', '\$420K', '\$495K'];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colors[index].withOpacity(0.2),
          child: Icon(Icons.handshake, color: colors[index]),
        ),
        title: Text('Property Deal ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Client: John Doe • Value: ${values[index]}'),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: (index + 1) * 0.2,
              backgroundColor: Colors.grey[200],
              color: colors[index],
              minHeight: 4,
            ),
          ],
        ),
        trailing: Chip(
          label: Text(stages[index]),
          backgroundColor: colors[index].withOpacity(0.2),
          labelStyle: TextStyle(color: colors[index], fontSize: 11),
          padding: EdgeInsets.zero,
        ),
        isThreeLine: true,
      ),
    );
  }
}
