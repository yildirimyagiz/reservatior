import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountFormWidget extends ConsumerStatefulWidget {
  final Account? item;
  final Function(Account) onSubmit;
  const AccountFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AccountFormWidget> createState() => _AccountFormWidgetState();
}

class _AccountFormWidgetState extends ConsumerState<AccountFormWidget> {
  String? _userId;
  String? _providerId;
  String? _accountId;
  String? _refreshToken;
  String? _accessToken;
  DateTime? _accessTokenExpiresAt;
  String? _tokenType;
  String? _scope;
  String? _idToken;
  String? _sessionState;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _providerId = widget.item?.providerId;
    _accountId = widget.item?.accountId;
    _refreshToken = widget.item?.refreshToken;
    _accessToken = widget.item?.accessToken;
    _accessTokenExpiresAt = widget.item?.accessTokenExpiresAt;
    _tokenType = widget.item?.tokenType;
    _scope = widget.item?.scope;
    _idToken = widget.item?.idToken;
    _sessionState = widget.item?.sessionState;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.account'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.account'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _providerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.providerid'.tr()),
              onChanged: (v) => _providerId = v,
            ),
            TextFormField(
              initialValue: _accountId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accountid'.tr()),
              onChanged: (v) => _accountId = v,
            ),
            TextFormField(
              initialValue: _refreshToken?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.refreshtoken'.tr()),
              onChanged: (v) => _refreshToken = v,
            ),
            TextFormField(
              initialValue: _accessToken?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accesstoken'.tr()),
              onChanged: (v) => _accessToken = v,
            ),
            ListTile(
              title: Text(
                'accessTokenExpiresAt: ${_accessTokenExpiresAt ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _accessTokenExpiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _accessTokenExpiresAt = d);
              },
            ),
            TextFormField(
              initialValue: _tokenType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tokentype'.tr()),
              onChanged: (v) => _tokenType = v,
            ),
            TextFormField(
              initialValue: _scope?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.scope'.tr()),
              onChanged: (v) => _scope = v,
            ),
            TextFormField(
              initialValue: _idToken?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.idtoken'.tr()),
              onChanged: (v) => _idToken = v,
            ),
            TextFormField(
              initialValue: _sessionState?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sessionstate'.tr()),
              onChanged: (v) => _sessionState = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_providerId != null) 'providerId': _providerId,
                  if (_accountId != null) 'accountId': _accountId,
                  if (_refreshToken != null) 'refreshToken': _refreshToken,
                  if (_accessToken != null) 'accessToken': _accessToken,
                  if (_accessTokenExpiresAt != null)
                    'accessTokenExpiresAt': _accessTokenExpiresAt!
                        .toIso8601String(),
                  if (_tokenType != null) 'tokenType': _tokenType,
                  if (_scope != null) 'scope': _scope,
                  if (_idToken != null) 'idToken': _idToken,
                  if (_sessionState != null) 'sessionState': _sessionState,
                  'isActive': _isActive,
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
                  widget.onSubmit(Account.fromJson(json));
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
