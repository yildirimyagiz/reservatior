import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

class AIPriceOptimizationListWidget extends StatelessWidget {
  final List<AIPriceOptimization> AIPriceOptimizations;
  final Function(AIPriceOptimization)? onTap;

  const AIPriceOptimizationListWidget({
    super.key,
    required this.AIPriceOptimizations,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AIPriceOptimizations.length,
      itemBuilder: (context, index) {
        final a_i_price_optimization = AIPriceOptimizations[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(a_i_price_optimization.id?.substring(0, 1).toUpperCase() ?? '?'),
            ),
            title: Text(a_i_price_optimization.id ?? 'Unknown'),
            subtitle: Text(_formatDate(a_i_price_optimization.createdAt)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onTap?.call(a_i_price_optimization),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}
