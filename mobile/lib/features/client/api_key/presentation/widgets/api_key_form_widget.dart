import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiKeyFormWidget extends ConsumerStatefulWidget {
  final ApiKey? item;
  final Function(ApiKey) onSubmit;
  const ApiKeyFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ApiKeyFormWidget> createState() => _ApiKeyFormWidgetState();
}

class _ApiKeyFormWidgetState extends ConsumerState<ApiKeyFormWidget> {
  String? _userId;
  String? _name;
  String? _keyHash;
  DateTime? _lastUsedAt;
  DateTime? _expiresAt;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _keyHash = widget.item?.keyHash;
    _lastUsedAt = widget.item?.lastUsedAt;
    _expiresAt = widget.item?.expiresAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.apikey'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.apikey'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _keyHash?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.keyhash'.tr()),
              onChanged: (v) => _keyHash = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_used_at'.tr()}: ${_lastUsedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastUsedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastUsedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_keyHash != null) 'keyHash': _keyHash,
                  if (_lastUsedAt != null)
                    'lastUsedAt': _lastUsedAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
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
                  widget.onSubmit(ApiKey.fromJson(json));
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
