import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/document_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/document_form_widget.dart';

// ── Document Client Page

class DocumentClientPage extends ConsumerStatefulWidget {
  const DocumentClientPage({super.key});
  @override ConsumerState<DocumentClientPage> createState() => _DocumentClientPageState();
}

class _DocumentClientPageState extends ConsumerState<DocumentClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(documentListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Documents'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(documentListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
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
            final list = _q.isEmpty ? items
                : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.contractId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.fileUrl?.toString() ?? '') + " " + (item.fileName?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.checksum?.toString() ?? '') + " " + (item.jurisdiction?.toString() ?? '') + " " + (item.templateId?.toString() ?? '') + " " + (item.analysisStatus?.toString() ?? '') + " " + (item.analysisJobId?.toString() ?? '') + " " + (item.searchVector?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Documents', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(documentListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(backgroundColor: _stColor(item.analysisStatus), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Created At: ' + _fmt(item.createdAt)),
                      trailing: const Icon(Icons.chevron_right),
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
            Text('$e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: () => ref.invalidate(documentListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DocumentClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Document'),
      ),
    );
  }

Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
}

  void _showDetail(BuildContext context, Document item) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.92, expand: false,
        builder: (ctx2, sc) => Column(children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Text('Document Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
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
                  _row('File Url', item.fileUrl?.toString() ?? 'N/A', Icons.text_fields),
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
                  _row('Expiry Date', _fmt(item.expiryDate), Icons.calendar_today),
                  _row('Compliance Type', item.complianceType?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Jurisdiction', item.jurisdiction?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Template Id', item.templateId?.toString() ?? 'N/A', Icons.link),
                  _row('Analysis Status', item.analysisStatus?.toString() ?? 'N/A', Icons.info_outline),
                  _row('Last Analyzed At', _fmt(item.lastAnalyzedAt), Icons.calendar_today),
                  _row('Analysis Job Id', item.analysisJobId?.toString() ?? 'N/A', Icons.link),
                  _row('Duplicates', item.duplicates?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Search Vector', item.searchVector?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
                  _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
          ])),
        ]),
      ),
    );
  }

  void _showForm(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft,
              child: Text('New Document', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: DocumentFormWidget(
                onSubmit: (newItem) {
                  ref.read(documentCreateStateProvider.notifier).state = newItem;
                  Navigator.pop(ctx);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}