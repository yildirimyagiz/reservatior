import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ApiIntegration Detail Widget  |  20 fields

class ApiIntegrationDetailWidget extends StatelessWidget {
  final ApiIntegration item;
  const ApiIntegrationDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.lastSyncStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.lastSyncStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.lastSyncStatus).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Platform', item.platform?.toString() ?? 'N/A', Icons.devices),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Enabled', (item.isEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Api Key', item.apiKey?.toString() ?? 'N/A', Icons.key),
        _row('Api Secret', item.apiSecret?.toString() ?? 'N/A', Icons.lock),
        _row('Access Token', item.accessToken?.toString() ?? 'N/A', Icons.vpn_key),
        _row('Refresh Token', item.refreshToken?.toString() ?? 'N/A', Icons.refresh),
        _row('Token Expiry', _fmt(item.tokenExpiry), Icons.calendar_today),
        _row('Base Url', item.baseUrl?.toString() ?? 'N/A', Icons.link),
        _row('Rate Limit', item.rateLimit?.toString() ?? 'N/A', Icons.speed),
        _row('Config', item.config?.toString() ?? 'N/A', Icons.settings),
        _row('Sync Direction', item.syncDirection?.toString() ?? 'N/A', Icons.sync),
        _row('Auto Sync', (item.autoSync == true ? 'Yes' : 'No'), Icons.autorenew),
        _row('Sync Interval', item.syncInterval?.toString() ?? 'N/A', Icons.timer),
        _row('Last Sync At', _fmt(item.lastSyncAt), Icons.calendar_today),
        _row('Last Sync Status', item.lastSyncStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Last Error', item.lastError?.toString() ?? 'N/A', Icons.error),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ],
    );
  }
}
Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
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