import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GuestReview Form Widget  |  Fields: bookingId, guestId, propertyId, rating, cleanliness, communication, checkIn, accuracy, location, value, comment, response, isPublic

class GuestReviewFormWidget extends StatefulWidget {
  final GuestReview? item;
  final void Function(GuestReview)? onSubmit;
  const GuestReviewFormWidget({super.key, this.item, this.onSubmit});
  @override State<GuestReviewFormWidget> createState() => _GuestReviewFormWidgetState();
}

class _GuestReviewFormWidgetState extends State<GuestReviewFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _bookingId;
  String? _guestId;
  String? _propertyId;
  int? _rating;
  int? _cleanliness;
  int? _communication;
  int? _checkIn;
  int? _accuracy;
  int? _location;
  int? _value;
  String? _comment;
  String? _response;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    _bookingId = widget.item?.bookingId?.toString();
    _guestId = widget.item?.guestId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _rating = widget.item?.rating;
    _cleanliness = widget.item?.cleanliness;
    _communication = widget.item?.communication;
    _checkIn = widget.item?.checkIn;
    _accuracy = widget.item?.accuracy;
    _location = widget.item?.location;
    _value = widget.item?.value;
    _comment = widget.item?.comment?.toString();
    _response = widget.item?.response?.toString();
    _isPublic = widget.item?.isPublic ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
        if (_guestId?.isNotEmpty == true) 'guestId': _guestId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_rating != null) 'rating': _rating,
        if (_cleanliness != null) 'cleanliness': _cleanliness,
        if (_communication != null) 'communication': _communication,
        if (_checkIn != null) 'checkIn': _checkIn,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_location != null) 'location': _location,
        if (_value != null) 'value': _value,
        if (_comment?.isNotEmpty == true) 'comment': _comment,
        if (_response?.isNotEmpty == true) 'response': _response,
        'isPublic': _isPublic,
    };
    final result = widget.item != null
        ? GuestReview.fromJson({...widget.item!.toJson(), ...data})
        : GuestReview.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Guest Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _guestId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _rating = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cleanliness', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _cleanliness = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Communication', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _communication = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Check In', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _checkIn = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Accuracy', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _accuracy = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                onSaved: (v) => _location = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _value = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comment', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _comment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Response', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _response = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Public'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isPublic,
                  onChanged: (v) { ss(() {}); setState(() => _isPublic = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Guest Review'),
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