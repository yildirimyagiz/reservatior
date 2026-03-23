import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIChatMessage Detail Widget  |  23 fields

class AIChatMessageDetailWidget extends StatelessWidget {
  final AIChatMessage item;
  const AIChatMessageDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Session Id', item.sessionId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
        _row('Role', item.role?.toString() ?? 'N/A', Icons.text_fields),
        _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
        _row('Content Hash', item.contentHash?.toString() ?? 'N/A', Icons.notes),
        _row('Redacted Content', item.redactedContent?.toString() ?? 'N/A', Icons.notes),
        _row('Pii Detected', (item.piiDetected == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Language', item.language?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is A I', (item.isAI == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Escalation Tag', item.escalationTag?.toString() ?? 'N/A', Icons.text_fields),
        _row('Escalation Topic', item.escalationTopic?.toString() ?? 'N/A', Icons.text_fields),
        _row('Payment Agreed', (item.paymentAgreed == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Payment Plan', item.paymentPlan?.toString() ?? 'N/A', Icons.text_fields),
        _row('Security Flag', (item.securityFlag == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Security Reason', item.securityReason?.toString() ?? 'N/A', Icons.text_fields),
        _row('Module Type', item.moduleType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
        _row('Token Count', item.tokenCount?.toString() ?? 'N/A', Icons.numbers),
        _row('Processing Ms', item.processingMs?.toString() ?? 'N/A', Icons.numbers),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
      ],
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}