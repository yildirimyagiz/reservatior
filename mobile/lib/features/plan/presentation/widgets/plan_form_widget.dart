import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Plan Form Widget  |  Fields: key, name, limits, priceMonthlyCents

class PlanFormWidget extends StatefulWidget {
  final Plan? item;
  final void Function(Plan)? onSubmit;
  const PlanFormWidget({super.key, this.item, this.onSubmit});
  @override State<PlanFormWidget> createState() => _PlanFormWidgetState();
}

class _PlanFormWidgetState extends State<PlanFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _key;
  String? _name;
  String? _limits;
  int? _priceMonthlyCents;

  @override
  void initState() {
    super.initState();
    _key = widget.item?.key?.toString();
    _name = widget.item?.name?.toString();
    _limits = widget.item?.limits?.toString();
    _priceMonthlyCents = widget.item?.priceMonthlyCents;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_key?.isNotEmpty == true) 'key': _key,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_limits?.isNotEmpty == true) 'limits': _limits,
        if (_priceMonthlyCents != null) 'priceMonthlyCents': _priceMonthlyCents,
    };
    final result = widget.item != null
        ? Plan.fromJson({...widget.item!.toJson(), ...data})
        : Plan.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _key = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Limits', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _limits = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price Monthly Cents', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _priceMonthlyCents = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Plan'),
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