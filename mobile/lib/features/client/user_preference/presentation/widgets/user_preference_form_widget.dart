import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class UserPreferenceFormWidget extends ConsumerStatefulWidget {
  final UserPreference? item;
  final Function(UserPreference) onSubmit;
  const UserPreferenceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<UserPreferenceFormWidget> createState() =>
      _UserPreferenceFormWidgetState();
}

class _UserPreferenceFormWidgetState
    extends ConsumerState<UserPreferenceFormWidget> {
  String? _userId;
  String? _theme;
  String? _language;
  String? _timezone;
  String? _dateFormat;
  String? _currency;
  bool? _emailNotifications;
  bool? _pushNotifications;
  bool? _marketingEmails;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _theme = widget.item?.theme;
    _language = widget.item?.language;
    _timezone = widget.item?.timezone;
    _dateFormat = widget.item?.dateFormat;
    _currency = widget.item?.currency;
    _emailNotifications = widget.item?.emailNotifications;
    _pushNotifications = widget.item?.pushNotifications;
    _marketingEmails = widget.item?.marketingEmails;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.userpreference'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.userpreference'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _theme?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.theme'.tr()),
              onChanged: (v) => _theme = v,
            ),
            TextFormField(
              initialValue: _language?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.language'.tr()),
              onChanged: (v) => _language = v,
            ),
            TextFormField(
              initialValue: _timezone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timezone'.tr()),
              onChanged: (v) => _timezone = v,
            ),
            TextFormField(
              initialValue: _dateFormat?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dateformat'.tr()),
              onChanged: (v) => _dateFormat = v,
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.emailnotifications'.tr()),
              value: _emailNotifications ?? false,
              onChanged: (v) => setState(() => _emailNotifications = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.pushnotifications'.tr()),
              value: _pushNotifications ?? false,
              onChanged: (v) => setState(() => _pushNotifications = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.marketingemails'.tr()),
              value: _marketingEmails ?? false,
              onChanged: (v) => setState(() => _marketingEmails = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_theme != null) 'theme': _theme,
                  if (_language != null) 'language': _language,
                  if (_timezone != null) 'timezone': _timezone,
                  if (_dateFormat != null) 'dateFormat': _dateFormat,
                  if (_currency != null) 'currency': _currency,
                  'emailNotifications': _emailNotifications,
                  'pushNotifications': _pushNotifications,
                  'marketingEmails': _marketingEmails,
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
                  widget.onSubmit(UserPreference.fromJson(json));
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
