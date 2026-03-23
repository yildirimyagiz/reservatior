import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SecurityDepositProtection Form Widget  |  Fields: leaseId, schemeProvider, schemeReference, depositAmount, currency, protectionStatus, protectedDate, releasedDate, tenantDetails, landlordDetails, disputeStatus, disputeReason, disputeResolution

class SecurityDepositProtectionFormWidget extends StatefulWidget {
  final SecurityDepositProtection? item;
  final void Function(SecurityDepositProtection)? onSubmit;
  const SecurityDepositProtectionFormWidget({super.key, this.item, this.onSubmit});
  @override State<SecurityDepositProtectionFormWidget> createState() => _SecurityDepositProtectionFormWidgetState();
}

class _SecurityDepositProtectionFormWidgetState extends State<SecurityDepositProtectionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _schemeProvider;
  String? _schemeReference;
  double? _depositAmount;
  String? _currency;
  String? _protectionStatus;
  DateTime? _protectedDate;
  DateTime? _releasedDate;
  String? _tenantDetails;
  String? _landlordDetails;
  String? _disputeStatus;
  String? _disputeReason;
  String? _disputeResolution;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _schemeProvider = widget.item?.schemeProvider?.toString();
    _schemeReference = widget.item?.schemeReference?.toString();
    _depositAmount = widget.item?.depositAmount;
    _currency = widget.item?.currency?.toString();
    _protectionStatus = widget.item?.protectionStatus?.toString();
    _protectedDate = widget.item?.protectedDate;
    _releasedDate = widget.item?.releasedDate;
    _tenantDetails = widget.item?.tenantDetails?.toString();
    _landlordDetails = widget.item?.landlordDetails?.toString();
    _disputeStatus = widget.item?.disputeStatus?.toString();
    _disputeReason = widget.item?.disputeReason?.toString();
    _disputeResolution = widget.item?.disputeResolution?.toString();
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
        if (_schemeProvider?.isNotEmpty == true) 'schemeProvider': _schemeProvider,
        if (_schemeReference?.isNotEmpty == true) 'schemeReference': _schemeReference,
        if (_depositAmount != null) 'depositAmount': _depositAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_protectionStatus?.isNotEmpty == true) 'protectionStatus': _protectionStatus,
        if (_protectedDate != null) 'protectedDate': _protectedDate!.toIso8601String(),
        if (_releasedDate != null) 'releasedDate': _releasedDate!.toIso8601String(),
        if (_tenantDetails?.isNotEmpty == true) 'tenantDetails': _tenantDetails,
        if (_landlordDetails?.isNotEmpty == true) 'landlordDetails': _landlordDetails,
        if (_disputeStatus?.isNotEmpty == true) 'disputeStatus': _disputeStatus,
        if (_disputeReason?.isNotEmpty == true) 'disputeReason': _disputeReason,
        if (_disputeResolution?.isNotEmpty == true) 'disputeResolution': _disputeResolution,
    };
    final result = widget.item != null
        ? SecurityDepositProtection.fromJson({...widget.item!.toJson(), ...data})
        : SecurityDepositProtection.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Scheme Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _schemeProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Scheme Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _schemeReference = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deposit Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _depositAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Protection Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _protectionStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _protectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _protectedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Protected Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_protectedDate != null ? _fmt(_protectedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _releasedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _releasedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Released Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_releasedDate != null ? _fmt(_releasedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Details', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantDetails = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Landlord Details', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _landlordDetails = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dispute Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _disputeStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dispute Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _disputeReason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dispute Resolution', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _disputeResolution = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Security Deposit Protection'),
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