import 'package:flutter/material.dart';

/// Agent Team Page - Manage agent teams
class AgentTeamPage extends StatelessWidget {
  const AgentTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Teams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Total Teams',
                  value: '8',
                  icon: Icons.groups,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Total Members',
                  value: '45',
                  icon: Icons.people,
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Teams List
          ...List.generate(
            5,
            (index) => _buildTeamCard(context, index),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.group_add),
        label: const Text('Create Team'),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamCard(BuildContext context, int index) {
    final teamNames = [
      'Sales Team Alpha',
      'Premium Properties',
      'Downtown Division',
      'Luxury Specialists',
      'New Development Team',
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[index % Colors.primaries.length]
              .withOpacity(0.2),
          child: Icon(
            Icons.groups,
            color: Colors.primaries[index % Colors.primaries.length],
          ),
        ),
        title: Text(
          teamNames[index],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${(index + 1) * 3} members • ${(index + 1) * 12} properties'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team Members',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  (index + 1) * 3,
                  (memberIndex) => ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${memberIndex + 1}'),
                    ),
                    title: Text('Agent ${memberIndex + 1}'),
                    subtitle: Text(memberIndex == 0 ? 'Team Leader' : 'Member'),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
