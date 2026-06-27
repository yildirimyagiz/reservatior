import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class KeyManagementFormWidget extends ConsumerStatefulWidget {
  final KeyManagement? item;
  final Function(KeyManagement) onSubmit;
  const KeyManagementFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<KeyManagementFormWidget> createState() =>
      _KeyManagementFormWidgetState();
}

class _KeyManagementFormWidgetState
    extends ConsumerState<KeyManagementFormWidget> {
  String? _propertyId;
  String? _keyType;
  String? _keyNumber;
  String? _keyLocation;
  String? _keySafeCode;
  String? _keyStatus;
  DateTime? _cutDate;
  String? _cutBy;
  double? _replacementCost;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _keyType = widget.item?.keyType;
    _keyNumber = widget.item?.keyNumber;
    _keyLocation = widget.item?.keyLocation;
    _keySafeCode = widget.item?.keySafeCode;
    _keyStatus = widget.item?.keyStatus;
    _cutDate = widget.item?.cutDate;
    _cutBy = widget.item?.cutBy;
    _replacementCost = widget.item?.replacementCost;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.keymanagement'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.keymanagement'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _keyType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keytype'.tr()),
              onChanged: (v) => _keyType = v,
            ),
            TextFormField(
              initialValue: _keyNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keynumber'.tr()),
              onChanged: (v) => _keyNumber = v,
            ),
            TextFormField(
              initialValue: _keyLocation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keylocation'.tr()),
              onChanged: (v) => _keyLocation = v,
            ),
            TextFormField(
              initialValue: _keySafeCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keysafecode'.tr()),
              onChanged: (v) => _keySafeCode = v,
            ),
            TextFormField(
              initialValue: _keyStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keystatus'.tr()),
              onChanged: (v) => _keyStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_cut_date'.tr()}: ${_cutDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _cutDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _cutDate = d);
              },
            ),
            TextFormField(
              initialValue: _cutBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cutby'.tr()),
              onChanged: (v) => _cutBy = v,
            ),
            TextFormField(
              initialValue: _replacementCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.replacementcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _replacementCost = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_keyType != null) 'keyType': _keyType,
                  if (_keyNumber != null) 'keyNumber': _keyNumber,
                  if (_keyLocation != null) 'keyLocation': _keyLocation,
                  if (_keySafeCode != null) 'keySafeCode': _keySafeCode,
                  if (_keyStatus != null) 'keyStatus': _keyStatus,
                  if (_cutDate != null) 'cutDate': _cutDate!.toIso8601String(),
                  if (_cutBy != null) 'cutBy': _cutBy,
                  if (_replacementCost != null)
                    'replacementCost': _replacementCost,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(KeyManagement.fromJson(json));
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
