import 'package:flutter/material.dart';

class ListingsDashboard extends StatelessWidget {
  const ListingsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing OS Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new listing flow
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStatCards(),
          const SizedBox(height: 24),
          const Text('Active Listings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildListingCard(context, 'Luxury Villa', 'Dubai', 'Available', '\$2000/mo'),
          _buildListingCard(context, 'Modern Apartment', 'New York', 'Rented', '\$4500/mo'),
        ],
      ),
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('Active', '12', Colors.green)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Pending', '3', Colors.orange)),
        const SizedBox(width: 16),
        Expanded(child: _buildStatCard('Total Views', '4.2K', Colors.blue)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, String title, String location, String status, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.home, color: Colors.grey),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$location • $price'),
        trailing: Chip(
          label: Text(status, style: const TextStyle(fontSize: 12)),
          backgroundColor: status == 'Available' ? Colors.green[100] : Colors.grey[200],
        ),
        onTap: () {
          // Navigate to details
        },
      ),
    );
  }
}
