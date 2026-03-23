import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Report List Widget ──

class ReportListWidget extends StatelessWidget {
  final List<Report> items;
  final void Function(Report)? onTap;
  final void Function(Report)? onEdit;
  final void Function(Report)? onDelete;

  const ReportListWidget({
    super.key,
    required this.items,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
          const SizedBox(height: 12),
          Text('No items', style: TextStyle(color: Colors.grey[500])),
        ]),
      );
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ListTile(
            leading: CircleAvatar(child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
            title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text('Created At: ' + _fmt(item.createdAt)),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              if (onEdit != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined, size: 20),
                  onPressed: () => onEdit?.call(item),
                ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                  onPressed: () => onDelete?.call(item),
                ),
              if (onEdit == null && onDelete == null)
                const Icon(Icons.chevron_right),
            ]),
            onTap: () => onTap?.call(item),
          ),
        );
      },
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
