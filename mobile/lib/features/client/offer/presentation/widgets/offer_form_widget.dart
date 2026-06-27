import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class OfferFormWidget extends ConsumerStatefulWidget {
  final Offer? item;
  final Function(Offer) onSubmit;
  const OfferFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<OfferFormWidget> createState() => _OfferFormWidgetState();
}

class _OfferFormWidgetState extends ConsumerState<OfferFormWidget> {
  String? _increaseId;
  double? _basePrice;
  double? _discountRate;
  double? _finalPrice;
  String? _guestId;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _specialRequirements;
  String? _notes;
  String? _reservationId;
  String? _propertyId;
  @override
  void initState() {
    super.initState();
    _increaseId = widget.item?.increaseId;
    _basePrice = widget.item?.basePrice;
    _discountRate = widget.item?.discountRate;
    _finalPrice = widget.item?.finalPrice;
    _guestId = widget.item?.guestId;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _specialRequirements = widget.item?.specialRequirements;
    _notes = widget.item?.notes;
    _reservationId = widget.item?.reservationId;
    _propertyId = widget.item?.propertyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.offer'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.offer'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _increaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.increaseid'.tr()),
              onChanged: (v) => _increaseId = v,
            ),
            TextFormField(
              initialValue: _basePrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _basePrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _discountRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.discountrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _discountRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _finalPrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.finalprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _finalPrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _guestId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.guestid'.tr()),
              onChanged: (v) => _guestId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _specialRequirements?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.specialrequirements'.tr(),
              ),
              onChanged: (v) => _specialRequirements = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_increaseId != null) 'increaseId': _increaseId,
                  if (_basePrice != null) 'basePrice': _basePrice,
                  if (_discountRate != null) 'discountRate': _discountRate,
                  if (_finalPrice != null) 'finalPrice': _finalPrice,
                  if (_guestId != null) 'guestId': _guestId,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_specialRequirements != null)
                    'specialRequirements': _specialRequirements,
                  if (_notes != null) 'notes': _notes,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_propertyId != null) 'propertyId': _propertyId,
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
                  widget.onSubmit(Offer.fromJson(json));
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
