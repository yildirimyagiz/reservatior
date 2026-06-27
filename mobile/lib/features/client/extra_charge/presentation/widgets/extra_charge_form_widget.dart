import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExtraChargeFormWidget extends ConsumerStatefulWidget {
  final ExtraCharge? item;
  final Function(ExtraCharge) onSubmit;
  const ExtraChargeFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ExtraChargeFormWidget> createState() =>
      _ExtraChargeFormWidgetState();
}

class _ExtraChargeFormWidgetState extends ConsumerState<ExtraChargeFormWidget> {
  String? _reservationId;
  String? _name;
  String? _description;
  double? _amount;
  String? _chargeType;
  bool? _isPaid;
  String? _icon;
  String? _logo;
  String? _facilityId;
  String? _includedServiceId;
  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _amount = widget.item?.amount;
    _chargeType = widget.item?.chargeType;
    _isPaid = widget.item?.isPaid;
    _icon = widget.item?.icon;
    _logo = widget.item?.logo;
    _facilityId = widget.item?.facilityId;
    _includedServiceId = widget.item?.includedServiceId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.extracharge'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.extracharge'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _chargeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.chargetype'.tr()),
              onChanged: (v) => _chargeType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.ispaid'.tr()),
              value: _isPaid ?? false,
              onChanged: (v) => setState(() => _isPaid = v),
            ),
            TextFormField(
              initialValue: _icon?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.icon'.tr()),
              onChanged: (v) => _icon = v,
            ),
            TextFormField(
              initialValue: _logo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.logo'.tr()),
              onChanged: (v) => _logo = v,
            ),
            TextFormField(
              initialValue: _facilityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.facilityid'.tr()),
              onChanged: (v) => _facilityId = v,
            ),
            TextFormField(
              initialValue: _includedServiceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.includedserviceid'.tr()),
              onChanged: (v) => _includedServiceId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_amount != null) 'amount': _amount,
                  if (_chargeType != null) 'chargeType': _chargeType,
                  'isPaid': _isPaid,
                  if (_icon != null) 'icon': _icon,
                  if (_logo != null) 'logo': _logo,
                  if (_facilityId != null) 'facilityId': _facilityId,
                  if (_includedServiceId != null)
                    'includedServiceId': _includedServiceId,
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
                  widget.onSubmit(ExtraCharge.fromJson(json));
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
