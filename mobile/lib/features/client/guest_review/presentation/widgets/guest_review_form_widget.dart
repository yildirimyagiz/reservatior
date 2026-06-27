import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class GuestReviewFormWidget extends ConsumerStatefulWidget {
  final GuestReview? item;
  final Function(GuestReview) onSubmit;
  const GuestReviewFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<GuestReviewFormWidget> createState() =>
      _GuestReviewFormWidgetState();
}

class _GuestReviewFormWidgetState extends ConsumerState<GuestReviewFormWidget> {
  String? _bookingId;
  String? _guestId;
  String? _propertyId;
  int? _rating;
  int? _cleanlines;
  int? _communication;
  int? _checkIn;
  int? _accuracy;
  int? _location;
  int? _value;
  String? _comment;
  String? _response;
  bool? _isPublic;
  @override
  void initState() {
    super.initState();
    _bookingId = widget.item?.bookingId;
    _guestId = widget.item?.guestId;
    _propertyId = widget.item?.propertyId;
    _rating = widget.item?.rating;
    _cleanlines = widget.item?.cleanlines;
    _communication = widget.item?.communication;
    _checkIn = widget.item?.checkIn;
    _accuracy = widget.item?.accuracy;
    _location = widget.item?.location;
    _value = widget.item?.value;
    _comment = widget.item?.comment;
    _response = widget.item?.response;
    _isPublic = widget.item?.isPublic;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.guestreview'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.guestreview'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _bookingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bookingid'.tr()),
              onChanged: (v) => _bookingId = v,
            ),
            TextFormField(
              initialValue: _guestId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.guestid'.tr()),
              onChanged: (v) => _guestId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _rating?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rating'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rating = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _cleanlines?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cleanlines'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _cleanlines = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _communication?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.communication'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _communication = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _checkIn?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkin'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _checkIn = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _accuracy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.accuracy'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _accuracy = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _location?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.location'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _location = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _value = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _comment?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.comment'.tr()),
              onChanged: (v) => _comment = v,
            ),
            TextFormField(
              initialValue: _response?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.response'.tr()),
              onChanged: (v) => _response = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.ispublic'.tr()),
              value: _isPublic ?? false,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_bookingId != null) 'bookingId': _bookingId,
                  if (_guestId != null) 'guestId': _guestId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_rating != null) 'rating': _rating,
                  if (_cleanlines != null) 'cleanlines': _cleanlines,
                  if (_communication != null) 'communication': _communication,
                  if (_checkIn != null) 'checkIn': _checkIn,
                  if (_accuracy != null) 'accuracy': _accuracy,
                  if (_location != null) 'location': _location,
                  if (_value != null) 'value': _value,
                  if (_comment != null) 'comment': _comment,
                  if (_response != null) 'response': _response,
                  'isPublic': _isPublic,
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
                  widget.onSubmit(GuestReview.fromJson(json));
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
