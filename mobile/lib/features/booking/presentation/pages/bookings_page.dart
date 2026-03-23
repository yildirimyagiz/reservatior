import 'package:flutter/material.dart';

/// Bookings Page - Manage property bookings and reservations
class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildStatCard('Upcoming', '12', Icons.event_available, Colors.blue),
                _buildStatCard('Active', '8', Icons.check_circle, Colors.green),
                _buildStatCard('Completed', '156', Icons.done_all, Colors.purple),
                _buildStatCard('Cancelled', '3', Icons.cancel, Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Upcoming Bookings
          Text('Upcoming Bookings', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(5, (i) => _buildBookingCard(context, i)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Booking'),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(label, style: const TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, int index) {
    final statuses = ['Confirmed', 'Pending', 'Confirmed', 'Confirmed', 'Pending'];
    final colors = [Colors.green, Colors.orange, Colors.green, Colors.green, Colors.orange];
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.home),
        ),
        title: Text('Property Booking #${1000 + index}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.person, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                const Text('John Doe'),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${index + 2} days from now'),
              ],
            ),
          ],
        ),
        trailing: Chip(
          label: Text(statuses[index]),
          backgroundColor: colors[index].withValues(alpha: 0.2),
          labelStyle: TextStyle(color: colors[index], fontSize: 11, fontWeight: FontWeight.bold),
          padding: EdgeInsets.zero,
        ),
        isThreeLine: true,
      ),
    );
  }
}
