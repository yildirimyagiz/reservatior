import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/integration_log_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// IntegrationLog Admin Page  |  13 fields
// Auto-generated — edit with care
// ================================================================

class IntegrationLogAdminPage extends ConsumerWidget {
  const IntegrationLogAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(integrationLogLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integration Log Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(integrationLogListProvider)),
        ],
      ),
      body: const _IntegrationLogBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'IntegrationLogFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Integration Log'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _IntegrationLogBody extends ConsumerStatefulWidget {
  const _IntegrationLogBody({super.key});
  @override ConsumerState<_IntegrationLogBody> createState() => __IntegrationLogBodyState();
}

class __IntegrationLogBodyState extends ConsumerState<_IntegrationLogBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(integrationLogListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Integration Logs…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.integrationType?.toString() ?? '') + " " + (item.operation?.toString() ?? '') + " " + (item.errorMessage?.toString() ?? '') + " " + (item.externalId?.toString() ?? '') + " " + (item.correlationId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Integration Logs yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(integrationLogListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.integrationType != null && item.integrationType!.toString().isNotEmpty ? item.integrationType!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.integrationType ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.statusCode != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.statusCode!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(integrationLogListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(IntegrationLog item) {
    final s = item.statusCode?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, IntegrationLog item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Integration Log Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Integration Type', item.integrationType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Operation', item.operation?.toString() ?? 'N/A', Icons.text_fields),
              _row('Request Data', item.requestData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Response Data', item.responseData?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status Code', item.statusCode?.toString() ?? 'N/A', Icons.info_outline),
              _row('Success', (item.success == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Error Message', item.errorMessage?.toString() ?? 'N/A', Icons.text_fields),
              _row('Processing Time Ms', item.processingTimeMs?.toString() ?? 'N/A', Icons.numbers),
              _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
              _row('Correlation Id', item.correlationId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {IntegrationLog? item}) {
  showDialog(context: context, builder: (ctx) => _IntegrationLogForm(item: item, ref: ref));
}

class _IntegrationLogForm extends ConsumerStatefulWidget {
  final IntegrationLog? item;
  final WidgetRef ref;
  const _IntegrationLogForm({super.key, this.item, required this.ref});
  @override ConsumerState<_IntegrationLogForm> createState() => __IntegrationLogFormState();
}

class __IntegrationLogFormState extends ConsumerState<_IntegrationLogForm> {
  final _key = GlobalKey<FormState>();

  String? _integrationType;
  String? _operation;
  String? _requestData;
  String? _responseData;
  int? _statusCode;
  bool _success = false;
  String? _errorMessage;
  int? _processingTimeMs;
  String? _externalId;
  String? _correlationId;

  @override
  void initState() {
    super.initState();
    _integrationType = widget.item?.integrationType?.toString();
    _operation = widget.item?.operation?.toString();
    _requestData = widget.item?.requestData?.toString();
    _responseData = widget.item?.responseData?.toString();
    _statusCode = widget.item?.statusCode;
    _success = widget.item?.success ?? false;
    _errorMessage = widget.item?.errorMessage?.toString();
    _processingTimeMs = widget.item?.processingTimeMs;
    _externalId = widget.item?.externalId?.toString();
    _correlationId = widget.item?.correlationId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_integrationType?.isNotEmpty == true) 'integrationType': _integrationType,
      if (_operation?.isNotEmpty == true) 'operation': _operation,
      if (_requestData?.isNotEmpty == true) 'requestData': _requestData,
      if (_responseData?.isNotEmpty == true) 'responseData': _responseData,
      if (_statusCode != null) 'statusCode': _statusCode,
      'success': _success,
      if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
      if (_processingTimeMs != null) 'processingTimeMs': _processingTimeMs,
      if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
      if (_correlationId?.isNotEmpty == true) 'correlationId': _correlationId,
    };
    if (widget.item == null) {
      widget.ref.read(integrationLogCreateStateProvider.notifier).state = IntegrationLog.fromJson(data);
    } else {
      widget.ref.read(integrationLogUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'integrationLog': IntegrationLog.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Integration Log' : 'New Integration Log'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Integration Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.integrationType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _integrationType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Operation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.operation?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _operation = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Request Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.requestData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _requestData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Response Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.responseData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _responseData = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Status Code', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.statusCode?.toString() ?? '',
                    onSaved: (v) => _statusCode = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Success'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.success ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _success = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Error Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.errorMessage?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Processing Time Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.processingTimeMs?.toString() ?? '',
                    onSaved: (v) => _processingTimeMs = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.externalId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Correlation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.correlationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _correlationId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Integration Log'),
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

void _confirmDel(BuildContext context, WidgetRef ref, IntegrationLog item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Integration Log?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(integrationLogDeleteStateProvider.notifier).state = item.id;
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
