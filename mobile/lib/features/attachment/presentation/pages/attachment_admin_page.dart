import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/attachment_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Attachment Admin Page  |  19 fields
// Auto-generated — edit with care
// ================================================================

class AttachmentAdminPage extends ConsumerWidget {
  const AttachmentAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(attachmentLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attachment Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(attachmentListProvider)),
        ],
      ),
      body: const _AttachmentBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AttachmentFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Attachment'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AttachmentBody extends ConsumerStatefulWidget {
  const _AttachmentBody({super.key});
  @override ConsumerState<_AttachmentBody> createState() => __AttachmentBodyState();
}

class __AttachmentBodyState extends ConsumerState<_AttachmentBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(attachmentListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Attachments…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.entityId?.toString() ?? '') + " " + (item.fileName?.toString() ?? '') + " " + (item.mimeType?.toString() ?? '') + " " + (item.storageKey?.toString() ?? '') + " " + (item.url?.toString() ?? '') + " " + (item.checksum?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '') + " " + (item.transactionId?.toString() ?? '') + " " + (item.taskId?.toString() ?? '') + " " + (item.messageId?.toString() ?? '') + " " + (item.propertyComplianceId?.toString() ?? '') + " " + (item.reviewId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Attachments yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(attachmentListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.entityType != null && item.entityType!.toString().isNotEmpty ? item.entityType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.entityType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(attachmentListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Attachment item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attachment Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('File Name', item.fileName?.toString() ?? 'N/A', Icons.person),
              _row('Mime Type', item.mimeType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Size Bytes', item.sizeBytes?.toString() ?? 'N/A', Icons.numbers),
              _row('Storage Key', item.storageKey?.toString() ?? 'N/A', Icons.text_fields),
              _row('Url', item.url?.toString() ?? 'N/A', Icons.link),
              _row('Checksum', item.checksum?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Transaction Id', item.transactionId?.toString() ?? 'N/A', Icons.link),
              _row('Task Id', item.taskId?.toString() ?? 'N/A', Icons.link),
              _row('Message Id', item.messageId?.toString() ?? 'N/A', Icons.link),
              _row('Property Compliance Id', item.propertyComplianceId?.toString() ?? 'N/A', Icons.link),
              _row('Review Id', item.reviewId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Attachment? item}) {
  showDialog(context: context, builder: (ctx) => _AttachmentForm(item: item, ref: ref));
}

class _AttachmentForm extends ConsumerStatefulWidget {
  final Attachment? item;
  final WidgetRef ref;
  const _AttachmentForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AttachmentForm> createState() => __AttachmentFormState();
}

class __AttachmentFormState extends ConsumerState<_AttachmentForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _entityType;
  String? _entityId;
  String? _fileName;
  String? _mimeType;
  int? _sizeBytes;
  String? _storageKey;
  String? _url;
  String? _checksum;
  String? _transactionId;
  String? _taskId;
  String? _messageId;
  String? _propertyComplianceId;
  String? _reviewId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _fileName = widget.item?.fileName?.toString();
    _mimeType = widget.item?.mimeType?.toString();
    _sizeBytes = widget.item?.sizeBytes;
    _storageKey = widget.item?.storageKey?.toString();
    _url = widget.item?.url?.toString();
    _checksum = widget.item?.checksum?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _taskId = widget.item?.taskId?.toString();
    _messageId = widget.item?.messageId?.toString();
    _propertyComplianceId = widget.item?.propertyComplianceId?.toString();
    _reviewId = widget.item?.reviewId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
      if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
      if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
      if (_storageKey?.isNotEmpty == true) 'storageKey': _storageKey,
      if (_url?.isNotEmpty == true) 'url': _url,
      if (_checksum?.isNotEmpty == true) 'checksum': _checksum,
      if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
      if (_taskId?.isNotEmpty == true) 'taskId': _taskId,
      if (_messageId?.isNotEmpty == true) 'messageId': _messageId,
      if (_propertyComplianceId?.isNotEmpty == true) 'propertyComplianceId': _propertyComplianceId,
      if (_reviewId?.isNotEmpty == true) 'reviewId': _reviewId,
    };
    if (widget.item == null) {
      widget.ref.read(attachmentCreateStateProvider.notifier).state = Attachment.fromJson(data);
    } else {
      widget.ref.read(attachmentUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'attachment': Attachment.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Attachment' : 'New Attachment'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.fileName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.mimeType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Size Bytes', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.sizeBytes?.toString() ?? '',
                    onSaved: (v) => _sizeBytes = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Storage Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.storageKey?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _storageKey = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.url?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _url = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.checksum?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.transactionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Task Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.taskId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taskId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Message Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.messageId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _messageId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Compliance Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyComplianceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyComplianceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Review Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reviewId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reviewId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Attachment'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Attachment item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Attachment?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(attachmentDeleteStateProvider.notifier).state = item.id;
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
