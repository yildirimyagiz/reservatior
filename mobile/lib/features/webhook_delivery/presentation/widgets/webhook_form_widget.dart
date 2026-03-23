import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Webhook Form Widget ──
// Fields: name, description, url, secret, headers, isActive, lastTriggeredAt, failureCount

class WebhookFormWidget extends StatefulWidget {
  final Webhook? item;
  final void Function(Webhook)? onSubmit;
  const WebhookFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<WebhookFormWidget> createState() => _WebhookFormWidgetState();
}

class _WebhookFormWidgetState extends State<WebhookFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _name;
  String? _description;
  String? _url;
  String? _secret;
  String? _headers;
  bool _isActive = false;
  DateTime? _lastTriggeredAt;
  int? _failureCount;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _url = widget.item?.url?.toString();
    _secret = widget.item?.secret?.toString();
    _headers = widget.item?.headers?.toString();
    _isActive = widget.item?.isActive ?? false;
    _lastTriggeredAt = widget.item?.lastTriggeredAt;
    _failureCount = widget.item?.failureCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name != null) 'name': _name,
        if (_description != null) 'description': _description,
        if (_url != null) 'url': _url,
        if (_secret != null) 'secret': _secret,
        if (_headers != null) 'headers': _headers,
        'isActive': _isActive,
        if (_lastTriggeredAt != null) 'lastTriggeredAt': _lastTriggeredAt!.toIso8601String(),
        if (_failureCount != null) 'failureCount': _failureCount,
    };
    final result = widget.item != null
        ? Webhook.fromJson({...widget.item!.toJson(), ...data})
        : Webhook.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _secret = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Headers', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _headers = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _lastTriggeredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastTriggeredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Triggered At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_lastTriggeredAt != null ? _fmt(_lastTriggeredAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Failure Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _failureCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Webhook'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
