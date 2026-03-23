import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── WebhookDelivery List Widget

class WebhookDeliveryListWidget extends StatelessWidget {
  final List<WebhookDelivery> items;
  final void Function(WebhookDelivery)? onTap;
  final void Function(WebhookDelivery)? onEdit;
  final void Function(WebhookDelivery)? onDelete;
  const WebhookDeliveryListWidget({super.key, required this.items, this.onTap, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
        const SizedBox(height: 12),
        Text('No items', style: TextStyle(color: Colors.grey[500])),
      ]));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: _stColor(item.statusCode), foregroundColor: Colors.white, child: Text(item.eventType != null && item.eventType!.toString().isNotEmpty ? item.eventType!.toString()[0].toUpperCase() : '?'),),
            title: Text(item.eventType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Created At: ' + _fmt(item.createdAt)),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              if (onEdit != null) IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => onEdit?.call(item)),
              if (onDelete != null) IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                onPressed: () => onDelete?.call(item)),
              if (onEdit == null && onDelete == null) const Icon(Icons.chevron_right),
            ]),
            onTap: () => onTap?.call(item),
          ),
        );
      },
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

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}