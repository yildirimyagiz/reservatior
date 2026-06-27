import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ApiTokenFormWidget extends ConsumerStatefulWidget {
  final ApiToken? item;
  final Function(ApiToken) onSubmit;
  const ApiTokenFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ApiTokenFormWidget> createState() => _ApiTokenFormWidgetState();
}

class _ApiTokenFormWidgetState extends ConsumerState<ApiTokenFormWidget> {
  String? _userId;
  String? _name;
  String? _tokenHash;
  DateTime? _lastUsedAt;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _tokenHash = widget.item?.tokenHash;
    _lastUsedAt = widget.item?.lastUsedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.apitoken'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.apitoken'.tr()}",
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
              initialValue: _tokenHash?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tokenhash'.tr()),
              onChanged: (v) => _tokenHash = v,
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_tokenHash != null) 'tokenHash': _tokenHash,
                  if (_lastUsedAt != null)
                    'lastUsedAt': _lastUsedAt!.toIso8601String(),
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
                  widget.onSubmit(ApiToken.fromJson(json));
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
