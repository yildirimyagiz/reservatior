import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/payment_negotiation_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// PaymentNegotiation Admin Page  |  17 fields
// Auto-generated — edit with care
// ================================================================

class PaymentNegotiationAdminPage extends ConsumerWidget {
  const PaymentNegotiationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(paymentNegotiationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Negotiation Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(paymentNegotiationListProvider)),
        ],
      ),
      body: const _PaymentNegotiationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PaymentNegotiationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Payment Negotiation'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PaymentNegotiationBody extends ConsumerStatefulWidget {
  const _PaymentNegotiationBody({super.key});
  @override ConsumerState<_PaymentNegotiationBody> createState() => __PaymentNegotiationBodyState();
}

class __PaymentNegotiationBodyState extends ConsumerState<_PaymentNegotiationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(paymentNegotiationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Payment Negotiations…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.tenantContactId?.toString() ?? '') + " " + (item.ownerContactId?.toString() ?? '') + " " + (item.ownerUserId?.toString() ?? '') + " " + (item.validationNotes?.toString() ?? '') + " " + (item.agreedOfferId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Payment Negotiations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(paymentNegotiationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.validationNotes != null && item.validationNotes!.toString().isNotEmpty ? item.validationNotes!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.validationNotes ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(paymentNegotiationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(PaymentNegotiation item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, PaymentNegotiation item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Negotiation Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Tenant Contact Id', item.tenantContactId?.toString() ?? 'N/A', Icons.link),
              _row('Owner Contact Id', item.ownerContactId?.toString() ?? 'N/A', Icons.link),
              _row('Owner User Id', item.ownerUserId?.toString() ?? 'N/A', Icons.link),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Max Installments', item.maxInstallments?.toString() ?? 'N/A', Icons.numbers),
              _row('Min First Payment Pct', item.minFirstPaymentPct?.toString() ?? 'N/A', Icons.numbers),
              _row('Platform Validated', (item.platformValidated == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Validation Notes', item.validationNotes?.toString() ?? 'N/A', Icons.notes),
              _row('Agreed Offer Id', item.agreedOfferId?.toString() ?? 'N/A', Icons.link),
              _row('Agreed At', _formatDate(item.agreedAt), Icons.calendar_today),
              _row('Expires At', _formatDate(item.expiresAt), Icons.calendar_today),
              _row('Reminder Sent At', _formatDate(item.reminderSentAt), Icons.calendar_today),
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

void _showForm(BuildContext context, WidgetRef ref, {PaymentNegotiation? item}) {
  showDialog(context: context, builder: (ctx) => _PaymentNegotiationForm(item: item, ref: ref));
}

class _PaymentNegotiationForm extends ConsumerStatefulWidget {
  final PaymentNegotiation? item;
  final WidgetRef ref;
  const _PaymentNegotiationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PaymentNegotiationForm> createState() => __PaymentNegotiationFormState();
}

class __PaymentNegotiationFormState extends ConsumerState<_PaymentNegotiationForm> {
  final _key = GlobalKey<FormState>();

  String? _reservationId;
  String? _tenantContactId;
  String? _ownerContactId;
  String? _ownerUserId;
  String? _status;
  int? _maxInstallments;
  double? _minFirstPaymentPct;
  bool _platformValidated = false;
  String? _validationNotes;
  String? _agreedOfferId;
  DateTime? _agreedAt;
  DateTime? _expiresAt;
  DateTime? _reminderSentAt;

  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId?.toString();
    _tenantContactId = widget.item?.tenantContactId?.toString();
    _ownerContactId = widget.item?.ownerContactId?.toString();
    _ownerUserId = widget.item?.ownerUserId?.toString();
    _status = widget.item?.status?.toString();
    _maxInstallments = widget.item?.maxInstallments;
    _minFirstPaymentPct = widget.item?.minFirstPaymentPct;
    _platformValidated = widget.item?.platformValidated ?? false;
    _validationNotes = widget.item?.validationNotes?.toString();
    _agreedOfferId = widget.item?.agreedOfferId?.toString();
    _agreedAt = widget.item?.agreedAt;
    _expiresAt = widget.item?.expiresAt;
    _reminderSentAt = widget.item?.reminderSentAt;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_tenantContactId?.isNotEmpty == true) 'tenantContactId': _tenantContactId,
      if (_ownerContactId?.isNotEmpty == true) 'ownerContactId': _ownerContactId,
      if (_ownerUserId?.isNotEmpty == true) 'ownerUserId': _ownerUserId,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_maxInstallments != null) 'maxInstallments': _maxInstallments,
      if (_minFirstPaymentPct != null) 'minFirstPaymentPct': _minFirstPaymentPct,
      'platformValidated': _platformValidated,
      if (_validationNotes?.isNotEmpty == true) 'validationNotes': _validationNotes,
      if (_agreedOfferId?.isNotEmpty == true) 'agreedOfferId': _agreedOfferId,
      if (_agreedAt != null) 'agreedAt': _agreedAt!.toIso8601String(),
      if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
      if (_reminderSentAt != null) 'reminderSentAt': _reminderSentAt!.toIso8601String(),
    };
    if (widget.item == null) {
      widget.ref.read(paymentNegotiationCreateStateProvider.notifier).state = PaymentNegotiation.fromJson(data);
    } else {
      widget.ref.read(paymentNegotiationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'paymentNegotiation': PaymentNegotiation.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Payment Negotiation' : 'New Payment Negotiation'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tenant Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.tenantContactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tenantContactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Owner Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.ownerContactId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ownerContactId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Owner User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.ownerUserId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _ownerUserId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Installments', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxInstallments?.toString() ?? '',
                    onSaved: (v) => _maxInstallments = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Min First Payment Pct', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.minFirstPaymentPct?.toString() ?? '',
                    onSaved: (v) => _minFirstPaymentPct = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Platform Validated'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.platformValidated ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _platformValidated = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Validation Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.validationNotes?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _validationNotes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Agreed Offer Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.agreedOfferId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _agreedOfferId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _agreedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _agreedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Agreed At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_agreedAt != null ? _formatDate(_agreedAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _expiresAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _expiresAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Expires At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_expiresAt != null ? _formatDate(_expiresAt) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _reminderSentAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _reminderSentAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Reminder Sent At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_reminderSentAt != null ? _formatDate(_reminderSentAt) : 'Tap to select date'),
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Payment Negotiation'),
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

void _confirmDel(BuildContext context, WidgetRef ref, PaymentNegotiation item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Payment Negotiation?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(paymentNegotiationDeleteStateProvider.notifier).state = item.id;
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
