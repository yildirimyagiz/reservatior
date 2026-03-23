import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/investor_portfolio_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// InvestorPortfolio Admin Page  |  10 fields
// Auto-generated — edit with care
// ================================================================

class InvestorPortfolioAdminPage extends ConsumerWidget {
  const InvestorPortfolioAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(investorPortfolioLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investor Portfolio Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(investorPortfolioListProvider)),
        ],
      ),
      body: const _InvestorPortfolioBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'InvestorPortfolioFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Investor Portfolio'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _InvestorPortfolioBody extends ConsumerStatefulWidget {
  const _InvestorPortfolioBody({super.key});
  @override ConsumerState<_InvestorPortfolioBody> createState() => __InvestorPortfolioBodyState();
}

class __InvestorPortfolioBodyState extends ConsumerState<_InvestorPortfolioBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(investorPortfolioListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Investor Portfolios…',
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
              : items.where((item) => ((item.userId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.investmentHorizon?.toString() ?? '') + " " + (item.organizationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Investor Portfolios yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(investorPortfolioListProvider),
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
                    subtitle: Text('User Id: ' + item.userId?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(investorPortfolioListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, InvestorPortfolio item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Investor Portfolio Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Target Irr', item.targetIrr?.toString() ?? 'N/A', Icons.numbers),
              _row('Risk Tolerance', item.riskTolerance?.toString() ?? 'N/A', Icons.text_fields),
              _row('Investment Horizon', item.investmentHorizon?.toString() ?? 'N/A', Icons.text_fields),
              _row('Total Invested', item.totalInvested?.toString() ?? 'N/A', Icons.attach_money),
              _row('Current Value', item.currentValue?.toString() ?? 'N/A', Icons.numbers),
              _row('Total Returns', item.totalReturns?.toString() ?? 'N/A', Icons.attach_money),
              _row('Organization Id', item.organizationId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {InvestorPortfolio? item}) {
  showDialog(context: context, builder: (ctx) => _InvestorPortfolioForm(item: item, ref: ref));
}

class _InvestorPortfolioForm extends ConsumerStatefulWidget {
  final InvestorPortfolio? item;
  final WidgetRef ref;
  const _InvestorPortfolioForm({super.key, this.item, required this.ref});
  @override ConsumerState<_InvestorPortfolioForm> createState() => __InvestorPortfolioFormState();
}

class __InvestorPortfolioFormState extends ConsumerState<_InvestorPortfolioForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _name;
  double? _targetIrr;
  String? _riskTolerance;
  String? _investmentHorizon;
  double? _totalInvested;
  double? _currentValue;
  double? _totalReturns;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _targetIrr = widget.item?.targetIrr;
    _riskTolerance = widget.item?.riskTolerance?.toString();
    _investmentHorizon = widget.item?.investmentHorizon?.toString();
    _totalInvested = widget.item?.totalInvested;
    _currentValue = widget.item?.currentValue;
    _totalReturns = widget.item?.totalReturns;
    _organizationId = widget.item?.organizationId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_targetIrr != null) 'targetIrr': _targetIrr,
      if (_riskTolerance?.isNotEmpty == true) 'riskTolerance': _riskTolerance,
      if (_investmentHorizon?.isNotEmpty == true) 'investmentHorizon': _investmentHorizon,
      if (_totalInvested != null) 'totalInvested': _totalInvested,
      if (_currentValue != null) 'currentValue': _currentValue,
      if (_totalReturns != null) 'totalReturns': _totalReturns,
      if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    if (widget.item == null) {
      widget.ref.read(investorPortfolioCreateStateProvider.notifier).state = InvestorPortfolio.fromJson(data);
    } else {
      widget.ref.read(investorPortfolioUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'investorPortfolio': InvestorPortfolio.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Investor Portfolio' : 'New Investor Portfolio'),
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
                    initialValue: widget.item.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Target Irr', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.targetIrr?.toString() ?? '',
                    onSaved: (v) => _targetIrr = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Risk Tolerance', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.riskTolerance?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskTolerance = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Investment Horizon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.investmentHorizon?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _investmentHorizon = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Invested', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.totalInvested?.toString() ?? '',
                    onSaved: (v) => _totalInvested = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Current Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.currentValue?.toString() ?? '',
                    onSaved: (v) => _currentValue = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Total Returns', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.totalReturns?.toString() ?? '',
                    onSaved: (v) => _totalReturns = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.organizationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Investor Portfolio'),
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

void _confirmDel(BuildContext context, WidgetRef ref, InvestorPortfolio item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Investor Portfolio?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(investorPortfolioDeleteStateProvider.notifier).state = item.id;
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
