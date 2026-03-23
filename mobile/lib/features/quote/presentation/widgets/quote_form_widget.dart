import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Quote Form Widget  |  Fields: contactId, quoteNumber, title, description, propertyId, listingId, items, subtotal, taxAmount, totalAmount, currency, validUntil, status, notes, terms

class QuoteFormWidget extends StatefulWidget {
  final Quote? item;
  final void Function(Quote)? onSubmit;
  const QuoteFormWidget({super.key, this.item, this.onSubmit});
  @override State<QuoteFormWidget> createState() => _QuoteFormWidgetState();
}

class _QuoteFormWidgetState extends State<QuoteFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contactId;
  String? _quoteNumber;
  String? _title;
  String? _description;
  String? _propertyId;
  String? _listingId;
  String? _items;
  double? _subtotal;
  double? _taxAmount;
  double? _totalAmount;
  String? _currency;
  DateTime? _validUntil;
  String? _status;
  String? _notes;
  String? _terms;

  @override
  void initState() {
    super.initState();
    _contactId = widget.item?.contactId?.toString();
    _quoteNumber = widget.item?.quoteNumber?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _items = widget.item?.items?.toString();
    _subtotal = widget.item?.subtotal;
    _taxAmount = widget.item?.taxAmount;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _validUntil = widget.item?.validUntil;
    _status = widget.item?.status?.toString();
    _notes = widget.item?.notes?.toString();
    _terms = widget.item?.terms?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_quoteNumber?.isNotEmpty == true) 'quoteNumber': _quoteNumber,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_items?.isNotEmpty == true) 'items': _items,
        if (_subtotal != null) 'subtotal': _subtotal,
        if (_taxAmount != null) 'taxAmount': _taxAmount,
        if (_totalAmount != null) 'totalAmount': _totalAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_validUntil != null) 'validUntil': _validUntil!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_terms?.isNotEmpty == true) 'terms': _terms,
    };
    final result = widget.item != null
        ? Quote.fromJson({...widget.item!.toJson(), ...data})
        : Quote.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quote Number', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _quoteNumber = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Items', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _items = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Subtotal', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _subtotal = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _taxAmount = double.tryParse(v ?? ''),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Terms', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _terms = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Quote'),
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