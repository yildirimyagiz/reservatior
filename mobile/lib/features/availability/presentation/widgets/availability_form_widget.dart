import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Availability Form Widget  |  Fields: date, isBlocked, isBooked, propertyId, reservationId, pricingRuleId, totalUnits, availableUnits, bookedUnits, blockedUnits, specialPricing, basePrice, currentPrice, priceSettings, minNights, maxNights, maxGuests, discountSettings, weekendRate, weekdayRate, weekendMultiplier, weekdayMultiplier, seasonalMultiplier

class AvailabilityFormWidget extends StatefulWidget {
  final Availability? item;
  final void Function(Availability)? onSubmit;
  const AvailabilityFormWidget({super.key, this.item, this.onSubmit});
  @override State<AvailabilityFormWidget> createState() => _AvailabilityFormWidgetState();
}

class _AvailabilityFormWidgetState extends State<AvailabilityFormWidget> {
  final _key = GlobalKey<FormState>();
  DateTime? _date;
  bool _isBlocked = false;
  bool _isBooked = false;
  String? _propertyId;
  String? _reservationId;
  String? _pricingRuleId;
  int? _totalUnits;
  int? _availableUnits;
  int? _bookedUnits;
  int? _blockedUnits;
  String? _specialPricing;
  double? _basePrice;
  double? _currentPrice;
  String? _priceSettings;
  int? _minNights;
  int? _maxNights;
  int? _maxGuests;
  String? _discountSettings;
  double? _weekendRate;
  double? _weekdayRate;
  double? _weekendMultiplier;
  double? _weekdayMultiplier;
  double? _seasonalMultiplier;

  @override
  void initState() {
    super.initState();
    _date = widget.item?.date;
    _isBlocked = widget.item?.isBlocked ?? false;
    _isBooked = widget.item?.isBooked ?? false;
    _propertyId = widget.item?.propertyId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _pricingRuleId = widget.item?.pricingRuleId?.toString();
    _totalUnits = widget.item?.totalUnits;
    _availableUnits = widget.item?.availableUnits;
    _bookedUnits = widget.item?.bookedUnits;
    _blockedUnits = widget.item?.blockedUnits;
    _specialPricing = widget.item?.specialPricing?.toString();
    _basePrice = widget.item?.basePrice;
    _currentPrice = widget.item?.currentPrice;
    _priceSettings = widget.item?.priceSettings?.toString();
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _maxGuests = widget.item?.maxGuests;
    _discountSettings = widget.item?.discountSettings?.toString();
    _weekendRate = widget.item?.weekendRate;
    _weekdayRate = widget.item?.weekdayRate;
    _weekendMultiplier = widget.item?.weekendMultiplier;
    _weekdayMultiplier = widget.item?.weekdayMultiplier;
    _seasonalMultiplier = widget.item?.seasonalMultiplier;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_date != null) 'date': _date!.toIso8601String(),
        'isBlocked': _isBlocked,
        'isBooked': _isBooked,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_pricingRuleId?.isNotEmpty == true) 'pricingRuleId': _pricingRuleId,
        if (_totalUnits != null) 'totalUnits': _totalUnits,
        if (_availableUnits != null) 'availableUnits': _availableUnits,
        if (_bookedUnits != null) 'bookedUnits': _bookedUnits,
        if (_blockedUnits != null) 'blockedUnits': _blockedUnits,
        if (_specialPricing?.isNotEmpty == true) 'specialPricing': _specialPricing,
        if (_basePrice != null) 'basePrice': _basePrice,
        if (_currentPrice != null) 'currentPrice': _currentPrice,
        if (_priceSettings?.isNotEmpty == true) 'priceSettings': _priceSettings,
        if (_minNights != null) 'minNights': _minNights,
        if (_maxNights != null) 'maxNights': _maxNights,
        if (_maxGuests != null) 'maxGuests': _maxGuests,
        if (_discountSettings?.isNotEmpty == true) 'discountSettings': _discountSettings,
        if (_weekendRate != null) 'weekendRate': _weekendRate,
        if (_weekdayRate != null) 'weekdayRate': _weekdayRate,
        if (_weekendMultiplier != null) 'weekendMultiplier': _weekendMultiplier,
        if (_weekdayMultiplier != null) 'weekdayMultiplier': _weekdayMultiplier,
        if (_seasonalMultiplier != null) 'seasonalMultiplier': _seasonalMultiplier,
    };
    final result = widget.item != null
        ? Availability.fromJson({...widget.item!.toJson(), ...data})
        : Availability.fromJson(data);
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _date ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _date = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_date != null ? _fmt(_date) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Blocked'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isBlocked,
                  onChanged: (v) { ss(() {}); setState(() => _isBlocked = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Booked'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isBooked,
                  onChanged: (v) { ss(() {}); setState(() => _isBooked = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _propertyId?.toString() ?? '',
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _reservationId?.toString() ?? '',
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pricing Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _pricingRuleId?.toString() ?? '',
                onSaved: (v) => _pricingRuleId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Units', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _totalUnits?.toString() ?? '',
                onSaved: (v) => _totalUnits = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Available Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _availableUnits?.toString() ?? '',
                onSaved: (v) => _availableUnits = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Booked Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _bookedUnits?.toString() ?? '',
                onSaved: (v) => _bookedUnits = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Blocked Units', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _blockedUnits?.toString() ?? '',
                onSaved: (v) => _blockedUnits = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Special Pricing', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _specialPricing?.toString() ?? '',
                onSaved: (v) => _specialPricing = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Base Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _basePrice?.toString() ?? '',
                onSaved: (v) => _basePrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _currentPrice?.toString() ?? '',
                onSaved: (v) => _currentPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price Settings', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                initialValue: _priceSettings?.toString() ?? '',
                onSaved: (v) => _priceSettings = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _minNights?.toString() ?? '',
                onSaved: (v) => _minNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _maxNights?.toString() ?? '',
                onSaved: (v) => _maxNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Guests', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _maxGuests?.toString() ?? '',
                onSaved: (v) => _maxGuests = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Discount Settings', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _discountSettings?.toString() ?? '',
                onSaved: (v) => _discountSettings = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weekend Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _weekendRate?.toString() ?? '',
                onSaved: (v) => _weekendRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weekday Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _weekdayRate?.toString() ?? '',
                onSaved: (v) => _weekdayRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weekend Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _weekendMultiplier?.toString() ?? '',
                onSaved: (v) => _weekendMultiplier = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weekday Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _weekdayMultiplier?.toString() ?? '',
                onSaved: (v) => _weekdayMultiplier = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seasonal Multiplier', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _seasonalMultiplier?.toString() ?? '',
                onSaved: (v) => _seasonalMultiplier = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Availability'),
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