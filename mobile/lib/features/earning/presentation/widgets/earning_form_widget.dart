import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Earning Form Widget  |  Fields: userId, name, type, percentage, fixedAmount, conditions, appliesToUsers, appliesToAgents, appliesToVendors, isActive, earningsRecords

class EarningFormWidget extends StatefulWidget {
  final Earning? item;
  final void Function(Earning)? onSubmit;
  const EarningFormWidget({super.key, this.item, this.onSubmit});
  @override State<EarningFormWidget> createState() => _EarningFormWidgetState();
}

class _EarningFormWidgetState extends State<EarningFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _type;
  double? _percentage;
  double? _fixedAmount;
  String? _conditions;
  bool _appliesToUsers = false;
  bool _appliesToAgents = false;
  bool _appliesToVendors = false;
  bool _isActive = false;
  String? _earningsRecords;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _percentage = widget.item?.percentage;
    _fixedAmount = widget.item?.fixedAmount;
    _conditions = widget.item?.conditions?.toString();
    _appliesToUsers = widget.item?.appliesToUsers ?? false;
    _appliesToAgents = widget.item?.appliesToAgents ?? false;
    _appliesToVendors = widget.item?.appliesToVendors ?? false;
    _isActive = widget.item?.isActive ?? false;
    _earningsRecords = widget.item?.earningsRecords?.toString();
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_percentage != null) 'percentage': _percentage,
        if (_fixedAmount != null) 'fixedAmount': _fixedAmount,
        if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
        'appliesToUsers': _appliesToUsers,
        'appliesToAgents': _appliesToAgents,
        'appliesToVendors': _appliesToVendors,
        'isActive': _isActive,
        if (_earningsRecords?.isNotEmpty == true) 'earningsRecords': _earningsRecords,
    };
    final result = widget.item != null
        ? Earning.fromJson({...widget.item!.toJson(), ...data})
        : Earning.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Percentage', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _percentage = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Fixed Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _fixedAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Applies To Users'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _appliesToUsers,
                  onChanged: (v) { ss(() {}); setState(() => _appliesToUsers = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Applies To Agents'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _appliesToAgents,
                  onChanged: (v) { ss(() {}); setState(() => _appliesToAgents = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Applies To Vendors'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _appliesToVendors,
                  onChanged: (v) { ss(() {}); setState(() => _appliesToVendors = v); },
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
                decoration: InputDecoration(labelText: 'Earnings Records', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _earningsRecords = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Earning'),
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