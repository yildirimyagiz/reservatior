import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Offer Form Widget  |  Fields: increaseId, offerType, status, basePrice, discountRate, finalPrice, guestId, startDate, endDate, specialRequirements, notes, reservationId, propertyId

class OfferFormWidget extends StatefulWidget {
  final Offer? item;
  final void Function(Offer)? onSubmit;
  const OfferFormWidget({super.key, this.item, this.onSubmit});
  @override State<OfferFormWidget> createState() => _OfferFormWidgetState();
}

class _OfferFormWidgetState extends State<OfferFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _increaseId;
  String? _offerType;
  String? _status;
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
    _increaseId = widget.item?.increaseId?.toString();
    _offerType = widget.item?.offerType?.toString();
    _status = widget.item?.status?.toString();
    _basePrice = widget.item?.basePrice;
    _discountRate = widget.item?.discountRate;
    _finalPrice = widget.item?.finalPrice;
    _guestId = widget.item?.guestId?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _specialRequirements = widget.item?.specialRequirements?.toString();
    _notes = widget.item?.notes?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_increaseId?.isNotEmpty == true) 'increaseId': _increaseId,
        if (_offerType?.isNotEmpty == true) 'offerType': _offerType,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_basePrice != null) 'basePrice': _basePrice,
        if (_discountRate != null) 'discountRate': _discountRate,
        if (_finalPrice != null) 'finalPrice': _finalPrice,
        if (_guestId?.isNotEmpty == true) 'guestId': _guestId,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_specialRequirements?.isNotEmpty == true) 'specialRequirements': _specialRequirements,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
    };
    final result = widget.item != null
        ? Offer.fromJson({...widget.item!.toJson(), ...data})
        : Offer.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Increase Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _increaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Offer Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _offerType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Base Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _basePrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Discount Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _discountRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Final Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _finalPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Guest Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _guestId = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Special Requirements', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _specialRequirements = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Offer'),
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