import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ApiIntegration Form Widget  |  Fields: platform, name, isEnabled, apiKey, apiSecret, accessToken, refreshToken, tokenExpiry, baseUrl, config, rateLimit, syncDirection, autoSync, syncInterval, lastSyncAt, lastSyncStatus, lastError

class ApiIntegrationFormWidget extends StatefulWidget {
  final ApiIntegration? item;
  final void Function(ApiIntegration)? onSubmit;
  const ApiIntegrationFormWidget({super.key, this.item, this.onSubmit});
  @override State<ApiIntegrationFormWidget> createState() => _ApiIntegrationFormWidgetState();
}

class _ApiIntegrationFormWidgetState extends State<ApiIntegrationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _platform;
  String? _name;
  bool _isEnabled = false;
  String? _apiKey;
  String? _apiSecret;
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;
  String? _baseUrl;
  String? _config;
  int? _rateLimit;
  String? _syncDirection;
  bool _autoSync = false;
  int? _syncInterval;
  DateTime? _lastSyncAt;
  String? _lastSyncStatus;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _platform = widget.item?.platform?.toString();
    _name = widget.item?.name?.toString();
    _isEnabled = widget.item?.isEnabled ?? false;
    _apiKey = widget.item?.apiKey?.toString();
    _apiSecret = widget.item?.apiSecret?.toString();
    _accessToken = widget.item?.accessToken?.toString();
    _refreshToken = widget.item?.refreshToken?.toString();
    _tokenExpiry = widget.item?.tokenExpiry;
    _baseUrl = widget.item?.baseUrl?.toString();
    _config = widget.item?.config?.toString();
    _rateLimit = widget.item?.rateLimit;
    _syncDirection = widget.item?.syncDirection?.toString();
    _autoSync = widget.item?.autoSync ?? false;
    _syncInterval = widget.item?.syncInterval;
    _lastSyncAt = widget.item?.lastSyncAt;
    _lastSyncStatus = widget.item?.lastSyncStatus?.toString();
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
        if (_platform?.isNotEmpty == true) 'platform': _platform,
        if (_name?.isNotEmpty == true) 'name': _name,
        'isEnabled': _isEnabled,
        if (_apiKey?.isNotEmpty == true) 'apiKey': _apiKey,
        if (_apiSecret?.isNotEmpty == true) 'apiSecret': _apiSecret,
        if (_accessToken?.isNotEmpty == true) 'accessToken': _accessToken,
        if (_refreshToken?.isNotEmpty == true) 'refreshToken': _refreshToken,
        if (_tokenExpiry != null) 'tokenExpiry': _tokenExpiry!.toIso8601String(),
        if (_baseUrl?.isNotEmpty == true) 'baseUrl': _baseUrl,
        if (_config?.isNotEmpty == true) 'config': _config,
        if (_rateLimit != null) 'rateLimit': _rateLimit,
        if (_syncDirection?.isNotEmpty == true) 'syncDirection': _syncDirection,
        'autoSync': _autoSync,
        if (_syncInterval != null) 'syncInterval': _syncInterval,
        if (_lastSyncAt != null) 'lastSyncAt': _lastSyncAt!.toIso8601String(),
        if (_lastSyncStatus?.isNotEmpty == true) 'lastSyncStatus': _lastSyncStatus,
        if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
    };
    final result = widget.item != null
        ? ApiIntegration.fromJson({...widget.item!.toJson(), ...data})
        : ApiIntegration.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _platform?.toString() ?? '',
                onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _name?.toString() ?? '',
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Api Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _apiKey?.toString() ?? '',
                onSaved: (v) => _apiKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Secret', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _apiSecret?.toString() ?? '',
                onSaved: (v) => _apiSecret = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Access Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _accessToken?.toString() ?? '',
                onSaved: (v) => _accessToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Refresh Token', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _refreshToken?.toString() ?? '',
                onSaved: (v) => _refreshToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _tokenExpiry ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _tokenExpiry = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Token Expiry',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_tokenExpiry != null ? _fmt(_tokenExpiry) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Base Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _baseUrl?.toString() ?? '',
                onSaved: (v) => _baseUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _config?.toString() ?? '',
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate Limit', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _rateLimit?.toString() ?? '',
                onSaved: (v) => _rateLimit = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sync Direction', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _syncDirection?.toString() ?? '',
                onSaved: (v) => _syncDirection = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Auto Sync'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _autoSync,
                  onChanged: (v) { ss(() {}); setState(() => _autoSync = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sync Interval', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _syncInterval?.toString() ?? '',
                onSaved: (v) => _syncInterval = int.tryParse(v ?? ''),
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
                decoration: InputDecoration(labelText: 'Last Sync Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _lastSyncStatus?.toString() ?? '',
                onSaved: (v) => _lastSyncStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _lastError?.toString() ?? '',
                onSaved: (v) => _lastError = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Api Integration'),
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