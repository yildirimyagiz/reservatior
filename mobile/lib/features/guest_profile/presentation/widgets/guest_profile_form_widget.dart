import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GuestProfile Form Widget  |  Fields: contactId, preferredCheckInTime, dietaryRestrictions, accessibilityNeeds, loyaltyPoints, lifetimeSpent, bookingCount

class GuestProfileFormWidget extends StatefulWidget {
  final GuestProfile? item;
  final void Function(GuestProfile)? onSubmit;
  const GuestProfileFormWidget({super.key, this.item, this.onSubmit});
  @override State<GuestProfileFormWidget> createState() => _GuestProfileFormWidgetState();
}

class _GuestProfileFormWidgetState extends State<GuestProfileFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contactId;
  String? _preferredCheckInTime;
  String? _dietaryRestrictions;
  String? _accessibilityNeeds;
  int? _loyaltyPoints;
  double? _lifetimeSpent;
  int? _bookingCount;

  @override
  void initState() {
    super.initState();
    _contactId = widget.item?.contactId?.toString();
    _preferredCheckInTime = widget.item?.preferredCheckInTime?.toString();
    _dietaryRestrictions = widget.item?.dietaryRestrictions?.toString();
    _accessibilityNeeds = widget.item?.accessibilityNeeds?.toString();
    _loyaltyPoints = widget.item?.loyaltyPoints;
    _lifetimeSpent = widget.item?.lifetimeSpent;
    _bookingCount = widget.item?.bookingCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_preferredCheckInTime?.isNotEmpty == true) 'preferredCheckInTime': _preferredCheckInTime,
        if (_dietaryRestrictions?.isNotEmpty == true) 'dietaryRestrictions': _dietaryRestrictions,
        if (_accessibilityNeeds?.isNotEmpty == true) 'accessibilityNeeds': _accessibilityNeeds,
        if (_loyaltyPoints != null) 'loyaltyPoints': _loyaltyPoints,
        if (_lifetimeSpent != null) 'lifetimeSpent': _lifetimeSpent,
        if (_bookingCount != null) 'bookingCount': _bookingCount,
    };
    final result = widget.item != null
        ? GuestProfile.fromJson({...widget.item!.toJson(), ...data})
        : GuestProfile.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preferred Check In Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _preferredCheckInTime = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dietary Restrictions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dietaryRestrictions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Accessibility Needs', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _accessibilityNeeds = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Loyalty Points', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _loyaltyPoints = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lifetime Spent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _lifetimeSpent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Booking Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _bookingCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Guest Profile'),
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