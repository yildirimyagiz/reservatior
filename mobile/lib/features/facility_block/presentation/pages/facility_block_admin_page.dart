import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/facility_block_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// FacilityBlock Admin Page  |  8 fields
// Auto-generated — edit with care
// ================================================================

class FacilityBlockAdminPage extends ConsumerWidget {
  const FacilityBlockAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(facilityBlockLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facility Block Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(facilityBlockListProvider)),
        ],
      ),
      body: const _FacilityBlockBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'FacilityBlockFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Facility Block'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _FacilityBlockBody extends ConsumerStatefulWidget {
  const _FacilityBlockBody({super.key});
  @override ConsumerState<_FacilityBlockBody> createState() => __FacilityBlockBodyState();
}

class __FacilityBlockBodyState extends ConsumerState<_FacilityBlockBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(facilityBlockListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Facility Blocks…',
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
              : items.where((item) => ((item.facilityId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.architect?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Facility Blocks yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(facilityBlockListProvider),
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
                    subtitle: Text('Facility Id: ' + item.facilityId?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(facilityBlockListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, FacilityBlock item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facility Block Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Facility Id', item.facilityId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Floors', item.floors?.toString() ?? 'N/A', Icons.numbers),
              _row('Units Per Floor', item.unitsPerFloor?.toString() ?? 'N/A', Icons.numbers),
              _row('Total Units', item.totalUnits?.toString() ?? 'N/A', Icons.attach_money),
              _row('Year Built', item.yearBuilt?.toString() ?? 'N/A', Icons.numbers),
              _row('Architect', item.architect?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {FacilityBlock? item}) {
  showDialog(context: context, builder: (ctx) => _FacilityBlockForm(item: item, ref: ref));
}

class _FacilityBlockForm extends ConsumerStatefulWidget {
  final FacilityBlock? item;
  final WidgetRef ref;
  const _FacilityBlockForm({super.key, this.item, required this.ref});
  @override ConsumerState<_FacilityBlockForm> createState() => __FacilityBlockFormState();
}

class __FacilityBlockFormState extends ConsumerState<_FacilityBlockForm> {
  final _key = GlobalKey<FormState>();

  String? _facilityId;
  String? _name;
  int? _floors;
  int? _unitsPerFloor;
  int? _totalUnits;
  int? _yearBuilt;
  String? _architect;

  @override
  void initState() {
    super.initState();
    _facilityId = widget.item?.facilityId?.toString();
    _name = widget.item?.name?.toString();
    _floors = widget.item?.floors;
    _unitsPerFloor = widget.item?.unitsPerFloor;
    _totalUnits = widget.item?.totalUnits;
    _yearBuilt = widget.item?.yearBuilt;
    _architect = widget.item?.architect?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_floors != null) 'floors': _floors,
      if (_unitsPerFloor != null) 'unitsPerFloor': _unitsPerFloor,
      if (_totalUnits != null) 'totalUnits': _totalUnits,
      if (_yearBuilt != null) 'yearBuilt': _yearBuilt,
      if (_architect?.isNotEmpty == true) 'architect': _architect,
    };
    if (widget.item == null) {
      widget.ref.read(facilityBlockCreateStateProvider.notifier).state = FacilityBlock.fromJson(data);
    } else {
      widget.ref.read(facilityBlockUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'facilityBlock': FacilityBlock.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Facility Block' : 'New Facility Block'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.facilityId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Floors', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.floors?.toString() ?? '',
                    onSaved: (v) => _floors = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Units Per Floor', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.unitsPerFloor?.toString() ?? '',
                    onSaved: (v) => _unitsPerFloor = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Units', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.totalUnits?.toString() ?? '',
                    onSaved: (v) => _totalUnits = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Year Built', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.yearBuilt?.toString() ?? '',
                    onSaved: (v) => _yearBuilt = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Architect', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.architect?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _architect = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Facility Block'),
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

void _confirmDel(BuildContext context, WidgetRef ref, FacilityBlock item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Facility Block?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(facilityBlockDeleteStateProvider.notifier).state = item.id;
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
