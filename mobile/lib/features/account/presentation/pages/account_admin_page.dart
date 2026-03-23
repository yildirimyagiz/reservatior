import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/account_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Account Admin Page  |  15 fields
// Auto-generated — edit with care
// ================================================================

class AccountAdminPage extends ConsumerWidget {
  const AccountAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(AccountLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(accountProvider)),
        ],
      ),
      body: const _AccountBody(key: Key('body')),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'AccountFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Account'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _AccountBody extends ConsumerStatefulWidget {
  const _AccountBody({required super.key});
  @override ConsumerState<_AccountBody> createState() => __AccountBodyState();
}

class __AccountBodyState extends ConsumerState<_AccountBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(accountProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Accounts…',
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
              : items.where((item) => '${item.userId ?? ''} ${item.providerId ?? ''} ${item.accountId ?? ''} ${item.refreshToken ?? ''} ${item.accessToken ?? ''} ${item.tokenType ?? ''} ${item.scope ?? ''} ${item.idToken ?? ''} ${item.sessionState ?? ''}'.toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Accounts yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(accountProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ${_formatDate(item.createdAt)}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(accountProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Account item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Provider Id', item.providerId?.toString() ?? 'N/A', Icons.link),
              _row('Account Id', item.accountId?.toString() ?? 'N/A', Icons.link),
              _row('Refresh Token', item.refreshToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('Access Token', item.accessToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('Access Token Expires At', _formatDate(item.accessTokenExpiresAt), Icons.calendar_today),
              _row('Token Type', item.tokenType?.toString() ?? 'N/A', Icons.text_fields),
              _row('Scope', item.scope?.toString() ?? 'N/A', Icons.text_fields),
              _row('Id Token', item.idToken?.toString() ?? 'N/A', Icons.text_fields),
              _row('Session State', item.sessionState?.toString() ?? 'N/A', Icons.text_fields),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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

void _showForm(BuildContext context, WidgetRef ref, {Account? item}) {
  showDialog(context: context, builder: (ctx) => _AccountForm(item: item, ref: ref));
}

class _AccountForm extends ConsumerStatefulWidget {
  final Account? item;
  final WidgetRef ref;
  const _AccountForm({super.key, this.item, required this.ref});
  @override ConsumerState<_AccountForm> createState() => __AccountFormState();
}

class __AccountFormState extends ConsumerState<_AccountForm> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _type;
  String? _providerId;
  String? _accountId;
  String? _refreshToken;
  String? _accessToken;
  DateTime? _accessTokenExpiresAt;
  String? _tokenType;
  String? _scope;
  String? _idToken;
  String? _sessionState;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _type = widget.item?.type?.toString();
    _providerId = widget.item?.providerId?.toString();
    _accountId = widget.item?.accountId?.toString();
    _refreshToken = widget.item?.refreshToken?.toString();
    _accessToken = widget.item?.accessToken?.toString();
    _accessTokenExpiresAt = widget.item?.accessTokenExpiresAt;
    _tokenType = widget.item?.tokenType?.toString();
    _scope = widget.item?.scope?.toString();
    _idToken = widget.item?.idToken?.toString();
    _sessionState = widget.item?.sessionState?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_userId?.isNotEmpty == true) 'userId': _userId,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_providerId?.isNotEmpty == true) 'providerId': _providerId,
      if (_accountId?.isNotEmpty == true) 'accountId': _accountId,
      if (_refreshToken?.isNotEmpty == true) 'refreshToken': _refreshToken,
      if (_accessToken?.isNotEmpty == true) 'accessToken': _accessToken,
      if (_accessTokenExpiresAt != null) 'accessTokenExpiresAt': _accessTokenExpiresAt!.toIso8601String(),
      if (_tokenType?.isNotEmpty == true) 'tokenType': _tokenType,
      if (_scope?.isNotEmpty == true) 'scope': _scope,
      if (_idToken?.isNotEmpty == true) 'idToken': _idToken,
      if (_sessionState?.isNotEmpty == true) 'sessionState': _sessionState,
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(AccountCreateStateProvider.notifier).state = Account.fromJson(data);
    } else {
      widget.ref.read(AccountUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'account': Account.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Account' : 'New Account'),
            automaticallyImplyLeading: false,
            actions: [const IconButton(icon: Icon(Icons.close), key: Key('close-dialog'), onPressed: null)],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.userId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Provider Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.providerId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _providerId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Account Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                    initialValue: widget.item?.accountId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _accountId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Refresh Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.refreshToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _refreshToken = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Access Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.accessToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _accessToken = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _accessTokenExpiresAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _accessTokenExpiresAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Access Token Expires At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_accessTokenExpiresAt != null ? _formatDate(_accessTokenExpiresAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Token Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.tokenType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tokenType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Scope', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.scope?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _scope = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Id Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.idToken?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _idToken = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Session State', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                    initialValue: widget.item?.sessionState?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sessionState = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: const Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item?.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Account'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Account item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Account?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(AccountDeleteStateProvider.notifier).state = item.id;
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
