import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── FinancialRecord Form Widget  |  Fields: propertyId, listingId, leaseId, bookingId, reservationId, vendorContactId, type, recordType, amount, currency, occurredAt, dueDate, billData, category, description, notes, paymentStatus, paidAt

class FinancialRecordFormWidget extends StatefulWidget {
  final FinancialRecord? item;
  final void Function(FinancialRecord)? onSubmit;
  const FinancialRecordFormWidget({super.key, this.item, this.onSubmit});
  @override State<FinancialRecordFormWidget> createState() => _FinancialRecordFormWidgetState();
}

class _FinancialRecordFormWidgetState extends State<FinancialRecordFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _reservationId;
  String? _vendorContactId;
  String? _type;
  String? _recordType;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  DateTime? _dueDate;
  String? _billData;
  String? _category;
  String? _description;
  String? _notes;
  String? _paymentStatus;
  DateTime? _paidAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _vendorContactId = widget.item?.vendorContactId?.toString();
    _type = widget.item?.type?.toString();
    _recordType = widget.item?.recordType?.toString();
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _occurredAt = widget.item?.occurredAt;
    _dueDate = widget.item?.dueDate;
    _billData = widget.item?.billData?.toString();
    _category = widget.item?.category?.toString();
    _description = widget.item?.description?.toString();
    _notes = widget.item?.notes?.toString();
    _paymentStatus = widget.item?.paymentStatus?.toString();
    _paidAt = widget.item?.paidAt;
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
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_vendorContactId?.isNotEmpty == true) 'vendorContactId': _vendorContactId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_recordType?.isNotEmpty == true) 'recordType': _recordType,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_occurredAt != null) 'occurredAt': _occurredAt!.toIso8601String(),
        if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
        if (_billData?.isNotEmpty == true) 'billData': _billData,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_paymentStatus?.isNotEmpty == true) 'paymentStatus': _paymentStatus,
        if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? FinancialRecord.fromJson({...widget.item!.toJson(), ...data})
        : FinancialRecord.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Vendor Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _vendorContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Record Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _recordType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
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
                    context: context, initialDate: _occurredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _occurredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Occurred At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_occurredAt != null ? _fmt(_occurredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dueDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_dueDate != null ? _fmt(_dueDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bill Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _billData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _paidAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _paidAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Paid At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_paidAt != null ? _fmt(_paidAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Financial Record'),
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