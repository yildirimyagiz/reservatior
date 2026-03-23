import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

class AIPriceOptimizationDetailWidget extends StatelessWidget {
  final AIPriceOptimization a_i_price_optimization;

  const AIPriceOptimizationDetailWidget({
    super.key,
    required this.a_i_price_optimization,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              a_i_price_optimization.id ?? 'Unknown AIPriceOptimization',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildDetailRow('ID', a_i_price_optimization.id ?? 'N/A'),
            _buildDetailRow('Status', _getAIPriceOptimizationStatus(a_i_price_optimization)),
            _buildDetailRow('Created', _formatDate(a_i_price_optimization.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAIPriceOptimizationStatus(AIPriceOptimization a_i_price_optimization) {
    // Logic to determine status
    if (a_i_price_optimization.isApplied == false) return 'Not Applied';
    return 'Applied';
  }

  Color _getStatusColor(AIPriceOptimization a_i_price_optimization) {
    final status = _getAIPriceOptimizationStatus(a_i_price_optimization);
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}
