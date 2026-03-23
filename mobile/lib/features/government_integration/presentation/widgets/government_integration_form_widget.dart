import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GovernmentIntegration Form Widget  |  Fields: userId, region, name, baseUrl, isEnabled, apiKeyCiphertext, apiSecretCiphertext, tokenCiphertext, lastSyncAt, status, lastError

class GovernmentIntegrationFormWidget extends StatefulWidget {
  final GovernmentIntegration? item;
  final void Function(GovernmentIntegration)? onSubmit;
  const GovernmentIntegrationFormWidget({super.key, this.item, this.onSubmit});
  @override State<GovernmentIntegrationFormWidget> createState() => _GovernmentIntegrationFormWidgetState();
}

class _GovernmentIntegrationFormWidgetState extends State<GovernmentIntegrationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _region;
  String? _name;
  String? _baseUrl;
  bool _isEnabled = false;
  String? _apiKeyCiphertext;
  String? _apiSecretCiphertext;
  String? _tokenCiphertext;
  DateTime? _lastSyncAt;
  String? _status;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _region = widget.item?.region?.toString();
    _name = widget.item?.name?.toString();
    _baseUrl = widget.item?.baseUrl?.toString();
    _isEnabled = widget.item?.isEnabled ?? false;
    _apiKeyCiphertext = widget.item?.apiKeyCiphertext?.toString();
    _apiSecretCiphertext = widget.item?.apiSecretCiphertext?.toString();
    _tokenCiphertext = widget.item?.tokenCiphertext?.toString();
    _lastSyncAt = widget.item?.lastSyncAt;
    _status = widget.item?.status?.toString();
    _lastError = widget.item?.lastError?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_region?.isNotEmpty == true) 'region': _region,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
        'isEnabled': _isEnabled,
        if (_apiKeyCiphertext?.isNotEmpty == true) 'apiKeyCiphertext': _apiKeyCiphertext,
        if (_apiSecretCiphertext?.isNotEmpty == true) 'apiSecretCiphertext': _apiSecretCiphertext,
        if (_tokenCiphertext?.isNotEmpty == true) 'tokenCiphertext': _tokenCiphertext,
        if (_lastSyncAt != null) 'lastSyncAt': _lastSyncAt!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
    };
    final result = widget.item != null
        ? GovernmentIntegration.fromJson({...widget.item!.toJson(), ...data})
        : GovernmentIntegration.fromJson(data);
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
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _region = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Base Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _baseUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Enabled'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isEnabled,
                  onChanged: (v) { ss(() {}); setState(() => _isEnabled = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Key Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _apiKeyCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Secret Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _apiSecretCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Token Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tokenCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastSyncAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSyncAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Sync At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSyncAt != null ? _fmt(_lastSyncAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lastError = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Government Integration'),
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