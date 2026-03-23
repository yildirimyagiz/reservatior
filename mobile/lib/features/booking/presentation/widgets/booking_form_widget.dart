import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Booking Form Widget  |  Fields: listingId, contactId, reservationId, status, startDate, endDate, adults, children, priceTotal, currency, paymentStatus, notes

class BookingFormWidget extends StatefulWidget {
  final Booking? item;
  final void Function(Booking)? onSubmit;
  const BookingFormWidget({super.key, this.item, this.onSubmit});
  @override State<BookingFormWidget> createState() => _BookingFormWidgetState();
}

class _BookingFormWidgetState extends State<BookingFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _contactId;
  String? _reservationId;
  String? _status;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _adults;
  int? _children;
  double? _priceTotal;
  String? _currency;
  String? _paymentStatus;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _status = widget.item?.status?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _adults = widget.item?.adults;
    _children = widget.item?.children;
    _priceTotal = widget.item?.priceTotal;
    _currency = widget.item?.currency?.toString();
    _paymentStatus = widget.item?.paymentStatus?.toString();
    _notes = widget.item?.notes?.toString();
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
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_adults != null) 'adults': _adults,
        if (_children != null) 'children': _children,
        if (_priceTotal != null) 'priceTotal': _priceTotal,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_paymentStatus?.isNotEmpty == true) 'paymentStatus': _paymentStatus,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? Booking.fromJson({...widget.item!.toJson(), ...data})
        : Booking.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                initialValue: _listingId?.toString() ?? '',
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contact Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                initialValue: _contactId?.toString() ?? '',
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reservation Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                initialValue: _reservationId?.toString() ?? '',
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adults', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _adults?.toString() ?? '',
                onSaved: (v) => _adults = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Children', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _children?.toString() ?? '',
                onSaved: (v) => _children = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price Total', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _priceTotal?.toString() ?? '',
                onSaved: (v) => _priceTotal = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Currency', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                initialValue: _currency?.toString() ?? '',
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Payment Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                initialValue: _paymentStatus?.toString() ?? '',
                onSaved: (v) => _paymentStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                initialValue: _notes?.toString() ?? '',
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Booking'),
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