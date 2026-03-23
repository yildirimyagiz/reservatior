import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MLSConnection Form Widget  |  Fields: provider, name, baseUrl, isEnabled, usernameCiphertext, passwordCiphertext, apiKeyCiphertext, tokenCiphertext, region, config, lastSyncAt, status, lastError

class MLSConnectionFormWidget extends StatefulWidget {
  final MLSConnection? item;
  final void Function(MLSConnection)? onSubmit;
  const MLSConnectionFormWidget({super.key, this.item, this.onSubmit});
  @override State<MLSConnectionFormWidget> createState() => _MLSConnectionFormWidgetState();
}

class _MLSConnectionFormWidgetState extends State<MLSConnectionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _provider;
  String? _name;
  String? _baseUrl;
  bool _isEnabled = false;
  String? _usernameCiphertext;
  String? _passwordCiphertext;
  String? _apiKeyCiphertext;
  String? _tokenCiphertext;
  String? _region;
  String? _config;
  DateTime? _lastSyncAt;
  String? _status;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _provider = widget.item?.provider?.toString();
    _name = widget.item?.name?.toString();
    _baseUrl = widget.item?.baseUrl?.toString();
    _isEnabled = widget.item?.isEnabled ?? false;
    _usernameCiphertext = widget.item?.usernameCiphertext?.toString();
    _passwordCiphertext = widget.item?.passwordCiphertext?.toString();
    _apiKeyCiphertext = widget.item?.apiKeyCiphertext?.toString();
    _tokenCiphertext = widget.item?.tokenCiphertext?.toString();
    _region = widget.item?.region?.toString();
    _config = widget.item?.config?.toString();
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
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
        'isEnabled': _isEnabled,
        if (_usernameCiphertext?.isNotEmpty == true) 'usernameCiphertext': _usernameCiphertext,
        if (_passwordCiphertext?.isNotEmpty == true) 'passwordCiphertext': _passwordCiphertext,
        if (_apiKeyCiphertext?.isNotEmpty == true) 'apiKeyCiphertext': _apiKeyCiphertext,
        if (_tokenCiphertext?.isNotEmpty == true) 'tokenCiphertext': _tokenCiphertext,
        if (_region?.isNotEmpty == true) 'region': _region,
        if (_config?.isNotEmpty == true) 'config': _config,
        if (_lastSyncAt != null) 'lastSyncAt': _lastSyncAt!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
    };
    final result = widget.item != null
        ? MLSConnection.fromJson({...widget.item!.toJson(), ...data})
        : MLSConnection.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Username Ciphertext', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _usernameCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _passwordCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Key Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _apiKeyCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Token Ciphertext', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tokenCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _region = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create M L S Connection'),
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