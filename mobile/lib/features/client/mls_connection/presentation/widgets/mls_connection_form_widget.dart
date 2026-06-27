import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlsConnectionFormWidget extends ConsumerStatefulWidget {
  final MlsConnection? item;
  final Function(MlsConnection) onSubmit;
  const MlsConnectionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<MlsConnectionFormWidget> createState() =>
      _MlsConnectionFormWidgetState();
}

class _MlsConnectionFormWidgetState
    extends ConsumerState<MlsConnectionFormWidget> {
  String? _name;
  String? _baseUrl;
  bool? _isEnabled;
  String? _usernameCiphertext;
  String? _passwordCiphertext;
  String? _apiKeyCiphertext;
  String? _tokenCiphertext;
  DateTime? _lastSyncAt;
  String? _lastError;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _baseUrl = widget.item?.baseUrl;
    _isEnabled = widget.item?.isEnabled;
    _usernameCiphertext = widget.item?.usernameCiphertext;
    _passwordCiphertext = widget.item?.passwordCiphertext;
    _apiKeyCiphertext = widget.item?.apiKeyCiphertext;
    _tokenCiphertext = widget.item?.tokenCiphertext;
    _lastSyncAt = widget.item?.lastSyncAt;
    _lastError = widget.item?.lastError;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlsconnection'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlsconnection'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _baseUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseurl'.tr()),
              onChanged: (v) => _baseUrl = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isenabled'.tr()),
              value: _isEnabled ?? false,
              onChanged: (v) => setState(() => _isEnabled = v),
            ),
            TextFormField(
              initialValue: _usernameCiphertext?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.usernameciphertext'.tr(),
              ),
              onChanged: (v) => _usernameCiphertext = v,
            ),
            TextFormField(
              initialValue: _passwordCiphertext?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.passwordciphertext'.tr(),
              ),
              onChanged: (v) => _passwordCiphertext = v,
            ),
            TextFormField(
              initialValue: _apiKeyCiphertext?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.apikeyciphertext'.tr()),
              onChanged: (v) => _apiKeyCiphertext = v,
            ),
            TextFormField(
              initialValue: _tokenCiphertext?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tokenciphertext'.tr()),
              onChanged: (v) => _tokenCiphertext = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_sync_at'.tr()}: ${_lastSyncAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSyncAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSyncAt = d);
              },
            ),
            TextFormField(
              initialValue: _lastError?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lasterror'.tr()),
              onChanged: (v) => _lastError = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_baseUrl != null) 'baseUrl': _baseUrl,
                  'isEnabled': _isEnabled,
                  if (_usernameCiphertext != null)
                    'usernameCiphertext': _usernameCiphertext,
                  if (_passwordCiphertext != null)
                    'passwordCiphertext': _passwordCiphertext,
                  if (_apiKeyCiphertext != null)
                    'apiKeyCiphertext': _apiKeyCiphertext,
                  if (_tokenCiphertext != null)
                    'tokenCiphertext': _tokenCiphertext,
                  if (_lastSyncAt != null)
                    'lastSyncAt': _lastSyncAt!.toIso8601String(),
                  if (_lastError != null) 'lastError': _lastError,
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
                  widget.onSubmit(MlsConnection.fromJson(json));
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
