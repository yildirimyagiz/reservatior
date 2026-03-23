import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

class AIChatHandoffDetailWidget extends StatelessWidget {
  final AIChatHandoff handoff;

  const AIChatHandoffDetailWidget({
    super.key,
    required this.handoff,
  });

  @override
  Widget build(BuildContext context) {
    final isResolved = handoff.resolvedAt != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Handoff to: ${handoff.handoffTo ?? 'Unknown'}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    _buildStatusChip(isResolved),
                  ],
                ),
                const SizedBox(height: 12),
                const Text('Reason:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(handoff.handoffReason ?? 'No reason provided'),
                if (handoff.notes != null) ...[
                   const SizedBox(height: 12),
                   const Text('Internal Notes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blueGrey)),
                   Text(handoff.notes!),
                ],
                const Divider(height: 24),
                _buildInfoRow(Icons.fingerprint, 'ID', handoff.id ?? 'N/A'),
                _buildInfoRow(Icons.chat_bubble_outline, 'Session ID', handoff.sessionId ?? 'N/A'),
                _buildInfoRow(Icons.access_time, 'Handoff At', _formatDateTime(handoff.handoffAt)),
                if (isResolved) ...[
                   _buildInfoRow(Icons.check_circle_outline, 'Resolved At', _formatDateTime(handoff.resolvedAt)),
                   _buildInfoRow(Icons.person_outline, 'Resolved By', handoff.resolvedBy ?? 'N/A'),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(bool isResolved) {
    final color = isResolved ? Colors.green : Colors.orange;
    final text = isResolved ? 'RESOLVED' : 'PENDING';
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.w400))),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
