import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class IntegrationLogFormWidget extends ConsumerStatefulWidget {
  final IntegrationLog? item;
  final Function(IntegrationLog) onSubmit;
  const IntegrationLogFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<IntegrationLogFormWidget> createState() =>
      _IntegrationLogFormWidgetState();
}

class _IntegrationLogFormWidgetState
    extends ConsumerState<IntegrationLogFormWidget> {
  String? _integrationType;
  String? _operation;
  int? _statusCode;
  bool? _succes;
  String? _errorMessage;
  int? _processingTimeMs;
  String? _externalId;
  String? _correlationId;
  @override
  void initState() {
    super.initState();
    _integrationType = widget.item?.integrationType;
    _operation = widget.item?.operation;
    _statusCode = widget.item?.statusCode;
    _succes = widget.item?.succes;
    _errorMessage = widget.item?.errorMessage;
    _processingTimeMs = widget.item?.processingTimeMs;
    _externalId = widget.item?.externalId;
    _correlationId = widget.item?.correlationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.integrationlog'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.integrationlog'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _integrationType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.integrationtype'.tr()),
              onChanged: (v) => _integrationType = v,
            ),
            TextFormField(
              initialValue: _operation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.operation'.tr()),
              onChanged: (v) => _operation = v,
            ),
            TextFormField(
              initialValue: _statusCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.statuscode'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _statusCode = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.succes'.tr()),
              value: _succes ?? false,
              onChanged: (v) => setState(() => _succes = v),
            ),
            TextFormField(
              initialValue: _errorMessage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errormessage'.tr()),
              onChanged: (v) => _errorMessage = v,
            ),
            TextFormField(
              initialValue: _processingTimeMs?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.processingtimems'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _processingTimeMs = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _correlationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.correlationid'.tr()),
              onChanged: (v) => _correlationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_integrationType != null)
                    'integrationType': _integrationType,
                  if (_operation != null) 'operation': _operation,
                  if (_statusCode != null) 'statusCode': _statusCode,
                  'succes': _succes,
                  if (_errorMessage != null) 'errorMessage': _errorMessage,
                  if (_processingTimeMs != null)
                    'processingTimeMs': _processingTimeMs,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_correlationId != null) 'correlationId': _correlationId,
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
                  widget.onSubmit(IntegrationLog.fromJson(json));
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
