import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── WebhookDelivery Form Widget  |  Fields: webhookId, eventType, payload, response, statusCode, deliveredAt, error

class WebhookDeliveryFormWidget extends StatefulWidget {
  final WebhookDelivery? item;
  final void Function(WebhookDelivery)? onSubmit;
  const WebhookDeliveryFormWidget({super.key, this.item, this.onSubmit});
  @override State<WebhookDeliveryFormWidget> createState() => _WebhookDeliveryFormWidgetState();
}

class _WebhookDeliveryFormWidgetState extends State<WebhookDeliveryFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _webhookId;
  String? _eventType;
  String? _payload;
  String? _response;
  int? _statusCode;
  DateTime? _deliveredAt;
  String? _error;

  @override
  void initState() {
    super.initState();
    _webhookId = widget.item?.webhookId?.toString();
    _eventType = widget.item?.eventType?.toString();
    _payload = widget.item?.payload?.toString();
    _response = widget.item?.response?.toString();
    _statusCode = widget.item?.statusCode;
    _deliveredAt = widget.item?.deliveredAt;
    _error = widget.item?.error?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_webhookId?.isNotEmpty == true) 'webhookId': _webhookId,
        if (_eventType?.isNotEmpty == true) 'eventType': _eventType,
        if (_payload?.isNotEmpty == true) 'payload': _payload,
        if (_response?.isNotEmpty == true) 'response': _response,
        if (_statusCode != null) 'statusCode': _statusCode,
        if (_deliveredAt != null) 'deliveredAt': _deliveredAt!.toIso8601String(),
        if (_error?.isNotEmpty == true) 'error': _error,
    };
    final result = widget.item != null
        ? WebhookDelivery.fromJson({...widget.item!.toJson(), ...data})
        : WebhookDelivery.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Webhook Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _webhookId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _eventType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payload', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _payload = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Response', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _response = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status Code', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _statusCode = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _deliveredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _deliveredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Delivered At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_deliveredAt != null ? _fmt(_deliveredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _error = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Webhook Delivery'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}