import 'package:flutter/material.dart';

/// AI Fraud Detection Page - Monitor and detect fraudulent activities
class AIFraudDetectionPage extends StatelessWidget {
  const AIFraudDetectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Fraud Detection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Alert Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Active Alerts',
                  value: '12',
                  icon: Icons.warning,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Resolved',
                  value: '45',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  title: 'Total Scans',
                  value: '1.2K',
                  icon: Icons.radar,
                  color: Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Risk Score Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.security, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        'Overall Risk Score',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Low Risk',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: 0.25,
                              backgroundColor: Colors.grey[200],
                              color: Colors.green,
                              minHeight: 10,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Score: 25/100',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.shield,
                          size: 48,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            'Recent Detections',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),

          // Fraud Alerts List
          ...List.generate(
            5,
            (index) => _buildFraudAlert(context, index),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_alert),
        label: const Text('New Scan'),
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
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFraudAlert(BuildContext context, int index) {
    final types = [
      {'type': 'Suspicious Transaction', 'severity': 'High', 'color': Colors.red},
      {'type': 'Unusual Activity', 'severity': 'Medium', 'color': Colors.orange},
      {'type': 'Identity Verification', 'severity': 'Low', 'color': Colors.yellow},
      {'type': 'Document Tampering', 'severity': 'High', 'color': Colors.red},
      {'type': 'Multiple Accounts', 'severity': 'Medium', 'color': Colors.orange},
    ];

    final alert = types[index % types.length];

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (alert['color'] as Color).withOpacity(0.2),
          child: Icon(
            Icons.warning,
            color: alert['color'] as Color,
          ),
        ),
        title: Text(alert['type'] as String),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('User ID: ${1000 + index} • ${_getTimeAgo(index)}'),
            const SizedBox(height: 4),
            Text(
              'AI Confidence: ${85 + index * 2}%',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Chip(
          label: Text(alert['severity'] as String),
          backgroundColor: (alert['color'] as Color).withOpacity(0.2),
          labelStyle: TextStyle(
            color: alert['color'] as Color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          padding: EdgeInsets.zero,
        ),
        onTap: () => _showAlertDetails(context, alert),
      ),
    );
  }

  String _getTimeAgo(int index) {
    if (index == 0) return '5 min ago';
    if (index == 1) return '1 hour ago';
    if (index == 2) return '3 hours ago';
    if (index == 3) return '1 day ago';
    return '2 days ago';
  }

  void _showAlertDetails(BuildContext context, Map<String, dynamic> alert) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning,
                  color: alert['color'] as Color,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alert['type'] as String,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${alert['severity']} Severity',
                        style: TextStyle(
                          color: alert['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'AI Analysis:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Multiple red flags detected including unusual transaction patterns, '
              'mismatched documentation, and suspicious timing. '
              'Recommend immediate review and verification.',
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Dismiss'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Escalating to review team...')),
                      );
                    },
                    child: const Text('Escalate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
