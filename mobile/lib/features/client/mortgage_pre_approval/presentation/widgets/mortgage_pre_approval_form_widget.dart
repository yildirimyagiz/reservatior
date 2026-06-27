import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MortgagePreApprovalFormWidget extends ConsumerStatefulWidget {
  final MortgagePreApproval? item;
  final Function(MortgagePreApproval) onSubmit;
  const MortgagePreApprovalFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MortgagePreApprovalFormWidget> createState() =>
      _MortgagePreApprovalFormWidgetState();
}

class _MortgagePreApprovalFormWidgetState
    extends ConsumerState<MortgagePreApprovalFormWidget> {
  String? _dealId;
  String? _contactId;
  String? _lenderName;
  String? _mortgageType;
  int? _mortgageTerm;
  double? _interestRate;
  double? _arrangementFee;
  double? _valuationFee;
  double? _loanAmount;
  double? _depositAmount;
  double? _loanToValue;
  double? _monthlyPayment;
  double? _totalPayable;
  String? _offerStatus;
  DateTime? _offerDate;
  DateTime? _expiryDate;
  DateTime? _acceptedDate;
  String? _solicitorName;
  String? _solicitorEmail;
  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId;
    _contactId = widget.item?.contactId;
    _lenderName = widget.item?.lenderName;
    _mortgageType = widget.item?.mortgageType;
    _mortgageTerm = widget.item?.mortgageTerm;
    _interestRate = widget.item?.interestRate;
    _arrangementFee = widget.item?.arrangementFee;
    _valuationFee = widget.item?.valuationFee;
    _loanAmount = widget.item?.loanAmount;
    _depositAmount = widget.item?.depositAmount;
    _loanToValue = widget.item?.loanToValue;
    _monthlyPayment = widget.item?.monthlyPayment;
    _totalPayable = widget.item?.totalPayable;
    _offerStatus = widget.item?.offerStatus;
    _offerDate = widget.item?.offerDate;
    _expiryDate = widget.item?.expiryDate;
    _acceptedDate = widget.item?.acceptedDate;
    _solicitorName = widget.item?.solicitorName;
    _solicitorEmail = widget.item?.solicitorEmail;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mortgagepreapproval'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mortgagepreapproval'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _dealId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealid'.tr()),
              onChanged: (v) => _dealId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _lenderName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lendername'.tr()),
              onChanged: (v) => _lenderName = v,
            ),
            TextFormField(
              initialValue: _mortgageType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgagetype'.tr()),
              onChanged: (v) => _mortgageType = v,
            ),
            TextFormField(
              initialValue: _mortgageTerm?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgageterm'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _mortgageTerm = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _interestRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.interestrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _interestRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _arrangementFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.arrangementfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _arrangementFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _valuationFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.valuationfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _valuationFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _loanAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.loanamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _loanAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _depositAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.depositamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _depositAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _loanToValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.loantovalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _loanToValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _monthlyPayment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.monthlypayment'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _monthlyPayment = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalPayable?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalpayable'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalPayable = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _offerStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.offerstatus'.tr()),
              onChanged: (v) => _offerStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_offer_date'.tr()}: ${_offerDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _offerDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _offerDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expiry_date'.tr()}: ${_expiryDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiryDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiryDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_accepted_date'.tr()}: ${_acceptedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _acceptedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _acceptedDate = d);
              },
            ),
            TextFormField(
              initialValue: _solicitorName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitorname'.tr()),
              onChanged: (v) => _solicitorName = v,
            ),
            TextFormField(
              initialValue: _solicitorEmail?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitoremail'.tr()),
              onChanged: (v) => _solicitorEmail = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_dealId != null) 'dealId': _dealId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_lenderName != null) 'lenderName': _lenderName,
                  if (_mortgageType != null) 'mortgageType': _mortgageType,
                  if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
                  if (_interestRate != null) 'interestRate': _interestRate,
                  if (_arrangementFee != null)
                    'arrangementFee': _arrangementFee,
                  if (_valuationFee != null) 'valuationFee': _valuationFee,
                  if (_loanAmount != null) 'loanAmount': _loanAmount,
                  if (_depositAmount != null) 'depositAmount': _depositAmount,
                  if (_loanToValue != null) 'loanToValue': _loanToValue,
                  if (_monthlyPayment != null)
                    'monthlyPayment': _monthlyPayment,
                  if (_totalPayable != null) 'totalPayable': _totalPayable,
                  if (_offerStatus != null) 'offerStatus': _offerStatus,
                  if (_offerDate != null)
                    'offerDate': _offerDate!.toIso8601String(),
                  if (_expiryDate != null)
                    'expiryDate': _expiryDate!.toIso8601String(),
                  if (_acceptedDate != null)
                    'acceptedDate': _acceptedDate!.toIso8601String(),
                  if (_solicitorName != null) 'solicitorName': _solicitorName,
                  if (_solicitorEmail != null)
                    'solicitorEmail': _solicitorEmail,
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
                  widget.onSubmit(MortgagePreApproval.fromJson(json));
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
