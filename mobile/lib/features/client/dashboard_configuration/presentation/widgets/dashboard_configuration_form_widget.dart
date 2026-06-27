import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardConfigurationFormWidget extends ConsumerStatefulWidget {
  final DashboardConfiguration? item;
  final Function(DashboardConfiguration) onSubmit;
  const DashboardConfigurationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<DashboardConfigurationFormWidget> createState() =>
      _DashboardConfigurationFormWidgetState();
}

class _DashboardConfigurationFormWidgetState
    extends ConsumerState<DashboardConfigurationFormWidget> {
  String? _userId;
  String? _dashboardName;
  bool? _isDefault;
  String? _timeRange;
  bool? _isPublic;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _dashboardName = widget.item?.dashboardName;
    _isDefault = widget.item?.isDefault;
    _timeRange = widget.item?.timeRange;
    _isPublic = widget.item?.isPublic;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.dashboardconfiguration'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.dashboardconfiguration'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _dashboardName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dashboardname'.tr()),
              onChanged: (v) => _dashboardName = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isdefault'.tr()),
              value: _isDefault ?? false,
              onChanged: (v) => setState(() => _isDefault = v),
            ),
            TextFormField(
              initialValue: _timeRange?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timerange'.tr()),
              onChanged: (v) => _timeRange = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.ispublic'.tr()),
              value: _isPublic ?? false,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_dashboardName != null) 'dashboardName': _dashboardName,
                  'isDefault': _isDefault,
                  if (_timeRange != null) 'timeRange': _timeRange,
                  'isPublic': _isPublic,
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
                  widget.onSubmit(DashboardConfiguration.fromJson(json));
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
