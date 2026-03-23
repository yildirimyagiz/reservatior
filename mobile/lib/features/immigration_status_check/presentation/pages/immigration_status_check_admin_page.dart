import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/immigration_status_check_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ImmigrationStatusCheck Admin Page  |  18 fields
// Auto-generated — edit with care
// ================================================================

class ImmigrationStatusCheckAdminPage extends ConsumerWidget {
  const ImmigrationStatusCheckAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(immigrationStatusCheckLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Immigration Status Check Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(immigrationStatusCheckListProvider)),
        ],
      ),
      body: const _ImmigrationStatusCheckBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ImmigrationStatusCheckFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Immigration Status Check'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ImmigrationStatusCheckBody extends ConsumerStatefulWidget {
  const _ImmigrationStatusCheckBody({super.key});
  @override ConsumerState<_ImmigrationStatusCheckBody> createState() => __ImmigrationStatusCheckBodyState();
}

class __ImmigrationStatusCheckBodyState extends ConsumerState<_ImmigrationStatusCheckBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(immigrationStatusCheckListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Immigration Status Checks…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.leaseId?.toString() ?? '') + " " + (item.tenantId?.toString() ?? '') + " " + (item.checkStatus?.toString() ?? '') + " " + (item.immigrationStatus?.toString() ?? '') + " " + (item.visaType?.toString() ?? '') + " " + (item.documentType?.toString() ?? '') + " " + (item.documentNumber?.toString() ?? '') + " " + (item.shareCode?.toString() ?? '') + " " + (item.checkReference?.toString() ?? '') + " " + (item.notes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Immigration Status Checks yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(immigrationStatusCheckListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.checkStatus != null && item.checkStatus!.toString().isNotEmpty ? item.checkStatus!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.checkStatus ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.checkStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.checkStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(immigrationStatusCheckListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(ImmigrationStatusCheck item) {
    final s = item.checkStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ImmigrationStatusCheck item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Immigration Status Check Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
              _row('Tenant Id', item.tenantId?.toString() ?? 'N/A', Icons.link),
              _row('Check Status', item.checkStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Check Date', _formatDate(item.checkDate), Icons.calendar_today),
              _row('Valid Until', _formatDate(item.validUntil), Icons.calendar_today),
              _row('Immigration Status', item.immigrationStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Visa Type', item.visaType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Visa Expiry', _formatDate(item.visaExpiry), Icons.calendar_today),
              _row('Document Type', item.documentType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Document Number', item.documentNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Document Verified', (item.documentVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Share Code', item.shareCode?.toString() ?? 'N/A', Icons.text_fields),
              _row('Check Reference', item.checkReference?.toString() ?? 'N/A', Icons.text_fields),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
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

void _showForm(BuildContext context, WidgetRef ref, {ImmigrationStatusCheck? item}) {
  showDialog(context: context, builder: (ctx) => _ImmigrationStatusCheckForm(item: item, ref: ref));
}

class _ImmigrationStatusCheckForm extends ConsumerStatefulWidget {
  final ImmigrationStatusCheck? item;
  final WidgetRef ref;
  const _ImmigrationStatusCheckForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ImmigrationStatusCheckForm> createState() => __ImmigrationStatusCheckFormState();
}

class __ImmigrationStatusCheckFormState extends ConsumerState<_ImmigrationStatusCheckForm> {
  final _key = GlobalKey<FormState>();

  String? _leaseId;
  String? _tenantId;
  String? _checkStatus;
  DateTime? _checkDate;
  DateTime? _validUntil;
  String? _immigrationStatus;
  String? _visaType;
  DateTime? _visaExpiry;
  String? _documentType;
  String? _documentNumber;
  bool _documentVerified = false;
  String? _shareCode;
  String? _checkReference;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _checkStatus = widget.item?.checkStatus?.toString();
    _checkDate = widget.item?.checkDate;
    _validUntil = widget.item?.validUntil;
    _immigrationStatus = widget.item?.immigrationStatus?.toString();
    _visaType = widget.item?.visaType?.toString();
    _visaExpiry = widget.item?.visaExpiry;
    _documentType = widget.item?.documentType?.toString();
    _documentNumber = widget.item?.documentNumber?.toString();
    _documentVerified = widget.item?.documentVerified ?? false;
    _shareCode = widget.item?.shareCode?.toString();
    _checkReference = widget.item?.checkReference?.toString();
    _notes = widget.item?.notes?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
      if (_checkStatus?.isNotEmpty == true) 'checkStatus': _checkStatus,
      if (_checkDate != null) 'checkDate': _checkDate!.toIso8601String(),
      if (_validUntil != null) 'validUntil': _validUntil!.toIso8601String(),
      if (_immigrationStatus?.isNotEmpty == true) 'immigrationStatus': _immigrationStatus,
      if (_visaType?.isNotEmpty == true) 'visaType': _visaType,
      if (_visaExpiry != null) 'visaExpiry': _visaExpiry!.toIso8601String(),
      if (_documentType?.isNotEmpty == true) 'documentType': _documentType,
      if (_documentNumber?.isNotEmpty == true) 'documentNumber': _documentNumber,
      'documentVerified': _documentVerified,
      if (_shareCode?.isNotEmpty == true) 'shareCode': _shareCode,
      if (_checkReference?.isNotEmpty == true) 'checkReference': _checkReference,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    if (widget.item == null) {
      widget.ref.read(immigrationStatusCheckCreateStateProvider.notifier).state = ImmigrationStatusCheck.fromJson(data);
    } else {
      widget.ref.read(immigrationStatusCheckUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'immigrationStatusCheck': ImmigrationStatusCheck.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Immigration Status Check' : 'New Immigration Status Check'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.tenantId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Check Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.checkStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checkStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _checkDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _checkDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Check Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_checkDate != null ? _formatDate(_checkDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _validUntil ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _validUntil = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Valid Until',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_validUntil != null ? _formatDate(_validUntil) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Immigration Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.immigrationStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _immigrationStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Visa Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.visaType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _visaType = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _visaExpiry ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _visaExpiry = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Visa Expiry',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_visaExpiry != null ? _formatDate(_visaExpiry) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Document Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.documentType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _documentType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Document Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.documentNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _documentNumber = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Document Verified'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.documentVerified ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _documentVerified = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Share Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.shareCode?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _shareCode = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Check Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checkReference?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checkReference = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Immigration Status Check'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ImmigrationStatusCheck item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Immigration Status Check?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(immigrationStatusCheckDeleteStateProvider.notifier).state = item.id;
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
