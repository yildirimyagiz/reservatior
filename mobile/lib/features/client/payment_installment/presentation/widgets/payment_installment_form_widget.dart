import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentInstallmentFormWidget extends ConsumerStatefulWidget {
  final PaymentInstallment? item;
  final Function(PaymentInstallment) onSubmit;
  const PaymentInstallmentFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PaymentInstallmentFormWidget> createState() =>
      _PaymentInstallmentFormWidgetState();
}

class _PaymentInstallmentFormWidgetState
    extends ConsumerState<PaymentInstallmentFormWidget> {
  String? _negotiationId;
  int? _installmentNo;
  double? _amount;
  String? _currency;
  DateTime? _dueDate;
  DateTime? _paidAt;
  String? _referenceNo;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _negotiationId = widget.item?.negotiationId;
    _installmentNo = widget.item?.installmentNo;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _dueDate = widget.item?.dueDate;
    _paidAt = widget.item?.paidAt;
    _referenceNo = widget.item?.referenceNo;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.paymentinstallment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.paymentinstallment'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _negotiationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.negotiationid'.tr()),
              onChanged: (v) => _negotiationId = v,
            ),
            TextFormField(
              initialValue: _installmentNo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.installmentno'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _installmentNo = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
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
            ListTile(
              title: Text("${'mobile.admin.field_paid_at'.tr()}: ${_paidAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _paidAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _paidAt = d);
              },
            ),
            TextFormField(
              initialValue: _referenceNo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.referenceno'.tr()),
              onChanged: (v) => _referenceNo = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_negotiationId != null) 'negotiationId': _negotiationId,
                  if (_installmentNo != null) 'installmentNo': _installmentNo,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
                  if (_referenceNo != null) 'referenceNo': _referenceNo,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(PaymentInstallment.fromJson(json));
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
