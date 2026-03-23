import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DashboardWidget List Widget

class DashboardWidgetListWidget extends StatelessWidget {
  final List<DashboardWidget> items;
  final void Function(DashboardWidget)? onTap;
  final void Function(DashboardWidget)? onEdit;
  final void Function(DashboardWidget)? onDelete;

  const DashboardWidgetListWidget({
    super.key,
    required this.items,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
        const SizedBox(height: 12),
        Text('No Dashboard_widgets', style: TextStyle(color: Colors.grey[500])),
      ]));
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
      itemCount: items.length,
      itemBuilder: (ctx, i) {
        final item = items[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            leading: CircleAvatar(
              child: Text(item.title != null && item.title!.toString().isNotEmpty
                  ? item.title!.toString()[0].toUpperCase() : '?'),
            ),
            title: Text(item.title?.toString() ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('${item.title}'),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              if (onEdit != null)
                IconButton(icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: () => onEdit!(item)),
              if (onDelete != null)
                IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    onPressed: () => onDelete!(item)),
            ]),
            onTap: onTap != null ? () => onTap!(item) : null,
          ),
        );
      },
    );
  }
}
