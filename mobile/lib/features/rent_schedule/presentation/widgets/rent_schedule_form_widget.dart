import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── RentSchedule Form Widget  |  Fields: leaseId, dueDate, amount, currency, status, paidAt

class RentScheduleFormWidget extends StatefulWidget {
  final RentSchedule? item;
  final void Function(RentSchedule)? onSubmit;
  const RentScheduleFormWidget({super.key, this.item, this.onSubmit});
  @override State<RentScheduleFormWidget> createState() => _RentScheduleFormWidgetState();
}

class _RentScheduleFormWidgetState extends State<RentScheduleFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  DateTime? _dueDate;
  double? _amount;
  String? _currency;
  String? _status;
  DateTime? _paidAt;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _dueDate = widget.item?.dueDate;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _paidAt = widget.item?.paidAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? RentSchedule.fromJson({...widget.item!.toJson(), ...data})
        : RentSchedule.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _paidAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _paidAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Paid At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_paidAt != null ? _fmt(_paidAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Rent Schedule'),
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