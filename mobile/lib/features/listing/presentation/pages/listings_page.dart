import 'package:flutter/material.dart';

/// Listings Page - Manage property listings
class ListingsPage extends StatelessWidget {
  const ListingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Listings'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () {})],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats
          Row(
            children: [
              Expanded(child: _buildStatCard(context, 'Active', '24', Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, 'Pending', '8', Colors.orange)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard(context, 'Sold', '156', Colors.blue)),
            ],
          ),
          const SizedBox(height: 24),
          Text('Recent Listings', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(5, (i) => _buildListingCard(context, i)),
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
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.home)),
        title: Text('Property Listing ${index + 1}'),
        subtitle: Text('\$${(index + 3) * 100}K • 3 bed, 2 bath'),
        trailing: Chip(
          label: Text(['Active', 'Pending', 'Sold'][index % 3]),
          backgroundColor: [Colors.green, Colors.orange, Colors.blue][index % 3].withOpacity(0.2),
        ),
      ),
    );
  }
}
