import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class VacationRentalFormWidget extends ConsumerStatefulWidget {
  final VacationRental? item;
  final Function(VacationRental) onSubmit;
  const VacationRentalFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<VacationRentalFormWidget> createState() =>
      _VacationRentalFormWidgetState();
}

class _VacationRentalFormWidgetState
    extends ConsumerState<VacationRentalFormWidget> {
  String? _propertyId;
  String? _listingId;
  bool? _isActive;
  String? _rentalType;
  bool? _instantBooking;
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
  bool? _childrenAllowed;
  bool? _petsAllowed;
  bool? _smokingAllowed;
  bool? _eventsAllowed;
  String? _houseRules;
  String? _cancellationPolicy;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _isActive = widget.item?.isActive;
    _rentalType = widget.item?.rentalType;
    _instantBooking = widget.item?.instantBooking;
    _baseNightlyRate = widget.item?.baseNightlyRate;
    _currency = widget.item?.currency;
    _cleaningFee = widget.item?.cleaningFee;
    _securityDeposit = widget.item?.securityDeposit;
    _weeklyDiscount = widget.item?.weeklyDiscount;
    _monthlyDiscount = widget.item?.monthlyDiscount;
    _checkInTime = widget.item?.checkInTime;
    _checkOutTime = widget.item?.checkOutTime;
    _minStayNights = widget.item?.minStayNights;
    _maxStayNights = widget.item?.maxStayNights;
    _advanceBookingDays = widget.item?.advanceBookingDays;
    _maxGuests = widget.item?.maxGuests;
    _childrenAllowed = widget.item?.childrenAllowed;
    _petsAllowed = widget.item?.petsAllowed;
    _smokingAllowed = widget.item?.smokingAllowed;
    _eventsAllowed = widget.item?.eventsAllowed;
    _houseRules = widget.item?.houseRules;
    _cancellationPolicy = widget.item?.cancellationPolicy;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.vacationrental'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.vacationrental'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _rentalType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentaltype'.tr()),
              onChanged: (v) => _rentalType = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.instantbooking'.tr()),
              value: _instantBooking ?? false,
              onChanged: (v) => setState(() => _instantBooking = v),
            ),
            TextFormField(
              initialValue: _baseNightlyRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.basenightlyrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _baseNightlyRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _cleaningFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cleaningfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _cleaningFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _securityDeposit?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.securitydeposit'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _securityDeposit = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _weeklyDiscount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.weeklydiscount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _weeklyDiscount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _monthlyDiscount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.monthlydiscount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _monthlyDiscount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _checkInTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkintime'.tr()),
              onChanged: (v) => _checkInTime = v,
            ),
            TextFormField(
              initialValue: _checkOutTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkouttime'.tr()),
              onChanged: (v) => _checkOutTime = v,
            ),
            TextFormField(
              initialValue: _minStayNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minstaynights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minStayNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxStayNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxstaynights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxStayNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _advanceBookingDays?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.advancebookingdays'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _advanceBookingDays = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxGuests?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxguests'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxGuests = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.childrenallowed'.tr()),
              value: _childrenAllowed ?? false,
              onChanged: (v) => setState(() => _childrenAllowed = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.petsallowed'.tr()),
              value: _petsAllowed ?? false,
              onChanged: (v) => setState(() => _petsAllowed = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.smokingallowed'.tr()),
              value: _smokingAllowed ?? false,
              onChanged: (v) => setState(() => _smokingAllowed = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.eventsallowed'.tr()),
              value: _eventsAllowed ?? false,
              onChanged: (v) => setState(() => _eventsAllowed = v),
            ),
            TextFormField(
              initialValue: _houseRules?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.houserules'.tr()),
              onChanged: (v) => _houseRules = v,
            ),
            TextFormField(
              initialValue: _cancellationPolicy?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.cancellationpolicy'.tr(),
              ),
              onChanged: (v) => _cancellationPolicy = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  'isActive': _isActive,
                  if (_rentalType != null) 'rentalType': _rentalType,
                  'instantBooking': _instantBooking,
                  if (_baseNightlyRate != null)
                    'baseNightlyRate': _baseNightlyRate,
                  if (_currency != null) 'currency': _currency,
                  if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
                  if (_securityDeposit != null)
                    'securityDeposit': _securityDeposit,
                  if (_weeklyDiscount != null)
                    'weeklyDiscount': _weeklyDiscount,
                  if (_monthlyDiscount != null)
                    'monthlyDiscount': _monthlyDiscount,
                  if (_checkInTime != null) 'checkInTime': _checkInTime,
                  if (_checkOutTime != null) 'checkOutTime': _checkOutTime,
                  if (_minStayNights != null) 'minStayNights': _minStayNights,
                  if (_maxStayNights != null) 'maxStayNights': _maxStayNights,
                  if (_advanceBookingDays != null)
                    'advanceBookingDays': _advanceBookingDays,
                  if (_maxGuests != null) 'maxGuests': _maxGuests,
                  'childrenAllowed': _childrenAllowed,
                  'petsAllowed': _petsAllowed,
                  'smokingAllowed': _smokingAllowed,
                  'eventsAllowed': _eventsAllowed,
                  if (_houseRules != null) 'houseRules': _houseRules,
                  if (_cancellationPolicy != null)
                    'cancellationPolicy': _cancellationPolicy,
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
                  widget.onSubmit(VacationRental.fromJson(json));
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
