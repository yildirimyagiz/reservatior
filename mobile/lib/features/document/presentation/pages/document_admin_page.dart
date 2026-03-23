import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/document_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Document Admin Page  |  33 fields
// Auto-generated — edit with care
// ================================================================

class DocumentAdminPage extends ConsumerWidget {
  const DocumentAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(documentLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(documentListProvider)),
        ],
      ),
      body: const _DocumentBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DocumentFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Document'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DocumentBody extends ConsumerStatefulWidget {
  const _DocumentBody({super.key});
  @override ConsumerState<_DocumentBody> createState() => __DocumentBodyState();
}

class __DocumentBodyState extends ConsumerState<_DocumentBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(documentListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Documents…',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _q.isNotEmpty
                ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                : null,
            border: const OutlineInputBorder(), isDense: true,
          ),
          onChanged: (v) => setState(() => _q = v.toLowerCase()),
        ),
      ),
      Expanded(child: async.when(
        data: (items) {
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.contractId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.fileUrl?.toString() ?? '') + " " + (item.fileName?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.checksum?.toString() ?? '') + " " + (item.jurisdiction?.toString() ?? '') + " " + (item.templateId?.toString() ?? '') + " " + (item.analysisStatus?.toString() ?? '') + " " + (item.analysisJobId?.toString() ?? '') + " " + (item.searchVector?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Documents yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(documentListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.analysisStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.analysisStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
                  ),
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                          onPressed: () => _showForm(context, ref, item: item)),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), tooltip: 'Delete',
                          onPressed: () => _confirmDel(context, ref, item)),
                    ]),
                    onTap: () => _showDetail(context, item),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 12),
          SelectableText('$e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: () => ref.invalidate(documentListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Document item) {
    final s = item.analysisStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Document item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Document Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Contract Id', item.contractId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Document Type', item.documentType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('File Url', item.fileUrl?.toString() ?? 'N/A', Icons.link),
              _row('File Name', item.fileName?.toString() ?? 'N/A', Icons.person),
              _row('File Size', item.fileSize?.toString() ?? 'N/A', Icons.numbers),
              _row('Mime Type', item.mimeType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Checksum', item.checksum?.toString() ?? 'N/A', Icons.text_fields),
              _row('Version', item.version?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Required', (item.isRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Is Signed', (item.isSigned == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Signature Required', (item.signatureRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Notarization Required', (item.notarizationRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Recording Required', (item.recordingRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Expiry Date', _formatDate(item.expiryDate), Icons.calendar_today),
              _row('Compliance Type', item.complianceType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Jurisdiction', item.jurisdiction?.toString() ?? 'N/A', Icons.text_fields),
              _row('Template Id', item.templateId?.toString() ?? 'N/A', Icons.link),
              _row('Analysis Status', item.analysisStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Last Analyzed At', _formatDate(item.lastAnalyzedAt), Icons.calendar_today),
              _row('Analysis Job Id', item.analysisJobId?.toString() ?? 'N/A', Icons.link),
              _row('Duplicates', item.duplicates?.toString() ?? 'N/A', Icons.text_fields),
              _row('Search Vector', item.searchVector?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
          ]),
        ),
      ),
    ),
  ));
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value),
    ])),
  ]),
);

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {Document? item}) {
  showDialog(context: context, builder: (ctx) => _DocumentForm(item: item, ref: ref));
}

class _DocumentForm extends ConsumerStatefulWidget {
  final Document? item;
  final WidgetRef ref;
  const _DocumentForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DocumentForm> createState() => __DocumentFormState();
}

class __DocumentFormState extends ConsumerState<_DocumentForm> {
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

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_contractId?.isNotEmpty == true) 'contractId': _contractId,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_documentType?.isNotEmpty == true) 'documentType': _documentType,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_fileUrl?.isNotEmpty == true) 'fileUrl': _fileUrl,
      if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
      if (_fileSize != null) 'fileSize': _fileSize,
      if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
      if (_checksum?.isNotEmpty == true) 'checksum': _checksum,
      if (_version != null) 'version': _version,
      'isRequired': _isRequired,
      'isSigned': _isSigned,
      'signatureRequired': _signatureRequired,
      'notarizationRequired': _notarizationRequired,
      'recordingRequired': _recordingRequired,
      if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
      if (_complianceType?.isNotEmpty == true) 'complianceType': _complianceType,
      if (_jurisdiction?.isNotEmpty == true) 'jurisdiction': _jurisdiction,
      if (_templateId?.isNotEmpty == true) 'templateId': _templateId,
      if (_analysisStatus?.isNotEmpty == true) 'analysisStatus': _analysisStatus,
      if (_lastAnalyzedAt != null) 'lastAnalyzedAt': _lastAnalyzedAt!.toIso8601String(),
      if (_analysisJobId?.isNotEmpty == true) 'analysisJobId': _analysisJobId,
      if (_duplicates?.isNotEmpty == true) 'duplicates': _duplicates,
      if (_searchVector?.isNotEmpty == true) 'searchVector': _searchVector,
    };
    if (widget.item == null) {
      widget.ref.read(documentCreateStateProvider.notifier).state = Document.fromJson(data);
    } else {
      widget.ref.read(documentUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'document': Document.fromJson({...widget.item!.toJson(), ...data}),
      };
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? 'Edit Document' : 'New Document'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.dealId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.contractId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Document Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.documentType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _documentType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'File Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.fileUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fileUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.fileName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'File Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.fileSize?.toString() ?? '',
                    onSaved: (v) => _fileSize = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mimeType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checksum?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.version?.toString() ?? '',
                    onSaved: (v) => _version = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isRequired = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Signed'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isSigned ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isSigned = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Signature Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.signatureRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _signatureRequired = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Notarization Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.notarizationRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _notarizationRequired = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Recording Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.recordingRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _recordingRequired = v); },
                    ),
                  ),
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
                      child: Text(_expiryDate != null ? _formatDate(_expiryDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Compliance Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.complianceType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _complianceType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Jurisdiction', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.jurisdiction?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _jurisdiction = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Template Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.templateId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _templateId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.analysisStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisStatus = v?.isEmpty == true ? null : v,
                  ),
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
                      child: Text(_lastAnalyzedAt != null ? _formatDate(_lastAnalyzedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.analysisJobId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisJobId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Duplicates', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.duplicates?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _duplicates = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Search Vector', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.searchVector?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _searchVector = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Document'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDel(BuildContext context, WidgetRef ref, Document item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Document?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(documentDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

// ─── Helpers ─────────────────────────────────────────────────────

String _formatDate(DateTime? d) {
  if (d == null) return 'N/A';
  final y = d.year; final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0'); final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '$y-$mo-$day $h:$mi';
}
