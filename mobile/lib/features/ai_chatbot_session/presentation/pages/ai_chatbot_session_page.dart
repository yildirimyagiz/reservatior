import 'package:flutter/material.dart';

/// AI Chatbot Session Management Page
class AIChatbotSessionPage extends StatelessWidget {
  const AIChatbotSessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Sessions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Row
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    context,
                    label: 'Active',
                    value: '24',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    context,
                    label: 'Waiting',
                    value: '8',
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    context,
                    label: 'Resolved',
                    value: '156',
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildQuickStat(
                    context,
                    label: 'Avg Time',
                    value: '4.2m',
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),

          // Filter Tabs
          DefaultTabController(
            length: 4,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Active'),
                    Tab(text: 'Waiting'),
                    Tab(text: 'Closed'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 280,
                  child: TabBarView(
                    children: [
                      _buildSessionsList(context),
                      _buildSessionsList(context, filter: 'active'),
                      _buildSessionsList(context, filter: 'waiting'),
                      _buildSessionsList(context, filter: 'closed'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildSessionsList(BuildContext context, {String? filter}) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return _buildSessionCard(context, index);
      },
    );
  }

  Widget _buildSessionCard(BuildContext context, int index) {
    final statuses = ['Active', 'Waiting', 'Closed'];
    final colors = [Colors.green, Colors.orange, Colors.grey];
    final status = statuses[index % 3];
    final color = colors[index % 3];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _openSession(context, index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.2),
                    child: Text(
                      'U${index + 1}',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User ${1000 + index}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Session ID: SES-${2024000 + index}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(status),
                    backgroundColor: color.withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.message, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${12 + index} messages',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${index + 3} min ago',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Topic: Property inquiry about downtown apartments',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSession(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Row(
                children: [
                  const CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User ${1000 + index}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Session ID: SES-${2024000 + index}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildChatMessage('Hello! I need help finding a property.', true),
                    _buildChatMessage(
                      'Hi! I\'d be happy to help. What type of property are you looking for?',
                      false,
                    ),
                    _buildChatMessage('Looking for a 2-bedroom apartment downtown.', true),
                    _buildChatMessage(
                      'Great! I found several options. What\'s your budget range?',
                      false,
                    ),
                  ],
                ),
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.transfer_within_a_station),
                      label: const Text('Transfer'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.done),
                      label: const Text('Resolve'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatMessage(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
