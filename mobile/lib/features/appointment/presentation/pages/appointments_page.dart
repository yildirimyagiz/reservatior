import 'package:flutter/material.dart';

/// Appointments Page - Manage property viewings and meetings
class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_view_month), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today's Appointments
          Row(
            children: [
              Text('Today', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              Chip(label: Text('${3} appointments')),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(3, (i) => _buildAppointmentCard(context, i, true)),
          const SizedBox(height: 24),
          
          // Upcoming
          Text('Upcoming', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...List.generate(4, (i) => _buildAppointmentCard(context, i, false)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Schedule'),
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, int index, bool isToday) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isToday ? Colors.blue : Colors.grey[300],
          child: Text('${isToday ? index + 10 : index + 14}', style: TextStyle(color: isToday ? Colors.white : Colors.black)),
        ),
        title: Text('Property Viewing'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: John Doe'),
            Text('${isToday ? 'Today' : 'Tomorrow'} at ${index + 10}:00 AM', style: TextStyle(fontSize: 11)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
            Text('123 St', style: TextStyle(fontSize: 10)),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
