import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyDisclosureFormWidget extends ConsumerStatefulWidget {
  final PropertyDisclosure? item;
  final Function(PropertyDisclosure) onSubmit;
  const PropertyDisclosureFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyDisclosureFormWidget> createState() =>
      _PropertyDisclosureFormWidgetState();
}

class _PropertyDisclosureFormWidgetState
    extends ConsumerState<PropertyDisclosureFormWidget> {
  String? _propertyId;
  String? _packStatus;
  DateTime? _createdDate;
  DateTime? _submittedDate;
  String? _completionNotes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _packStatus = widget.item?.packStatus;
    _createdDate = widget.item?.createdDate;
    _submittedDate = widget.item?.submittedDate;
    _completionNotes = widget.item?.completionNotes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertydisclosure'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertydisclosure'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _packStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.packstatus'.tr()),
              onChanged: (v) => _packStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_created_date'.tr()}: ${_createdDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _createdDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _createdDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_submitted_date'.tr()}: ${_submittedDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _submittedDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _submittedDate = d);
              },
            ),
            TextFormField(
              initialValue: _completionNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.completionnotes'.tr()),
              onChanged: (v) => _completionNotes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_packStatus != null) 'packStatus': _packStatus,
                  if (_createdDate != null)
                    'createdDate': _createdDate!.toIso8601String(),
                  if (_submittedDate != null)
                    'submittedDate': _submittedDate!.toIso8601String(),
                  if (_completionNotes != null)
                    'completionNotes': _completionNotes,
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
                  widget.onSubmit(PropertyDisclosure.fromJson(json));
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
