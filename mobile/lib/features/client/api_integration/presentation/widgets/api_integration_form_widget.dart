import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class APIIntegrationFormWidget extends ConsumerStatefulWidget {
  final APIIntegration? item;
  final Function(APIIntegration) onSubmit;
  const APIIntegrationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<APIIntegrationFormWidget> createState() =>
      _APIIntegrationFormWidgetState();
}

class _APIIntegrationFormWidgetState
    extends ConsumerState<APIIntegrationFormWidget> {
  String? _providerName;
  String? _integrationType;
  String? _apiKeyCiphertext;
  String? _apiSecretCiphertext;
  String? _accessTokenCiphertext;
  String? _refreshTokenCiphertext;
  String? _baseUrl;
  int? _rateLimit;
  int? _timeout;
  String? _status;
  DateTime? _lastUsedAt;
  int? _errorCount;
  String? _lastError;
  bool? _isSandbox;
  @override
  void initState() {
    super.initState();
    _providerName = widget.item?.providerName;
    _integrationType = widget.item?.integrationType;
    _apiKeyCiphertext = widget.item?.apiKeyCiphertext;
    _apiSecretCiphertext = widget.item?.apiSecretCiphertext;
    _accessTokenCiphertext = widget.item?.accessTokenCiphertext;
    _refreshTokenCiphertext = widget.item?.refreshTokenCiphertext;
    _baseUrl = widget.item?.baseUrl;
    _rateLimit = widget.item?.rateLimit;
    _timeout = widget.item?.timeout;
    _status = widget.item?.status;
    _lastUsedAt = widget.item?.lastUsedAt;
    _errorCount = widget.item?.errorCount;
    _lastError = widget.item?.lastError;
    _isSandbox = widget.item?.isSandbox;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.apiintegration'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.apiintegration'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _providerName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.providername'.tr()),
              onChanged: (v) => _providerName = v,
            ),
            TextFormField(
              initialValue: _integrationType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.integrationtype'.tr()),
              onChanged: (v) => _integrationType = v,
            ),
            TextFormField(
              initialValue: _apiKeyCiphertext?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.apikeyciphertext'.tr()),
              onChanged: (v) => _apiKeyCiphertext = v,
            ),
            TextFormField(
              initialValue: _apiSecretCiphertext?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.apisecretciphertext'.tr(),
              ),
              onChanged: (v) => _apiSecretCiphertext = v,
            ),
            TextFormField(
              initialValue: _accessTokenCiphertext?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.accesstokenciphertext'.tr(),
              ),
              onChanged: (v) => _accessTokenCiphertext = v,
            ),
            TextFormField(
              initialValue: _refreshTokenCiphertext?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.refreshtokenciphertext'.tr(),
              ),
              onChanged: (v) => _refreshTokenCiphertext = v,
            ),
            TextFormField(
              initialValue: _baseUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseurl'.tr()),
              onChanged: (v) => _baseUrl = v,
            ),
            TextFormField(
              initialValue: _rateLimit?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ratelimit'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rateLimit = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _timeout?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timeout'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _timeout = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_used_at'.tr()}: ${_lastUsedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastUsedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastUsedAt = d);
              },
            ),
            TextFormField(
              initialValue: _errorCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.errorcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _errorCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lastError?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lasterror'.tr()),
              onChanged: (v) => _lastError = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.issandbox'.tr()),
              value: _isSandbox ?? false,
              onChanged: (v) => setState(() => _isSandbox = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_providerName != null) 'providerName': _providerName,
                  if (_integrationType != null)
                    'integrationType': _integrationType,
                  if (_apiKeyCiphertext != null)
                    'apiKeyCiphertext': _apiKeyCiphertext,
                  if (_apiSecretCiphertext != null)
                    'apiSecretCiphertext': _apiSecretCiphertext,
                  if (_accessTokenCiphertext != null)
                    'accessTokenCiphertext': _accessTokenCiphertext,
                  if (_refreshTokenCiphertext != null)
                    'refreshTokenCiphertext': _refreshTokenCiphertext,
                  if (_baseUrl != null) 'baseUrl': _baseUrl,
                  if (_rateLimit != null) 'rateLimit': _rateLimit,
                  if (_timeout != null) 'timeout': _timeout,
                  if (_status != null) 'status': _status,
                  if (_lastUsedAt != null)
                    'lastUsedAt': _lastUsedAt!.toIso8601String(),
                  if (_errorCount != null) 'errorCount': _errorCount,
                  if (_lastError != null) 'lastError': _lastError,
                  'isSandbox': _isSandbox,
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
                  widget.onSubmit(APIIntegration.fromJson(json));
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
