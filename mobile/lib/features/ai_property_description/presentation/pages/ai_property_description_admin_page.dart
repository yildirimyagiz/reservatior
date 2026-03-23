import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_property_description_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIPropertyDescription Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class AIPropertyDescriptionAdminPage extends ConsumerWidget {
  const AIPropertyDescriptionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiPropertyDescriptionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Property Description Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiPropertyDescriptionListProvider)),
        ],
      ),
      body: const _AIPropertyDescriptionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIPropertyDescriptionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Property Description'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIPropertyDescriptionBody extends ConsumerStatefulWidget {
  const _AIPropertyDescriptionBody();
  @override ConsumerState<_AIPropertyDescriptionBody> createState() => __AIPropertyDescriptionBodyState();
}

class __AIPropertyDescriptionBodyState extends ConsumerState<_AIPropertyDescriptionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiPropertyDescriptionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Property Descriptions…',
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
              : items.where((AIPropertyDescription item) {
                  final searchText = [
                    item.orgId ?? '',
                    item.propertyId ?? '',
                    item.generatedDescription ?? '',
                    item.originalDescription ?? '',
                    item.tone ?? '',
                    item.targetAudience ?? '',
                    item.approvedBy ?? '',
                  ].join(' ');
                  return searchText.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Property Descriptions yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiPropertyDescriptionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.generatedDescription != null && item.generatedDescription!.toString().isNotEmpty ? item.generatedDescription!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.generatedDescription ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiPropertyDescriptionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIPropertyDescription item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Property Description Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Generated Description', item.generatedDescription?.toString() ?? 'N/A', Icons.attach_money),
              _row('Original Description', item.originalDescription?.toString() ?? 'N/A', Icons.notes),
              _row('Tone', item.tone?.toString() ?? 'N/A', Icons.text_fields),
              _row('Target Audience', item.targetAudience?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Features', item.keyFeatures?.toString() ?? 'N/A', Icons.text_fields),
              _row('Seo Keywords', item.seoKeywords?.toString() ?? 'N/A', Icons.text_fields),
              _row('Quality Score', item.qualityScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Generated At', _formatDate(item.generatedAt), Icons.attach_money),
              _row('Is Approved', (item.isApproved == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Approved By', item.approvedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Approved At', _formatDate(item.approvedAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {AIPropertyDescription? item}) {
  showDialog(context: context, builder: (ctx) => _AIPropertyDescriptionForm(item: item, ref: ref));
}

class _AIPropertyDescriptionForm extends ConsumerStatefulWidget {
  final AIPropertyDescription? item;
  final WidgetRef ref;
  const _AIPropertyDescriptionForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIPropertyDescriptionForm> createState() => __AIPropertyDescriptionFormState();
}

class __AIPropertyDescriptionFormState extends ConsumerState<_AIPropertyDescriptionForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _generatedDescription;
  String? _originalDescription;
  String? _tone;
  String? _targetAudience;
  String? _keyFeatures;
  String? _seoKeywords;
  double? _qualityScore;
  DateTime? _generatedAt;
  bool _isApproved = false;
  String? _approvedBy;
  DateTime? _approvedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _generatedDescription = widget.item?.generatedDescription?.toString();
    _originalDescription = widget.item?.originalDescription?.toString();
    _tone = widget.item?.tone?.toString();
    _targetAudience = widget.item?.targetAudience?.toString();
    _keyFeatures = widget.item?.keyFeatures?.toString();
    _seoKeywords = widget.item?.seoKeywords?.toString();
    _qualityScore = widget.item?.qualityScore;
    _generatedAt = widget.item?.generatedAt;
    _isApproved = widget.item?.isApproved ?? false;
    _approvedBy = widget.item?.approvedBy?.toString();
    _approvedAt = widget.item?.approvedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_generatedDescription?.isNotEmpty == true) 'generatedDescription': _generatedDescription,
      if (_originalDescription?.isNotEmpty == true) 'originalDescription': _originalDescription,
      if (_tone?.isNotEmpty == true) 'tone': _tone,
      if (_targetAudience?.isNotEmpty == true) 'targetAudience': _targetAudience,
      if (_keyFeatures?.isNotEmpty == true) 'keyFeatures': _keyFeatures,
      if (_seoKeywords?.isNotEmpty == true) 'seoKeywords': _seoKeywords,
      if (_qualityScore != null) 'qualityScore': _qualityScore,
      if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
      'isApproved': _isApproved,
      if (_approvedBy?.isNotEmpty == true) 'approvedBy': _approvedBy,
      if (_approvedAt != null) 'approvedAt': _approvedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(aiPropertyDescriptionCreateStateProvider.notifier).state = AIPropertyDescription.fromJson(data);
    } else {
      widget.ref.read(aiPropertyDescriptionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiPropertyDescription': AIPropertyDescription.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Property Description' : 'New Ai Property Description'),
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
                    decoration: const InputDecoration(labelText: 'Generated Description', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    initialValue: widget.item?.generatedDescription?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _generatedDescription = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Original Description', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                    initialValue: widget.item?.originalDescription?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _originalDescription = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Tone', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.tone?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tone = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Target Audience', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.targetAudience?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _targetAudience = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Key Features', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.keyFeatures?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyFeatures = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Seo Keywords', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.seoKeywords?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _seoKeywords = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Quality Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.qualityScore?.toString() ?? '',
                    onSaved: (v) => _qualityScore = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _generatedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _generatedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Generated At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_generatedAt != null ? _formatDate(_generatedAt) : 'Tap to select date'),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Approved'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isApproved ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isApproved = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Approved By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.approvedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _approvedBy = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _approvedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _approvedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Approved At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_approvedAt != null ? _formatDate(_approvedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Property Description'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIPropertyDescription item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Property Description?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiPropertyDescriptionDeleteStateProvider.notifier).state = item.id;
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
