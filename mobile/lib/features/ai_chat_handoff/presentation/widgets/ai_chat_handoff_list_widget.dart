import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIChatHandoff List Widget

class AIChatHandoffListWidget extends StatelessWidget {
  final List<AIChatHandoff> items;
  final void Function(AIChatHandoff)? onTap;
  final void Function(AIChatHandoff)? onEdit;
  final void Function(AIChatHandoff)? onDelete;
  const AIChatHandoffListWidget({super.key, required this.items, this.onTap, this.onEdit, this.onDelete});

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
            leading: CircleAvatar(child: Text(item.handoffReason != null && item.handoffReason!.toString().isNotEmpty ? item.handoffReason!.toString()[0].toUpperCase() : '?'),),
            title: Text(item.handoffReason ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Session Id: ${item.sessionId?.toString() ?? "N/A"}'),
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
