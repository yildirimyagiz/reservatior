import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class UserFormWidget extends ConsumerStatefulWidget {
  final User? item;
  final Function(User) onSubmit;
  const UserFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends ConsumerState<UserFormWidget> {
  String? _email;
  String? _name;
  String? _phone;
  String? _locale;
  String? _timezone;
  DateTime? _gdprConsentAt;
  DateTime? _ccpaOptOutAt;
  DateTime? _dataRetentionUntil;
  DateTime? _anonymizedAt;
  @override
  void initState() {
    super.initState();
    _email = widget.item?.email;
    _name = widget.item?.name;
    _phone = widget.item?.phone;
    _locale = widget.item?.locale;
    _timezone = widget.item?.timezone;
    _gdprConsentAt = widget.item?.gdprConsentAt;
    _ccpaOptOutAt = widget.item?.ccpaOptOutAt;
    _dataRetentionUntil = widget.item?.dataRetentionUntil;
    _anonymizedAt = widget.item?.anonymizedAt;
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
              widget.item == null ? 'mobile.auto.new_user'.tr() : 'mobile.auto.edit_user'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _phone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phone'.tr()),
              onChanged: (v) => _phone = v,
            ),
            TextFormField(
              initialValue: _locale?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.locale'.tr()),
              onChanged: (v) => _locale = v,
            ),
            TextFormField(
              initialValue: _timezone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timezone'.tr()),
              onChanged: (v) => _timezone = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_gdpr_consent_at'.tr()}: ${_gdprConsentAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _gdprConsentAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _gdprConsentAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_ccpa_opt_out_at'.tr()}: ${_ccpaOptOutAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _ccpaOptOutAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _ccpaOptOutAt = d);
              },
            ),
            ListTile(
              title: Text(
                "${'mobile.admin.field_data_retention_until'.tr()}: ${_dataRetentionUntil ?? 'mobile.admin.select'.tr()}",
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dataRetentionUntil ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dataRetentionUntil = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_anonymized_at'.tr()}: ${_anonymizedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _anonymizedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _anonymizedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_email != null) 'email': _email,
                  if (_name != null) 'name': _name,
                  if (_phone != null) 'phone': _phone,
                  if (_locale != null) 'locale': _locale,
                  if (_timezone != null) 'timezone': _timezone,
                  if (_gdprConsentAt != null)
                    'gdprConsentAt': _gdprConsentAt!.toIso8601String(),
                  if (_ccpaOptOutAt != null)
                    'ccpaOptOutAt': _ccpaOptOutAt!.toIso8601String(),
                  if (_dataRetentionUntil != null)
                    'dataRetentionUntil': _dataRetentionUntil!
                        .toIso8601String(),
                  if (_anonymizedAt != null)
                    'anonymizedAt': _anonymizedAt!.toIso8601String(),
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
                  widget.onSubmit(User.fromJson(json));
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
