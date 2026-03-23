import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── UserPreference Form Widget  |  Fields: userId, theme, language, timezone, dateFormat, currency, emailNotifications, pushNotifications, marketingEmails, dashboardLayout

class UserPreferenceFormWidget extends StatefulWidget {
  final UserPreference? item;
  final void Function(UserPreference)? onSubmit;
  const UserPreferenceFormWidget({super.key, this.item, this.onSubmit});
  @override State<UserPreferenceFormWidget> createState() => _UserPreferenceFormWidgetState();
}

class _UserPreferenceFormWidgetState extends State<UserPreferenceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _theme;
  String? _language;
  String? _timezone;
  String? _dateFormat;
  String? _currency;
  bool _emailNotifications = false;
  bool _pushNotifications = false;
  bool _marketingEmails = false;
  String? _dashboardLayout;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _theme = widget.item?.theme?.toString();
    _language = widget.item?.language?.toString();
    _timezone = widget.item?.timezone?.toString();
    _dateFormat = widget.item?.dateFormat?.toString();
    _currency = widget.item?.currency?.toString();
    _emailNotifications = widget.item?.emailNotifications ?? false;
    _pushNotifications = widget.item?.pushNotifications ?? false;
    _marketingEmails = widget.item?.marketingEmails ?? false;
    _dashboardLayout = widget.item?.dashboardLayout?.toString();
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
        if (_theme?.isNotEmpty == true) 'theme': _theme,
        if (_language?.isNotEmpty == true) 'language': _language,
        if (_timezone?.isNotEmpty == true) 'timezone': _timezone,
        if (_dateFormat?.isNotEmpty == true) 'dateFormat': _dateFormat,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        'emailNotifications': _emailNotifications,
        'pushNotifications': _pushNotifications,
        'marketingEmails': _marketingEmails,
        if (_dashboardLayout?.isNotEmpty == true) 'dashboardLayout': _dashboardLayout,
    };
    final result = widget.item != null
        ? UserPreference.fromJson({...widget.item!.toJson(), ...data})
        : UserPreference.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Theme', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _theme = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Language', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _language = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Timezone', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _timezone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date Format', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dateFormat = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Email Notifications'),
                  secondary: const Icon(Icons.email),
                  value: _emailNotifications,
                  onChanged: (v) { ss(() {}); setState(() => _emailNotifications = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Push Notifications'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _pushNotifications,
                  onChanged: (v) { ss(() {}); setState(() => _pushNotifications = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Marketing Emails'),
                  secondary: const Icon(Icons.email),
                  value: _marketingEmails,
                  onChanged: (v) { ss(() {}); setState(() => _marketingEmails = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dashboard Layout', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dashboardLayout = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create User Preference'),
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