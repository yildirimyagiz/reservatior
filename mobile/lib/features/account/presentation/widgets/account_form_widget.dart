import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Account Form Widget  |  Fields: userId, type, providerId, accountId, refreshToken, accessToken, accessTokenExpiresAt, tokenType, scope, idToken, sessionState, isActive

class AccountFormWidget extends StatefulWidget {
  final Account? item;
  final void Function(Account)? onSubmit;
  const AccountFormWidget({super.key, this.item, this.onSubmit});
  @override State<AccountFormWidget> createState() => _AccountFormWidgetState();
}

class _AccountFormWidgetState extends State<AccountFormWidget> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _cUserId;
  late final TextEditingController _cType;
  late final TextEditingController _cProviderId;
  late final TextEditingController _cAccountId;
  late final TextEditingController _cRefreshToken;
  late final TextEditingController _cAccessToken;
  late final TextEditingController _cTokenType;
  late final TextEditingController _cScope;
  late final TextEditingController _cIdToken;
  late final TextEditingController _cSessionState;
  String? _userId;
  String? _type;
  String? _providerId;
  String? _accountId;
  String? _refreshToken;
  String? _accessToken;
  DateTime? _accessTokenExpiresAt;
  String? _tokenType;
  String? _scope;
  String? _idToken;
  String? _sessionState;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _cUserId = TextEditingController(text: widget.item?.userId?.toString() ?? '');
    _cType = TextEditingController(text: widget.item?.type?.toString() ?? '');
    _cProviderId = TextEditingController(text: widget.item?.providerId?.toString() ?? '');
    _cAccountId = TextEditingController(text: widget.item?.accountId?.toString() ?? '');
    _cRefreshToken = TextEditingController(text: widget.item?.refreshToken?.toString() ?? '');
    _cAccessToken = TextEditingController(text: widget.item?.accessToken?.toString() ?? '');
    _cTokenType = TextEditingController(text: widget.item?.tokenType?.toString() ?? '');
    _cScope = TextEditingController(text: widget.item?.scope?.toString() ?? '');
    _cIdToken = TextEditingController(text: widget.item?.idToken?.toString() ?? '');
    _cSessionState = TextEditingController(text: widget.item?.sessionState?.toString() ?? '');
    _userId = widget.item?.userId?.toString();
    _type = widget.item?.type?.toString();
    _providerId = widget.item?.providerId?.toString();
    _accountId = widget.item?.accountId?.toString();
    _refreshToken = widget.item?.refreshToken?.toString();
    _accessToken = widget.item?.accessToken?.toString();
    _accessTokenExpiresAt = widget.item?.accessTokenExpiresAt;
    _tokenType = widget.item?.tokenType?.toString();
    _scope = widget.item?.scope?.toString();
    _idToken = widget.item?.idToken?.toString();
    _sessionState = widget.item?.sessionState?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  @override
  void dispose() {
    _cUserId.dispose();
    _cType.dispose();
    _cProviderId.dispose();
    _cAccountId.dispose();
    _cRefreshToken.dispose();
    _cAccessToken.dispose();
    _cTokenType.dispose();
    _cScope.dispose();
    _cIdToken.dispose();
    _cSessionState.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_providerId?.isNotEmpty == true) 'providerId': _providerId,
        if (_accountId?.isNotEmpty == true) 'accountId': _accountId,
        if (_refreshToken?.isNotEmpty == true) 'refreshToken': _refreshToken,
        if (_accessToken?.isNotEmpty == true) 'accessToken': _accessToken,
        if (_accessTokenExpiresAt != null) 'accessTokenExpiresAt': _accessTokenExpiresAt!.toIso8601String(),
        if (_tokenType?.isNotEmpty == true) 'tokenType': _tokenType,
        if (_scope?.isNotEmpty == true) 'scope': _scope,
        if (_idToken?.isNotEmpty == true) 'idToken': _idToken,
        if (_sessionState?.isNotEmpty == true) 'sessionState': _sessionState,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? Account.fromJson({...widget.item!.toJson(), ...data})
        : Account.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cUserId, maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cType, maxLines: 1,
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Provider Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cProviderId, maxLines: 1,
                onSaved: (v) => _providerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Account Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                controller: _cAccountId, maxLines: 1,
                onSaved: (v) => _accountId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Refresh Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cRefreshToken, maxLines: 1,
                onSaved: (v) => _refreshToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Access Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cAccessToken, maxLines: 1,
                onSaved: (v) => _accessToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _accessTokenExpiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _accessTokenExpiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Access Token Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_accessTokenExpiresAt != null ? _fmt(_accessTokenExpiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Token Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cTokenType, maxLines: 1,
                onSaved: (v) => _tokenType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Scope', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cScope, maxLines: 1,
                onSaved: (v) => _scope = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Id Token', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cIdToken, maxLines: 1,
                onSaved: (v) => _idToken = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Session State', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                controller: _cSessionState, maxLines: 1,
                onSaved: (v) => _sessionState = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: const Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Account'),
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