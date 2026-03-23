import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/pricing_rule_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// PricingRule Admin Page  |  21 fields
// Auto-generated — edit with care
// ================================================================

class PricingRuleAdminPage extends ConsumerWidget {
  const PricingRuleAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(pricingRuleLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pricing Rule Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(pricingRuleListProvider)),
        ],
      ),
      body: const _PricingRuleBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PricingRuleFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Pricing Rule'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PricingRuleBody extends ConsumerStatefulWidget {
  const _PricingRuleBody({super.key});
  @override ConsumerState<_PricingRuleBody> createState() => __PricingRuleBodyState();
}

class __PricingRuleBodyState extends ConsumerState<_PricingRuleBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(pricingRuleListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Pricing Rules…',
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
              : items.where((item) => ((item.listingId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.ruleType?.toString() ?? '') + " " + (item.strategy?.toString() ?? '') + " " + (item.currencyId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Pricing Rules yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(pricingRuleListProvider),
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
                    subtitle: Text('Start Date: ' + _formatDate(item.startDate)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(pricingRuleListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, PricingRule item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pricing Rule Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Rule Type', item.ruleType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Conditions', item.conditions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Actions', item.actions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Priority', item.priority?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Base Price', item.basePrice?.toString() ?? 'N/A', Icons.attach_money),
              _row('Strategy', item.strategy?.toString() ?? 'N/A', Icons.attach_money),
              _row('Start Date', _formatDate(item.startDate), Icons.calendar_today),
              _row('End Date', _formatDate(item.endDate), Icons.calendar_today),
              _row('Min Nights', item.minNights?.toString() ?? 'N/A', Icons.numbers),
              _row('Max Nights', item.maxNights?.toString() ?? 'N/A', Icons.numbers),
              _row('Weekday Prices', item.weekdayPrices?.toString() ?? 'N/A', Icons.attach_money),
              _row('Tax Rules', item.taxRules?.toString() ?? 'N/A', Icons.text_fields),
              _row('Discount Rules', item.discountRules?.toString() ?? 'N/A', Icons.text_fields),
              _row('Currency Id', item.currencyId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {PricingRule? item}) {
  showDialog(context: context, builder: (ctx) => _PricingRuleForm(item: item, ref: ref));
}

class _PricingRuleForm extends ConsumerStatefulWidget {
  final PricingRule? item;
  final WidgetRef ref;
  const _PricingRuleForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PricingRuleForm> createState() => __PricingRuleFormState();
}

class __PricingRuleFormState extends ConsumerState<_PricingRuleForm> {
  final _key = GlobalKey<FormState>();

  String? _listingId;
  String? _name;
  String? _description;
  String? _ruleType;
  String? _conditions;
  String? _actions;
  int? _priority;
  bool _isActive = false;
  double? _basePrice;
  String? _strategy;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _minNights;
  int? _maxNights;
  String? _weekdayPrices;
  String? _taxRules;
  String? _discountRules;
  String? _currencyId;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _ruleType = widget.item?.ruleType?.toString();
    _conditions = widget.item?.conditions?.toString();
    _actions = widget.item?.actions?.toString();
    _priority = widget.item?.priority;
    _isActive = widget.item?.isActive ?? false;
    _basePrice = widget.item?.basePrice;
    _strategy = widget.item?.strategy?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _weekdayPrices = widget.item?.weekdayPrices?.toString();
    _taxRules = widget.item?.taxRules?.toString();
    _discountRules = widget.item?.discountRules?.toString();
    _currencyId = widget.item?.currencyId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_ruleType?.isNotEmpty == true) 'ruleType': _ruleType,
      if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
      if (_actions?.isNotEmpty == true) 'actions': _actions,
      if (_priority != null) 'priority': _priority,
      'isActive': _isActive,
      if (_basePrice != null) 'basePrice': _basePrice,
      if (_strategy?.isNotEmpty == true) 'strategy': _strategy,
      if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
      if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
      if (_minNights != null) 'minNights': _minNights,
      if (_maxNights != null) 'maxNights': _maxNights,
      if (_weekdayPrices?.isNotEmpty == true) 'weekdayPrices': _weekdayPrices,
      if (_taxRules?.isNotEmpty == true) 'taxRules': _taxRules,
      if (_discountRules?.isNotEmpty == true) 'discountRules': _discountRules,
      if (_currencyId?.isNotEmpty == true) 'currencyId': _currencyId,
    };
    if (widget.item == null) {
      widget.ref.read(pricingRuleCreateStateProvider.notifier).state = PricingRule.fromJson(data);
    } else {
      widget.ref.read(pricingRuleUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'pricingRule': PricingRule.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Pricing Rule' : 'New Pricing Rule'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rule Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.ruleType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ruleType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.conditions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Actions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.actions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _actions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Priority', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.priority?.toString() ?? '',
                    onSaved: (v) => _priority = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Base Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.basePrice?.toString() ?? '',
                    onSaved: (v) => _basePrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Strategy', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item.strategy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _strategy = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Min Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.minNights?.toString() ?? '',
                    onSaved: (v) => _minNights = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxNights?.toString() ?? '',
                    onSaved: (v) => _maxNights = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Weekday Prices', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                    initialValue: widget.item.weekdayPrices?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _weekdayPrices = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tax Rules', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.taxRules?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _taxRules = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Discount Rules', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.discountRules?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _discountRules = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.currencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currencyId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Pricing Rule'),
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

void _confirmDel(BuildContext context, WidgetRef ref, PricingRule item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Pricing Rule?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(pricingRuleDeleteStateProvider.notifier).state = item.id;
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
