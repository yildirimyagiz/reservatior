import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiModelDeploymentFormWidget extends ConsumerStatefulWidget {
  final AiModelDeployment? item;
  final Function(AiModelDeployment) onSubmit;
  const AiModelDeploymentFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiModelDeploymentFormWidget> createState() =>
      _AiModelDeploymentFormWidgetState();
}

class _AiModelDeploymentFormWidgetState
    extends ConsumerState<AiModelDeploymentFormWidget> {
  String? _modelId;
  String? _deploymentId;
  String? _environment;
  String? _status;
  DateTime? _deployedAt;
  DateTime? _lastHealthCheck;
  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId;
    _deploymentId = widget.item?.deploymentId;
    _environment = widget.item?.environment;
    _status = widget.item?.status;
    _deployedAt = widget.item?.deployedAt;
    _lastHealthCheck = widget.item?.lastHealthCheck;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aimodeldeployment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aimodeldeployment'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _modelId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.modelid'.tr()),
              onChanged: (v) => _modelId = v,
            ),
            TextFormField(
              initialValue: _deploymentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deploymentid'.tr()),
              onChanged: (v) => _deploymentId = v,
            ),
            TextFormField(
              initialValue: _environment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.environment'.tr()),
              onChanged: (v) => _environment = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_deployed_at'.tr()}: ${_deployedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deployedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _deployedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_health_check'.tr()}: ${_lastHealthCheck ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastHealthCheck ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastHealthCheck = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_modelId != null) 'modelId': _modelId,
                  if (_deploymentId != null) 'deploymentId': _deploymentId,
                  if (_environment != null) 'environment': _environment,
                  if (_status != null) 'status': _status,
                  if (_deployedAt != null)
                    'deployedAt': _deployedAt!.toIso8601String(),
                  if (_lastHealthCheck != null)
                    'lastHealthCheck': _lastHealthCheck!.toIso8601String(),
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
                  widget.onSubmit(AiModelDeployment.fromJson(json));
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
