import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ProjectAlert Form Widget  |  Fields: projectId, alertType, title, message, severity, isRead, isResolved, resolvedAt

class ProjectAlertFormWidget extends StatefulWidget {
  final ProjectAlert? item;
  final void Function(ProjectAlert)? onSubmit;
  const ProjectAlertFormWidget({super.key, this.item, this.onSubmit});
  @override State<ProjectAlertFormWidget> createState() => _ProjectAlertFormWidgetState();
}

class _ProjectAlertFormWidgetState extends State<ProjectAlertFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _projectId;
  String? _alertType;
  String? _title;
  String? _message;
  String? _severity;
  bool _isRead = false;
  bool _isResolved = false;
  DateTime? _resolvedAt;

  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId?.toString();
    _alertType = widget.item?.alertType?.toString();
    _title = widget.item?.title?.toString();
    _message = widget.item?.message?.toString();
    _severity = widget.item?.severity?.toString();
    _isRead = widget.item?.isRead ?? false;
    _isResolved = widget.item?.isResolved ?? false;
    _resolvedAt = widget.item?.resolvedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_projectId?.isNotEmpty == true) 'projectId': _projectId,
        if (_alertType?.isNotEmpty == true) 'alertType': _alertType,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_message?.isNotEmpty == true) 'message': _message,
        if (_severity?.isNotEmpty == true) 'severity': _severity,
        'isRead': _isRead,
        'isResolved': _isResolved,
        if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? ProjectAlert.fromJson({...widget.item!.toJson(), ...data})
        : ProjectAlert.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Project Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _projectId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alert Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _alertType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _message = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Severity', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _severity = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Read'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRead,
                  onChanged: (v) { ss(() {}); setState(() => _isRead = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Resolved'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isResolved,
                  onChanged: (v) { ss(() {}); setState(() => _isResolved = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _resolvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _resolvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Resolved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_resolvedAt != null ? _fmt(_resolvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Project Alert'),
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