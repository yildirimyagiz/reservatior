import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../gen_models/enums/a_i_chat_role.dart';

class AIChatMessageDetailWidget extends StatelessWidget {
  final AIChatMessage message;

  const AIChatMessageDetailWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == AIChatRole.USER;

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
                  children: [
                    CircleAvatar(
                      backgroundColor: isUser ? Colors.blue : Colors.green,
                      child: Icon(isUser ? Icons.person : Icons.smart_toy, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUser ? 'User Message' : 'AI Assistant',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Session: ${message.sessionId ?? 'N/A'}',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 24),
                const Text('Content:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(message.content ?? 'No content'),
                ),
                if (message.redactedContent != null) ...[
                   const SizedBox(height: 12),
                   const Text('Redacted Content:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.orange)),
                   Text(message.redactedContent!),
                ],
                const Divider(height: 24),
                _buildInfoRow(Icons.fingerprint, 'ID', message.id ?? 'N/A'),
                _buildInfoRow(Icons.business, 'Org ID', message.orgId ?? 'N/A'),
                _buildInfoRow(Icons.access_time, 'Created At', _formatDateTime(message.createdAt)),
                _buildInfoRow(Icons.language, 'Language', message.language ?? 'N/A'),
                const Divider(height: 24),
                _buildSecuritySection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Security & Metadata', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
             _buildFlagChip('PII Detected', message.piiDetected ?? false),
             _buildFlagChip('Security Flag', message.securityFlag ?? false),
             _buildFlagChip('Payment Agreed', message.paymentAgreed ?? false),
          ],
        ),
        if (message.securityReason != null)
           _buildInfoRow(Icons.warning_amber, 'Security Reason', message.securityReason!),
      ],
    );
  }

  Widget _buildFlagChip(String label, bool value) {
    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 10)),
      backgroundColor: value ? Colors.red.shade50 : Colors.green.shade50,
      labelStyle: TextStyle(color: value ? Colors.red : Colors.green),
      side: BorderSide(color: value ? Colors.red.shade100 : Colors.green.shade100),
      visualDensity: VisualDensity.compact,
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
