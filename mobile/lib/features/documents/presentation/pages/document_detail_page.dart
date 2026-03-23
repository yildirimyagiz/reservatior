import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/document_provider.dart';
import '../widgets/document_analysis_widget.dart';
import '../../domain/entities/document.dart';
import '../../shared/utils/document_utils.dart';

// ── Document Detail Page
// Document detaylarını gösteren sayfa

class DocumentDetailPage extends ConsumerStatefulWidget {
  final String documentId;

  const DocumentDetailPage({super.key, required this.documentId});

  @override
  ConsumerState<DocumentDetailPage> createState() => _DocumentDetailPageState();
}

class _DocumentDetailPageState extends ConsumerState<DocumentDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentAsync = ref.watch(documentProvider(widget.documentId));
    final analysesAsync = ref.watch(documentAnalysesProvider(widget.documentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _editDocument(),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadDocument(),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareDocument(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Details'),
            Tab(text: 'Analysis'),
            Tab(text: 'Activity'),
          ],
        ),
      ),
      body: documentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        data: (document) {
          if (document == null) {
            return const Center(child: Text('Document not found'));
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildDetailsTab(document),
              _buildAnalysisTab(document, analysesAsync),
              _buildActivityTab(document),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailsTab(Document document) {
    final status = DocumentUtils.getDocumentStatus(document);
    final statusColor = DocumentUtils.getDocumentStatusColor(status);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _getStatusIcon(status),
                    color: _getStatusColor(statusColor),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${status.name.toUpperCase()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _getStatusDescription(status, document),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Basic information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow('Title', document.title),
                  _buildDetailRow('Description', document.description),
                  _buildDetailRow('File Name', document.fileName),
                  _buildDetailRow('File Size', DocumentUtils.formatFileSize(document.fileSize)),
                  _buildDetailRow('MIME Type', document.mimeType),
                  _buildDetailRow('Document Type', DocumentUtils.getDocumentTypeDisplayName(document.documentType)),
                  _buildDetailRow('Compliance Type', DocumentUtils.getComplianceTypeDisplayName(document.complianceType)),
                  _buildDetailRow('Created Date', DocumentUtils.formatDateTime(document.createdAt)),
                  _buildDetailRow('Updated Date', DocumentUtils.formatDateTime(document.updatedAt)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Requirements
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Requirements',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRequirementRow('Required Document', document.isRequired),
                  _buildRequirementRow('Signature Required', document.signatureRequired),
                  _buildRequirementRow('Is Signed', document.isSigned),
                  _buildRequirementRow('Notarization Required', document.notarizationRequired),
                  _buildRequirementRow('Recording Required', document.recordingRequired),
                  _buildDetailRow('Expiry Date', DocumentUtils.formatDate(document.expiryDate)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Tags
          if (document.tags != null && document.tags!.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tags',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: document.tags!.map((tag) {
                        return Chip(
                          label: Text(tag),
                          backgroundColor: Colors.blue.shade100,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab(Document document, AsyncValue analysesAsync) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Analysis status
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    _getAnalysisStatusIcon(document.analysisStatus),
                    color: _getAnalysisStatusColor(document.analysisStatus),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analysis Status: ${DocumentUtils.getAnalysisStatusDisplayName(_getAnalysisStatusEnum(document.analysisStatus))}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (document.lastAnalyzedAt != null)
                        Text(
                          'Last analyzed: ${DocumentUtils.formatDateTime(document.lastAnalyzedAt)}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Analyses list
          analysesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error loading analyses: $error'),
            ),
            data: (analyses) {
              if (analyses.isEmpty) {
                return const Center(
                  child: Text('No analyses found'),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: analyses.length,
                itemBuilder: (context, index) {
                  final analysis = analyses[index];
                  return DocumentAnalysisWidget(analysis: analysis);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTab(Document document) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity Log',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // TODO: Implement activity log
          Center(
            child: Text('Activity log coming soon...'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String label, bool? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Icon(
            value == true ? Icons.check_circle : Icons.cancel,
            color: value == true ? Colors.green : Colors.red,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            value == true ? 'Yes' : 'No',
            style: TextStyle(
              color: value == true ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.active:
        return Icons.check_circle;
      case DocumentStatus.pendingSignature:
        return Icons.pending;
      case DocumentStatus.signed:
        return Icons.verified;
      case DocumentStatus.expired:
        return Icons.error;
    }
  }

  String _getStatusDescription(DocumentStatus status, Document document) {
    switch (status) {
      case DocumentStatus.active:
        return 'Document is active and valid';
      case DocumentStatus.pendingSignature:
        return 'Document signature is pending';
      case DocumentStatus.signed:
        return 'Document has been signed';
      case DocumentStatus.expired:
        return 'Document has expired';
    }
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  AnalysisStatus _getAnalysisStatusEnum(String? status) {
    switch (status) {
      case 'pending':
        return AnalysisStatus.pending;
      case 'processing':
        return AnalysisStatus.processing;
      case 'completed':
        return AnalysisStatus.completed;
      case 'failed':
        return AnalysisStatus.failed;
      default:
        return AnalysisStatus.pending;
    }
  }

  IconData _getAnalysisStatusIcon(String? status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'processing':
        return Icons.autorenew;
      case 'completed':
        return Icons.check_circle;
      case 'failed':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  Color _getAnalysisStatusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _editDocument() {
    // TODO: Implement edit document
  }

  void _downloadDocument() {
    // TODO: Implement download document
  }

  void _shareDocument() {
    // TODO: Implement share document
  }
}
