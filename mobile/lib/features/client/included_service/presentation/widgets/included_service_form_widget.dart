import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class IncludedServiceFormWidget extends ConsumerStatefulWidget {
  final IncludedService? item;
  final Function(IncludedService) onSubmit;
  const IncludedServiceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<IncludedServiceFormWidget> createState() =>
      _IncludedServiceFormWidgetState();
}

class _IncludedServiceFormWidgetState
    extends ConsumerState<IncludedServiceFormWidget> {
  String? _propertyId;
  String? _name;
  String? _description;
  double? _value;
  bool? _isRecurring;
  String? _frequency;
  String? _icon;
  String? _logo;
  String? _facilityId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _value = widget.item?.value;
    _isRecurring = widget.item?.isRecurring;
    _frequency = widget.item?.frequency;
    _icon = widget.item?.icon;
    _logo = widget.item?.logo;
    _facilityId = widget.item?.facilityId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.includedservice'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.includedservice'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
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
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _value = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isrecurring'.tr()),
              value: _isRecurring ?? false,
              onChanged: (v) => setState(() => _isRecurring = v),
            ),
            TextFormField(
              initialValue: _frequency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.frequency'.tr()),
              onChanged: (v) => _frequency = v,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_value != null) 'value': _value,
                  'isRecurring': _isRecurring,
                  if (_frequency != null) 'frequency': _frequency,
                  if (_icon != null) 'icon': _icon,
                  if (_logo != null) 'logo': _logo,
                  if (_facilityId != null) 'facilityId': _facilityId,
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
                  widget.onSubmit(IncludedService.fromJson(json));
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
