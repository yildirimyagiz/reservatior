import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyDocumentFormWidget extends ConsumerStatefulWidget {
  final PropertyDocument? item;
  final Function(PropertyDocument) onSubmit;
  const PropertyDocumentFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyDocumentFormWidget> createState() =>
      _PropertyDocumentFormWidgetState();
}

class _PropertyDocumentFormWidgetState
    extends ConsumerState<PropertyDocumentFormWidget> {
  String? _propertyId;
  String? _title;
  String? _fileName;
  String? _mimeType;
  int? _sizeBytes;
  String? _storageKey;
  String? _category;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _title = widget.item?.title;
    _fileName = widget.item?.fileName;
    _mimeType = widget.item?.mimeType;
    _sizeBytes = widget.item?.sizeBytes;
    _storageKey = widget.item?.storageKey;
    _category = widget.item?.category;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertydocument'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertydocument'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _fileName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.filename'.tr()),
              onChanged: (v) => _fileName = v,
            ),
            TextFormField(
              initialValue: _mimeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mimetype'.tr()),
              onChanged: (v) => _mimeType = v,
            ),
            TextFormField(
              initialValue: _sizeBytes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sizebytes'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sizeBytes = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _storageKey?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.storagekey'.tr()),
              onChanged: (v) => _storageKey = v,
            ),
            TextFormField(
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_title != null) 'title': _title,
                  if (_fileName != null) 'fileName': _fileName,
                  if (_mimeType != null) 'mimeType': _mimeType,
                  if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
                  if (_storageKey != null) 'storageKey': _storageKey,
                  if (_category != null) 'category': _category,
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
                  widget.onSubmit(PropertyDocument.fromJson(json));
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
