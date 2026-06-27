import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyPhotoFormWidget extends ConsumerStatefulWidget {
  final PropertyPhoto? item;
  final Function(PropertyPhoto) onSubmit;
  const PropertyPhotoFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PropertyPhotoFormWidget> createState() =>
      _PropertyPhotoFormWidgetState();
}

class _PropertyPhotoFormWidgetState
    extends ConsumerState<PropertyPhotoFormWidget> {
  String? _propertyId;
  String? _url;
  String? _caption;
  bool? _isPrimary;
  int? _sortOrder;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _url = widget.item?.url;
    _caption = widget.item?.caption;
    _isPrimary = widget.item?.isPrimary;
    _sortOrder = widget.item?.sortOrder;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyphoto'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyphoto'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _url?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.url'.tr()),
              onChanged: (v) => _url = v,
            ),
            TextFormField(
              initialValue: _caption?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.caption'.tr()),
              onChanged: (v) => _caption = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isprimary'.tr()),
              value: _isPrimary ?? false,
              onChanged: (v) => setState(() => _isPrimary = v),
            ),
            TextFormField(
              initialValue: _sortOrder?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sortorder'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sortOrder = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_url != null) 'url': _url,
                  if (_caption != null) 'caption': _caption,
                  'isPrimary': _isPrimary,
                  if (_sortOrder != null) 'sortOrder': _sortOrder,
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
                  widget.onSubmit(PropertyPhoto.fromJson(json));
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
