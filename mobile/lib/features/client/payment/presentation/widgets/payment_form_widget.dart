import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentFormWidget extends ConsumerStatefulWidget {
  final Payment? item;
  final Function(Payment) onSubmit;
  const PaymentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PaymentFormWidget> createState() => _PaymentFormWidgetState();
}

class _PaymentFormWidgetState extends ConsumerState<PaymentFormWidget> {
  String? _tenantId;
  String? _leaseId;
  double? _amount;
  String? _type;
  String? _currencyId;
  DateTime? _paymentDate;
  DateTime? _dueDate;
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
    _tenantId = widget.item?.tenantId;
    _leaseId = widget.item?.leaseId;
    _amount = widget.item?.amount;
    _type = widget.item?.type;
    _currencyId = widget.item?.currencyId;
    _paymentDate = widget.item?.paymentDate;
    _dueDate = widget.item?.dueDate;
    _paymentMethod = widget.item?.paymentMethod;
    _reference = widget.item?.reference;
    _notes = widget.item?.notes;
    _stripePaymentIntentId = widget.item?.stripePaymentIntentId;
    _stripePaymentMethodId = widget.item?.stripePaymentMethodId;
    _stripeClientSecret = widget.item?.stripeClientSecret;
    _stripeStatus = widget.item?.stripeStatus;
    _stripeError = widget.item?.stripeError;
    _propertyId = widget.item?.propertyId;
    _expenseId = widget.item?.expenseId;
    _reservationId = widget.item?.reservationId;
    _subscriptionId = widget.item?.subscriptionId;
    _commissionRuleId = widget.item?.commissionRuleId;
    _includedServiceId = widget.item?.includedServiceId;
    _extraChargeId = widget.item?.extraChargeId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.payment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.payment'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _currencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currencyid'.tr()),
              onChanged: (v) => _currencyId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_payment_date'.tr()}: ${_paymentDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _paymentDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _paymentDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_due_date'.tr()}: ${_dueDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dueDate = d);
              },
            ),
            TextFormField(
              initialValue: _paymentMethod?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.paymentmethod'.tr()),
              onChanged: (v) => _paymentMethod = v,
            ),
            TextFormField(
              initialValue: _reference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reference'.tr()),
              onChanged: (v) => _reference = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _stripePaymentIntentId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.stripepaymentintentid'.tr(),
              ),
              onChanged: (v) => _stripePaymentIntentId = v,
            ),
            TextFormField(
              initialValue: _stripePaymentMethodId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.stripepaymentmethodid'.tr(),
              ),
              onChanged: (v) => _stripePaymentMethodId = v,
            ),
            TextFormField(
              initialValue: _stripeClientSecret?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.stripeclientsecret'.tr(),
              ),
              onChanged: (v) => _stripeClientSecret = v,
            ),
            TextFormField(
              initialValue: _stripeStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.stripestatus'.tr()),
              onChanged: (v) => _stripeStatus = v,
            ),
            TextFormField(
              initialValue: _stripeError?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.stripeerror'.tr()),
              onChanged: (v) => _stripeError = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _expenseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.expenseid'.tr()),
              onChanged: (v) => _expenseId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _subscriptionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subscriptionid'.tr()),
              onChanged: (v) => _subscriptionId = v,
            ),
            TextFormField(
              initialValue: _commissionRuleId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionruleid'.tr()),
              onChanged: (v) => _commissionRuleId = v,
            ),
            TextFormField(
              initialValue: _includedServiceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.includedserviceid'.tr()),
              onChanged: (v) => _includedServiceId = v,
            ),
            TextFormField(
              initialValue: _extraChargeId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.extrachargeid'.tr()),
              onChanged: (v) => _extraChargeId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_amount != null) 'amount': _amount,
                  if (_type != null) 'type': _type,
                  if (_currencyId != null) 'currencyId': _currencyId,
                  if (_paymentDate != null)
                    'paymentDate': _paymentDate!.toIso8601String(),
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_paymentMethod != null) 'paymentMethod': _paymentMethod,
                  if (_reference != null) 'reference': _reference,
                  if (_notes != null) 'notes': _notes,
                  if (_stripePaymentIntentId != null)
                    'stripePaymentIntentId': _stripePaymentIntentId,
                  if (_stripePaymentMethodId != null)
                    'stripePaymentMethodId': _stripePaymentMethodId,
                  if (_stripeClientSecret != null)
                    'stripeClientSecret': _stripeClientSecret,
                  if (_stripeStatus != null) 'stripeStatus': _stripeStatus,
                  if (_stripeError != null) 'stripeError': _stripeError,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_expenseId != null) 'expenseId': _expenseId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_subscriptionId != null)
                    'subscriptionId': _subscriptionId,
                  if (_commissionRuleId != null)
                    'commissionRuleId': _commissionRuleId,
                  if (_includedServiceId != null)
                    'includedServiceId': _includedServiceId,
                  if (_extraChargeId != null) 'extraChargeId': _extraChargeId,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(Payment.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
