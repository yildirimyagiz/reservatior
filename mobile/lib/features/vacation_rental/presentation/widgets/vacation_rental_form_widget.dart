import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VacationRental Form Widget  |  Fields: propertyId, listingId, isActive, rentalType, instantBooking, baseNightlyRate, currency, cleaningFee, securityDeposit, weeklyDiscount, monthlyDiscount, checkInTime, checkOutTime, minStayNights, maxStayNights, advanceBookingDays, maxGuests, childrenAllowed, petsAllowed, smokingAllowed, eventsAllowed, houseRules, cancellationPolicy

class VacationRentalFormWidget extends StatefulWidget {
  final VacationRental? item;
  final void Function(VacationRental)? onSubmit;
  const VacationRentalFormWidget({super.key, this.item, this.onSubmit});
  @override State<VacationRentalFormWidget> createState() => _VacationRentalFormWidgetState();
}

class _VacationRentalFormWidgetState extends State<VacationRentalFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  bool _isActive = false;
  String? _rentalType;
  bool _instantBooking = false;
  double? _baseNightlyRate;
  String? _currency;
  double? _cleaningFee;
  double? _securityDeposit;
  double? _weeklyDiscount;
  double? _monthlyDiscount;
  String? _checkInTime;
  String? _checkOutTime;
  int? _minStayNights;
  int? _maxStayNights;
  int? _advanceBookingDays;
  int? _maxGuests;
  bool _childrenAllowed = false;
  bool _petsAllowed = false;
  bool _smokingAllowed = false;
  bool _eventsAllowed = false;
  String? _houseRules;
  String? _cancellationPolicy;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _isActive = widget.item?.isActive ?? false;
    _rentalType = widget.item?.rentalType?.toString();
    _instantBooking = widget.item?.instantBooking ?? false;
    _baseNightlyRate = widget.item?.baseNightlyRate;
    _currency = widget.item?.currency?.toString();
    _cleaningFee = widget.item?.cleaningFee;
    _securityDeposit = widget.item?.securityDeposit;
    _weeklyDiscount = widget.item?.weeklyDiscount;
    _monthlyDiscount = widget.item?.monthlyDiscount;
    _checkInTime = widget.item?.checkInTime?.toString();
    _checkOutTime = widget.item?.checkOutTime?.toString();
    _minStayNights = widget.item?.minStayNights;
    _maxStayNights = widget.item?.maxStayNights;
    _advanceBookingDays = widget.item?.advanceBookingDays;
    _maxGuests = widget.item?.maxGuests;
    _childrenAllowed = widget.item?.childrenAllowed ?? false;
    _petsAllowed = widget.item?.petsAllowed ?? false;
    _smokingAllowed = widget.item?.smokingAllowed ?? false;
    _eventsAllowed = widget.item?.eventsAllowed ?? false;
    _houseRules = widget.item?.houseRules?.toString();
    _cancellationPolicy = widget.item?.cancellationPolicy?.toString();
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
        'isActive': _isActive,
        if (_rentalType?.isNotEmpty == true) 'rentalType': _rentalType,
        'instantBooking': _instantBooking,
        if (_baseNightlyRate != null) 'baseNightlyRate': _baseNightlyRate,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
        if (_securityDeposit != null) 'securityDeposit': _securityDeposit,
        if (_weeklyDiscount != null) 'weeklyDiscount': _weeklyDiscount,
        if (_monthlyDiscount != null) 'monthlyDiscount': _monthlyDiscount,
        if (_checkInTime?.isNotEmpty == true) 'checkInTime': _checkInTime,
        if (_checkOutTime?.isNotEmpty == true) 'checkOutTime': _checkOutTime,
        if (_minStayNights != null) 'minStayNights': _minStayNights,
        if (_maxStayNights != null) 'maxStayNights': _maxStayNights,
        if (_advanceBookingDays != null) 'advanceBookingDays': _advanceBookingDays,
        if (_maxGuests != null) 'maxGuests': _maxGuests,
        'childrenAllowed': _childrenAllowed,
        'petsAllowed': _petsAllowed,
        'smokingAllowed': _smokingAllowed,
        'eventsAllowed': _eventsAllowed,
        if (_houseRules?.isNotEmpty == true) 'houseRules': _houseRules,
        if (_cancellationPolicy?.isNotEmpty == true) 'cancellationPolicy': _cancellationPolicy,
    };
    final result = widget.item != null
        ? VacationRental.fromJson({...widget.item!.toJson(), ...data})
        : VacationRental.fromJson(data);
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
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rental Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _rentalType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Instant Booking'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _instantBooking,
                  onChanged: (v) { ss(() {}); setState(() => _instantBooking = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Base Nightly Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _baseNightlyRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cleaning Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _cleaningFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Security Deposit', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _securityDeposit = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weekly Discount', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _weeklyDiscount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Discount', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _monthlyDiscount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check In Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkInTime = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Out Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkOutTime = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min Stay Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _minStayNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Stay Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxStayNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Advance Booking Days', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _advanceBookingDays = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Guests', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxGuests = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Children Allowed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _childrenAllowed,
                  onChanged: (v) { ss(() {}); setState(() => _childrenAllowed = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Pets Allowed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _petsAllowed,
                  onChanged: (v) { ss(() {}); setState(() => _petsAllowed = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Smoking Allowed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _smokingAllowed,
                  onChanged: (v) { ss(() {}); setState(() => _smokingAllowed = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Events Allowed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _eventsAllowed,
                  onChanged: (v) { ss(() {}); setState(() => _eventsAllowed = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'House Rules', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _houseRules = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cancellation Policy', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _cancellationPolicy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Vacation Rental'),
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