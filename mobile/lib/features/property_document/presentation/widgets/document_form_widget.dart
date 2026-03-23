import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Document Form Widget ──
// Fields: dealId, propertyId, contractId, userId, listingId, documentType, title, description, fileUrl, fileName, fileSize, mimeType, checksum, version, isRequired, isSigned, signatureRequired, notarizationRequired, recordingRequired, expiryDate, complianceType, jurisdiction, templateId, analysisStatus, lastAnalyzedAt, analysisJobId, duplicates, searchVector

class DocumentFormWidget extends StatefulWidget {
  final Document? item;
  final void Function(Document)? onSubmit;
  const DocumentFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<DocumentFormWidget> createState() => _DocumentFormWidgetState();
}

class _DocumentFormWidgetState extends State<DocumentFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _dealId;
  String? _propertyId;
  String? _contractId;
  String? _userId;
  String? _listingId;
  String? _documentType;
  String? _title;
  String? _description;
  String? _fileUrl;
  String? _fileName;
  int? _fileSize;
  String? _mimeType;
  String? _checksum;
  int? _version;
  bool _isRequired = false;
  bool _isSigned = false;
  bool _signatureRequired = false;
  bool _notarizationRequired = false;
  bool _recordingRequired = false;
  DateTime? _expiryDate;
  String? _complianceType;
  String? _jurisdiction;
  String? _templateId;
  String? _analysisStatus;
  DateTime? _lastAnalyzedAt;
  String? _analysisJobId;
  String? _duplicates;
  String? _searchVector;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _contractId = widget.item?.contractId?.toString();
    _userId = widget.item?.userId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _documentType = widget.item?.documentType?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _fileUrl = widget.item?.fileUrl?.toString();
    _fileName = widget.item?.fileName?.toString();
    _fileSize = widget.item?.fileSize;
    _mimeType = widget.item?.mimeType?.toString();
    _checksum = widget.item?.checksum?.toString();
    _version = widget.item?.version;
    _isRequired = widget.item?.isRequired ?? false;
    _isSigned = widget.item?.isSigned ?? false;
    _signatureRequired = widget.item?.signatureRequired ?? false;
    _notarizationRequired = widget.item?.notarizationRequired ?? false;
    _recordingRequired = widget.item?.recordingRequired ?? false;
    _expiryDate = widget.item?.expiryDate;
    _complianceType = widget.item?.complianceType?.toString();
    _jurisdiction = widget.item?.jurisdiction?.toString();
    _templateId = widget.item?.templateId?.toString();
    _analysisStatus = widget.item?.analysisStatus?.toString();
    _lastAnalyzedAt = widget.item?.lastAnalyzedAt;
    _analysisJobId = widget.item?.analysisJobId?.toString();
    _duplicates = widget.item?.duplicates?.toString();
    _searchVector = widget.item?.searchVector?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_dealId != null) 'dealId': _dealId,
        if (_propertyId != null) 'propertyId': _propertyId,
        if (_contractId != null) 'contractId': _contractId,
        if (_userId != null) 'userId': _userId,
        if (_listingId != null) 'listingId': _listingId,
        if (_documentType != null) 'documentType': _documentType,
        if (_title != null) 'title': _title,
        if (_description != null) 'description': _description,
        if (_fileUrl != null) 'fileUrl': _fileUrl,
        if (_fileName != null) 'fileName': _fileName,
        if (_fileSize != null) 'fileSize': _fileSize,
        if (_mimeType != null) 'mimeType': _mimeType,
        if (_checksum != null) 'checksum': _checksum,
        if (_version != null) 'version': _version,
        'isRequired': _isRequired,
        'isSigned': _isSigned,
        'signatureRequired': _signatureRequired,
        'notarizationRequired': _notarizationRequired,
        'recordingRequired': _recordingRequired,
        if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
        if (_complianceType != null) 'complianceType': _complianceType,
        if (_jurisdiction != null) 'jurisdiction': _jurisdiction,
        if (_templateId != null) 'templateId': _templateId,
        if (_analysisStatus != null) 'analysisStatus': _analysisStatus,
        if (_lastAnalyzedAt != null) 'lastAnalyzedAt': _lastAnalyzedAt!.toIso8601String(),
        if (_analysisJobId != null) 'analysisJobId': _analysisJobId,
        if (_duplicates != null) 'duplicates': _duplicates,
        if (_searchVector != null) 'searchVector': _searchVector,
    };
    final result = widget.item != null
        ? Document.fromJson({...widget.item!.toJson(), ...data})
        : Document.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _documentType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'File Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _fileUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'File Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _fileSize = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _version = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRequired,
                  onChanged: (v) { ss(() {}); setState(() => _isRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Signed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isSigned,
                  onChanged: (v) { ss(() {}); setState(() => _isSigned = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Signature Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _signatureRequired,
                  onChanged: (v) { ss(() {}); setState(() => _signatureRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Notarization Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _notarizationRequired,
                  onChanged: (v) { ss(() {}); setState(() => _notarizationRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Recording Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _recordingRequired,
                  onChanged: (v) { ss(() {}); setState(() => _recordingRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _expiryDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiryDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Expiry Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_expiryDate != null ? _fmt(_expiryDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Compliance Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _complianceType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Jurisdiction', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _jurisdiction = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Template Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _templateId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _analysisStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _lastAnalyzedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastAnalyzedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Analyzed At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_lastAnalyzedAt != null ? _fmt(_lastAnalyzedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _analysisJobId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duplicates', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _duplicates = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Search Vector', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _searchVector = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Document'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
