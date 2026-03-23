import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/key_management_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// KeyManagement Admin Page  |  14 fields
// Auto-generated — edit with care
// ================================================================

class KeyManagementAdminPage extends ConsumerWidget {
  const KeyManagementAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(keyManagementLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Management Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(keyManagementListProvider)),
        ],
      ),
      body: const _KeyManagementBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'KeyManagementFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Key Management'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _KeyManagementBody extends ConsumerStatefulWidget {
  const _KeyManagementBody({super.key});
  @override ConsumerState<_KeyManagementBody> createState() => __KeyManagementBodyState();
}

class __KeyManagementBodyState extends ConsumerState<_KeyManagementBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(keyManagementListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Key Managements…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.keyType?.toString() ?? '') + " " + (item.keyNumber?.toString() ?? '') + " " + (item.keyLocation?.toString() ?? '') + " " + (item.keySafeCode?.toString() ?? '') + " " + (item.keyStatus?.toString() ?? '') + " " + (item.cutBy?.toString() ?? '') + " " + (item.notes?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Key Managements yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(keyManagementListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.keyType != null && item.keyType!.toString().isNotEmpty ? item.keyType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.keyType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.keyStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.keyStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(keyManagementListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(KeyManagement item) {
    final s = item.keyStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, KeyManagement item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Key Management Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Key Type', item.keyType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Number', item.keyNumber?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Location', item.keyLocation?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Safe Code', item.keySafeCode?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Status', item.keyStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Cut Date', _formatDate(item.cutDate), Icons.calendar_today),
              _row('Cut By', item.cutBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Replacement Cost', item.replacementCost?.toString() ?? 'N/A', Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {KeyManagement? item}) {
  showDialog(context: context, builder: (ctx) => _KeyManagementForm(item: item, ref: ref));
}

class _KeyManagementForm extends ConsumerStatefulWidget {
  final KeyManagement? item;
  final WidgetRef ref;
  const _KeyManagementForm({super.key, this.item, required this.ref});
  @override ConsumerState<_KeyManagementForm> createState() => __KeyManagementFormState();
}

class __KeyManagementFormState extends ConsumerState<_KeyManagementForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _keyType;
  String? _keyNumber;
  String? _keyLocation;
  String? _keySafeCode;
  String? _keyStatus;
  DateTime? _cutDate;
  String? _cutBy;
  double? _replacementCost;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _keyType = widget.item?.keyType?.toString();
    _keyNumber = widget.item?.keyNumber?.toString();
    _keyLocation = widget.item?.keyLocation?.toString();
    _keySafeCode = widget.item?.keySafeCode?.toString();
    _keyStatus = widget.item?.keyStatus?.toString();
    _cutDate = widget.item?.cutDate;
    _cutBy = widget.item?.cutBy?.toString();
    _replacementCost = widget.item?.replacementCost;
    _notes = widget.item?.notes?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_keyType?.isNotEmpty == true) 'keyType': _keyType,
      if (_keyNumber?.isNotEmpty == true) 'keyNumber': _keyNumber,
      if (_keyLocation?.isNotEmpty == true) 'keyLocation': _keyLocation,
      if (_keySafeCode?.isNotEmpty == true) 'keySafeCode': _keySafeCode,
      if (_keyStatus?.isNotEmpty == true) 'keyStatus': _keyStatus,
      if (_cutDate != null) 'cutDate': _cutDate!.toIso8601String(),
      if (_cutBy?.isNotEmpty == true) 'cutBy': _cutBy,
      if (_replacementCost != null) 'replacementCost': _replacementCost,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    if (widget.item == null) {
      widget.ref.read(keyManagementCreateStateProvider.notifier).state = KeyManagement.fromJson(data);
    } else {
      widget.ref.read(keyManagementUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'keyManagement': KeyManagement.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Key Management' : 'New Key Management'),
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
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.keyType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.keyNumber?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyNumber = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Location', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.keyLocation?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyLocation = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Safe Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.keySafeCode?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keySafeCode = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.keyStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _cutDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _cutDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Cut Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_cutDate != null ? _formatDate(_cutDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cut By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.cutBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _cutBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Replacement Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.replacementCost?.toString() ?? '',
                    onSaved: (v) => _replacementCost = double.tryParse(v ?? ''),
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
                  label: Text(isEdit ? 'Save Changes' : 'Create Key Management'),
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

void _confirmDel(BuildContext context, WidgetRef ref, KeyManagement item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Key Management?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(keyManagementDeleteStateProvider.notifier).state = item.id;
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
