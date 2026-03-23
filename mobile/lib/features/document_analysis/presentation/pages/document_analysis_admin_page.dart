import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/document_analysis_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// DocumentAnalysis Admin Page  |  11 fields
// Auto-generated — edit with care
// ================================================================

class DocumentAnalysisAdminPage extends ConsumerWidget {
  const DocumentAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(documentAnalysisLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Analysis Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(documentAnalysisListProvider)),
        ],
      ),
      body: const _DocumentAnalysisBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DocumentAnalysisFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Document Analysis'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DocumentAnalysisBody extends ConsumerStatefulWidget {
  const _DocumentAnalysisBody({super.key});
  @override ConsumerState<_DocumentAnalysisBody> createState() => __DocumentAnalysisBodyState();
}

class __DocumentAnalysisBodyState extends ConsumerState<_DocumentAnalysisBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(documentAnalysisListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Document Analysiss…',
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
              : items.where((item) => ((item.documentId?.toString() ?? '') + " " + (item.jobId?.toString() ?? '') + " " + (item.orgId?.toString() ?? '') + " " + (item.extractedText?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Document Analysiss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(documentAnalysisListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.extractedText != null && item.extractedText!.toString().isNotEmpty ? item.extractedText!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.extractedText ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(documentAnalysisListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, DocumentAnalysis item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Document Analysis Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Document Id', item.documentId?.toString() ?? 'N/A', Icons.link),
              _row('Job Id', item.jobId?.toString() ?? 'N/A', Icons.link),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Extracted Text', item.extractedText?.toString() ?? 'N/A', Icons.text_fields),
              _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
              _row('Classification', item.classification?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Processing Time', item.processingTime?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {DocumentAnalysis? item}) {
  showDialog(context: context, builder: (ctx) => _DocumentAnalysisForm(item: item, ref: ref));
}

class _DocumentAnalysisForm extends ConsumerStatefulWidget {
  final DocumentAnalysis? item;
  final WidgetRef ref;
  const _DocumentAnalysisForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DocumentAnalysisForm> createState() => __DocumentAnalysisFormState();
}

class __DocumentAnalysisFormState extends ConsumerState<_DocumentAnalysisForm> {
  final _key = GlobalKey<FormState>();

  String? _documentId;
  String? _jobId;
  String? _extractedText;
  String? _metadata;
  String? _classification;
  double? _confidence;
  int? _processingTime;

  @override
  void initState() {
    super.initState();
    _documentId = widget.item?.documentId?.toString();
    _jobId = widget.item?.jobId?.toString();
    _extractedText = widget.item?.extractedText?.toString();
    _metadata = widget.item?.metadata?.toString();
    _classification = widget.item?.classification?.toString();
    _confidence = widget.item?.confidence;
    _processingTime = widget.item?.processingTime;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_documentId?.isNotEmpty == true) 'documentId': _documentId,
      if (_jobId?.isNotEmpty == true) 'jobId': _jobId,
      if (_extractedText?.isNotEmpty == true) 'extractedText': _extractedText,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
      if (_classification?.isNotEmpty == true) 'classification': _classification,
      if (_confidence != null) 'confidence': _confidence,
      if (_processingTime != null) 'processingTime': _processingTime,
    };
    if (widget.item == null) {
      widget.ref.read(documentAnalysisCreateStateProvider.notifier).state = DocumentAnalysis.fromJson(data);
    } else {
      widget.ref.read(documentAnalysisUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'documentAnalysis': DocumentAnalysis.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Document Analysis' : 'New Document Analysis'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Document Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.documentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _documentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.jobId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _jobId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Extracted Text', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.extractedText?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _extractedText = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Classification', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.classification?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _classification = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Processing Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.processingTime?.toString() ?? '',
                    onSaved: (v) => _processingTime = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Document Analysis'),
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

void _confirmDel(BuildContext context, WidgetRef ref, DocumentAnalysis item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Document Analysis?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(documentAnalysisDeleteStateProvider.notifier).state = item.id;
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
