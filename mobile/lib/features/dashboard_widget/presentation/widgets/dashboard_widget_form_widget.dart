import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DashboardWidget Form Widget  |  Fields: userId, title, config, position

class DashboardWidgetFormWidget extends StatefulWidget {
  final DashboardWidget? item;
  final void Function(DashboardWidget)? onSubmit;
  const DashboardWidgetFormWidget({super.key, this.item, this.onSubmit});
  @override State<DashboardWidgetFormWidget> createState() => _DashboardWidgetFormWidgetState();
}

class _DashboardWidgetFormWidgetState extends State<DashboardWidgetFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _config;
  String? _position;
  String? _title;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _config = widget.item?.config?.toString();
    _position = widget.item?.position?.toString();
    _title = widget.item?.title?.toString();
    _userId = widget.item?.userId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_config?.isNotEmpty == true) 'config': _config,
        if (_position?.isNotEmpty == true) 'position': _position,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
    };
    final result = widget.item != null
        ? DashboardWidget.fromJson({...widget.item!.toJson(), ...data})
        : DashboardWidget.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _config?.toString() ?? '',
                maxLines: 3,
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Position', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _position?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _position = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _title?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _userId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Dashboard_widget'),
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
