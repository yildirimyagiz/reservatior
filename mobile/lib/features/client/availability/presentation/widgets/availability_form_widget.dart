import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AvailabilityFormWidget extends ConsumerStatefulWidget {
  final Availability? item;
  final Function(Availability) onSubmit;
  const AvailabilityFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AvailabilityFormWidget> createState() =>
      _AvailabilityFormWidgetState();
}

class _AvailabilityFormWidgetState
    extends ConsumerState<AvailabilityFormWidget> {
  DateTime? _date;
  bool? _isBlocked;
  bool? _isBooked;
  String? _propertyId;
  String? _reservationId;
  String? _pricingRuleId;
  int? _totalUnits;
  int? _availableUnits;
  int? _bookedUnits;
  int? _blockedUnits;
  double? _basePrice;
  double? _currentPrice;
  int? _minNights;
  int? _maxNights;
  int? _maxGuests;
  double? _weekendRate;
  double? _weekdayRate;
  double? _weekendMultiplier;
  double? _weekdayMultiplier;
  double? _seasonalMultiplier;
  @override
  void initState() {
    super.initState();
    _date = widget.item?.date;
    _isBlocked = widget.item?.isBlocked;
    _isBooked = widget.item?.isBooked;
    _propertyId = widget.item?.propertyId;
    _reservationId = widget.item?.reservationId;
    _pricingRuleId = widget.item?.pricingRuleId;
    _totalUnits = widget.item?.totalUnits;
    _availableUnits = widget.item?.availableUnits;
    _bookedUnits = widget.item?.bookedUnits;
    _blockedUnits = widget.item?.blockedUnits;
    _basePrice = widget.item?.basePrice;
    _currentPrice = widget.item?.currentPrice;
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _maxGuests = widget.item?.maxGuests;
    _weekendRate = widget.item?.weekendRate;
    _weekdayRate = widget.item?.weekdayRate;
    _weekendMultiplier = widget.item?.weekendMultiplier;
    _weekdayMultiplier = widget.item?.weekdayMultiplier;
    _seasonalMultiplier = widget.item?.seasonalMultiplier;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.availability'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.availability'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text("${'mobile.admin.field_date'.tr()}: ${_date ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _date ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _date = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.isblocked'.tr()),
              value: _isBlocked ?? false,
              onChanged: (v) => setState(() => _isBlocked = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isbooked'.tr()),
              value: _isBooked ?? false,
              onChanged: (v) => setState(() => _isBooked = v),
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _pricingRuleId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricingruleid'.tr()),
              onChanged: (v) => _pricingRuleId = v,
            ),
            TextFormField(
              initialValue: _totalUnits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalunits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalUnits = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _availableUnits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.availableunits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _availableUnits = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bookedUnits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bookedunits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bookedUnits = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _blockedUnits?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.blockedunits'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _blockedUnits = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _basePrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _basePrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currentPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _minNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minnights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxnights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxGuests?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxguests'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxGuests = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _weekendRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.weekendrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _weekendRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _weekdayRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.weekdayrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _weekdayRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _weekendMultiplier?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.weekendmultiplier'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _weekendMultiplier = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _weekdayMultiplier?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.weekdaymultiplier'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _weekdayMultiplier = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _seasonalMultiplier?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.seasonalmultiplier'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _seasonalMultiplier = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_date != null) 'date': _date!.toIso8601String(),
                  'isBlocked': _isBlocked,
                  'isBooked': _isBooked,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_pricingRuleId != null) 'pricingRuleId': _pricingRuleId,
                  if (_totalUnits != null) 'totalUnits': _totalUnits,
                  if (_availableUnits != null)
                    'availableUnits': _availableUnits,
                  if (_bookedUnits != null) 'bookedUnits': _bookedUnits,
                  if (_blockedUnits != null) 'blockedUnits': _blockedUnits,
                  if (_basePrice != null) 'basePrice': _basePrice,
                  if (_currentPrice != null) 'currentPrice': _currentPrice,
                  if (_minNights != null) 'minNights': _minNights,
                  if (_maxNights != null) 'maxNights': _maxNights,
                  if (_maxGuests != null) 'maxGuests': _maxGuests,
                  if (_weekendRate != null) 'weekendRate': _weekendRate,
                  if (_weekdayRate != null) 'weekdayRate': _weekdayRate,
                  if (_weekendMultiplier != null)
                    'weekendMultiplier': _weekendMultiplier,
                  if (_weekdayMultiplier != null)
                    'weekdayMultiplier': _weekdayMultiplier,
                  if (_seasonalMultiplier != null)
                    'seasonalMultiplier': _seasonalMultiplier,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(Availability.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
