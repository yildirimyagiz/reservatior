import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Payment Form Widget  |  Fields: tenantId, leaseId, amount, type, currencyId, paymentDate, dueDate, status, paymentMethod, reference, notes, stripePaymentIntentId, stripePaymentMethodId, stripeClientSecret, stripeStatus, stripeError, propertyId, expenseId, reservationId, subscriptionId, commissionRuleId, includedServiceId, extraChargeId

class PaymentFormWidget extends StatefulWidget {
  final Payment? item;
  final void Function(Payment)? onSubmit;
  const PaymentFormWidget({super.key, this.item, this.onSubmit});
  @override State<PaymentFormWidget> createState() => _PaymentFormWidgetState();
}

class _PaymentFormWidgetState extends State<PaymentFormWidget> {
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

  @override
  void dispose() {
    super.dispose();
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
    final result = widget.item != null
        ? Payment.fromJson({...widget.item!.toJson(), ...data})
        : Payment.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _currencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _paymentDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _paymentDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Payment Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_paymentDate != null ? _fmt(_paymentDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dueDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_dueDate != null ? _fmt(_dueDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _paymentMethod = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reference = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Payment Intent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _stripePaymentIntentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Payment Method Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _stripePaymentMethodId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Client Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _stripeClientSecret = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _stripeStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _stripeError = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Expense Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _expenseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subscription Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _subscriptionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Commission Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _commissionRuleId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Included Service Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Extra Charge Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _extraChargeId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Payment'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}