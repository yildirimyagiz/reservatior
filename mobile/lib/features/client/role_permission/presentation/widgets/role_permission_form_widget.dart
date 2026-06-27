import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RolePermissionFormWidget extends ConsumerStatefulWidget {
  final RolePermission? item;
  final Function(RolePermission) onSubmit;
  const RolePermissionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<RolePermissionFormWidget> createState() =>
      _RolePermissionFormWidgetState();
}

class _RolePermissionFormWidgetState
    extends ConsumerState<RolePermissionFormWidget> {
  String? _roleId;
  String? _permissionId;
  @override
  void initState() {
    super.initState();
    _roleId = widget.item?.roleId;
    _permissionId = widget.item?.permissionId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.rolepermission'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.rolepermission'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _roleId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.roleid'.tr()),
              onChanged: (v) => _roleId = v,
            ),
            TextFormField(
              initialValue: _permissionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.permissionid'.tr()),
              onChanged: (v) => _permissionId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_roleId != null) 'roleId': _roleId,
                  if (_permissionId != null) 'permissionId': _permissionId,
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
                  widget.onSubmit(RolePermission.fromJson(json));
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
