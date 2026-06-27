import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyAmenityFormWidget extends ConsumerStatefulWidget {
  final PropertyAmenity? item;
  final Function(PropertyAmenity) onSubmit;
  const PropertyAmenityFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyAmenityFormWidget> createState() =>
      _PropertyAmenityFormWidgetState();
}

class _PropertyAmenityFormWidgetState
    extends ConsumerState<PropertyAmenityFormWidget> {
  String? _propertyId;
  String? _amenityId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _amenityId = widget.item?.amenityId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyamenity'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyamenity'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _amenityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amenityid'.tr()),
              onChanged: (v) => _amenityId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_amenityId != null) 'amenityId': _amenityId,
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
                  widget.onSubmit(PropertyAmenity.fromJson(json));
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
