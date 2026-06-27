import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyPromotionFormWidget extends ConsumerStatefulWidget {
  final PropertyPromotion? item;
  final Function(PropertyPromotion) onSubmit;
  const PropertyPromotionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyPromotionFormWidget> createState() =>
      _PropertyPromotionFormWidgetState();
}

class _PropertyPromotionFormWidgetState
    extends ConsumerState<PropertyPromotionFormWidget> {
  String? _propertyId;
  String? _agencyId;
  String? _agentId;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _price;
  String? _currency;
  bool? _isAutoRenew;
  String? _paymentHistoryId;
  String? _userId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _agencyId = widget.item?.agencyId;
    _agentId = widget.item?.agentId;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _price = widget.item?.price;
    _currency = widget.item?.currency;
    _isAutoRenew = widget.item?.isAutoRenew;
    _paymentHistoryId = widget.item?.paymentHistoryId;
    _userId = widget.item?.userId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertypromotion'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertypromotion'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _price?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.price'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _price = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isautorenew'.tr()),
              value: _isAutoRenew ?? false,
              onChanged: (v) => setState(() => _isAutoRenew = v),
            ),
            TextFormField(
              initialValue: _paymentHistoryId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.paymenthistoryid'.tr()),
              onChanged: (v) => _paymentHistoryId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_agentId != null) 'agentId': _agentId,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_price != null) 'price': _price,
                  if (_currency != null) 'currency': _currency,
                  'isAutoRenew': _isAutoRenew,
                  if (_paymentHistoryId != null)
                    'paymentHistoryId': _paymentHistoryId,
                  if (_userId != null) 'userId': _userId,
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
                  widget.onSubmit(PropertyPromotion.fromJson(json));
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
