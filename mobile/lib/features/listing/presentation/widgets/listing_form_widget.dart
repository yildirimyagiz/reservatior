import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Listing Form Widget  |  Fields: propertyId, type, status, willBeAvailableAt, strategy, title, description, price, priceCurrency, locationId

class ListingFormWidget extends StatefulWidget {
  final Listing? item;
  final void Function(Listing)? onSubmit;
  const ListingFormWidget({super.key, this.item, this.onSubmit});
  @override State<ListingFormWidget> createState() => _ListingFormWidgetState();
}

class _ListingFormWidgetState extends State<ListingFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _type;
  String? _status;
  DateTime? _willBeAvailableAt;
  String? _strategy;
  String? _title;
  String? _description;
  double? _price;
  String? _priceCurrency;
  String? _locationId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _willBeAvailableAt = widget.item?.willBeAvailableAt;
    _strategy = widget.item?.strategy?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _price = widget.item?.price;
    _priceCurrency = widget.item?.priceCurrency?.toString();
    _locationId = widget.item?.locationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_willBeAvailableAt != null) 'willBeAvailableAt': _willBeAvailableAt!.toIso8601String(),
        if (_strategy?.isNotEmpty == true) 'strategy': _strategy,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_price != null) 'price': _price,
        if (_priceCurrency?.isNotEmpty == true) 'priceCurrency': _priceCurrency,
        if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
    };
    final result = widget.item != null
        ? Listing.fromJson({...widget.item!.toJson(), ...data})
        : Listing.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _willBeAvailableAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _willBeAvailableAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Will Be Available At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_willBeAvailableAt != null ? _fmt(_willBeAvailableAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Strategy', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _strategy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _price = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price Currency', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _priceCurrency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Listing'),
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