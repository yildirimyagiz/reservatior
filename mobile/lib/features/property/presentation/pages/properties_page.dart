import 'package:flutter/material.dart';

/// Properties Page - Browse and manage properties
class PropertiesPage extends StatelessWidget {
  const PropertiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                FilterChip(label: const Text('All'), selected: true, onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text('For Sale'), selected: false, onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text('For Rent'), selected: false, onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text('Featured'), selected: false, onSelected: (_) {}),
              ],
            ),
          ),
          // Properties Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => _buildPropertyCard(context, index),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Property'),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(height: 120, color: Colors.grey[300], child: const Center(child: Icon(Icons.home, size: 40))),
              Positioned(top: 8, right: 8, child: CircleAvatar(radius: 16, backgroundColor: Colors.white, child: Icon(Icons.favorite_border, size: 16, color: Colors.red))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Modern ${index % 2 == 0 ? 'Apartment' : 'House'}', style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1),
                Text('\$${(index + 3) * 100}K', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(children: [Icon(Icons.bed, size: 12), Text(' ${index + 2}'), SizedBox(width: 8), Icon(Icons.bathtub, size: 12), Text(' ${index + 1}')]),
                const SizedBox(height: 4),
                Row(children: [Icon(Icons.location_on, size: 12), Expanded(child: Text(' Downtown', style: TextStyle(fontSize: 11), maxLines: 1))]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
