import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class UserActivityLogFormWidget extends ConsumerStatefulWidget {
  final UserActivityLog? item;
  final Function(UserActivityLog) onSubmit;
  const UserActivityLogFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<UserActivityLogFormWidget> createState() =>
      _UserActivityLogFormWidgetState();
}

class _UserActivityLogFormWidgetState
    extends ConsumerState<UserActivityLogFormWidget> {
  String? _userId;
  String? _action;
  String? _entityType;
  String? _entityId;
  String? _ipAddres;
  String? _userAgent;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _action = widget.item?.action;
    _entityType = widget.item?.entityType;
    _entityId = widget.item?.entityId;
    _ipAddres = widget.item?.ipAddres;
    _userAgent = widget.item?.userAgent;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.useractivitylog'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.useractivitylog'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _action?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.action'.tr()),
              onChanged: (v) => _action = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _ipAddres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ipaddres'.tr()),
              onChanged: (v) => _ipAddres = v,
            ),
            TextFormField(
              initialValue: _userAgent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.useragent'.tr()),
              onChanged: (v) => _userAgent = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_action != null) 'action': _action,
                  if (_entityType != null) 'entityType': _entityType,
                  if (_entityId != null) 'entityId': _entityId,
                  if (_ipAddres != null) 'ipAddres': _ipAddres,
                  if (_userAgent != null) 'userAgent': _userAgent,
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
                  widget.onSubmit(UserActivityLog.fromJson(json));
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
