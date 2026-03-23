import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_investment_analysis_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIInvestmentAnalysis Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class AIInvestmentAnalysisAdminPage extends ConsumerWidget {
  const AIInvestmentAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiInvestmentAnalysisLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Investment Analysis Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiInvestmentAnalysisListProvider)),
        ],
      ),
      body: const _AIInvestmentAnalysisBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIInvestmentAnalysisFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Investment Analysis'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIInvestmentAnalysisBody extends ConsumerStatefulWidget {
  const _AIInvestmentAnalysisBody();
  @override ConsumerState<_AIInvestmentAnalysisBody> createState() => __AIInvestmentAnalysisBodyState();
}

class __AIInvestmentAnalysisBodyState extends ConsumerState<_AIInvestmentAnalysisBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiInvestmentAnalysisListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Investment Analysiss…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.analysisType?.toString() ?? '') + " " + (item.timeHorizon?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Investment Analysiss yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiInvestmentAnalysisListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.analysisType != null && item.analysisType!.toString().isNotEmpty ? item.analysisType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.analysisType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiInvestmentAnalysisListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIInvestmentAnalysis item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Investment Analysis Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Time Horizon', item.timeHorizon?.toString() ?? 'N/A', Icons.text_fields),
              _row('Projected Returns', item.projectedReturns?.toString() ?? 'N/A', Icons.text_fields),
              _row('Cash Flow Projection', item.cashFlowProjection?.toString() ?? 'N/A', Icons.text_fields),
              _row('Risk Metrics', item.riskMetrics?.toString() ?? 'N/A', Icons.text_fields),
              _row('Key Assumptions', item.keyAssumptions?.toString() ?? 'N/A', Icons.text_fields),
              _row('Sensitivity Analysis', item.sensitivityAnalysis?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Generated At', _formatDate(item.generatedAt), Icons.attach_money),
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

void _showForm(BuildContext context, WidgetRef ref, {AIInvestmentAnalysis? item}) {
  showDialog(context: context, builder: (ctx) => _AIInvestmentAnalysisForm(item: item, ref: ref));
}

class _AIInvestmentAnalysisForm extends ConsumerStatefulWidget {
  final AIInvestmentAnalysis? item;
  final WidgetRef ref;
  const _AIInvestmentAnalysisForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIInvestmentAnalysisForm> createState() => __AIInvestmentAnalysisFormState();
}

class __AIInvestmentAnalysisFormState extends ConsumerState<_AIInvestmentAnalysisForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _analysisType;
  String? _timeHorizon;
  String? _projectedReturns;
  String? _cashFlowProjection;
  String? _riskMetrics;
  String? _keyAssumptions;
  String? _sensitivityAnalysis;
  double? _confidence;
  DateTime? _generatedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _timeHorizon = widget.item?.timeHorizon?.toString();
    _projectedReturns = widget.item?.projectedReturns?.toString();
    _cashFlowProjection = widget.item?.cashFlowProjection?.toString();
    _riskMetrics = widget.item?.riskMetrics?.toString();
    _keyAssumptions = widget.item?.keyAssumptions?.toString();
    _sensitivityAnalysis = widget.item?.sensitivityAnalysis?.toString();
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
      if (_timeHorizon?.isNotEmpty == true) 'timeHorizon': _timeHorizon,
      if (_projectedReturns?.isNotEmpty == true) 'projectedReturns': _projectedReturns,
      if (_cashFlowProjection?.isNotEmpty == true) 'cashFlowProjection': _cashFlowProjection,
      if (_riskMetrics?.isNotEmpty == true) 'riskMetrics': _riskMetrics,
      if (_keyAssumptions?.isNotEmpty == true) 'keyAssumptions': _keyAssumptions,
      if (_sensitivityAnalysis?.isNotEmpty == true) 'sensitivityAnalysis': _sensitivityAnalysis,
      if (_confidence != null) 'confidence': _confidence,
      if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(aiInvestmentAnalysisCreateStateProvider.notifier).state = AIInvestmentAnalysis.fromJson(data);
    } else {
      widget.ref.read(aiInvestmentAnalysisUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiInvestmentAnalysis': AIInvestmentAnalysis.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Investment Analysis' : 'New Ai Investment Analysis'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.analysisType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Time Horizon', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.timeHorizon?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _timeHorizon = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Projected Returns', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.projectedReturns?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _projectedReturns = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Cash Flow Projection', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.cashFlowProjection?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _cashFlowProjection = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Risk Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskMetrics?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskMetrics = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Key Assumptions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.keyAssumptions?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _keyAssumptions = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sensitivity Analysis', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.sensitivityAnalysis?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sensitivityAnalysis = v?.isEmpty == true ? null : v,
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
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Investment Analysis'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIInvestmentAnalysis item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Investment Analysis?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiInvestmentAnalysisDeleteStateProvider.notifier).state = item.id;
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
