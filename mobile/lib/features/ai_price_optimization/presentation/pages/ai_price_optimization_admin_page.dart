import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_price_optimization_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIPriceOptimization Admin Page  |  14 fields
// Auto-generated — edit with care
// ================================================================

class AIPriceOptimizationAdminPage extends ConsumerWidget {
  const AIPriceOptimizationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiPriceOptimizationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Price Optimization Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiPriceOptimizationListProvider)),
        ],
      ),
      body: const _AIPriceOptimizationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIPriceOptimizationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Price Optimization'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIPriceOptimizationBody extends ConsumerStatefulWidget {
  const _AIPriceOptimizationBody();
  @override ConsumerState<_AIPriceOptimizationBody> createState() => __AIPriceOptimizationBodyState();
}

class __AIPriceOptimizationBodyState extends ConsumerState<_AIPriceOptimizationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiPriceOptimizationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Price Optimizations…',
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
              : items.where((AIPriceOptimization item) {
                  final searchText = [
                    item.orgId ?? '',
                    item.listingId ?? '',
                    item.currentPrice ?? '',
                    item.recommendedPrice ?? '',
                    '',
                  ].join(' ');
                  return searchText.toLowerCase().contains(_q);
                }).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Price Optimizations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiPriceOptimizationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.orgId != null && item.orgId!.toString().isNotEmpty ? item.orgId!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.orgId ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiPriceOptimizationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIPriceOptimization item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Price Optimization Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
              _row('Current Price', item.currentPrice?.toString() ?? 'N/A', Icons.attach_money),
              _row('Recommended Price', item.recommendedPrice?.toString() ?? 'N/A', Icons.attach_money),
              _row('Price Range', item.priceRange?.toString() ?? 'N/A', Icons.attach_money),
              _row('Factors', item.factors?.toString() ?? 'N/A', Icons.text_fields),
              _row('Comparable Data', item.comparableData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Market Trends', item.marketTrends?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Generated At', _formatDate(item.generatedAt), Icons.attach_money),
              _row('Is Applied', (item.isApplied == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Applied At', _formatDate(item.appliedAt), Icons.calendar_today),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {AIPriceOptimization? item}) {
  showDialog(context: context, builder: (ctx) => _AIPriceOptimizationForm(item: item, ref: ref));
}

class _AIPriceOptimizationForm extends ConsumerStatefulWidget {
  final AIPriceOptimization? item;
  final WidgetRef ref;
  const _AIPriceOptimizationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIPriceOptimizationForm> createState() => __AIPriceOptimizationFormState();
}

class __AIPriceOptimizationFormState extends ConsumerState<_AIPriceOptimizationForm> {
  final _key = GlobalKey<FormState>();

  String? _listingId;
  double? _currentPrice;
  double? _recommendedPrice;
  String? _priceRange;
  String? _factors;
  String? _comparableData;
  String? _marketTrends;
  double? _confidence;
  DateTime? _generatedAt;
  bool _isApplied = false;
  DateTime? _appliedAt;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _currentPrice = widget.item?.currentPrice;
    _recommendedPrice = widget.item?.recommendedPrice;
    _priceRange = widget.item?.priceRange?.toString();
    _factors = widget.item?.factors?.toString();
    _comparableData = widget.item?.comparableData?.toString();
    _marketTrends = widget.item?.marketTrends?.toString();
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
    _isApplied = widget.item?.isApplied ?? false;
    _appliedAt = widget.item?.appliedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_currentPrice != null) 'currentPrice': _currentPrice,
      if (_recommendedPrice != null) 'recommendedPrice': _recommendedPrice,
      if (_priceRange?.isNotEmpty == true) 'priceRange': _priceRange,
      if (_factors?.isNotEmpty == true) 'factors': _factors,
      if (_comparableData?.isNotEmpty == true) 'comparableData': _comparableData,
      if (_marketTrends?.isNotEmpty == true) 'marketTrends': _marketTrends,
      if (_confidence != null) 'confidence': _confidence,
      if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
      'isApplied': _isApplied,
      if (_appliedAt != null) 'appliedAt': _appliedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(aiPriceOptimizationCreateStateProvider.notifier).state = AIPriceOptimization.fromJson(data);
    } else {
      widget.ref.read(aiPriceOptimizationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiPriceOptimization': AIPriceOptimization.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Price Optimization' : 'New Ai Price Optimization'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Current Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.currentPrice?.toString() ?? '',
                    onSaved: (v) => _currentPrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Recommended Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.recommendedPrice?.toString() ?? '',
                    onSaved: (v) => _recommendedPrice = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price Range', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    initialValue: widget.item?.priceRange?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _priceRange = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.factors?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _factors = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Comparable Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.comparableData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _comparableData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Market Trends', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.marketTrends?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _marketTrends = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
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
                      title: Text('Is Applied'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isApplied ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isApplied = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _appliedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _appliedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Applied At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_appliedAt != null ? _formatDate(_appliedAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Price Optimization'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIPriceOptimization item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Price Optimization?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiPriceOptimizationDeleteStateProvider.notifier).state = item.id;
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
