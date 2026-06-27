import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TaxRecordFormWidget extends ConsumerStatefulWidget {
  final TaxRecord? item;
  final Function(TaxRecord) onSubmit;
  const TaxRecordFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<TaxRecordFormWidget> createState() =>
      _TaxRecordFormWidgetState();
}

class _TaxRecordFormWidgetState extends ConsumerState<TaxRecordFormWidget> {
  String? _profileId;
  String? _transactionId;
  String? _propertyId;
  String? _contactId;
  String? _recordType;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _profileId = widget.item?.profileId;
    _transactionId = widget.item?.transactionId;
    _propertyId = widget.item?.propertyId;
    _contactId = widget.item?.contactId;
    _recordType = widget.item?.recordType;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.taxrecord'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.taxrecord'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _profileId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.profileid'.tr()),
              onChanged: (v) => _profileId = v,
            ),
            TextFormField(
              initialValue: _transactionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.transactionid'.tr()),
              onChanged: (v) => _transactionId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _recordType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recordtype'.tr()),
              onChanged: (v) => _recordType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_profileId != null) 'profileId': _profileId,
                  if (_transactionId != null) 'transactionId': _transactionId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_recordType != null) 'recordType': _recordType,
                  'isActive': _isActive,
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
                  widget.onSubmit(TaxRecord.fromJson(json));
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
