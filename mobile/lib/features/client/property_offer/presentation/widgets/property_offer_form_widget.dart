import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyOfferFormWidget extends ConsumerStatefulWidget {
  final PropertyOffer? item;
  final Function(PropertyOffer) onSubmit;
  const PropertyOfferFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PropertyOfferFormWidget> createState() =>
      _PropertyOfferFormWidgetState();
}

class _PropertyOfferFormWidgetState
    extends ConsumerState<PropertyOfferFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _contactId;
  String? _originalOfferId;
  double? _offerPrice;
  String? _currency;
  DateTime? _closingDate;
  String? _financingType;
  double? _earnestMoneyDeposit;
  int? _dueDiligencePeriod;
  bool? _inspectionContingency;
  bool? _appraisalContingency;
  String? _specialConditions;
  String? _status;
  DateTime? _validUntil;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _contactId = widget.item?.contactId;
    _originalOfferId = widget.item?.originalOfferId;
    _offerPrice = widget.item?.offerPrice;
    _currency = widget.item?.currency;
    _closingDate = widget.item?.closingDate;
    _financingType = widget.item?.financingType;
    _earnestMoneyDeposit = widget.item?.earnestMoneyDeposit;
    _dueDiligencePeriod = widget.item?.dueDiligencePeriod;
    _inspectionContingency = widget.item?.inspectionContingency;
    _appraisalContingency = widget.item?.appraisalContingency;
    _specialConditions = widget.item?.specialConditions;
    _status = widget.item?.status;
    _validUntil = widget.item?.validUntil;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyoffer'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyoffer'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _originalOfferId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.originalofferid'.tr()),
              onChanged: (v) => _originalOfferId = v,
            ),
            TextFormField(
              initialValue: _offerPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.offerprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _offerPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_closing_date'.tr()}: ${_closingDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _closingDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _closingDate = d);
              },
            ),
            TextFormField(
              initialValue: _financingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.financingtype'.tr()),
              onChanged: (v) => _financingType = v,
            ),
            TextFormField(
              initialValue: _earnestMoneyDeposit?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.earnestmoneydeposit'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _earnestMoneyDeposit = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _dueDiligencePeriod?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.duediligenceperiod'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _dueDiligencePeriod = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.inspectioncontingency'.tr()),
              value: _inspectionContingency ?? false,
              onChanged: (v) => setState(() => _inspectionContingency = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.appraisalcontingency'.tr()),
              value: _appraisalContingency ?? false,
              onChanged: (v) => setState(() => _appraisalContingency = v),
            ),
            TextFormField(
              initialValue: _specialConditions?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.specialconditions'.tr()),
              onChanged: (v) => _specialConditions = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_valid_until'.tr()}: ${_validUntil ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _validUntil ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _validUntil = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_originalOfferId != null)
                    'originalOfferId': _originalOfferId,
                  if (_offerPrice != null) 'offerPrice': _offerPrice,
                  if (_currency != null) 'currency': _currency,
                  if (_closingDate != null)
                    'closingDate': _closingDate!.toIso8601String(),
                  if (_financingType != null) 'financingType': _financingType,
                  if (_earnestMoneyDeposit != null)
                    'earnestMoneyDeposit': _earnestMoneyDeposit,
                  if (_dueDiligencePeriod != null)
                    'dueDiligencePeriod': _dueDiligencePeriod,
                  'inspectionContingency': _inspectionContingency,
                  'appraisalContingency': _appraisalContingency,
                  if (_specialConditions != null)
                    'specialConditions': _specialConditions,
                  if (_status != null) 'status': _status,
                  if (_validUntil != null)
                    'validUntil': _validUntil!.toIso8601String(),
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
                  widget.onSubmit(PropertyOffer.fromJson(json));
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
