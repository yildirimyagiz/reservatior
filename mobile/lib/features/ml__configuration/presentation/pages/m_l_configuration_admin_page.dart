import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/m_l_configuration_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MLConfiguration Admin Page  |  11 fields
// Auto-generated — edit with care
// ================================================================

class MLConfigurationAdminPage extends ConsumerWidget {
  const MLConfigurationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(mLConfigurationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('M L Configuration Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(mLConfigurationListProvider)),
        ],
      ),
      body: const _MLConfigurationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MLConfigurationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New M L Configuration'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MLConfigurationBody extends ConsumerStatefulWidget {
  const _MLConfigurationBody({super.key});
  @override ConsumerState<_MLConfigurationBody> createState() => __MLConfigurationBodyState();
}

class __MLConfigurationBodyState extends ConsumerState<_MLConfigurationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(mLConfigurationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search M L Configurations…',
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
              : items.where((item) => ((item.analysisMode?.toString() ?? '') + " " + (item.updatedBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No M L Configurations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(mLConfigurationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.analysisMode != null && item.analysisMode!.toString().isNotEmpty ? item.analysisMode!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.analysisMode ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(mLConfigurationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MLConfiguration item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('M L Configuration Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Enable Auto Tagging', (item.enableAutoTagging == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Quality Threshold', item.qualityThreshold?.toString() ?? 'N/A', Icons.numbers),
              _row('Enable M L Features', (item.enableMLFeatures == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Max Tags Per Image', item.maxTagsPerImage?.toString() ?? 'N/A', Icons.numbers),
              _row('Analysis Mode', item.analysisMode?.toString() ?? 'N/A', Icons.text_fields),
              _row('Custom Settings', item.customSettings?.toString() ?? 'N/A', Icons.text_fields),
              _row('Updated By', item.updatedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Version', item.version?.toString() ?? 'N/A', Icons.numbers),
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

void _showForm(BuildContext context, WidgetRef ref, {MLConfiguration? item}) {
  showDialog(context: context, builder: (ctx) => _MLConfigurationForm(item: item, ref: ref));
}

class _MLConfigurationForm extends ConsumerStatefulWidget {
  final MLConfiguration? item;
  final WidgetRef ref;
  const _MLConfigurationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MLConfigurationForm> createState() => __MLConfigurationFormState();
}

class __MLConfigurationFormState extends ConsumerState<_MLConfigurationForm> {
  final _key = GlobalKey<FormState>();

  bool _enableAutoTagging = false;
  double? _qualityThreshold;
  bool _enableMLFeatures = false;
  int? _maxTagsPerImage;
  String? _analysisMode;
  String? _customSettings;
  String? _updatedBy;
  int? _version;

  @override
  void initState() {
    super.initState();
    _enableAutoTagging = widget.item?.enableAutoTagging ?? false;
    _qualityThreshold = widget.item?.qualityThreshold;
    _enableMLFeatures = widget.item?.enableMLFeatures ?? false;
    _maxTagsPerImage = widget.item?.maxTagsPerImage;
    _analysisMode = widget.item?.analysisMode?.toString();
    _customSettings = widget.item?.customSettings?.toString();
    _updatedBy = widget.item?.updatedBy?.toString();
    _version = widget.item?.version;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      'enableAutoTagging': _enableAutoTagging,
      if (_qualityThreshold != null) 'qualityThreshold': _qualityThreshold,
      'enableMLFeatures': _enableMLFeatures,
      if (_maxTagsPerImage != null) 'maxTagsPerImage': _maxTagsPerImage,
      if (_analysisMode?.isNotEmpty == true) 'analysisMode': _analysisMode,
      if (_customSettings?.isNotEmpty == true) 'customSettings': _customSettings,
      if (_updatedBy?.isNotEmpty == true) 'updatedBy': _updatedBy,
      if (_version != null) 'version': _version,
    };
    if (widget.item == null) {
      widget.ref.read(mLConfigurationCreateStateProvider.notifier).state = MLConfiguration.fromJson(data);
    } else {
      widget.ref.read(mLConfigurationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'mLConfiguration': MLConfiguration.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit M L Configuration' : 'New M L Configuration'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Enable Auto Tagging'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.enableAutoTagging ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _enableAutoTagging = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Quality Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.qualityThreshold?.toString() ?? '',
                    onSaved: (v) => _qualityThreshold = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Enable M L Features'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.enableMLFeatures ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _enableMLFeatures = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Tags Per Image', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxTagsPerImage?.toString() ?? '',
                    onSaved: (v) => _maxTagsPerImage = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Mode', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.analysisMode?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisMode = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Custom Settings', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.customSettings?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _customSettings = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Updated By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.updatedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _updatedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.version?.toString() ?? '',
                    onSaved: (v) => _version = int.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create M L Configuration'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MLConfiguration item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete M L Configuration?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(mLConfigurationDeleteStateProvider.notifier).state = item.id;
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
