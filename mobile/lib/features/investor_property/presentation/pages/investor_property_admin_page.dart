import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/investor_property_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// InvestorProperty Admin Page  |  10 fields
// Auto-generated — edit with care
// ================================================================

class InvestorPropertyAdminPage extends ConsumerWidget {
  const InvestorPropertyAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(investorPropertyLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Property Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(investorPropertyListProvider)),
        ],
      ),
      body: const _InvestorPropertyBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'InvestorPropertyFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Investor Property'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _InvestorPropertyBody extends ConsumerStatefulWidget {
  const _InvestorPropertyBody({super.key});
  @override ConsumerState<_InvestorPropertyBody> createState() => __InvestorPropertyBodyState();
}

class __InvestorPropertyBodyState extends ConsumerState<_InvestorPropertyBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(investorPropertyListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Investor Propertys…',
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
              : items.where((item) => ((item.portfolioId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.insuranceProvider?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Investor Propertys yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(investorPropertyListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.insuranceProvider != null && item.insuranceProvider!.toString().isNotEmpty ? item.insuranceProvider!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.insuranceProvider ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Portfolio Id: ' + item.portfolioId?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(investorPropertyListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, InvestorProperty item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Investor Property Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Portfolio Id', item.portfolioId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Acquired At', _formatDate(item.acquiredAt), Icons.calendar_today),
              _row('Acquired Cost', item.acquiredCost?.toString() ?? 'N/A', Icons.attach_money),
              _row('Mortgage Balance', item.mortgageBalance?.toString() ?? 'N/A', Icons.attach_money),
              _row('Mortgage Rate', item.mortgageRate?.toString() ?? 'N/A', Icons.attach_money),
              _row('Mortgage Term', item.mortgageTerm?.toString() ?? 'N/A', Icons.numbers),
              _row('Insurance Provider', item.insuranceProvider?.toString() ?? 'N/A', Icons.text_fields),
              _row('Insurance Amount', item.insuranceAmount?.toString() ?? 'N/A', Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {InvestorProperty? item}) {
  showDialog(context: context, builder: (ctx) => _InvestorPropertyForm(item: item, ref: ref));
}

class _InvestorPropertyForm extends ConsumerStatefulWidget {
  final InvestorProperty? item;
  final WidgetRef ref;
  const _InvestorPropertyForm({super.key, this.item, required this.ref});
  @override ConsumerState<_InvestorPropertyForm> createState() => __InvestorPropertyFormState();
}

class __InvestorPropertyFormState extends ConsumerState<_InvestorPropertyForm> {
  final _key = GlobalKey<FormState>();

  String? _portfolioId;
  String? _propertyId;
  DateTime? _acquiredAt;
  double? _acquiredCost;
  double? _mortgageBalance;
  double? _mortgageRate;
  int? _mortgageTerm;
  String? _insuranceProvider;
  double? _insuranceAmount;

  @override
  void initState() {
    super.initState();
    _portfolioId = widget.item?.portfolioId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _acquiredAt = widget.item?.acquiredAt;
    _acquiredCost = widget.item?.acquiredCost;
    _mortgageBalance = widget.item?.mortgageBalance;
    _mortgageRate = widget.item?.mortgageRate;
    _mortgageTerm = widget.item?.mortgageTerm;
    _insuranceProvider = widget.item?.insuranceProvider?.toString();
    _insuranceAmount = widget.item?.insuranceAmount;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_portfolioId?.isNotEmpty == true) 'portfolioId': _portfolioId,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_acquiredAt != null) 'acquiredAt': _acquiredAt!.toIso8601String(),
      if (_acquiredCost != null) 'acquiredCost': _acquiredCost,
      if (_mortgageBalance != null) 'mortgageBalance': _mortgageBalance,
      if (_mortgageRate != null) 'mortgageRate': _mortgageRate,
      if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
      if (_insuranceProvider?.isNotEmpty == true) 'insuranceProvider': _insuranceProvider,
      if (_insuranceAmount != null) 'insuranceAmount': _insuranceAmount,
    };
    if (widget.item == null) {
      widget.ref.read(investorPropertyCreateStateProvider.notifier).state = InvestorProperty.fromJson(data);
    } else {
      widget.ref.read(investorPropertyUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'investorProperty': InvestorProperty.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Investor Property' : 'New Investor Property'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Portfolio Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.portfolioId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _portfolioId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _acquiredAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _acquiredAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Acquired At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_acquiredAt != null ? _formatDate(_acquiredAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Acquired Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.acquiredCost?.toString() ?? '',
                    onSaved: (v) => _acquiredCost = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mortgage Balance', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.mortgageBalance?.toString() ?? '',
                    onSaved: (v) => _mortgageBalance = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mortgage Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.mortgageRate?.toString() ?? '',
                    onSaved: (v) => _mortgageRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Mortgage Term', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.mortgageTerm?.toString() ?? '',
                    onSaved: (v) => _mortgageTerm = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Insurance Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.insuranceProvider?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _insuranceProvider = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Insurance Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.insuranceAmount?.toString() ?? '',
                    onSaved: (v) => _insuranceAmount = double.tryParse(v ?? ''),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Investor Property'),
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

void _confirmDel(BuildContext context, WidgetRef ref, InvestorProperty item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Investor Property?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(investorPropertyDeleteStateProvider.notifier).state = item.id;
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
