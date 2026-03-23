import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Tenant Form Widget ──
// Fields: userId, firstName, lastName, email, phoneNumber, leaseStartDate, leaseEndDate, paymentStatus, propertyId, isActive

class TenantFormWidget extends StatefulWidget {
  final Tenant? item;
  final void Function(Tenant)? onSubmit;
  const TenantFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<TenantFormWidget> createState() => _TenantFormWidgetState();
}

class _TenantFormWidgetState extends State<TenantFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _userId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;
  DateTime? _leaseStartDate;
  DateTime? _leaseEndDate;
  String? _paymentStatus;
  String? _propertyId;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _firstName = widget.item?.firstName?.toString();
    _lastName = widget.item?.lastName?.toString();
    _email = widget.item?.email?.toString();
    _phoneNumber = widget.item?.phoneNumber?.toString();
    _leaseStartDate = widget.item?.leaseStartDate;
    _leaseEndDate = widget.item?.leaseEndDate;
    _paymentStatus = widget.item?.paymentStatus?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId != null) 'userId': _userId,
        if (_firstName != null) 'firstName': _firstName,
        if (_lastName != null) 'lastName': _lastName,
        if (_email != null) 'email': _email,
        if (_phoneNumber != null) 'phoneNumber': _phoneNumber,
        if (_leaseStartDate != null) 'leaseStartDate': _leaseStartDate!.toIso8601String(),
        if (_leaseEndDate != null) 'leaseEndDate': _leaseEndDate!.toIso8601String(),
        if (_paymentStatus != null) 'paymentStatus': _paymentStatus,
        if (_propertyId != null) 'propertyId': _propertyId,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? Tenant.fromJson({...widget.item!.toJson(), ...data})
        : Tenant.fromJson(data);
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
                maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _firstName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _lastName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _email = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _phoneNumber = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _leaseStartDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _leaseStartDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Lease Start Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_leaseStartDate != null ? _fmt(_leaseStartDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _leaseEndDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _leaseEndDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Lease End Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_leaseEndDate != null ? _fmt(_leaseEndDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _paymentStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tenant'),
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
