import 'package:flutter/material.dart';
import '../../domain/entities/document_analysis.dart';
import '../../shared/utils/document_utils.dart';

// ── Document Analysis Widget
// Document analiz sonuçlarını gösteren widget

class DocumentAnalysisWidget extends StatelessWidget {
  final DocumentAnalysis analysis;

  const DocumentAnalysisWidget({
    super.key,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          'Analysis - ${DocumentUtils.formatDateTime(analysis.createdAt)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Icon(
              _getConfidenceIcon(analysis.confidence),
              color: _getConfidenceColor(analysis.confidence),
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              'Confidence: ${((analysis.confidence ?? 0) * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: _getConfidenceColor(analysis.confidence),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            if (analysis.processingTime != null)
              Text(
                'Processing: ${analysis.processingTime}ms',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Extracted Text
                if (analysis.extractedText != null && analysis.extractedText!.isNotEmpty) ...[
                  const Text(
                    'Extracted Text:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      analysis.extractedText!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                
                // Classification
                if (analysis.classification != null) ...[
                  const Text(
                    'Classification:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildClassificationWidget(analysis.classification),
                  const SizedBox(height: 16),
                ],
                
                // Metadata
                if (analysis.metadata != null) ...[
                  const Text(
                    'Metadata:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMetadataWidget(analysis.metadata),
                  const SizedBox(height: 16),
                ],
                
                // Analysis Details
                _buildAnalysisDetails(analysis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationWidget(dynamic classification) {
    if (classification is Map) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: classification.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  Text(
                    '${entry.key}:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value.toString(),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(classification.toString()),
      );
    }
  }

  Widget _buildMetadataWidget(dynamic metadata) {
    if (metadata is Map) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: metadata.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      '${entry.key}:',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.value.toString(),
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(metadata.toString()),
      );
    }
  }

  Widget _buildAnalysisDetails(DocumentAnalysis analysis) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analysis Details:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Analysis ID', analysis.id),
          _buildDetailRow('Document ID', analysis.documentId),
          _buildDetailRow('Job ID', analysis.jobId),
          _buildDetailRow('Organization ID', analysis.orgId),
          _buildDetailRow('Created At', DocumentUtils.formatDateTime(analysis.createdAt)),
          _buildDetailRow('Updated At', DocumentUtils.formatDateTime(analysis.updatedAt)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getConfidenceIcon(double? confidence) {
    if (confidence == null) return Icons.help;
    
    if (confidence >= 0.9) return Icons.verified;
    if (confidence >= 0.7) return Icons.thumb_up;
    if (confidence >= 0.5) return Icons.remove_red_eye;
    return Icons.warning;
  }

  Color _getConfidenceColor(double? confidence) {
    if (confidence == null) return Colors.grey;
    
    if (confidence >= 0.9) return Colors.green;
    if (confidence >= 0.7) return Colors.blue;
    if (confidence >= 0.5) return Colors.orange;
    return Colors.red;
  }
}
