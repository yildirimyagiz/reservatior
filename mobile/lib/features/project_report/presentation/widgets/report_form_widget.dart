import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Report Form Widget ──
// Fields: userId, name, description, reportType, config, schedule, recipients, lastRunAt, isActive

class ReportFormWidget extends StatefulWidget {
  final Report? item;
  final void Function(Report)? onSubmit;
  const ReportFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<ReportFormWidget> createState() => _ReportFormWidgetState();
}

class _ReportFormWidgetState extends State<ReportFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _name;
  String? _description;
  String? _reportType;
  String? _config;
  String? _schedule;
  String? _recipients;
  DateTime? _lastRunAt;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _reportType = widget.item?.reportType?.toString();
    _config = widget.item?.config?.toString();
    _schedule = widget.item?.schedule?.toString();
    _recipients = widget.item?.recipients?.toString();
    _lastRunAt = widget.item?.lastRunAt;
    _isActive = widget.item?.isActive ?? false;
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
        if (_name != null) 'name': _name,
        if (_description != null) 'description': _description,
        if (_reportType != null) 'reportType': _reportType,
        if (_config != null) 'config': _config,
        if (_schedule != null) 'schedule': _schedule,
        if (_recipients != null) 'recipients': _recipients,
        if (_lastRunAt != null) 'lastRunAt': _lastRunAt!.toIso8601String(),
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? Report.fromJson({...widget.item!.toJson(), ...data})
        : Report.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Report Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _reportType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Schedule', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _schedule = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipients', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _recipients = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _lastRunAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastRunAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Last Run At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_lastRunAt != null ? _fmt(_lastRunAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Report'),
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
