import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyComplianceFormWidget extends ConsumerStatefulWidget {
  final PropertyCompliance? item;
  final Function(PropertyCompliance) onSubmit;
  const PropertyComplianceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyComplianceFormWidget> createState() =>
      _PropertyComplianceFormWidgetState();
}

class _PropertyComplianceFormWidgetState
    extends ConsumerState<PropertyComplianceFormWidget> {
  String? _propertyId;
  String? _type;
  String? _status;
  String? _inspectorId;
  String? _inspectorContactId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _type = widget.item?.type;
    _status = widget.item?.status;
    _inspectorId = widget.item?.inspectorId;
    _inspectorContactId = widget.item?.inspectorContactId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertycompliance'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertycompliance'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _inspectorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.inspectorid'.tr()),
              onChanged: (v) => _inspectorId = v,
            ),
            TextFormField(
              initialValue: _inspectorContactId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.inspectorcontactid'.tr(),
              ),
              onChanged: (v) => _inspectorContactId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_type != null) 'type': _type,
                  if (_status != null) 'status': _status,
                  if (_inspectorId != null) 'inspectorId': _inspectorId,
                  if (_inspectorContactId != null)
                    'inspectorContactId': _inspectorContactId,
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
                  widget.onSubmit(PropertyCompliance.fromJson(json));
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
