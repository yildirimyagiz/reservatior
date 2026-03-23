import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/mls_data_mapping_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MlsDataMapping Admin Page  |  11 fields
// Auto-generated — edit with care
// ================================================================

class MlsDataMappingAdminPage extends ConsumerWidget {
  const MlsDataMappingAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(mlsDataMappingLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mls Data Mapping Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(mlsDataMappingListProvider)),
        ],
      ),
      body: const _MlsDataMappingBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MlsDataMappingFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Mls Data Mapping'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MlsDataMappingBody extends ConsumerStatefulWidget {
  const _MlsDataMappingBody({super.key});
  @override ConsumerState<_MlsDataMappingBody> createState() => __MlsDataMappingBodyState();
}

class __MlsDataMappingBodyState extends ConsumerState<_MlsDataMappingBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mlsDataMappingListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Mls Data Mappings…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.fieldName?.toString() ?? '') + " " + (item.standardField?.toString() ?? '') + " " + (item.dataType?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Mls Data Mappings yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mlsDataMappingListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.fieldName != null && item.fieldName!.toString().isNotEmpty ? item.fieldName!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.fieldName ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(mlsDataMappingListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MlsDataMapping item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mls Data Mapping Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Mls Provider', item.mlsProvider?.toString() ?? 'N/A', Icons.text_fields),
              _row('Field Name', item.fieldName?.toString() ?? 'N/A', Icons.person),
              _row('Standard Field', item.standardField?.toString() ?? 'N/A', Icons.text_fields),
              _row('Data Type', item.dataType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Required', (item.isRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Transform Rule', item.transformRule?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {MlsDataMapping? item}) {
  showDialog(context: context, builder: (ctx) => _MlsDataMappingForm(item: item, ref: ref));
}

class _MlsDataMappingForm extends ConsumerStatefulWidget {
  final MlsDataMapping? item;
  final WidgetRef ref;
  const _MlsDataMappingForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MlsDataMappingForm> createState() => __MlsDataMappingFormState();
}

class __MlsDataMappingFormState extends ConsumerState<_MlsDataMappingForm> {
  final _key = GlobalKey<FormState>();

  String? _mlsProvider;
  String? _fieldName;
  String? _standardField;
  String? _dataType;
  bool _isRequired = false;
  String? _transformRule;

  @override
  void initState() {
    super.initState();
    _mlsProvider = widget.item?.mlsProvider?.toString();
    _fieldName = widget.item?.fieldName?.toString();
    _standardField = widget.item?.standardField?.toString();
    _dataType = widget.item?.dataType?.toString();
    _isRequired = widget.item?.isRequired ?? false;
    _transformRule = widget.item?.transformRule?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_mlsProvider?.isNotEmpty == true) 'mlsProvider': _mlsProvider,
      if (_fieldName?.isNotEmpty == true) 'fieldName': _fieldName,
      if (_standardField?.isNotEmpty == true) 'standardField': _standardField,
      if (_dataType?.isNotEmpty == true) 'dataType': _dataType,
      'isRequired': _isRequired,
      if (_transformRule?.isNotEmpty == true) 'transformRule': _transformRule,
    };
    if (widget.item == null) {
      widget.ref.read(mlsDataMappingCreateStateProvider.notifier).state = MlsDataMapping.fromJson(data);
    } else {
      widget.ref.read(mlsDataMappingUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'mlsDataMapping': MlsDataMapping.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Mls Data Mapping' : 'New Mls Data Mapping'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mls Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mlsProvider?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mlsProvider = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Field Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.fieldName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fieldName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Standard Field', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.standardField?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _standardField = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Data Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.dataType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dataType = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Required'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isRequired ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isRequired = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Transform Rule', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.transformRule?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _transformRule = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Mls Data Mapping'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MlsDataMapping item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Mls Data Mapping?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(mlsDataMappingDeleteStateProvider.notifier).state = item.id;
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
