import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MobileDeviceFormWidget extends ConsumerStatefulWidget {
  final MobileDevice? item;
  final Function(MobileDevice) onSubmit;
  const MobileDeviceFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MobileDeviceFormWidget> createState() =>
      _MobileDeviceFormWidgetState();
}

class _MobileDeviceFormWidgetState
    extends ConsumerState<MobileDeviceFormWidget> {
  String? _userId;
  String? _deviceId;
  String? _deviceType;
  String? _deviceToken;
  String? _appVersion;
  String? _osVersion;
  bool? _isActive;
  DateTime? _lastLoginAt;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _deviceId = widget.item?.deviceId;
    _deviceType = widget.item?.deviceType;
    _deviceToken = widget.item?.deviceToken;
    _appVersion = widget.item?.appVersion;
    _osVersion = widget.item?.osVersion;
    _isActive = widget.item?.isActive;
    _lastLoginAt = widget.item?.lastLoginAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mobiledevice'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mobiledevice'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _deviceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deviceid'.tr()),
              onChanged: (v) => _deviceId = v,
            ),
            TextFormField(
              initialValue: _deviceType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.devicetype'.tr()),
              onChanged: (v) => _deviceType = v,
            ),
            TextFormField(
              initialValue: _deviceToken?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.devicetoken'.tr()),
              onChanged: (v) => _deviceToken = v,
            ),
            TextFormField(
              initialValue: _appVersion?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.appversion'.tr()),
              onChanged: (v) => _appVersion = v,
            ),
            TextFormField(
              initialValue: _osVersion?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.osversion'.tr()),
              onChanged: (v) => _osVersion = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_login_at'.tr()}: ${_lastLoginAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastLoginAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastLoginAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_deviceId != null) 'deviceId': _deviceId,
                  if (_deviceType != null) 'deviceType': _deviceType,
                  if (_deviceToken != null) 'deviceToken': _deviceToken,
                  if (_appVersion != null) 'appVersion': _appVersion,
                  if (_osVersion != null) 'osVersion': _osVersion,
                  'isActive': _isActive,
                  if (_lastLoginAt != null)
                    'lastLoginAt': _lastLoginAt!.toIso8601String(),
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
                  widget.onSubmit(MobileDevice.fromJson(json));
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
