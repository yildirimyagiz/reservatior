import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Expense Form Widget  |  Fields: propertyId, tenantId, agencyId, type, amount, currencyId, dueDate, paidDate, status, notes, facilityId, includedServiceId, extraChargeId

class ExpenseFormWidget extends StatefulWidget {
  final Expense? item;
  final void Function(Expense)? onSubmit;
  const ExpenseFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExpenseFormWidget> createState() => _ExpenseFormWidgetState();
}

class _ExpenseFormWidgetState extends State<ExpenseFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _tenantId;
  String? _agencyId;
  String? _type;
  double? _amount;
  String? _currencyId;
  DateTime? _dueDate;
  DateTime? _paidDate;
  String? _status;
  String? _notes;
  String? _facilityId;
  String? _includedServiceId;
  String? _extraChargeId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _type = widget.item?.type?.toString();
    _amount = widget.item?.amount;
    _currencyId = widget.item?.currencyId?.toString();
    _dueDate = widget.item?.dueDate;
    _paidDate = widget.item?.paidDate;
    _status = widget.item?.status?.toString();
    _notes = widget.item?.notes?.toString();
    _facilityId = widget.item?.facilityId?.toString();
    _includedServiceId = widget.item?.includedServiceId?.toString();
    _extraChargeId = widget.item?.extraChargeId?.toString();
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
        if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_amount != null) 'amount': _amount,
        if (_currencyId?.isNotEmpty == true) 'currencyId': _currencyId,
        if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
        if (_paidDate != null) 'paidDate': _paidDate!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
        if (_includedServiceId?.isNotEmpty == true) 'includedServiceId': _includedServiceId,
        if (_extraChargeId?.isNotEmpty == true) 'extraChargeId': _extraChargeId,
    };
    final result = widget.item != null
        ? Expense.fromJson({...widget.item!.toJson(), ...data})
        : Expense.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _currencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dueDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_dueDate != null ? _fmt(_dueDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _paidDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _paidDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Paid Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_paidDate != null ? _fmt(_paidDate) : 'Tap to select date'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Included Service Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Extra Charge Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _extraChargeId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Expense'),
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