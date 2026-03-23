import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/api_integration_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ApiIntegration Admin Page  |  22 fields
// Auto-generated — edit with care
// ================================================================

class ApiIntegrationAdminPage extends ConsumerWidget {
  const ApiIntegrationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(apiIntegrationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Integration Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(apiIntegrationListProvider)),
        ],
      ),
      body: const _ApiIntegrationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ApiIntegrationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Api Integration'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ApiIntegrationBody extends ConsumerStatefulWidget {
  const _ApiIntegrationBody({super.key});
  @override ConsumerState<_ApiIntegrationBody> createState() => __ApiIntegrationBodyState();
}

class __ApiIntegrationBodyState extends ConsumerState<_ApiIntegrationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(apiIntegrationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Api Integrations…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.name?.toString() ?? '') + " " + (item.apiKey?.toString() ?? '') + " " + (item.apiSecret?.toString() ?? '') + " " + (item.accessToken?.toString() ?? '') + " " + (item.refreshToken?.toString() ?? '') + " " + (item.baseUrl?.toString() ?? '') + " " + (item.lastError?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Api Integrations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(apiIntegrationListProvider),
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
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.lastSyncStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.lastSyncStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(apiIntegrationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(ApiIntegration item) {
    final s = item.lastSyncStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ApiIntegration item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Api Integration Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Platform', item.platform?.toString() ?? 'N/A', Icons.text_fields),
              _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
              _row('Is Enabled', (item.isEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Api Key', item.apiKey?.toString() ?? 'N/A', Icons.text_fields),
              _row('Api Secret', item.apiSecret?.toString() ?? 'N/A', Icons.text_fields),
              _row('Access Token', item.accessToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('Refresh Token', item.refreshToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('Token Expiry', _formatDate(item.tokenExpiry), Icons.calendar_today),
              _row('Base Url', item.baseUrl?.toString() ?? 'N/A', Icons.link),
              _row('Config', item.config?.toString() ?? 'N/A', Icons.text_fields),
              _row('Rate Limit', item.rateLimit?.toString() ?? 'N/A', Icons.attach_money),
              _row('Sync Direction', item.syncDirection?.toString() ?? 'N/A', Icons.text_fields),
              _row('Auto Sync', (item.autoSync == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Sync Interval', item.syncInterval?.toString() ?? 'N/A', Icons.numbers),
              _row('Last Sync At', _formatDate(item.lastSyncAt), Icons.calendar_today),
              _row('Last Sync Status', item.lastSyncStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Last Error', item.lastError?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {ApiIntegration? item}) {
  showDialog(context: context, builder: (ctx) => _ApiIntegrationForm(item: item, ref: ref));
}

class _ApiIntegrationForm extends ConsumerStatefulWidget {
  final ApiIntegration? item;
  final WidgetRef ref;
  const _ApiIntegrationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ApiIntegrationForm> createState() => __ApiIntegrationFormState();
}

class __ApiIntegrationFormState extends ConsumerState<_ApiIntegrationForm> {
  final _key = GlobalKey<FormState>();

  String? _platform;
  String? _name;
  bool _isEnabled = false;
  String? _apiKey;
  String? _apiSecret;
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  String? _baseUrl;
  String? _config;
  int? _rateLimit;
  String? _syncDirection;
  bool _autoSync = false;
  int? _syncInterval;
  DateTime? _lastSyncAt;
  String? _lastSyncStatus;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _platform = widget.item?.platform?.toString();
    _name = widget.item?.name?.toString();
    _isEnabled = widget.item?.isEnabled ?? false;
    _apiKey = widget.item?.apiKey?.toString();
    _apiSecret = widget.item?.apiSecret?.toString();
    _accessToken = widget.item?.accessToken?.toString();
    _refreshToken = widget.item?.refreshToken?.toString();
    _tokenExpiry = widget.item?.tokenExpiry;
    _baseUrl = widget.item?.baseUrl?.toString();
    _config = widget.item?.config?.toString();
    _rateLimit = widget.item?.rateLimit;
    _syncDirection = widget.item?.syncDirection?.toString();
    _autoSync = widget.item?.autoSync ?? false;
    _syncInterval = widget.item?.syncInterval;
    _lastSyncAt = widget.item?.lastSyncAt;
    _lastSyncStatus = widget.item?.lastSyncStatus?.toString();
    _lastError = widget.item?.lastError?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_platform?.isNotEmpty == true) 'platform': _platform,
      if (_name?.isNotEmpty == true) 'name': _name,
      'isEnabled': _isEnabled,
      if (_apiKey?.isNotEmpty == true) 'apiKey': _apiKey,
      if (_apiSecret?.isNotEmpty == true) 'apiSecret': _apiSecret,
      if (_accessToken?.isNotEmpty == true) 'accessToken': _accessToken,
      if (_refreshToken?.isNotEmpty == true) 'refreshToken': _refreshToken,
      if (_tokenExpiry != null) 'tokenExpiry': _tokenExpiry!.toIso8601String(),
      if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
      if (_config?.isNotEmpty == true) 'config': _config,
      if (_rateLimit != null) 'rateLimit': _rateLimit,
      if (_syncDirection?.isNotEmpty == true) 'syncDirection': _syncDirection,
      'autoSync': _autoSync,
      if (_syncInterval != null) 'syncInterval': _syncInterval,
      if (_lastSyncAt != null) 'lastSyncAt': _lastSyncAt!.toIso8601String(),
      if (_lastSyncStatus?.isNotEmpty == true) 'lastSyncStatus': _lastSyncStatus,
      if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
    };
    if (widget.item == null) {
      widget.ref.read(apiIntegrationCreateStateProvider.notifier).state = ApiIntegration.fromJson(data);
    } else {
      widget.ref.read(apiIntegrationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'apiIntegration': ApiIntegration.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Api Integration' : 'New Api Integration'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.platform?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item?.name?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _name = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Enabled'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isEnabled ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isEnabled = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Api Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.apiKey?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _apiKey = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Api Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.apiSecret?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _apiSecret = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Access Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.accessToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _accessToken = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Refresh Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.refreshToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _refreshToken = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _tokenExpiry ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _tokenExpiry = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Token Expiry',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_tokenExpiry != null ? _formatDate(_tokenExpiry) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Base Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.baseUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _baseUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.config?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _config = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Rate Limit', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.rateLimit?.toString() ?? '',
                    onSaved: (v) => _rateLimit = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sync Direction', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.syncDirection?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _syncDirection = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Auto Sync'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.autoSync ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _autoSync = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Sync Interval', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item?.syncInterval?.toString() ?? '',
                    onSaved: (v) => _syncInterval = int.tryParse(v ?? ''),
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
                    decoration: InputDecoration(labelText: 'Last Sync Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.lastSyncStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lastSyncStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.lastError?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _lastError = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Api Integration'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ApiIntegration item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Api Integration?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(apiIntegrationDeleteStateProvider.notifier).state = item.id;
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
