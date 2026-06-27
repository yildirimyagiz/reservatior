import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class WebhookFormWidget extends ConsumerStatefulWidget {
  final Webhook? item;
  final Function(Webhook) onSubmit;
  const WebhookFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<WebhookFormWidget> createState() => _WebhookFormWidgetState();
}

class _WebhookFormWidgetState extends ConsumerState<WebhookFormWidget> {
  String? _name;
  String? _description;
  String? _url;
  String? _secret;
  bool? _isActive;
  DateTime? _lastTriggeredAt;
  int? _failureCount;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _description = widget.item?.description;
    _url = widget.item?.url;
    _secret = widget.item?.secret;
    _isActive = widget.item?.isActive;
    _lastTriggeredAt = widget.item?.lastTriggeredAt;
    _failureCount = widget.item?.failureCount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.webhook'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.webhook'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _url?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.url'.tr()),
              onChanged: (v) => _url = v,
            ),
            TextFormField(
              initialValue: _secret?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.secret'.tr()),
              onChanged: (v) => _secret = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_triggered_at'.tr()}: ${_lastTriggeredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastTriggeredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastTriggeredAt = d);
              },
            ),
            TextFormField(
              initialValue: _failureCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.failurecount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _failureCount = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_url != null) 'url': _url,
                  if (_secret != null) 'secret': _secret,
                  'isActive': _isActive,
                  if (_lastTriggeredAt != null)
                    'lastTriggeredAt': _lastTriggeredAt!.toIso8601String(),
                  if (_failureCount != null) 'failureCount': _failureCount,
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
                  widget.onSubmit(Webhook.fromJson(json));
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
