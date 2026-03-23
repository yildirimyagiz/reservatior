import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DashboardConfiguration Form Widget  |  Fields: userId, dashboardName, isDefault, layout, widgets, filters, timeRange, isPublic

class DashboardConfigurationFormWidget extends StatefulWidget {
  final DashboardConfiguration? item;
  final void Function(DashboardConfiguration)? onSubmit;
  const DashboardConfigurationFormWidget({super.key, this.item, this.onSubmit});
  @override State<DashboardConfigurationFormWidget> createState() => _DashboardConfigurationFormWidgetState();
}

class _DashboardConfigurationFormWidgetState extends State<DashboardConfigurationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _dashboardName;
  bool _isDefault = false;
  String? _layout;
  String? _widgets;
  String? _filters;
  String? _timeRange;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _dashboardName = widget.item?.dashboardName?.toString();
    _isDefault = widget.item?.isDefault ?? false;
    _layout = widget.item?.layout?.toString();
    _widgets = widget.item?.widgets?.toString();
    _filters = widget.item?.filters?.toString();
    _timeRange = widget.item?.timeRange?.toString();
    _isPublic = widget.item?.isPublic ?? false;
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
        if (_dashboardName?.isNotEmpty == true) 'dashboardName': _dashboardName,
        'isDefault': _isDefault,
        if (_layout?.isNotEmpty == true) 'layout': _layout,
        if (_widgets?.isNotEmpty == true) 'widgets': _widgets,
        if (_filters?.isNotEmpty == true) 'filters': _filters,
        if (_timeRange?.isNotEmpty == true) 'timeRange': _timeRange,
        'isPublic': _isPublic,
    };
    final result = widget.item != null
        ? DashboardConfiguration.fromJson({...widget.item!.toJson(), ...data})
        : DashboardConfiguration.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Dashboard Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _dashboardName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Default'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isDefault,
                  onChanged: (v) { ss(() {}); setState(() => _isDefault = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Layout', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _layout = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Widgets', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _widgets = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Filters', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _filters = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Time Range', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _timeRange = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Public'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isPublic,
                  onChanged: (v) { ss(() {}); setState(() => _isPublic = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Dashboard Configuration'),
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