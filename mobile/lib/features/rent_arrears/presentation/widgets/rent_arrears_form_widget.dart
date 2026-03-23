import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── RentArrears Form Widget  |  Fields: leaseId, tenantId, periodStart, periodEnd, rentDue, rentPaid, arrearsAmount, status, lastPaymentDate, noticeSent, noticeDate, noticeType, legalAction, legalReference, courtDate, recoveryAmount, writeOffAmount

class RentArrearsFormWidget extends StatefulWidget {
  final RentArrears? item;
  final void Function(RentArrears)? onSubmit;
  const RentArrearsFormWidget({super.key, this.item, this.onSubmit});
  @override State<RentArrearsFormWidget> createState() => _RentArrearsFormWidgetState();
}

class _RentArrearsFormWidgetState extends State<RentArrearsFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _tenantId;
  DateTime? _periodStart;
  DateTime? _periodEnd;
  double? _rentDue;
  double? _rentPaid;
  double? _arrearsAmount;
  String? _status;
  DateTime? _lastPaymentDate;
  bool _noticeSent = false;
  DateTime? _noticeDate;
  String? _noticeType;
  bool _legalAction = false;
  String? _legalReference;
  DateTime? _courtDate;
  double? _recoveryAmount;
  double? _writeOffAmount;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _periodStart = widget.item?.periodStart;
    _periodEnd = widget.item?.periodEnd;
    _rentDue = widget.item?.rentDue;
    _rentPaid = widget.item?.rentPaid;
    _arrearsAmount = widget.item?.arrearsAmount;
    _status = widget.item?.status?.toString();
    _lastPaymentDate = widget.item?.lastPaymentDate;
    _noticeSent = widget.item?.noticeSent ?? false;
    _noticeDate = widget.item?.noticeDate;
    _noticeType = widget.item?.noticeType?.toString();
    _legalAction = widget.item?.legalAction ?? false;
    _legalReference = widget.item?.legalReference?.toString();
    _courtDate = widget.item?.courtDate;
    _recoveryAmount = widget.item?.recoveryAmount;
    _writeOffAmount = widget.item?.writeOffAmount;
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
        if (_tenantId?.isNotEmpty == true) 'tenantId': _tenantId,
        if (_periodStart != null) 'periodStart': _periodStart!.toIso8601String(),
        if (_periodEnd != null) 'periodEnd': _periodEnd!.toIso8601String(),
        if (_rentDue != null) 'rentDue': _rentDue,
        if (_rentPaid != null) 'rentPaid': _rentPaid,
        if (_arrearsAmount != null) 'arrearsAmount': _arrearsAmount,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_lastPaymentDate != null) 'lastPaymentDate': _lastPaymentDate!.toIso8601String(),
        'noticeSent': _noticeSent,
        if (_noticeDate != null) 'noticeDate': _noticeDate!.toIso8601String(),
        if (_noticeType?.isNotEmpty == true) 'noticeType': _noticeType,
        'legalAction': _legalAction,
        if (_legalReference?.isNotEmpty == true) 'legalReference': _legalReference,
        if (_courtDate != null) 'courtDate': _courtDate!.toIso8601String(),
        if (_recoveryAmount != null) 'recoveryAmount': _recoveryAmount,
        if (_writeOffAmount != null) 'writeOffAmount': _writeOffAmount,
    };
    final result = widget.item != null
        ? RentArrears.fromJson({...widget.item!.toJson(), ...data})
        : RentArrears.fromJson(data);
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _periodStart ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _periodStart = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Period Start',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_periodStart != null ? _fmt(_periodStart) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _periodEnd ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _periodEnd = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Period End',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_periodEnd != null ? _fmt(_periodEnd) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rent Due', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _rentDue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rent Paid', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _rentPaid = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Arrears Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _arrearsAmount = double.tryParse(v ?? ''),
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
                    context: context, initialDate: _lastPaymentDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastPaymentDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Payment Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastPaymentDate != null ? _fmt(_lastPaymentDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Notice Sent'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _noticeSent,
                  onChanged: (v) { ss(() {}); setState(() => _noticeSent = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _noticeDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _noticeDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Notice Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_noticeDate != null ? _fmt(_noticeDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notice Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _noticeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Legal Action'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _legalAction,
                  onChanged: (v) { ss(() {}); setState(() => _legalAction = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Legal Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _legalReference = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _courtDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _courtDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Court Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_courtDate != null ? _fmt(_courtDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recovery Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _recoveryAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Write Off Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _writeOffAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Rent Arrears'),
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