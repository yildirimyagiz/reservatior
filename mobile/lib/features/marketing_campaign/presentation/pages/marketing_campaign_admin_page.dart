import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/marketing_campaign_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// MarketingCampaign Admin Page  |  21 fields
// Auto-generated — edit with care
// ================================================================

class MarketingCampaignAdminPage extends ConsumerWidget {
  const MarketingCampaignAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(marketingCampaignLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketing Campaign Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(marketingCampaignListProvider)),
        ],
      ),
      body: const _MarketingCampaignBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'MarketingCampaignFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Marketing Campaign'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _MarketingCampaignBody extends ConsumerStatefulWidget {
  const _MarketingCampaignBody({super.key});
  @override ConsumerState<_MarketingCampaignBody> createState() => __MarketingCampaignBodyState();
}

class __MarketingCampaignBodyState extends ConsumerState<_MarketingCampaignBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(marketingCampaignListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Marketing Campaigns…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.targetType?.toString() ?? '') + " " + (item.subject?.toString() ?? '') + " " + (item.content?.toString() ?? '') + " " + (item.templateId?.toString() ?? '') + " " + (item.objective?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Marketing Campaigns yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(marketingCampaignListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(marketingCampaignListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(MarketingCampaign item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, MarketingCampaign item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marketing Campaign Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Target Type', item.targetType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Subject', item.subject?.toString() ?? 'N/A', Icons.text_fields),
              _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
              _row('Template Id', item.templateId?.toString() ?? 'N/A', Icons.link),
              _row('Scheduled At', _formatDate(item.scheduledAt), Icons.calendar_today),
              _row('Sent At', _formatDate(item.sentAt), Icons.calendar_today),
              _row('Completed At', _formatDate(item.completedAt), Icons.calendar_today),
              _row('Sent Count', item.sentCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Open Count', item.openCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Click Count', item.clickCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Conversion Count', item.conversionCount?.toString() ?? 'N/A', Icons.numbers),
              _row('Budget', item.budget?.toString() ?? 'N/A', Icons.numbers),
              _row('Actual Spend', item.actualSpend?.toString() ?? 'N/A', Icons.numbers),
              _row('Objective', item.objective?.toString() ?? 'N/A', Icons.text_fields),
              _row('Target Ids', item.targetIds?.join(', ') ?? 'N/A', Icons.group),
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

void _showForm(BuildContext context, WidgetRef ref, {MarketingCampaign? item}) {
  showDialog(context: context, builder: (ctx) => _MarketingCampaignForm(item: item, ref: ref));
}

class _MarketingCampaignForm extends ConsumerStatefulWidget {
  final MarketingCampaign? item;
  final WidgetRef ref;
  const _MarketingCampaignForm({super.key, this.item, required this.ref});
  @override ConsumerState<_MarketingCampaignForm> createState() => __MarketingCampaignFormState();
}

class __MarketingCampaignFormState extends ConsumerState<_MarketingCampaignForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _type;
  String? _status;
  String? _targetType;
  String? _subject;
  String? _content;
  String? _templateId;
  DateTime? _scheduledAt;
  DateTime? _sentAt;
  DateTime? _completedAt;
  int? _sentCount;
  int? _openCount;
  int? _clickCount;
  int? _conversionCount;
  double? _budget;
  double? _actualSpend;
  String? _objective;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _targetType = widget.item?.targetType?.toString();
    _subject = widget.item?.subject?.toString();
    _content = widget.item?.content?.toString();
    _templateId = widget.item?.templateId?.toString();
    _scheduledAt = widget.item?.scheduledAt;
    _sentAt = widget.item?.sentAt;
    _completedAt = widget.item?.completedAt;
    _sentCount = widget.item?.sentCount;
    _openCount = widget.item?.openCount;
    _clickCount = widget.item?.clickCount;
    _conversionCount = widget.item?.conversionCount;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _objective = widget.item?.objective?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_targetType?.isNotEmpty == true) 'targetType': _targetType,
      if (_subject?.isNotEmpty == true) 'subject': _subject,
      if (_content?.isNotEmpty == true) 'content': _content,
      if (_templateId?.isNotEmpty == true) 'templateId': _templateId,
      if (_scheduledAt != null) 'scheduledAt': _scheduledAt!.toIso8601String(),
      if (_sentAt != null) 'sentAt': _sentAt!.toIso8601String(),
      if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
      if (_sentCount != null) 'sentCount': _sentCount,
      if (_openCount != null) 'openCount': _openCount,
      if (_clickCount != null) 'clickCount': _clickCount,
      if (_conversionCount != null) 'conversionCount': _conversionCount,
      if (_budget != null) 'budget': _budget,
      if (_actualSpend != null) 'actualSpend': _actualSpend,
      if (_objective?.isNotEmpty == true) 'objective': _objective,
    };
    if (widget.item == null) {
      widget.ref.read(marketingCampaignCreateStateProvider.notifier).state = MarketingCampaign.fromJson(data);
    } else {
      widget.ref.read(marketingCampaignUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'marketingCampaign': MarketingCampaign.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Marketing Campaign' : 'New Marketing Campaign'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Target Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.targetType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _targetType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.subject?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.content?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _content = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Template Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.templateId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _templateId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _scheduledAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _scheduledAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Scheduled At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_scheduledAt != null ? _formatDate(_scheduledAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _sentAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _sentAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Sent At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_sentAt != null ? _formatDate(_sentAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _completedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _completedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Completed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_completedAt != null ? _formatDate(_completedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sent Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.sentCount?.toString() ?? '',
                    onSaved: (v) => _sentCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Open Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.openCount?.toString() ?? '',
                    onSaved: (v) => _openCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Click Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.clickCount?.toString() ?? '',
                    onSaved: (v) => _clickCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Conversion Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.conversionCount?.toString() ?? '',
                    onSaved: (v) => _conversionCount = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.budget?.toString() ?? '',
                    onSaved: (v) => _budget = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Spend', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.actualSpend?.toString() ?? '',
                    onSaved: (v) => _actualSpend = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Objective', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.objective?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _objective = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Marketing Campaign'),
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

void _confirmDel(BuildContext context, WidgetRef ref, MarketingCampaign item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Marketing Campaign?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(marketingCampaignDeleteStateProvider.notifier).state = item.id;
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
