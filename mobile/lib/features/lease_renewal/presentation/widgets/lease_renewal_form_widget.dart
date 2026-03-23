import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── LeaseRenewal Form Widget  |  Fields: leaseId, status, proposedRent, proposedTerms, renewalDate, responseDeadline, organizationId, listingId

class LeaseRenewalFormWidget extends StatefulWidget {
  final LeaseRenewal? item;
  final void Function(LeaseRenewal)? onSubmit;
  const LeaseRenewalFormWidget({super.key, this.item, this.onSubmit});
  @override State<LeaseRenewalFormWidget> createState() => _LeaseRenewalFormWidgetState();
}

class _LeaseRenewalFormWidgetState extends State<LeaseRenewalFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _status;
  double? _proposedRent;
  String? _proposedTerms;
  DateTime? _renewalDate;
  DateTime? _responseDeadline;
  String? _organizationId;
  String? _listingId;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _status = widget.item?.status?.toString();
    _proposedRent = widget.item?.proposedRent;
    _proposedTerms = widget.item?.proposedTerms?.toString();
    _renewalDate = widget.item?.renewalDate;
    _responseDeadline = widget.item?.responseDeadline;
    _organizationId = widget.item?.organizationId?.toString();
    _listingId = widget.item?.listingId?.toString();
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
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_proposedRent != null) 'proposedRent': _proposedRent,
        if (_proposedTerms?.isNotEmpty == true) 'proposedTerms': _proposedTerms,
        if (_renewalDate != null) 'renewalDate': _renewalDate!.toIso8601String(),
        if (_responseDeadline != null) 'responseDeadline': _responseDeadline!.toIso8601String(),
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
    };
    final result = widget.item != null
        ? LeaseRenewal.fromJson({...widget.item!.toJson(), ...data})
        : LeaseRenewal.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Proposed Rent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _proposedRent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proposed Terms', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _proposedTerms = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _renewalDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _renewalDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Renewal Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_renewalDate != null ? _fmt(_renewalDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _responseDeadline ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _responseDeadline = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Response Deadline',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_responseDeadline != null ? _fmt(_responseDeadline) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Lease Renewal'),
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