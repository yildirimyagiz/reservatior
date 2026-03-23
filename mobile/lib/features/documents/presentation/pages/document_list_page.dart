import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/document_provider.dart';
import '../widgets/document_card.dart';
import '../../domain/entities/document.dart';
import '../../shared/utils/document_utils.dart';

// ── Document List Page
// Tüm document'leri listeleyen ana sayfa

class DocumentListPage extends ConsumerStatefulWidget {
  const DocumentListPage({super.key});

  @override
  ConsumerState<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends ConsumerState<DocumentListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  DocumentType? _selectedType;
  DocumentStatus? _selectedStatus;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentsAsync = _searchQuery.isNotEmpty
        ? ref.watch(documentSearchProvider(_searchQuery))
        : ref.watch(documentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDocumentDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Filter chips
          if (_selectedType != null || _selectedStatus != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  if (_selectedType != null)
                    Chip(
                      label: Text(DocumentUtils.getDocumentTypeDisplayName(_selectedType)),
                      onDeleted: () => setState(() => _selectedType = null),
                    ),
                  if (_selectedStatus != null)
                    Chip(
                      label: Text(_selectedStatus!.name.toUpperCase()),
                      onDeleted: () => setState(() => _selectedStatus = null),
                    ),
                ],
              ),
            ),
          // Documents list
          Expanded(
            child: documentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
              data: (documents) {
                final filteredDocuments = _filterDocuments(documents);
                
                if (filteredDocuments.isEmpty) {
                  return const Center(
                    child: Text('No documents found'),
                  );
                }

                return ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index];
                    return DocumentCard(
                      document: document,
                      onTap: () => _navigateToDocumentDetail(document),
                      onEdit: () => _editDocument(document),
                      onDelete: () => _deleteDocument(document),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Document> _filterDocuments(List<Document> documents) {
    var filtered = documents;

    if (_selectedType != null) {
      filtered = filtered.where((doc) => doc.documentType == _selectedType).toList();
    }

    if (_selectedStatus != null) {
      filtered = filtered.where((doc) => DocumentUtils.getDocumentStatus(doc) == _selectedStatus).toList();
    }

    return filtered;
  }

  void _showAddDocumentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DocumentFormDialog(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Documents'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Type filter
                const Text('Document Type'),
                Wrap(
                  spacing: 8.0,
                  children: DocumentType.values.map((type) {
                    return FilterChip(
                      label: Text(DocumentUtils.getDocumentTypeDisplayName(type)),
                      selected: _selectedType == type,
                      onSelected: (selected) {
                        setState(() {
                          _selectedType = selected ? type : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // Status filter
                const Text('Document Status'),
                Wrap(
                  spacing: 8.0,
                  children: DocumentStatus.values.map((status) {
                    return FilterChip(
                      label: Text(status.name.toUpperCase()),
                      selected: _selectedStatus == status,
                      onSelected: (selected) {
                        setState(() {
                          _selectedStatus = selected ? status : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Apply'),
          ),
        ],
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void _navigateToDocumentDetail(Document document) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DocumentDetailPage(documentId: document.id!),
      ),
    );
  }

  void _editDocument(Document document) {
    showDialog(
      context: context,
      builder: (context) => DocumentFormDialog(document: document),
    );
  }

  void _deleteDocument(Document document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Document'),
        content: Text('Are you sure you want to delete "${document.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(deleteDocumentProvider(document.id!).future);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
