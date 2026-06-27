import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class HealthCheckFormWidget extends ConsumerStatefulWidget {
  final HealthCheck? item;
  final Function(HealthCheck) onSubmit;
  const HealthCheckFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<HealthCheckFormWidget> createState() =>
      _HealthCheckFormWidgetState();
}

class _HealthCheckFormWidgetState extends ConsumerState<HealthCheckFormWidget> {
  String? _serviceName;
  String? _componentName;
  String? _status;
  int? _responseTime;
  String? _errorMessage;
  DateTime? _checkedAt;
  @override
  void initState() {
    super.initState();
    _serviceName = widget.item?.serviceName;
    _componentName = widget.item?.componentName;
    _status = widget.item?.status;
    _responseTime = widget.item?.responseTime;
    _errorMessage = widget.item?.errorMessage;
    _checkedAt = widget.item?.checkedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.healthcheck'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.healthcheck'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _serviceName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.servicename'.tr()),
              onChanged: (v) => _serviceName = v,
            ),
            TextFormField(
              initialValue: _componentName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.componentname'.tr()),
              onChanged: (v) => _componentName = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _responseTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.responsetime'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _responseTime = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _errorMessage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errormessage'.tr()),
              onChanged: (v) => _errorMessage = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_checked_at'.tr()}: ${_checkedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _checkedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _checkedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_serviceName != null) 'serviceName': _serviceName,
                  if (_componentName != null) 'componentName': _componentName,
                  if (_status != null) 'status': _status,
                  if (_responseTime != null) 'responseTime': _responseTime,
                  if (_errorMessage != null) 'errorMessage': _errorMessage,
                  if (_checkedAt != null)
                    'checkedAt': _checkedAt!.toIso8601String(),
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
                  widget.onSubmit(HealthCheck.fromJson(json));
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
