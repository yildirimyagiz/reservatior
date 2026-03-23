import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── User Form Widget ──
// Fields: email, name, phone, locale, timezone, gdprConsentAt, ccpaOptOutAt, dataRetentionUntil, anonymizedAt

class UserFormWidget extends StatefulWidget {
  final User? item;
  final void Function(User)? onSubmit;
  const UserFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _email;
  String? _name;
  String? _phone;
  String? _locale;
  String? _timezone;
  DateTime? _gdprConsentAt;
  DateTime? _ccpaOptOutAt;
  DateTime? _dataRetentionUntil;
  DateTime? _anonymizedAt;

  @override
  void initState() {
    super.initState();
    _email = widget.item?.email?.toString();
    _name = widget.item?.name?.toString();
    _phone = widget.item?.phone?.toString();
    _locale = widget.item?.locale?.toString();
    _timezone = widget.item?.timezone?.toString();
    _gdprConsentAt = widget.item?.gdprConsentAt;
    _ccpaOptOutAt = widget.item?.ccpaOptOutAt;
    _dataRetentionUntil = widget.item?.dataRetentionUntil;
    _anonymizedAt = widget.item?.anonymizedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_email != null) 'email': _email,
        if (_name != null) 'name': _name,
        if (_phone != null) 'phone': _phone,
        if (_locale != null) 'locale': _locale,
        if (_timezone != null) 'timezone': _timezone,
        if (_gdprConsentAt != null) 'gdprConsentAt': _gdprConsentAt!.toIso8601String(),
        if (_ccpaOptOutAt != null) 'ccpaOptOutAt': _ccpaOptOutAt!.toIso8601String(),
        if (_dataRetentionUntil != null) 'dataRetentionUntil': _dataRetentionUntil!.toIso8601String(),
        if (_anonymizedAt != null) 'anonymizedAt': _anonymizedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? User.fromJson({...widget.item!.toJson(), ...data})
        : User.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _phone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Locale', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _locale = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Timezone', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _timezone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _gdprConsentAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _gdprConsentAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Gdpr Consent At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_gdprConsentAt != null ? _fmt(_gdprConsentAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _ccpaOptOutAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _ccpaOptOutAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Ccpa Opt Out At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_ccpaOptOutAt != null ? _fmt(_ccpaOptOutAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _dataRetentionUntil ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dataRetentionUntil = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Data Retention Until',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_dataRetentionUntil != null ? _fmt(_dataRetentionUntil) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _anonymizedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _anonymizedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Anonymized At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_anonymizedAt != null ? _fmt(_anonymizedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create User'),
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
