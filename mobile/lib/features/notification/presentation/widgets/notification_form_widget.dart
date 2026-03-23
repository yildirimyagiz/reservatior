import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Notification Form Widget ──
// Fields: userId, title, body, data, status, sentAt, readAt, userPreferences, deliveries, ruleKey, ruleConfig

class NotificationFormWidget extends StatefulWidget {
  final Notification? item;
  final void Function(Notification)? onSubmit;
  const NotificationFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<NotificationFormWidget> createState() => _NotificationFormWidgetState();
}

class _NotificationFormWidgetState extends State<NotificationFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _title;
  String? _body;
  String? _data;
  String? _status;
  DateTime? _sentAt;
  DateTime? _readAt;
  String? _userPreferences;
  String? _deliveries;
  String? _ruleKey;
  String? _ruleConfig;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _title = widget.item?.title?.toString();
    _body = widget.item?.body?.toString();
    _data = widget.item?.data?.toString();
    _status = widget.item?.status?.toString();
    _sentAt = widget.item?.sentAt;
    _readAt = widget.item?.readAt;
    _userPreferences = widget.item?.userPreferences?.toString();
    _deliveries = widget.item?.deliveries?.toString();
    _ruleKey = widget.item?.ruleKey?.toString();
    _ruleConfig = widget.item?.ruleConfig?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId != null) 'userId': _userId,
        if (_title != null) 'title': _title,
        if (_body != null) 'body': _body,
        if (_data != null) 'data': _data,
        if (_status != null) 'status': _status,
        if (_sentAt != null) 'sentAt': _sentAt!.toIso8601String(),
        if (_readAt != null) 'readAt': _readAt!.toIso8601String(),
        if (_userPreferences != null) 'userPreferences': _userPreferences,
        if (_deliveries != null) 'deliveries': _deliveries,
        if (_ruleKey != null) 'ruleKey': _ruleKey,
        if (_ruleConfig != null) 'ruleConfig': _ruleConfig,
    };
    final result = widget.item != null
        ? Notification.fromJson({...widget.item!.toJson(), ...data})
        : Notification.fromJson(data);
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
                maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Body', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _body = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _data = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _sentAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _sentAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Sent At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_sentAt != null ? _fmt(_sentAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _readAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _readAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Read At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_readAt != null ? _fmt(_readAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Preferences', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _userPreferences = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deliveries', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _deliveries = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _ruleKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _ruleConfig = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Notification'),
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
