import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Contract Form Widget ──
// Fields: propertyId, listingId, leaseId, bookingId, type, status, title, effectiveFrom, effectiveTo, nextRenewalAt, renewalNoticeDays

class ContractFormWidget extends StatefulWidget {
  final Contract? item;
  final void Function(Contract)? onSubmit;
  const ContractFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<ContractFormWidget> createState() => _ContractFormWidgetState();
}

class _ContractFormWidgetState extends State<ContractFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _type;
  String? _status;
  String? _title;
  DateTime? _effectiveFrom;
  DateTime? _effectiveTo;
  DateTime? _nextRenewalAt;
  int? _renewalNoticeDays;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _title = widget.item?.title?.toString();
    _effectiveFrom = widget.item?.effectiveFrom;
    _effectiveTo = widget.item?.effectiveTo;
    _nextRenewalAt = widget.item?.nextRenewalAt;
    _renewalNoticeDays = widget.item?.renewalNoticeDays;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId != null) 'propertyId': _propertyId,
        if (_listingId != null) 'listingId': _listingId,
        if (_leaseId != null) 'leaseId': _leaseId,
        if (_bookingId != null) 'bookingId': _bookingId,
        if (_type != null) 'type': _type,
        if (_status != null) 'status': _status,
        if (_title != null) 'title': _title,
        if (_effectiveFrom != null) 'effectiveFrom': _effectiveFrom!.toIso8601String(),
        if (_effectiveTo != null) 'effectiveTo': _effectiveTo!.toIso8601String(),
        if (_nextRenewalAt != null) 'nextRenewalAt': _nextRenewalAt!.toIso8601String(),
        if (_renewalNoticeDays != null) 'renewalNoticeDays': _renewalNoticeDays,
    };
    final result = widget.item != null
        ? Contract.fromJson({...widget.item!.toJson(), ...data})
        : Contract.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lease Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Booking Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _effectiveFrom ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _effectiveFrom = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Effective From',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_effectiveFrom != null ? _fmt(_effectiveFrom) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _effectiveTo ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _effectiveTo = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Effective To',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_effectiveTo != null ? _fmt(_effectiveTo) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _nextRenewalAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _nextRenewalAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Next Renewal At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_nextRenewalAt != null ? _fmt(_nextRenewalAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Renewal Notice Days', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onSaved: (v) => _renewalNoticeDays = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Contract'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
