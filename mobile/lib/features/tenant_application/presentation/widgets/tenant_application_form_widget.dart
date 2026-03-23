import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── TenantApplication Form Widget  |  Fields: propertyId, listingId, applicantId, status, submittedAt, reviewedAt, reviewedBy, applicationData, creditScore, incomeVerified, backgroundCheck, organizationId

class TenantApplicationFormWidget extends StatefulWidget {
  final TenantApplication? item;
  final void Function(TenantApplication)? onSubmit;
  const TenantApplicationFormWidget({super.key, this.item, this.onSubmit});
  @override State<TenantApplicationFormWidget> createState() => _TenantApplicationFormWidgetState();
}

class _TenantApplicationFormWidgetState extends State<TenantApplicationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _applicantId;
  String? _status;
  DateTime? _submittedAt;
  DateTime? _reviewedAt;
  String? _reviewedBy;
  String? _applicationData;
  int? _creditScore;
  bool _incomeVerified = false;
  bool _backgroundCheck = false;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _applicantId = widget.item?.applicantId?.toString();
    _status = widget.item?.status?.toString();
    _submittedAt = widget.item?.submittedAt;
    _reviewedAt = widget.item?.reviewedAt;
    _reviewedBy = widget.item?.reviewedBy?.toString();
    _applicationData = widget.item?.applicationData?.toString();
    _creditScore = widget.item?.creditScore;
    _incomeVerified = widget.item?.incomeVerified ?? false;
    _backgroundCheck = widget.item?.backgroundCheck ?? false;
    _organizationId = widget.item?.organizationId?.toString();
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
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_applicantId?.isNotEmpty == true) 'applicantId': _applicantId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_submittedAt != null) 'submittedAt': _submittedAt!.toIso8601String(),
        if (_reviewedAt != null) 'reviewedAt': _reviewedAt!.toIso8601String(),
        if (_reviewedBy?.isNotEmpty == true) 'reviewedBy': _reviewedBy,
        if (_applicationData?.isNotEmpty == true) 'applicationData': _applicationData,
        if (_creditScore != null) 'creditScore': _creditScore,
        'incomeVerified': _incomeVerified,
        'backgroundCheck': _backgroundCheck,
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    final result = widget.item != null
        ? TenantApplication.fromJson({...widget.item!.toJson(), ...data})
        : TenantApplication.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Applicant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _applicantId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _submittedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _submittedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Submitted At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_submittedAt != null ? _fmt(_submittedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _reviewedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _reviewedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Reviewed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_reviewedAt != null ? _fmt(_reviewedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reviewed By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reviewedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Application Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _applicationData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Credit Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _creditScore = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Income Verified'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _incomeVerified,
                  onChanged: (v) { ss(() {}); setState(() => _incomeVerified = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Background Check'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _backgroundCheck,
                  onChanged: (v) { ss(() {}); setState(() => _backgroundCheck = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tenant Application'),
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