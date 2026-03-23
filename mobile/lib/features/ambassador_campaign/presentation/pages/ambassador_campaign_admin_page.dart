import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ambassador_campaign_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AmbassadorCampaign Admin Page  |  21 fields
// Auto-generated — edit with care
// ================================================================

class AmbassadorCampaignAdminPage extends ConsumerWidget {
  const AmbassadorCampaignAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(ambassadorCampaignLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambassador Campaign Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(ambassadorCampaignListProvider)),
        ],
      ),
      body: const _AmbassadorCampaignBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AmbassadorCampaignFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ambassador Campaign'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AmbassadorCampaignBody extends ConsumerStatefulWidget {
  const _AmbassadorCampaignBody({super.key});
  @override ConsumerState<_AmbassadorCampaignBody> createState() => __AmbassadorCampaignBodyState();
}

class __AmbassadorCampaignBodyState extends ConsumerState<_AmbassadorCampaignBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(ambassadorCampaignListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ambassador Campaigns…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.ambassadorId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.currency?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ambassador Campaigns yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(ambassadorCampaignListProvider),
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
                    subtitle: Text('Status: ${item.status ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(ambassadorCampaignListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AmbassadorCampaign item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AmbassadorCampaign item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ambassador Campaign Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Ambassador Id', item.ambassadorId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Start Date', _formatDate(item.startDate), Icons.calendar_today),
              _row('End Date', _formatDate(item.endDate), Icons.calendar_today),
              _row('Budget', item.budget?.toString() ?? 'N/A', Icons.numbers),
              _row('Actual Spend', item.actualSpend?.toString() ?? 'N/A', Icons.numbers),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Target Reach', item.targetReach?.toString() ?? 'N/A', Icons.numbers),
              _row('Actual Reach', item.actualReach?.toString() ?? 'N/A', Icons.numbers),
              _row('Impressions', item.impressions?.toString() ?? 'N/A', Icons.numbers),
              _row('Clicks', item.clicks?.toString() ?? 'N/A', Icons.numbers),
              _row('Conversions', item.conversions?.toString() ?? 'N/A', Icons.numbers),
              _row('Conversion Value', item.conversionValue?.toString() ?? 'N/A', Icons.numbers),
              _row('Roi', item.roi?.toString() ?? 'N/A', Icons.numbers),
              _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
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

void _showForm(BuildContext context, WidgetRef ref, {AmbassadorCampaign? item}) {
  showDialog(context: context, builder: (ctx) => _AmbassadorCampaignForm(item: item, ref: ref));
}

class _AmbassadorCampaignForm extends ConsumerStatefulWidget {
  final AmbassadorCampaign? item;
  final WidgetRef ref;
  const _AmbassadorCampaignForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AmbassadorCampaignForm> createState() => __AmbassadorCampaignFormState();
}

class __AmbassadorCampaignFormState extends ConsumerState<_AmbassadorCampaignForm> {
  final _key = GlobalKey<FormState>();

  String? _ambassadorId;
  String? _name;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _budget;
  double? _actualSpend;
  String? _currency;
  String? _status;
  int? _targetReach;
  int? _actualReach;
  int? _impressions;
  int? _clicks;
  int? _conversions;
  double? _conversionValue;
  double? _roi;
  String? _content;

  @override
  void initState() {
    super.initState();
    _ambassadorId = widget.item?.ambassadorId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _targetReach = widget.item?.targetReach;
    _actualReach = widget.item?.actualReach;
    _impressions = widget.item?.impressions;
    _clicks = widget.item?.clicks;
    _conversions = widget.item?.conversions;
    _conversionValue = widget.item?.conversionValue;
    _roi = widget.item?.roi;
    _content = widget.item?.content?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_ambassadorId?.isNotEmpty == true) 'ambassadorId': _ambassadorId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
      if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
      if (_budget != null) 'budget': _budget,
      if (_actualSpend != null) 'actualSpend': _actualSpend,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_targetReach != null) 'targetReach': _targetReach,
      if (_actualReach != null) 'actualReach': _actualReach,
      if (_impressions != null) 'impressions': _impressions,
      if (_clicks != null) 'clicks': _clicks,
      if (_conversions != null) 'conversions': _conversions,
      if (_conversionValue != null) 'conversionValue': _conversionValue,
      if (_roi != null) 'roi': _roi,
      if (_content?.isNotEmpty == true) 'content': _content,
    };
    if (widget.item == null) {
      widget.ref.read(ambassadorCampaignCreateStateProvider.notifier).state = AmbassadorCampaign.fromJson(data);
    } else {
      widget.ref.read(ambassadorCampaignUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'ambassadorCampaign': AmbassadorCampaign.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ambassador Campaign' : 'New Ambassador Campaign'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Ambassador Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.ambassadorId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ambassadorId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _startDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _startDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Start Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_startDate != null ? _formatDate(_startDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _endDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _endDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_endDate != null ? _formatDate(_endDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.budget?.toString() ?? '',
                    onSaved: (v) => _budget = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Spend', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.actualSpend?.toString() ?? '',
                    onSaved: (v) => _actualSpend = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Target Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.targetReach?.toString() ?? '',
                    onSaved: (v) => _targetReach = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.actualReach?.toString() ?? '',
                    onSaved: (v) => _actualReach = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Impressions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.impressions?.toString() ?? '',
                    onSaved: (v) => _impressions = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Clicks', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.clicks?.toString() ?? '',
                    onSaved: (v) => _clicks = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Conversions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.conversions?.toString() ?? '',
                    onSaved: (v) => _conversions = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Conversion Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.conversionValue?.toString() ?? '',
                    onSaved: (v) => _conversionValue = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Roi', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.roi?.toString() ?? '',
                    onSaved: (v) => _roi = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.content?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _content = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ambassador Campaign'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AmbassadorCampaign item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ambassador Campaign?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(ambassadorCampaignDeleteStateProvider.notifier).state = item.id;
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
