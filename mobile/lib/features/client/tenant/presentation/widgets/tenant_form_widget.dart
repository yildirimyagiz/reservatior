import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TenantFormWidget extends ConsumerStatefulWidget {
  final Tenant? item;
  final Function(Tenant) onSubmit;
  const TenantFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<TenantFormWidget> createState() => _TenantFormWidgetState();
}

class _TenantFormWidgetState extends ConsumerState<TenantFormWidget> {
  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  DateTime? _leaseStartDate;
  DateTime? _leaseEndDate;
  String? _propertyId;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _firstName = widget.item?.firstName;
    _lastName = widget.item?.lastName;
    _email = widget.item?.email;
    _phoneNumber = widget.item?.phoneNumber;
    _leaseStartDate = widget.item?.leaseStartDate;
    _leaseEndDate = widget.item?.leaseEndDate;
    _propertyId = widget.item?.propertyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.tenant'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.tenant'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _firstName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.firstname'.tr()),
              onChanged: (v) => _firstName = v,
            ),
            TextFormField(
              initialValue: _lastName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lastname'.tr()),
              onChanged: (v) => _lastName = v,
            ),
            TextFormField(
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _phoneNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phonenumber'.tr()),
              onChanged: (v) => _phoneNumber = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_lease_start_date'.tr()}: ${_leaseStartDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _leaseStartDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _leaseStartDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_lease_end_date'.tr()}: ${_leaseEndDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _leaseEndDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _leaseEndDate = d);
              },
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
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
                  if (_userId != null) 'userId': _userId,
                  if (_firstName != null) 'firstName': _firstName,
                  if (_lastName != null) 'lastName': _lastName,
                  if (_email != null) 'email': _email,
                  if (_phoneNumber != null) 'phoneNumber': _phoneNumber,
                  if (_leaseStartDate != null)
                    'leaseStartDate': _leaseStartDate!.toIso8601String(),
                  if (_leaseEndDate != null)
                    'leaseEndDate': _leaseEndDate!.toIso8601String(),
                  if (_propertyId != null) 'propertyId': _propertyId,
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
                  widget.onSubmit(Tenant.fromJson(json));
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
