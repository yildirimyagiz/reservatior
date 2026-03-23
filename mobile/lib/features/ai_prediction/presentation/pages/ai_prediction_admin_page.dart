import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/ai_prediction_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// AIPrediction Admin Page  |  19 fields
// Auto-generated — edit with care
// ================================================================

class AIPredictionAdminPage extends ConsumerWidget {
  const AIPredictionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(aiPredictionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ai Prediction Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(aiPredictionListProvider)),
        ],
      ),
      body: const _AIPredictionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AIPredictionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Ai Prediction'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AIPredictionBody extends ConsumerStatefulWidget {
  const _AIPredictionBody();
  @override ConsumerState<_AIPredictionBody> createState() => __AIPredictionBodyState();
}

class __AIPredictionBodyState extends ConsumerState<_AIPredictionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(aiPredictionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Ai Predictions…',
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
              : items.where((item) => '${item.orgId ?? ''} ${item.modelId ?? ''} ${item.requestId ?? ''} ${item.batchId ?? ''} ${item.modelType ?? ''} ${item.status ?? ''} ${item.errorMessage ?? ''} ${item.userId ?? ''} ${item.propertyId ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Ai Predictions yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(aiPredictionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.modelType != null && item.modelType!.toString().isNotEmpty ? item.modelType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.modelType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ${item.status?.toString() ?? 'N/A'}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(aiPredictionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(AIPrediction item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, AIPrediction item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ai Prediction Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Model Id', item.modelId?.toString() ?? 'N/A', Icons.link),
              _row('Request Id', item.requestId?.toString() ?? 'N/A', Icons.link),
              _row('Batch Id', item.batchId?.toString() ?? 'N/A', Icons.link),
              _row('Model Type', item.modelType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Input Data', item.inputData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Output Data', item.outputData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Result', item.result?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
              _row('Processing Time Ms', item.processingTimeMs?.toString() ?? 'N/A', Icons.numbers),
              _row('Processing Time', item.processingTime?.toString() ?? 'N/A', Icons.numbers),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Success', (item.success == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Error Message', item.errorMessage?.toString() ?? 'N/A', Icons.text_fields),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {AIPrediction? item}) {
  showDialog(context: context, builder: (ctx) => _AIPredictionForm(item: item, ref: ref));
}

class _AIPredictionForm extends ConsumerStatefulWidget {
  final AIPrediction? item;
  final WidgetRef ref;
  const _AIPredictionForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AIPredictionForm> createState() => __AIPredictionFormState();
}

class __AIPredictionFormState extends ConsumerState<_AIPredictionForm> {
  final _key = GlobalKey<FormState>();

  String? _modelId;
  String? _requestId;
  String? _batchId;
  String? _modelType;
  String? _inputData;
  String? _outputData;
  String? _result;
  double? _confidence;
  int? _processingTimeMs;
  int? _processingTime;
  String? _status;
  bool _success = false;
  String? _errorMessage;
  String? _userId;
  String? _propertyId;
  String? _metadata;

  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId?.toString();
    _requestId = widget.item?.requestId?.toString();
    _batchId = widget.item?.batchId?.toString();
    _modelType = widget.item?.modelType?.toString();
    _inputData = widget.item?.inputData?.toString();
    _outputData = widget.item?.outputData?.toString();
    _result = widget.item?.result?.toString();
    _confidence = widget.item?.confidence;
    _processingTimeMs = widget.item?.processingTimeMs;
    _processingTime = widget.item?.processingTime;
    _status = widget.item?.status?.toString();
    _success = widget.item?.success ?? false;
    _errorMessage = widget.item?.errorMessage?.toString();
    _userId = widget.item?.userId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _metadata = widget.item?.metadata?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_modelId?.isNotEmpty == true) 'modelId': _modelId,
      if (_requestId?.isNotEmpty == true) 'requestId': _requestId,
      if (_batchId?.isNotEmpty == true) 'batchId': _batchId,
      if (_modelType?.isNotEmpty == true) 'modelType': _modelType,
      if (_inputData?.isNotEmpty == true) 'inputData': _inputData,
      if (_outputData?.isNotEmpty == true) 'outputData': _outputData,
      if (_result?.isNotEmpty == true) 'result': _result,
      if (_confidence != null) 'confidence': _confidence,
      if (_processingTimeMs != null) 'processingTimeMs': _processingTimeMs,
      if (_processingTime != null) 'processingTime': _processingTime,
      if (_status?.isNotEmpty == true) 'status': _status,
      'success': _success,
      if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
    };
    if (widget.item == null) {
      widget.ref.read(aiPredictionCreateStateProvider.notifier).state = AIPrediction.fromJson(data);
    } else {
      widget.ref.read(aiPredictionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'aiPrediction': AIPrediction.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Ai Prediction' : 'New Ai Prediction'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Model Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.modelId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _modelId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Request Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.requestId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _requestId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Batch Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.batchId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _batchId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Model Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.modelType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _modelType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Input Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.inputData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _inputData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Output Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.outputData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _outputData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Result', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.result?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _result = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.confidence?.toString() ?? '',
                    onSaved: (v) => _confidence = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Processing Time Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.processingTimeMs?.toString() ?? '',
                    onSaved: (v) => _processingTimeMs = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Processing Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.processingTime?.toString() ?? '',
                    onSaved: (v) => _processingTime = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Success'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.success ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _success = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Error Message', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.errorMessage?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metadata', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Ai Prediction'),
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

void _confirmDel(BuildContext context, WidgetRef ref, AIPrediction item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Ai Prediction?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(aiPredictionDeleteStateProvider.notifier).state = item.id;
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
