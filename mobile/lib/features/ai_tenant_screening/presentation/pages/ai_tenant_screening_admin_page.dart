import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_tenant_screening_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AITenantScreening Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class AITenantScreeningAdminPage extends ConsumerWidget {
  const AITenantScreeningAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiTenantScreeningLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Tenant Screening Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiTenantScreeningListProvider)),
        ],
      ),
      body: const _AITenantScreeningBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AITenantScreeningFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Tenant Screening'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AITenantScreeningBody extends ConsumerStatefulWidget {
  const _AITenantScreeningBody();
  @override ConsumerState<_AITenantScreeningBody> createState() => __AITenantScreeningBodyState();
}

class __AITenantScreeningBodyState extends ConsumerState<_AITenantScreeningBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiTenantScreeningListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Tenant Screenings…',
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
              : items.where((item) => '${item.orgId ?? ''} ${item.applicationId ?? ''} ${item.riskAssessment ?? ''} ${item.reviewedBy ?? ''} ${item.finalDecision ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Tenant Screenings yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiTenantScreeningListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.riskAssessment != null && item.riskAssessment!.isNotEmpty ? item.riskAssessment![0].toUpperCase() : '?'),),
                    title: Text(item.riskAssessment ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Score: ${item.overallScore?.toString() ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiTenantScreeningListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AITenantScreening item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Tenant Screening Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Application Id', item.applicationId?.toString() ?? 'N/A', Icons.link),
              _row('Overall Score', item.overallScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Risk Assessment', item.riskAssessment?.toString() ?? 'N/A', Icons.text_fields),
              _row('Credit Score', item.creditScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Income Stability', item.incomeStability?.toString() ?? 'N/A', Icons.numbers),
              _row('Rental History', item.rentalHistory?.toString() ?? 'N/A', Icons.numbers),
              _row('Background Check', item.backgroundCheck?.toString() ?? 'N/A', Icons.numbers),
              _row('Risk Factors', item.riskFactors?.toString() ?? 'N/A', Icons.text_fields),
              _row('Recommendations', item.recommendations?.toString() ?? 'N/A', Icons.text_fields),
              _row('Screened At', _formatDate(item.screenedAt), Icons.calendar_today),
              _row('Reviewed By', item.reviewedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Final Decision', item.finalDecision?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {AITenantScreening? item}) {
  showDialog(context: context, builder: (ctx) => _AITenantScreeningForm(item: item, ref: ref));
}

class _AITenantScreeningForm extends ConsumerStatefulWidget {
  final AITenantScreening? item;
  final WidgetRef ref;
  const _AITenantScreeningForm({this.item, required this.ref});
  @override ConsumerState<_AITenantScreeningForm> createState() => __AITenantScreeningFormState();
}

class __AITenantScreeningFormState extends ConsumerState<_AITenantScreeningForm> {
  final _key = GlobalKey<FormState>();

  String? _applicationId;
  double? _overallScore;
  String? _riskAssessment;
  double? _creditScore;
  double? _incomeStability;
  double? _rentalHistory;
  double? _backgroundCheck;
  String? _riskFactors;
  String? _recommendations;
  DateTime? _screenedAt;
  String? _reviewedBy;
  String? _finalDecision;

  @override
  void initState() {
    super.initState();
    _applicationId = widget.item?.applicationId?.toString();
    _overallScore = widget.item?.overallScore;
    _riskAssessment = widget.item?.riskAssessment?.toString();
    _creditScore = widget.item?.creditScore;
    _incomeStability = widget.item?.incomeStability;
    _rentalHistory = widget.item?.rentalHistory;
    _backgroundCheck = widget.item?.backgroundCheck;
    _riskFactors = widget.item?.riskFactors?.toString();
    _recommendations = widget.item?.recommendations?.toString();
    _screenedAt = widget.item?.screenedAt;
    _reviewedBy = widget.item?.reviewedBy?.toString();
    _finalDecision = widget.item?.finalDecision?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_applicationId?.isNotEmpty == true) 'applicationId': _applicationId,
      if (_overallScore != null) 'overallScore': _overallScore,
      if (_riskAssessment?.isNotEmpty == true) 'riskAssessment': _riskAssessment,
      if (_creditScore != null) 'creditScore': _creditScore,
      if (_incomeStability != null) 'incomeStability': _incomeStability,
      if (_rentalHistory != null) 'rentalHistory': _rentalHistory,
      if (_backgroundCheck != null) 'backgroundCheck': _backgroundCheck,
      if (_riskFactors?.isNotEmpty == true) 'riskFactors': _riskFactors,
      if (_recommendations?.isNotEmpty == true) 'recommendations': _recommendations,
      if (_screenedAt != null) 'screenedAt': _screenedAt!.toIso8601String(),
      if (_reviewedBy?.isNotEmpty == true) 'reviewedBy': _reviewedBy,
      if (_finalDecision?.isNotEmpty == true) 'finalDecision': _finalDecision,
    };
    if (widget.item == null) {
      widget.ref.read(aiTenantScreeningCreateStateProvider.notifier).state = AITenantScreening.fromJson(data);
    } else {
      widget.ref.read(aiTenantScreeningUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiTenantScreening': AITenantScreening.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Tenant Screening' : 'New Ai Tenant Screening'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Application Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.applicationId ?? '',
                    maxLines: 1,
                    onSaved: (v) => _applicationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Overall Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.overallScore?.toString() ?? '',
                    onSaved: (v) => _overallScore = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Risk Assessment', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskAssessment ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskAssessment = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Credit Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.creditScore?.toString() ?? '',
                    onSaved: (v) => _creditScore = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Income Stability', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.incomeStability?.toString() ?? '',
                    onSaved: (v) => _incomeStability = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Rental History', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.rentalHistory?.toString() ?? '',
                    onSaved: (v) => _rentalHistory = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Background Check', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.backgroundCheck?.toString() ?? '',
                    onSaved: (v) => _backgroundCheck = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Risk Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.riskFactors ?? '',
                    maxLines: 1,
                    onSaved: (v) => _riskFactors = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Recommendations', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.recommendations ?? '',
                    maxLines: 1,
                    onSaved: (v) => _recommendations = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _screenedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _screenedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Screened At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_screenedAt != null ? _formatDate(_screenedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Reviewed By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.reviewedBy ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reviewedBy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Final Decision', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.finalDecision ?? '',
                    maxLines: 1,
                    onSaved: (v) => _finalDecision = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Tenant Screening'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AITenantScreening item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Tenant Screening?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiTenantScreeningDeleteStateProvider.notifier).state = item.id;
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
