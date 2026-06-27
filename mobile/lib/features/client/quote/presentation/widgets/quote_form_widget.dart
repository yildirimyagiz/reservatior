import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class QuoteFormWidget extends ConsumerStatefulWidget {
  final Quote? item;
  final Function(Quote) onSubmit;
  const QuoteFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<QuoteFormWidget> createState() => _QuoteFormWidgetState();
}

class _QuoteFormWidgetState extends ConsumerState<QuoteFormWidget> {
  String? _contactId;
  String? _quoteNumber;
  String? _title;
  String? _description;
  String? _propertyId;
  String? _listingId;
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
    _contactId = widget.item?.contactId;
    _quoteNumber = widget.item?.quoteNumber;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _subtotal = widget.item?.subtotal;
    _taxAmount = widget.item?.taxAmount;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency;
    _validUntil = widget.item?.validUntil;
    _status = widget.item?.status;
    _notes = widget.item?.notes;
    _terms = widget.item?.terms;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.quote'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.quote'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _quoteNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.quotenumber'.tr()),
              onChanged: (v) => _quoteNumber = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
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
            TextFormField(
              initialValue: _subtotal?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subtotal'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _subtotal = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _taxAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _taxAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_valid_until'.tr()}: ${_validUntil ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _validUntil ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _validUntil = d);
              },
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _terms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.terms'.tr()),
              onChanged: (v) => _terms = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_contactId != null) 'contactId': _contactId,
                  if (_quoteNumber != null) 'quoteNumber': _quoteNumber,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_subtotal != null) 'subtotal': _subtotal,
                  if (_taxAmount != null) 'taxAmount': _taxAmount,
                  if (_totalAmount != null) 'totalAmount': _totalAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_validUntil != null)
                    'validUntil': _validUntil!.toIso8601String(),
                  if (_status != null) 'status': _status,
                  if (_notes != null) 'notes': _notes,
                  if (_terms != null) 'terms': _terms,
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
                  widget.onSubmit(Quote.fromJson(json));
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
