import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class WebhookDeliveryFormWidget extends ConsumerStatefulWidget {
  final WebhookDelivery? item;
  final Function(WebhookDelivery) onSubmit;
  const WebhookDeliveryFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<WebhookDeliveryFormWidget> createState() =>
      _WebhookDeliveryFormWidgetState();
}

class _WebhookDeliveryFormWidgetState
    extends ConsumerState<WebhookDeliveryFormWidget> {
  String? _webhookId;
  String? _eventType;
  int? _statusCode;
  DateTime? _deliveredAt;
  String? _error;
  @override
  void initState() {
    super.initState();
    _webhookId = widget.item?.webhookId;
    _eventType = widget.item?.eventType;
    _statusCode = widget.item?.statusCode;
    _deliveredAt = widget.item?.deliveredAt;
    _error = widget.item?.error;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.webhookdelivery'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.webhookdelivery'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _webhookId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.webhookid'.tr()),
              onChanged: (v) => _webhookId = v,
            ),
            TextFormField(
              initialValue: _eventType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.eventtype'.tr()),
              onChanged: (v) => _eventType = v,
            ),
            TextFormField(
              initialValue: _statusCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.statuscode'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _statusCode = int.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_delivered_at'.tr()}: ${_deliveredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _deliveredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _deliveredAt = d);
              },
            ),
            TextFormField(
              initialValue: _error?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.error'.tr()),
              onChanged: (v) => _error = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_webhookId != null) 'webhookId': _webhookId,
                  if (_eventType != null) 'eventType': _eventType,
                  if (_statusCode != null) 'statusCode': _statusCode,
                  if (_deliveredAt != null)
                    'deliveredAt': _deliveredAt!.toIso8601String(),
                  if (_error != null) 'error': _error,
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
                  widget.onSubmit(WebhookDelivery.fromJson(json));
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
