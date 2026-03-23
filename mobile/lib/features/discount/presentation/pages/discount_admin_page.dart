import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/discount_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Discount Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class DiscountAdminPage extends ConsumerWidget {
  const DiscountAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(discountLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(discountListProvider)),
        ],
      ),
      body: const _DiscountBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DiscountFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Discount'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DiscountBody extends ConsumerStatefulWidget {
  const _DiscountBody({super.key});
  @override ConsumerState<_DiscountBody> createState() => __DiscountBodyState();
}

class __DiscountBodyState extends ConsumerState<_DiscountBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(discountListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Discounts…',
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
              : items.where((item) => ((item.name?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.code?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.pricingRuleId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Discounts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(discountListProvider),
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
                    subtitle: Text('Type: ' + item.type?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(discountListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Discount item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Discount Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Code', item.code?.toString() ?? 'N/A', Icons.text_fields),
              _row('Value', item.value?.toString() ?? 'N/A', Icons.numbers),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Start Date', _formatDate(item.startDate), Icons.calendar_today),
              _row('End Date', _formatDate(item.endDate), Icons.calendar_today),
              _row('Max Usage', item.maxUsage?.toString() ?? 'N/A', Icons.numbers),
              _row('Current Usage', item.currentUsage?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Pricing Rule Id', item.pricingRuleId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Discount? item}) {
  showDialog(context: context, builder: (ctx) => _DiscountForm(item: item, ref: ref));
}

class _DiscountForm extends ConsumerStatefulWidget {
  final Discount? item;
  final WidgetRef ref;
  const _DiscountForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DiscountForm> createState() => __DiscountFormState();
}

class __DiscountFormState extends ConsumerState<_DiscountForm> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _description;
  String? _code;
  double? _value;
  String? _type;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _maxUsage;
  int? _currentUsage;
  bool _isActive = false;
  String? _propertyId;
  String? _pricingRuleId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _code = widget.item?.code?.toString();
    _value = widget.item?.value;
    _type = widget.item?.type?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _maxUsage = widget.item?.maxUsage;
    _currentUsage = widget.item?.currentUsage;
    _isActive = widget.item?.isActive ?? false;
    _propertyId = widget.item?.propertyId?.toString();
    _pricingRuleId = widget.item?.pricingRuleId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_code?.isNotEmpty == true) 'code': _code,
      if (_value != null) 'value': _value,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
      if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
      if (_maxUsage != null) 'maxUsage': _maxUsage,
      if (_currentUsage != null) 'currentUsage': _currentUsage,
      'isActive': _isActive,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_pricingRuleId?.isNotEmpty == true) 'pricingRuleId': _pricingRuleId,
    };
    if (widget.item == null) {
      widget.ref.read(discountCreateStateProvider.notifier).state = Discount.fromJson(data);
    } else {
      widget.ref.read(discountUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'discount': Discount.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Discount' : 'New Discount'),
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
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.code?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _code = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.value?.toString() ?? '',
                    onSaved: (v) => _value = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Max Usage', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxUsage?.toString() ?? '',
                    onSaved: (v) => _maxUsage = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Current Usage', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.currentUsage?.toString() ?? '',
                    onSaved: (v) => _currentUsage = int.tryParse(v ?? ''),
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
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Pricing Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.pricingRuleId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _pricingRuleId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Discount'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Discount item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Discount?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(discountDeleteStateProvider.notifier).state = item.id;
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
