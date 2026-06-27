import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DealFormWidget extends ConsumerStatefulWidget {
  final Deal? item;
  final Function(Deal) onSubmit;
  const DealFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<DealFormWidget> createState() => _DealFormWidgetState();
}

class _DealFormWidgetState extends ConsumerState<DealFormWidget> {
  String? _listingId;
  String? _propertyId;
  String? _clientId;
  String? _agentId;
  String? _locationId;
  String? _dealType;
  double? _offerPrice;
  double? _listPrice;
  double? _salePrice;
  double? _commissionRate;
  double? _commissionAmount;
  DateTime? _closingDate;
  String? _financingType;
  double? _loanAmount;
  double? _downPayment;
  double? _earnestMoney;
  double? _escrowAmount;
  double? _closingCosts;
  double? _sellerConcessions;
  double? _buyerCredits;
  int? _inspectionPeriod;
  bool? _financingContingency;
  bool? _appraisalContingency;
  bool? _titleContingency;
  bool? _attorneyReview;
  bool? _multipleOffers;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _propertyId = widget.item?.propertyId;
    _clientId = widget.item?.clientId;
    _agentId = widget.item?.agentId;
    _locationId = widget.item?.locationId;
    _dealType = widget.item?.dealType;
    _offerPrice = widget.item?.offerPrice;
    _listPrice = widget.item?.listPrice;
    _salePrice = widget.item?.salePrice;
    _commissionRate = widget.item?.commissionRate;
    _commissionAmount = widget.item?.commissionAmount;
    _closingDate = widget.item?.closingDate;
    _financingType = widget.item?.financingType;
    _loanAmount = widget.item?.loanAmount;
    _downPayment = widget.item?.downPayment;
    _earnestMoney = widget.item?.earnestMoney;
    _escrowAmount = widget.item?.escrowAmount;
    _closingCosts = widget.item?.closingCosts;
    _sellerConcessions = widget.item?.sellerConcessions;
    _buyerCredits = widget.item?.buyerCredits;
    _inspectionPeriod = widget.item?.inspectionPeriod;
    _financingContingency = widget.item?.financingContingency;
    _appraisalContingency = widget.item?.appraisalContingency;
    _titleContingency = widget.item?.titleContingency;
    _attorneyReview = widget.item?.attorneyReview;
    _multipleOffers = widget.item?.multipleOffers;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.deal'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.deal'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _clientId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.clientid'.tr()),
              onChanged: (v) => _clientId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            TextFormField(
              initialValue: _locationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locationid'.tr()),
              onChanged: (v) => _locationId = v,
            ),
            TextFormField(
              initialValue: _dealType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealtype'.tr()),
              onChanged: (v) => _dealType = v,
            ),
            TextFormField(
              initialValue: _offerPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.offerprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _offerPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _listPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _listPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _salePrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.saleprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _salePrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _commissionRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _commissionAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionAmount = double.tryParse(v ?? ""),
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
              initialValue: _loanAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.loanamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _loanAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _downPayment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.downpayment'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _downPayment = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _earnestMoney?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.earnestmoney'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _earnestMoney = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _escrowAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.escrowamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _escrowAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _closingCosts?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.closingcosts'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _closingCosts = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _sellerConcessions?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sellerconcessions'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sellerConcessions = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _buyerCredits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.buyercredits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _buyerCredits = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _inspectionPeriod?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.inspectionperiod'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _inspectionPeriod = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.financingcontingency'.tr()),
              value: _financingContingency ?? false,
              onChanged: (v) => setState(() => _financingContingency = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.appraisalcontingency'.tr()),
              value: _appraisalContingency ?? false,
              onChanged: (v) => setState(() => _appraisalContingency = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.titlecontingency'.tr()),
              value: _titleContingency ?? false,
              onChanged: (v) => setState(() => _titleContingency = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.attorneyreview'.tr()),
              value: _attorneyReview ?? false,
              onChanged: (v) => setState(() => _attorneyReview = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.multipleoffers'.tr()),
              value: _multipleOffers ?? false,
              onChanged: (v) => setState(() => _multipleOffers = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_clientId != null) 'clientId': _clientId,
                  if (_agentId != null) 'agentId': _agentId,
                  if (_locationId != null) 'locationId': _locationId,
                  if (_dealType != null) 'dealType': _dealType,
                  if (_offerPrice != null) 'offerPrice': _offerPrice,
                  if (_listPrice != null) 'listPrice': _listPrice,
                  if (_salePrice != null) 'salePrice': _salePrice,
                  if (_commissionRate != null)
                    'commissionRate': _commissionRate,
                  if (_commissionAmount != null)
                    'commissionAmount': _commissionAmount,
                  if (_closingDate != null)
                    'closingDate': _closingDate!.toIso8601String(),
                  if (_financingType != null) 'financingType': _financingType,
                  if (_loanAmount != null) 'loanAmount': _loanAmount,
                  if (_downPayment != null) 'downPayment': _downPayment,
                  if (_earnestMoney != null) 'earnestMoney': _earnestMoney,
                  if (_escrowAmount != null) 'escrowAmount': _escrowAmount,
                  if (_closingCosts != null) 'closingCosts': _closingCosts,
                  if (_sellerConcessions != null)
                    'sellerConcessions': _sellerConcessions,
                  if (_buyerCredits != null) 'buyerCredits': _buyerCredits,
                  if (_inspectionPeriod != null)
                    'inspectionPeriod': _inspectionPeriod,
                  'financingContingency': _financingContingency,
                  'appraisalContingency': _appraisalContingency,
                  'titleContingency': _titleContingency,
                  'attorneyReview': _attorneyReview,
                  'multipleOffers': _multipleOffers,
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
                  widget.onSubmit(Deal.fromJson(json));
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
