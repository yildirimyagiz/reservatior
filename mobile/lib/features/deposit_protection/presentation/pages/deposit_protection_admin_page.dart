import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/deposit_protection_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// DepositProtection Admin Page  |  10 fields
// Auto-generated — edit with care
// ================================================================

class DepositProtectionAdminPage extends ConsumerWidget {
  const DepositProtectionAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(deposit_protectionLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit_protection Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(deposit_protectionListProvider)),
        ],
      ),
      body: const _DepositProtectionBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'DepositProtectionFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Deposit_protection'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _DepositProtectionBody extends ConsumerStatefulWidget {
  const _DepositProtectionBody({super.key});
  @override ConsumerState<_DepositProtectionBody> createState() => __DepositProtectionBodyState();
}

class __DepositProtectionBodyState extends ConsumerState<_DepositProtectionBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(deposit_protectionListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Deposit_protections…',
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
              : items.where((item) => ((item.leaseId?.toString() ?? '') + " " + (item.provider?.toString() ?? '') + " " + (item.scheme?.toString() ?? '') + " " + (item.reference?.toString() ?? '') + " " + (item.currency?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "\$_q"' : 'No Deposit_protections yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(deposit_protectionListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(child: Text(item.leaseId != null && item.leaseId!.toString().isNotEmpty ? item.leaseId!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.leaseId?.toString() ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Type: ' + (item.scheme?.toString() ?? 'N/A')),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(deposit_protectionListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, DepositProtection item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Deposit_protection Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Claimed At', _formatDate(item.claimedAt), Icons.calendar_today),
              _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
              _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
              _row('Protected At', _formatDate(item.protectedAt), Icons.calendar_today),
              _row('Provider', item.provider?.toString() ?? 'N/A', Icons.link),
              _row('Reference', item.reference?.toString() ?? 'N/A', Icons.text_fields),
              _row('Returned At', _formatDate(item.returnedAt), Icons.calendar_today),
              _row('Scheme', item.scheme?.toString() ?? 'N/A', Icons.text_fields),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
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

void _showForm(BuildContext context, WidgetRef ref, {DepositProtection? item}) {
  showDialog(context: context, builder: (ctx) => _DepositProtectionForm(item: item, ref: ref));
}

class _DepositProtectionForm extends ConsumerStatefulWidget {
  final DepositProtection? item;
  final WidgetRef ref;
  const _DepositProtectionForm({super.key, this.item, required this.ref});
  @override ConsumerState<_DepositProtectionForm> createState() => __DepositProtectionFormState();
}

class __DepositProtectionFormState extends ConsumerState<_DepositProtectionForm> {
  final _key = GlobalKey<FormState>();

  double? _amount;
  DateTime? _claimedAt;
  String? _currency;
  String? _leaseId;
  DateTime? _protectedAt;
  String? _provider;
  String? _reference;
  DateTime? _returnedAt;
  String? _scheme;
  String? _status;

  @override
  void initState() {
    super.initState();
    _amount = widget.item?.amount;
    _claimedAt = widget.item?.claimedAt;
    _currency = widget.item?.currency?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _protectedAt = widget.item?.protectedAt;
    _provider = widget.item?.provider?.toString();
    _reference = widget.item?.reference?.toString();
    _returnedAt = widget.item?.returnedAt;
    _scheme = widget.item?.scheme?.toString();
    _status = widget.item?.status?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_amount != null) 'amount': _amount,
      if (_claimedAt != null) 'claimedAt': _claimedAt!.toIso8601String(),
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_protectedAt != null) 'protectedAt': _protectedAt!.toIso8601String(),
      if (_provider?.isNotEmpty == true) 'provider': _provider,
      if (_reference?.isNotEmpty == true) 'reference': _reference,
      if (_returnedAt != null) 'returnedAt': _returnedAt!.toIso8601String(),
      if (_scheme?.isNotEmpty == true) 'scheme': _scheme,
      if (_status?.isNotEmpty == true) 'status': _status,
    };
    if (widget.item == null) {
      widget.ref.read(deposit_protectionCreateStateProvider.notifier).state = DepositProtection.fromJson(data);
    } else {
      widget.ref.read(deposit_protectionUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'deposit_protection': DepositProtection.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Deposit_protection' : 'New Deposit_protection'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.amount?.toString() ?? '',
                    onSaved: (v) => _amount = double.tryParse(v ?? ''),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _claimedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _claimedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Claimed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_claimedAt != null ? _formatDate(_claimedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _protectedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _protectedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Protected At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_protectedAt != null ? _formatDate(_protectedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.provider?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reference?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reference = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _returnedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _returnedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Returned At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_returnedAt != null ? _formatDate(_returnedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Scheme', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.scheme?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _scheme = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Deposit_protection'),
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

void _confirmDel(BuildContext context, WidgetRef ref, DepositProtection item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Deposit_protection?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(deposit_protectionDeleteStateProvider.notifier).state = item.id;
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
