import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/compliance_record_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ComplianceRecord Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class ComplianceRecordAdminPage extends ConsumerWidget {
  const ComplianceRecordAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(complianceRecordLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compliance Record Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(complianceRecordListProvider)),
        ],
      ),
      body: const _ComplianceRecordBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ComplianceRecordFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Compliance Record'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ComplianceRecordBody extends ConsumerStatefulWidget {
  const _ComplianceRecordBody({super.key});
  @override ConsumerState<_ComplianceRecordBody> createState() => __ComplianceRecordBodyState();
}

class __ComplianceRecordBodyState extends ConsumerState<_ComplianceRecordBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(complianceRecordListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Compliance Records…',
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
              : items.where((item) => ((item.entityId?.toString() ?? '') + " " + (item.entityType?.toString() ?? '') + " " + (item.documentUrl?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.agentId?.toString() ?? '') + " " + (item.agencyId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Compliance Records yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(complianceRecordListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.status!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(complianceRecordListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(ComplianceRecord item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ComplianceRecord item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Compliance Record Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
              _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Document Url', item.documentUrl?.toString() ?? 'N/A', Icons.link),
              _row('Expiry Date', _formatDate(item.expiryDate), Icons.calendar_today),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Is Verified', (item.isVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
              _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {ComplianceRecord? item}) {
  showDialog(context: context, builder: (ctx) => _ComplianceRecordForm(item: item, ref: ref));
}

class _ComplianceRecordForm extends ConsumerStatefulWidget {
  final ComplianceRecord? item;
  final WidgetRef ref;
  const _ComplianceRecordForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ComplianceRecordForm> createState() => __ComplianceRecordFormState();
}

class __ComplianceRecordFormState extends ConsumerState<_ComplianceRecordForm> {
  final _key = GlobalKey<FormState>();

  String? _entityId;
  String? _entityType;
  String? _type;
  String? _status;
  String? _documentUrl;
  DateTime? _expiryDate;
  String? _notes;
  bool _isVerified = false;
  String? _propertyId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;

  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _documentUrl = widget.item?.documentUrl?.toString();
    _expiryDate = widget.item?.expiryDate;
    _notes = widget.item?.notes?.toString();
    _isVerified = widget.item?.isVerified ?? false;
    _propertyId = widget.item?.propertyId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
      if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_documentUrl?.isNotEmpty == true) 'documentUrl': _documentUrl,
      if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      'isVerified': _isVerified,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
      if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
    };
    if (widget.item == null) {
      widget.ref.read(complianceRecordCreateStateProvider.notifier).state = ComplianceRecord.fromJson(data);
    } else {
      widget.ref.read(complianceRecordUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'complianceRecord': ComplianceRecord.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Compliance Record' : 'New Compliance Record'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.entityType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Document Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.documentUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _documentUrl = v?.isEmpty == true ? null : v,
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
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Verified'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isVerified ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isVerified = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.agencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Compliance Record'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ComplianceRecord item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Compliance Record?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(complianceRecordDeleteStateProvider.notifier).state = item.id;
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
