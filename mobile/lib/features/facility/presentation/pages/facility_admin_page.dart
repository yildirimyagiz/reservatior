import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/providers.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Facility Admin Page  |  10 fields
// Auto-generated — edit with care
// ================================================================

class FacilityAdminPage extends ConsumerWidget {
  const FacilityAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facilityCreateState = ref.watch(facilityCreateStateProvider);
    final loading = ref.watch(facilityLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facility Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(facilityListProvider)),
        ],
      ),
      body: const _FacilityBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FacilityFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Facility'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _FacilityBody extends ConsumerStatefulWidget {
  const _FacilityBody({super.key});
  @override ConsumerState<_FacilityBody> createState() => __FacilityBodyState();
}

class __FacilityBodyState extends ConsumerState<_FacilityBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(facilityListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Facilitys…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.feeCurrency?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Facilitys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(facilityListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ${_formatDate(item.createdAt)}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(facilityListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Facility item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facility Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Fee Amount', item.feeAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Fee Currency', item.feeCurrency?.toString() ?? 'N/A', Icons.attach_money),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
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

void _showForm(BuildContext context, WidgetRef ref, {Facility? item}) {
  showDialog(context: context, builder: (ctx) => _FacilityForm(item: item, ref: ref));
}

class _FacilityForm extends ConsumerStatefulWidget {
  final Facility? item;
  final WidgetRef ref;
  const _FacilityForm({super.key, this.item, required this.ref});
  @override ConsumerState<_FacilityForm> createState() => __FacilityFormState();
}

class __FacilityFormState extends ConsumerState<_FacilityForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _name;
  double? _feeAmount;
  String? _feeCurrency;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _name = widget.item?.name?.toString();
    _feeAmount = widget.item?.feeAmount;
    _feeCurrency = widget.item?.feeCurrency?.toString();
    _notes = widget.item?.notes?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_feeAmount != null) 'feeAmount': _feeAmount,
      if (_feeCurrency?.isNotEmpty == true) 'feeCurrency': _feeCurrency,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    if (widget.item == null) {
      widget.ref.read(facilityCreateStateProvider.notifier).state = Facility.fromJson(data);
    } else {
      widget.ref.read(facilityUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'facility': Facility.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Facility' : 'New Facility'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fee Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.feeAmount?.toString() ?? '',
                    onSaved: (v) => _feeAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Fee Currency', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    initialValue: widget.item?.feeCurrency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _feeCurrency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Notes', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Facility'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Facility item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Facility?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          void _deleteItem(String id) {
            ref.read(facilityDeleteStateProvider.notifier).delete(id);
          }
          _deleteItem(item.id!);
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
