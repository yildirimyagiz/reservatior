import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MortgageOfferFormWidget extends ConsumerStatefulWidget {
  final MortgageOffer? item;
  final Function(MortgageOffer) onSubmit;
  const MortgageOfferFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MortgageOfferFormWidget> createState() =>
      _MortgageOfferFormWidgetState();
}

class _MortgageOfferFormWidgetState
    extends ConsumerState<MortgageOfferFormWidget> {
  String? _contactId;
  String? _propertyId;
  String? _lender;
  double? _offerAmount;
  double? _interestRate;
  int? _termYears;
  double? _monthlyPayment;
  String? _currency;
  String? _status;
  DateTime? _offeredAt;
  DateTime? _acceptedAt;
  DateTime? _expiresAt;
  String? _conditions;
  @override
  void initState() {
    super.initState();
    _contactId = widget.item?.contactId;
    _propertyId = widget.item?.propertyId;
    _lender = widget.item?.lender;
    _offerAmount = widget.item?.offerAmount;
    _interestRate = widget.item?.interestRate;
    _termYears = widget.item?.termYears;
    _monthlyPayment = widget.item?.monthlyPayment;
    _currency = widget.item?.currency;
    _status = widget.item?.status;
    _offeredAt = widget.item?.offeredAt;
    _acceptedAt = widget.item?.acceptedAt;
    _expiresAt = widget.item?.expiresAt;
    _conditions = widget.item?.conditions;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mortgageoffer'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mortgageoffer'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _lender?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lender'.tr()),
              onChanged: (v) => _lender = v,
            ),
            TextFormField(
              initialValue: _offerAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.offeramount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _offerAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _interestRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.interestrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _interestRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _termYears?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.termyears'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _termYears = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _monthlyPayment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.monthlypayment'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _monthlyPayment = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_offered_at'.tr()}: ${_offeredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _offeredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _offeredAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_accepted_at'.tr()}: ${_acceptedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _acceptedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _acceptedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            TextFormField(
              initialValue: _conditions?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.conditions'.tr()),
              onChanged: (v) => _conditions = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contactId != null) 'contactId': _contactId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_lender != null) 'lender': _lender,
                  if (_offerAmount != null) 'offerAmount': _offerAmount,
                  if (_interestRate != null) 'interestRate': _interestRate,
                  if (_termYears != null) 'termYears': _termYears,
                  if (_monthlyPayment != null)
                    'monthlyPayment': _monthlyPayment,
                  if (_currency != null) 'currency': _currency,
                  if (_status != null) 'status': _status,
                  if (_offeredAt != null)
                    'offeredAt': _offeredAt!.toIso8601String(),
                  if (_acceptedAt != null)
                    'acceptedAt': _acceptedAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  if (_conditions != null) 'conditions': _conditions,
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
                  widget.onSubmit(MortgageOffer.fromJson(json));
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
