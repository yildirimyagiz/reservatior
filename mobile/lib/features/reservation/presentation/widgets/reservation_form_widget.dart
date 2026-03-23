import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Reservation Form Widget  |  Fields: listingId, contactId, checkInDate, checkOutDate, guestCount, specialRequests, nightlyRate, cleaningFee, totalAmount, currency, status, paymentStatus, validUntil

class ReservationFormWidget extends StatefulWidget {
  final Reservation? item;
  final void Function(Reservation)? onSubmit;
  const ReservationFormWidget({super.key, this.item, this.onSubmit});
  @override State<ReservationFormWidget> createState() => _ReservationFormWidgetState();
}

class _ReservationFormWidgetState extends State<ReservationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _contactId;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int? _guestCount;
  String? _specialRequests;
  double? _nightlyRate;
  double? _cleaningFee;
  double? _totalAmount;
  String? _currency;
  String? _status;
  String? _paymentStatus;
  DateTime? _validUntil;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _checkInDate = widget.item?.checkInDate;
    _checkOutDate = widget.item?.checkOutDate;
    _guestCount = widget.item?.guestCount;
    _specialRequests = widget.item?.specialRequests?.toString();
    _nightlyRate = widget.item?.nightlyRate;
    _cleaningFee = widget.item?.cleaningFee;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _paymentStatus = widget.item?.paymentStatus?.toString();
    _validUntil = widget.item?.validUntil;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_checkInDate != null) 'checkInDate': _checkInDate!.toIso8601String(),
        if (_checkOutDate != null) 'checkOutDate': _checkOutDate!.toIso8601String(),
        if (_guestCount != null) 'guestCount': _guestCount,
        if (_specialRequests?.isNotEmpty == true) 'specialRequests': _specialRequests,
        if (_nightlyRate != null) 'nightlyRate': _nightlyRate,
        if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
        if (_totalAmount != null) 'totalAmount': _totalAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_paymentStatus?.isNotEmpty == true) 'paymentStatus': _paymentStatus,
        if (_validUntil != null) 'validUntil': _validUntil!.toIso8601String(),
    };
    final result = widget.item != null
        ? Reservation.fromJson({...widget.item!.toJson(), ...data})
        : Reservation.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _checkInDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _checkInDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Check In Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_checkInDate != null ? _fmt(_checkInDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _checkOutDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _checkOutDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Check Out Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_checkOutDate != null ? _fmt(_checkOutDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Guest Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _guestCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Special Requests', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _specialRequests = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nightly Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _nightlyRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cleaning Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _cleaningFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _paymentStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _validUntil ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _validUntil = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Valid Until',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_validUntil != null ? _fmt(_validUntil) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Reservation'),
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