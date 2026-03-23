import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Language Form Widget  |  Fields: code, name, nativeName, isRTL, isActive, agencyId, agentId, userId

class LanguageFormWidget extends StatefulWidget {
  final Language? item;
  final void Function(Language)? onSubmit;
  const LanguageFormWidget({super.key, this.item, this.onSubmit});
  @override State<LanguageFormWidget> createState() => _LanguageFormWidgetState();
}

class _LanguageFormWidgetState extends State<LanguageFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _code;
  String? _name;
  String? _nativeName;
  bool _isRTL = false;
  bool _isActive = false;
  String? _agencyId;
  String? _agentId;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _code = widget.item?.code?.toString();
    _name = widget.item?.name?.toString();
    _nativeName = widget.item?.nativeName?.toString();
    _isRTL = widget.item?.isRTL ?? false;
    _isActive = widget.item?.isActive ?? false;
    _agencyId = widget.item?.agencyId?.toString();
    _agentId = widget.item?.agentId?.toString();
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
        if (_code?.isNotEmpty == true) 'code': _code,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_nativeName?.isNotEmpty == true) 'nativeName': _nativeName,
        'isRTL': _isRTL,
        'isActive': _isActive,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
    };
    final result = widget.item != null
        ? Language.fromJson({...widget.item!.toJson(), ...data})
        : Language.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _code = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Native Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _nativeName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is R T L'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRTL,
                  onChanged: (v) { ss(() {}); setState(() => _isRTL = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Language'),
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