import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class GuestProfileFormWidget extends ConsumerStatefulWidget {
  final GuestProfile? item;
  final Function(GuestProfile) onSubmit;
  const GuestProfileFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<GuestProfileFormWidget> createState() =>
      _GuestProfileFormWidgetState();
}

class _GuestProfileFormWidgetState
    extends ConsumerState<GuestProfileFormWidget> {
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
    _contactId = widget.item?.contactId;
    _preferredCheckInTime = widget.item?.preferredCheckInTime;
    _dietaryRestrictions = widget.item?.dietaryRestrictions;
    _accessibilityNeeds = widget.item?.accessibilityNeeds;
    _loyaltyPoints = widget.item?.loyaltyPoints;
    _lifetimeSpent = widget.item?.lifetimeSpent;
    _bookingCount = widget.item?.bookingCount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.guestprofile'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.guestprofile'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _preferredCheckInTime?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.preferredcheckintime'.tr(),
              ),
              onChanged: (v) => _preferredCheckInTime = v,
            ),
            TextFormField(
              initialValue: _dietaryRestrictions?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.dietaryrestrictions'.tr(),
              ),
              onChanged: (v) => _dietaryRestrictions = v,
            ),
            TextFormField(
              initialValue: _accessibilityNeeds?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.accessibilityneeds'.tr(),
              ),
              onChanged: (v) => _accessibilityNeeds = v,
            ),
            TextFormField(
              initialValue: _loyaltyPoints?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.loyaltypoints'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _loyaltyPoints = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lifetimeSpent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lifetimespent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lifetimeSpent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bookingCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bookingcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bookingCount = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contactId != null) 'contactId': _contactId,
                  if (_preferredCheckInTime != null)
                    'preferredCheckInTime': _preferredCheckInTime,
                  if (_dietaryRestrictions != null)
                    'dietaryRestrictions': _dietaryRestrictions,
                  if (_accessibilityNeeds != null)
                    'accessibilityNeeds': _accessibilityNeeds,
                  if (_loyaltyPoints != null) 'loyaltyPoints': _loyaltyPoints,
                  if (_lifetimeSpent != null) 'lifetimeSpent': _lifetimeSpent,
                  if (_bookingCount != null) 'bookingCount': _bookingCount,
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
                  widget.onSubmit(GuestProfile.fromJson(json));
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
