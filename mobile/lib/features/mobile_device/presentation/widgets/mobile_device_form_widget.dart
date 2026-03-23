import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MobileDevice Form Widget  |  Fields: userId, deviceId, deviceType, deviceToken, appVersion, osVersion, isActive, lastLoginAt, notificationPreferences

class MobileDeviceFormWidget extends StatefulWidget {
  final MobileDevice? item;
  final void Function(MobileDevice)? onSubmit;
  const MobileDeviceFormWidget({super.key, this.item, this.onSubmit});
  @override State<MobileDeviceFormWidget> createState() => _MobileDeviceFormWidgetState();
}

class _MobileDeviceFormWidgetState extends State<MobileDeviceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _deviceId;
  String? _deviceType;
  String? _deviceToken;
  String? _appVersion;
  String? _osVersion;
  bool _isActive = false;
  DateTime? _lastLoginAt;
  String? _notificationPreferences;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _deviceId = widget.item?.deviceId?.toString();
    _deviceType = widget.item?.deviceType?.toString();
    _deviceToken = widget.item?.deviceToken?.toString();
    _appVersion = widget.item?.appVersion?.toString();
    _osVersion = widget.item?.osVersion?.toString();
    _isActive = widget.item?.isActive ?? false;
    _lastLoginAt = widget.item?.lastLoginAt;
    _notificationPreferences = widget.item?.notificationPreferences?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_deviceId?.isNotEmpty == true) 'deviceId': _deviceId,
        if (_deviceType?.isNotEmpty == true) 'deviceType': _deviceType,
        if (_deviceToken?.isNotEmpty == true) 'deviceToken': _deviceToken,
        if (_appVersion?.isNotEmpty == true) 'appVersion': _appVersion,
        if (_osVersion?.isNotEmpty == true) 'osVersion': _osVersion,
        'isActive': _isActive,
        if (_lastLoginAt != null) 'lastLoginAt': _lastLoginAt!.toIso8601String(),
        if (_notificationPreferences?.isNotEmpty == true) 'notificationPreferences': _notificationPreferences,
    };
    final result = widget.item != null
        ? MobileDevice.fromJson({...widget.item!.toJson(), ...data})
        : MobileDevice.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Device Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _deviceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Device Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _deviceType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Device Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _deviceToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'App Version', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _appVersion = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Os Version', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _osVersion = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastLoginAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastLoginAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Login At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastLoginAt != null ? _fmt(_lastLoginAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notification Preferences', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _notificationPreferences = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mobile Device'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}