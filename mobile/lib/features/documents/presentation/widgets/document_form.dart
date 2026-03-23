import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/document.dart';
import '../providers/document_provider.dart';
import '../../shared/utils/document_utils.dart';

// ── Document Form Widget
// Document ekleme/düzenleme form'u

class DocumentFormDialog extends ConsumerStatefulWidget {
  final Document? document;

  const DocumentFormDialog({super.key, this.document});

  @override
  ConsumerState<DocumentFormDialog> createState() => _DocumentFormDialogState();
}

class _DocumentFormDialogState extends ConsumerState<DocumentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _fileUrlController = TextEditingController();
  final _tagsController = TextEditingController();

  DocumentType? _selectedType;
  ComplianceType? _selectedComplianceType;
  DateTime? _expiryDate;
  bool? _isRequired;
  bool? _signatureRequired;
  bool? _notarizationRequired;
  bool? _recordingRequired;
  String? _selectedTemplateId;

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      _initializeForm();
    }
  }

  void _initializeForm() {
    final doc = widget.document!;
    _titleController.text = doc.title ?? '';
    _descriptionController.text = doc.description ?? '';
    _fileUrlController.text = doc.fileUrl ?? '';
    _tagsController.text = doc.tags?.join(', ') ?? '';
    _selectedType = doc.documentType;
    _selectedComplianceType = doc.complianceType;
    _expiryDate = doc.expiryDate;
    _isRequired = doc.isRequired;
    _signatureRequired = doc.signatureRequired;
    _notarizationRequired = doc.notarizationRequired;
    _recordingRequired = doc.recordingRequired;
    _selectedTemplateId = doc.templateId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _fileUrlController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.document == null ? 'Add Document' : 'Edit Document'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                
                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                
                // File URL
                TextFormField(
                  controller: _fileUrlController,
                  decoration: const InputDecoration(
                    labelText: 'File URL',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Document Type
                DropdownButtonFormField<DocumentType>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Document Type',
                    border: OutlineInputBorder(),
                  ),
                  items: DocumentType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(DocumentUtils.getDocumentTypeDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Compliance Type
                DropdownButtonFormField<ComplianceType>(
                  value: _selectedComplianceType,
                  decoration: const InputDecoration(
                    labelText: 'Compliance Type',
                    border: OutlineInputBorder(),
                  ),
                  items: ComplianceType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(DocumentUtils.getComplianceTypeDisplayName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedComplianceType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Expiry Date
                ListTile(
                  title: const Text('Expiry Date'),
                  subtitle: Text(
                    _expiryDate != null
                        ? DocumentUtils.formatDate(_expiryDate)
                        : 'No expiry date',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _expiryDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 3650)),
                    );
                    if (date != null) {
                      setState(() {
                        _expiryDate = date;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                
                // Checkboxes
                CheckboxListTile(
                  title: const Text('Required Document'),
                  value: _isRequired ?? false,
                  onChanged: (value) {
                    setState(() {
                      _isRequired = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Signature Required'),
                  value: _signatureRequired ?? false,
                  onChanged: (value) {
                    setState(() {
                      _signatureRequired = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Notarization Required'),
                  value: _notarizationRequired ?? false,
                  onChanged: (value) {
                    setState(() {
                      _notarizationRequired = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Recording Required'),
                  value: _recordingRequired ?? false,
                  onChanged: (value) {
                    setState(() {
                      _recordingRequired = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Tags
                TextFormField(
                  controller: _tagsController,
                  decoration: const InputDecoration(
                    labelText: 'Tags (comma separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveDocument,
          child: const Text('Save'),
        ),
      ],
    );
  }

  void _saveDocument() {
    if (!_formKey.currentState!.validate()) return;

    final document = Document(
      id: widget.document?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      fileUrl: _fileUrlController.text.trim(),
      documentType: _selectedType,
      complianceType: _selectedComplianceType,
      expiryDate: _expiryDate,
      isRequired: _isRequired,
      signatureRequired: _signatureRequired,
      notarizationRequired: _notarizationRequired,
      recordingRequired: _recordingRequired,
      tags: _tagsController.text
          .split(',')
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(),
      templateId: _selectedTemplateId,
      createdAt: widget.document?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (widget.document == null) {
      // Create new document
      ref.read(createDocumentProvider(document).future).then((_) {
        Navigator.of(context).pop();
      });
    } else {
      // Update existing document
      ref.read(updateDocumentProvider(document).future).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}
