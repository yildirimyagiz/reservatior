import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/payment_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Payment Admin Page  |  26 fields
// Auto-generated — edit with care
// ================================================================

class PaymentAdminPage extends ConsumerWidget {
  const PaymentAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(paymentLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(paymentListProvider)),
        ],
      ),
      body: const _PaymentBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'PaymentFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Payment'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _PaymentBody extends ConsumerStatefulWidget {
  const _PaymentBody({super.key});
  @override ConsumerState<_PaymentBody> createState() => __PaymentBodyState();
}

class __PaymentBodyState extends ConsumerState<_PaymentBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(paymentListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search Payments…',
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
              : items.where((item) => ((item.tenantId?.toString() ?? '') + " " + (item.leaseId?.toString() ?? '') + " " + (item.type?.toString() ?? '') + " " + (item.currencyId?.toString() ?? '') + " " + (item.paymentMethod?.toString() ?? '') + " " + (item.reference?.toString() ?? '') + " " + (item.notes?.toString() ?? '') + " " + (item.stripePaymentIntentId?.toString() ?? '') + " " + (item.stripePaymentMethodId?.toString() ?? '') + " " + (item.stripeClientSecret?.toString() ?? '') + " " + (item.stripeStatus?.toString() ?? '') + " " + (item.stripeError?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.expenseId?.toString() ?? '') + " " + (item.reservationId?.toString() ?? '') + " " + (item.subscriptionId?.toString() ?? '') + " " + (item.commissionRuleId?.toString() ?? '') + " " + (item.includedServiceId?.toString() ?? '') + " " + (item.extraChargeId?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Payments yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(paymentListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.type != null && item.type!.toString().isNotEmpty ? item.type!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.type ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Status: ${item.status?.toString() ?? "N/A"}'),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(paymentListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Payment item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Payment item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Tenant Id', item.tenantId?.toString() ?? 'N/A', Icons.link),
              _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
              _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
              _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
              _row('Currency Id', item.currencyId?.toString() ?? 'N/A', Icons.link),
              _row('Payment Date', _formatDate(item.paymentDate), Icons.calendar_today),
              _row('Due Date', _formatDate(item.dueDate), Icons.calendar_today),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Payment Method', item.paymentMethod?.toString() ?? 'N/A', Icons.text_fields),
              _row('Reference', item.reference?.toString() ?? 'N/A', Icons.text_fields),
              _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
              _row('Stripe Payment Intent Id', item.stripePaymentIntentId?.toString() ?? 'N/A', Icons.link),
              _row('Stripe Payment Method Id', item.stripePaymentMethodId?.toString() ?? 'N/A', Icons.link),
              _row('Stripe Client Secret', item.stripeClientSecret?.toString() ?? 'N/A', Icons.text_fields),
              _row('Stripe Status', item.stripeStatus?.toString() ?? 'N/A', Icons.info_outline),
              _row('Stripe Error', item.stripeError?.toString() ?? 'N/A', Icons.text_fields),
              _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
              _row('Expense Id', item.expenseId?.toString() ?? 'N/A', Icons.link),
              _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
              _row('Subscription Id', item.subscriptionId?.toString() ?? 'N/A', Icons.link),
              _row('Commission Rule Id', item.commissionRuleId?.toString() ?? 'N/A', Icons.link),
              _row('Included Service Id', item.includedServiceId?.toString() ?? 'N/A', Icons.link),
              _row('Extra Charge Id', item.extraChargeId?.toString() ?? 'N/A', Icons.link),
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

void _showForm(BuildContext context, WidgetRef ref, {Payment? item}) {
  showDialog(context: context, builder: (ctx) => _PaymentForm(item: item, ref: ref));
}

class _PaymentForm extends ConsumerStatefulWidget {
  final Payment? item;
  final WidgetRef ref;
  const _PaymentForm({super.key, this.item, required this.ref});
  @override ConsumerState<_PaymentForm> createState() => __PaymentFormState();
}

class __PaymentFormState extends ConsumerState<_PaymentForm> {
  final _key = GlobalKey<FormState>();

  String? _tenantId;
  String? _leaseId;
  double? _amount;
  String? _type;
  String? _currencyId;
  DateTime? _paymentDate;
  DateTime? _dueDate;
  String? _status;
  String? _paymentMethod;
  String? _reference;
  String? _notes;
  String? _stripePaymentIntentId;
  String? _stripePaymentMethodId;
  String? _stripeClientSecret;
  String? _stripeStatus;
  String? _stripeError;
  String? _propertyId;
  String? _expenseId;
  String? _reservationId;
  String? _subscriptionId;
  String? _commissionRuleId;
  String? _includedServiceId;
  String? _extraChargeId;

  @override
  void initState() {
    super.initState();
    _tenantId = widget.item?.tenantId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _amount = widget.item?.amount;
    _type = widget.item?.type?.toString();
    _currencyId = widget.item?.currencyId?.toString();
    _paymentDate = widget.item?.paymentDate;
    _dueDate = widget.item?.dueDate;
    _status = widget.item?.status?.toString();
    _paymentMethod = widget.item?.paymentMethod?.toString();
    _reference = widget.item?.reference?.toString();
    _notes = widget.item?.notes?.toString();
    _stripePaymentIntentId = widget.item?.stripePaymentIntentId?.toString();
    _stripePaymentMethodId = widget.item?.stripePaymentMethodId?.toString();
    _stripeClientSecret = widget.item?.stripeClientSecret?.toString();
    _stripeStatus = widget.item?.stripeStatus?.toString();
    _stripeError = widget.item?.stripeError?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _expenseId = widget.item?.expenseId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _subscriptionId = widget.item?.subscriptionId?.toString();
    _commissionRuleId = widget.item?.commissionRuleId?.toString();
    _includedServiceId = widget.item?.includedServiceId?.toString();
    _extraChargeId = widget.item?.extraChargeId?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
      if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
      if (_amount != null) 'amount': _amount,
      if (_type?.isNotEmpty == true) 'type': _type,
      if (_currencyId?.isNotEmpty == true) 'currencyId': _currencyId,
      if (_paymentDate != null) 'paymentDate': _paymentDate!.toIso8601String(),
      if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_paymentMethod?.isNotEmpty == true) 'paymentMethod': _paymentMethod,
      if (_reference?.isNotEmpty == true) 'reference': _reference,
      if (_notes?.isNotEmpty == true) 'notes': _notes,
      if (_stripePaymentIntentId?.isNotEmpty == true) 'stripePaymentIntentId': _stripePaymentIntentId,
      if (_stripePaymentMethodId?.isNotEmpty == true) 'stripePaymentMethodId': _stripePaymentMethodId,
      if (_stripeClientSecret?.isNotEmpty == true) 'stripeClientSecret': _stripeClientSecret,
      if (_stripeStatus?.isNotEmpty == true) 'stripeStatus': _stripeStatus,
      if (_stripeError?.isNotEmpty == true) 'stripeError': _stripeError,
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_expenseId?.isNotEmpty == true) 'expenseId': _expenseId,
      if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
      if (_subscriptionId?.isNotEmpty == true) 'subscriptionId': _subscriptionId,
      if (_commissionRuleId?.isNotEmpty == true) 'commissionRuleId': _commissionRuleId,
      if (_includedServiceId?.isNotEmpty == true) 'includedServiceId': _includedServiceId,
      if (_extraChargeId?.isNotEmpty == true) 'extraChargeId': _extraChargeId,
    };
    if (widget.item == null) {
      widget.ref.read(paymentCreateStateProvider.notifier).state = Payment.fromJson(data);
    } else {
      widget.ref.read(paymentUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'payment': Payment.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit Payment' : 'New Payment'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.tenantId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.leaseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item?.amount?.toString() ?? '',
                    onSaved: (v) => _amount = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.type?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _type = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.currencyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currencyId = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _paymentDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _paymentDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Payment Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_paymentDate != null ? _formatDate(_paymentDate) : 'Tap to select date'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _dueDate ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _dueDate = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Due Date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_dueDate != null ? _formatDate(_dueDate) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Payment Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.paymentMethod?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _paymentMethod = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reference?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reference = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item?.notes?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stripe Payment Intent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.stripePaymentIntentId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stripePaymentIntentId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stripe Payment Method Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.stripePaymentMethodId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stripePaymentMethodId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stripe Client Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.stripeClientSecret?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stripeClientSecret = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stripe Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item?.stripeStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stripeStatus = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Stripe Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item?.stripeError?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stripeError = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Expense Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.expenseId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _expenseId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.reservationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subscription Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.subscriptionId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _subscriptionId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Commission Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.commissionRuleId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _commissionRuleId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Included Service Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.includedServiceId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Extra Charge Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item?.extraChargeId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _extraChargeId = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Payment'),
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

void _confirmDel(BuildContext context, WidgetRef ref, Payment item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Payment?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(paymentDeleteStateProvider.notifier).state = item.id;
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
