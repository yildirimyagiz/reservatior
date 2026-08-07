import 'package:flutter/material.dart';

class SagaTimelineViewer extends StatelessWidget {
  final String workflowId;

  const SagaTimelineViewer({
    super.key,
    required this.workflowId,
  });

  @override
  Widget build(BuildContext context) {
    // Mock saga steps
    final steps = [
      {'id': 'step1', 'label': 'Verify Identity', 'status': 'COMPLETED'},
      {'id': 'step2', 'label': 'Check Funds', 'status': 'COMPLETED'},
      {'id': 'step3', 'label': 'Lock Property', 'status': 'IN_PROGRESS'},
      {'id': 'step4', 'label': 'Generate Contract', 'status': 'PENDING'},
      {'id': 'step5', 'label': 'Sign Documents', 'status': 'PENDING'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Temporal Workflow Execution',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 4),
          Text(
            'Workflow ID: $workflowId',
            style: TextStyle(fontSize: 12, color: Colors.grey[500], fontFamily: 'monospace'),
          ),
          const SizedBox(height: 24),
          Column(
            children: List.generate(steps.length, (index) {
              final step = steps[index];
              final isLast = index == steps.length - 1;
              return _buildTimelineStep(step, isLast);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(Map<String, String> step, bool isLast) {
    Color statusColor;
    IconData statusIcon;
    
    switch (step['status']) {
      case 'COMPLETED':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'IN_PROGRESS':
        statusColor = Colors.blue;
        statusIcon = Icons.play_circle_fill;
        break;
      case 'FAILED':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.radio_button_unchecked;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: step['status'] == 'COMPLETED' ? Colors.green : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['label']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: step['status'] == 'PENDING' ? Colors.grey : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      step['status']!,
                      style: TextStyle(fontSize: 10, color: statusColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
