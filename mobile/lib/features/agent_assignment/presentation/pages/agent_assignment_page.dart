import 'package:flutter/material.dart';

/// Agent Assignment Page - Assign agents to properties or clients
class AgentAssignmentPage extends StatelessWidget {
  const AgentAssignmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Assignments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (value) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Active'),
                  selected: false,
                  onSelected: (value) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Pending'),
                  selected: false,
                  onSelected: (value) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Completed'),
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ),
          ),

          // Assignments List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildAssignmentCard(context, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.assignment_ind),
        label: const Text('New Assignment'),
      ),
    );
  }

  Widget _buildAssignmentCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final statuses = ['Active', 'Pending', 'Completed'];
    final colors = [Colors.green, Colors.orange, Colors.blue];
    final status = statuses[index % 3];
    final color = colors[index % 3];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Text(
            'A${index + 1}',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text('Agent ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Property: 123 Main St, Unit ${index + 1}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Assigned: 2 days ago',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        trailing: Chip(
          label: Text(status),
          backgroundColor: color.withOpacity(0.1),
          labelStyle: TextStyle(color: color, fontSize: 11),
          padding: EdgeInsets.zero,
        ),
        onTap: () {},
      ),
    );
  }
}
