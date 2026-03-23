import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

class AIChatHandoffListWidget extends StatelessWidget {
  final List<AIChatHandoff> handoffs;
  final Function(AIChatHandoff)? onTap;

  const AIChatHandoffListWidget({
    super.key,
    required this.handoffs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: handoffs.length,
      itemBuilder: (context, index) {
        final handoff = handoffs[index];
        final isResolved = handoff.resolvedAt != null;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isResolved ? Colors.green : Colors.orange,
              child: Icon(
                isResolved ? Icons.check : Icons.call_merge,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              'To: ${handoff.handoffTo ?? 'Unknown'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reason: ${handoff.handoffReason ?? 'No reason provided'}'),
                Text(
                  'Handoff at: ${_formatDate(handoff.handoffAt)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right, size: 16),
            onTap: () => onTap?.call(handoff),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
