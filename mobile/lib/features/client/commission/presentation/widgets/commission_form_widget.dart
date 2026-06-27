import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CommissionFormWidget extends ConsumerStatefulWidget {
  final Commission? item;
  final Function(Commission) onSubmit;
  const CommissionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<CommissionFormWidget> createState() =>
      _CommissionFormWidgetState();
}

class _CommissionFormWidgetState extends ConsumerState<CommissionFormWidget> {
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _transactionId;
  String? _beneficiaryUserId;
  String? _beneficiaryOrgId;
  double? _amountBase;
  double? _commissionAmount;
  String? _currency;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _leaseId = widget.item?.leaseId;
    _bookingId = widget.item?.bookingId;
    _transactionId = widget.item?.transactionId;
    _beneficiaryUserId = widget.item?.beneficiaryUserId;
    _beneficiaryOrgId = widget.item?.beneficiaryOrgId;
    _amountBase = widget.item?.amountBase;
    _commissionAmount = widget.item?.commissionAmount;
    _currency = widget.item?.currency;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.commission'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.commission'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _bookingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bookingid'.tr()),
              onChanged: (v) => _bookingId = v,
            ),
            TextFormField(
              initialValue: _transactionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.transactionid'.tr()),
              onChanged: (v) => _transactionId = v,
            ),
            TextFormField(
              initialValue: _beneficiaryUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.beneficiaryuserid'.tr()),
              onChanged: (v) => _beneficiaryUserId = v,
            ),
            TextFormField(
              initialValue: _beneficiaryOrgId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.beneficiaryorgid'.tr()),
              onChanged: (v) => _beneficiaryOrgId = v,
            ),
            TextFormField(
              initialValue: _amountBase?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amountbase'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amountBase = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _commissionAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_bookingId != null) 'bookingId': _bookingId,
                  if (_transactionId != null) 'transactionId': _transactionId,
                  if (_beneficiaryUserId != null)
                    'beneficiaryUserId': _beneficiaryUserId,
                  if (_beneficiaryOrgId != null)
                    'beneficiaryOrgId': _beneficiaryOrgId,
                  if (_amountBase != null) 'amountBase': _amountBase,
                  if (_commissionAmount != null)
                    'commissionAmount': _commissionAmount,
                  if (_currency != null) 'currency': _currency,
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
                  widget.onSubmit(Commission.fromJson(json));
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
