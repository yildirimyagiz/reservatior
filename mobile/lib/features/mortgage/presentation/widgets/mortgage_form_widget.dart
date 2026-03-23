import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Mortgage Form Widget  |  Fields: propertyId, lender, principal, interestRate, startDate, endDate, status, notes

class MortgageFormWidget extends StatefulWidget {
  final Mortgage? item;
  final void Function(Mortgage)? onSubmit;
  const MortgageFormWidget({super.key, this.item, this.onSubmit});
  @override State<MortgageFormWidget> createState() => _MortgageFormWidgetState();
}

class _MortgageFormWidgetState extends State<MortgageFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _lender;
  double? _principal;
  double? _interestRate;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _status;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _lender = widget.item?.lender?.toString();
    _principal = widget.item?.principal;
    _interestRate = widget.item?.interestRate;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _status = widget.item?.status?.toString();
    _notes = widget.item?.notes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_lender?.isNotEmpty == true) 'lender': _lender,
        if (_principal != null) 'principal': _principal,
        if (_interestRate != null) 'interestRate': _interestRate,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? Mortgage.fromJson({...widget.item!.toJson(), ...data})
        : Mortgage.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lender', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lender = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Principal', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _principal = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Interest Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _interestRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mortgage'),
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