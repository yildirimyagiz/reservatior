import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ListingStatusHistory Form Widget  |  Fields: listingId, status, fromDate, toDate, reason

class ListingStatusHistoryFormWidget extends StatefulWidget {
  final ListingStatusHistory? item;
  final void Function(ListingStatusHistory)? onSubmit;
  const ListingStatusHistoryFormWidget({super.key, this.item, this.onSubmit});
  @override State<ListingStatusHistoryFormWidget> createState() => _ListingStatusHistoryFormWidgetState();
}

class _ListingStatusHistoryFormWidgetState extends State<ListingStatusHistoryFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _status;
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _reason;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _status = widget.item?.status?.toString();
    _fromDate = widget.item?.fromDate;
    _toDate = widget.item?.toDate;
    _reason = widget.item?.reason?.toString();
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
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_fromDate != null) 'fromDate': _fromDate!.toIso8601String(),
        if (_toDate != null) 'toDate': _toDate!.toIso8601String(),
        if (_reason?.isNotEmpty == true) 'reason': _reason,
    };
    final result = widget.item != null
        ? ListingStatusHistory.fromJson({...widget.item!.toJson(), ...data})
        : ListingStatusHistory.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _fromDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _fromDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'From Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_fromDate != null ? _fmt(_fromDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _toDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _toDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'To Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_toDate != null ? _fmt(_toDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Listing Status History'),
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