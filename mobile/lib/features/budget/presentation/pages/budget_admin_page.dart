import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/budget_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Budget Admin Page  |  19 fields
// Auto-generated — edit with care
// ================================================================

class BudgetAdminPage extends ConsumerWidget {
  const BudgetAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(budgetLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(budgetListProvider)),
        ],
      ),
      body: const _BudgetBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'BudgetFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Budget'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _BudgetBody extends ConsumerStatefulWidget {
  const _BudgetBody({super.key});
  @override ConsumerState<_BudgetBody> createState() => __BudgetBodyState();
}

class __BudgetBodyState extends ConsumerState<_BudgetBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(budgetListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Budgets…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.budgetType?.toString() ?? '') + " " + (item.period?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Budgets yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(budgetListProvider),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(budgetListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Budget item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Budget Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Budget Type', item.budgetType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Period', item.period?.toString() ?? 'N/A', Icons.text_fields),
              _row('Start Date', _formatDate(item.startDate), Icons.calendar_today),
              _row('End Date', _formatDate(item.endDate), Icons.calendar_today),
              _row('Total Amount', item.totalAmount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Line Items', item.lineItems?.toString() ?? 'N/A', Icons.text_fields),
              _row('Categories', item.categories?.toString() ?? 'N/A', Icons.text_fields),
              _row('Alerts', item.alerts?.toString() ?? 'N/A', Icons.text_fields),
              _row('Actual Spent', item.actualSpent?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {Budget? item}) {
  showDialog(context: context, builder: (ctx) => _BudgetForm(item: item, ref: ref));
}

class _BudgetForm extends ConsumerStatefulWidget {
  final Budget? item;
  final WidgetRef ref;
  const _BudgetForm({super.key, this.item, required this.ref});
  @override ConsumerState<_BudgetForm> createState() => __BudgetFormState();
}

class __BudgetFormState extends ConsumerState<_BudgetForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _name;
  String? _description;
  String? _budgetType;
  String? _period;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _totalAmount;
  String? _currency;
  String? _lineItems;
  String? _categories;
  String? _alerts;
  double? _actualSpent;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _budgetType = widget.item?.budgetType?.toString();
    _period = widget.item?.period?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _lineItems = widget.item?.lineItems?.toString();
    _categories = widget.item?.categories?.toString();
    _alerts = widget.item?.alerts?.toString();
    _actualSpent = widget.item?.actualSpent;
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_budgetType?.isNotEmpty == true) 'budgetType': _budgetType,
      if (_period?.isNotEmpty == true) 'period': _period,
      if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
      if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
      if (_totalAmount != null) 'totalAmount': _totalAmount,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_lineItems?.isNotEmpty == true) 'lineItems': _lineItems,
      if (_categories?.isNotEmpty == true) 'categories': _categories,
      if (_alerts?.isNotEmpty == true) 'alerts': _alerts,
      if (_actualSpent != null) 'actualSpent': _actualSpent,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(budgetCreateStateProvider.notifier).state = Budget.fromJson(data);
    } else {
      widget.ref.read(budgetUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'budget': Budget.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Budget' : 'New Budget'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Budget Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.budgetType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _budgetType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Period', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.period?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _period = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Total Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.totalAmount?.toString() ?? '',
                    onSaved: (v) => _totalAmount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Line Items', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.lineItems?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lineItems = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Categories', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.categories?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _categories = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Alerts', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.alerts?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _alerts = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Actual Spent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.actualSpent?.toString() ?? '',
                    onSaved: (v) => _actualSpent = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Budget'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Budget item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Budget?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(budgetDeleteStateProvider.notifier).state = item.id;
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
