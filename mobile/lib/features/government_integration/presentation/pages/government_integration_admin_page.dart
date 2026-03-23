import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/government_integration_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// GovernmentIntegration Admin Page  |  16 fields
// Auto-generated — edit with care
// ================================================================

class GovernmentIntegrationAdminPage extends ConsumerWidget {
  const GovernmentIntegrationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(governmentIntegrationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Integration Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(governmentIntegrationListProvider)),
        ],
      ),
      body: const _GovernmentIntegrationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'GovernmentIntegrationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Government Integration'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _GovernmentIntegrationBody extends ConsumerStatefulWidget {
  const _GovernmentIntegrationBody({super.key});
  @override ConsumerState<_GovernmentIntegrationBody> createState() => __GovernmentIntegrationBodyState();
}

class __GovernmentIntegrationBodyState extends ConsumerState<_GovernmentIntegrationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(governmentIntegrationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Government Integrations…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.userId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.baseUrl?.toString() ?? '') + " " + (item.apiKeyCiphertext?.toString() ?? '') + " " + (item.apiSecretCiphertext?.toString() ?? '') + " " + (item.tokenCiphertext?.toString() ?? '') + " " + (item.lastError?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Government Integrations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(governmentIntegrationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.name != null && item.name!.toString().isNotEmpty ? item.name!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.name ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(governmentIntegrationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(GovernmentIntegration item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, GovernmentIntegration item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Government Integration Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Region', item.region?.toString() ?? 'N/A', Icons.text_fields),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Base Url', item.baseUrl?.toString() ?? 'N/A', Icons.link),
              _row('Is Enabled', (item.isEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Api Key Ciphertext', item.apiKeyCiphertext?.toString() ?? 'N/A', Icons.text_fields),
              _row('Api Secret Ciphertext', item.apiSecretCiphertext?.toString() ?? 'N/A', Icons.text_fields),
              _row('Token Ciphertext', item.tokenCiphertext?.toString() ?? 'N/A', Icons.text_fields),
              _row('Last Sync At', _formatDate(item.lastSyncAt), Icons.calendar_today),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Last Error', item.lastError?.toString() ?? 'N/A', Icons.text_fields),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Scopes', item.scopes?.join(', ') ?? 'N/A', Icons.label_outline),
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

void _showForm(BuildContext context, WidgetRef ref, {GovernmentIntegration? item}) {
  showDialog(context: context, builder: (ctx) => _GovernmentIntegrationForm(item: item, ref: ref));
}

class _GovernmentIntegrationForm extends ConsumerStatefulWidget {
  final GovernmentIntegration? item;
  final WidgetRef ref;
  const _GovernmentIntegrationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_GovernmentIntegrationForm> createState() => __GovernmentIntegrationFormState();
}

class __GovernmentIntegrationFormState extends ConsumerState<_GovernmentIntegrationForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _region;
  String? _name;
  String? _baseUrl;
  bool _isEnabled = false;
  String? _apiKeyCiphertext;
  String? _apiSecretCiphertext;
  String? _tokenCiphertext;
  DateTime? _lastSyncAt;
  String? _status;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _region = widget.item?.region?.toString();
    _name = widget.item?.name?.toString();
    _baseUrl = widget.item?.baseUrl?.toString();
    _isEnabled = widget.item?.isEnabled ?? false;
    _apiKeyCiphertext = widget.item?.apiKeyCiphertext?.toString();
    _apiSecretCiphertext = widget.item?.apiSecretCiphertext?.toString();
    _tokenCiphertext = widget.item?.tokenCiphertext?.toString();
    _lastSyncAt = widget.item?.lastSyncAt;
    _status = widget.item?.status?.toString();
    _lastError = widget.item?.lastError?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_region?.isNotEmpty == true) 'region': _region,
      if (_name?.isNotEmpty == true) 'name': _name,
      if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
      'isEnabled': _isEnabled,
      if (_apiKeyCiphertext?.isNotEmpty == true) 'apiKeyCiphertext': _apiKeyCiphertext,
      if (_apiSecretCiphertext?.isNotEmpty == true) 'apiSecretCiphertext': _apiSecretCiphertext,
      if (_tokenCiphertext?.isNotEmpty == true) 'tokenCiphertext': _tokenCiphertext,
      if (_lastSyncAt != null) 'lastSyncAt': _lastSyncAt!.toIso8601String(),
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
    };
    if (widget.item == null) {
      widget.ref.read(governmentIntegrationCreateStateProvider.notifier).state = GovernmentIntegration.fromJson(data);
    } else {
      widget.ref.read(governmentIntegrationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'governmentIntegration': GovernmentIntegration.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Government Integration' : 'New Government Integration'),
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
                    decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.region?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _region = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Base Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.baseUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _baseUrl = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Enabled'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isEnabled ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isEnabled = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Api Key Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.apiKeyCiphertext?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _apiKeyCiphertext = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Api Secret Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.apiSecretCiphertext?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _apiSecretCiphertext = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Token Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.tokenCiphertext?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tokenCiphertext = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastSyncAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastSyncAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Sync At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastSyncAt != null ? _formatDate(_lastSyncAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.lastError?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lastError = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Government Integration'),
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

void _confirmDel(BuildContext context, WidgetRef ref, GovernmentIntegration item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Government Integration?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(governmentIntegrationDeleteStateProvider.notifier).state = item.id;
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
