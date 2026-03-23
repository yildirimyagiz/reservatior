import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── NegotiationOffer Form Widget  |  Fields: negotiationId, offeredBy, installmentCount, firstPaymentPct, totalAmount, currency, notes, status, offeredAt, expiresAt, respondedAt

class NegotiationOfferFormWidget extends StatefulWidget {
  final NegotiationOffer? item;
  final void Function(NegotiationOffer)? onSubmit;
  const NegotiationOfferFormWidget({super.key, this.item, this.onSubmit});
  @override State<NegotiationOfferFormWidget> createState() => _NegotiationOfferFormWidgetState();
}

class _NegotiationOfferFormWidgetState extends State<NegotiationOfferFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _negotiationId;
  String? _offeredBy;
  int? _installmentCount;
  double? _firstPaymentPct;
  double? _totalAmount;
  String? _currency;
  String? _notes;
  String? _status;
  DateTime? _offeredAt;
  DateTime? _expiresAt;
  DateTime? _respondedAt;

  @override
  void initState() {
    super.initState();
    _negotiationId = widget.item?.negotiationId?.toString();
    _offeredBy = widget.item?.offeredBy?.toString();
    _installmentCount = widget.item?.installmentCount;
    _firstPaymentPct = widget.item?.firstPaymentPct;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _notes = widget.item?.notes?.toString();
    _status = widget.item?.status?.toString();
    _offeredAt = widget.item?.offeredAt;
    _expiresAt = widget.item?.expiresAt;
    _respondedAt = widget.item?.respondedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_negotiationId?.isNotEmpty == true) 'negotiationId': _negotiationId,
        if (_offeredBy?.isNotEmpty == true) 'offeredBy': _offeredBy,
        if (_installmentCount != null) 'installmentCount': _installmentCount,
        if (_firstPaymentPct != null) 'firstPaymentPct': _firstPaymentPct,
        if (_totalAmount != null) 'totalAmount': _totalAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_offeredAt != null) 'offeredAt': _offeredAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_respondedAt != null) 'respondedAt': _respondedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? NegotiationOffer.fromJson({...widget.item!.toJson(), ...data})
        : NegotiationOffer.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Negotiation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _negotiationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Offered By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _offeredBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Installment Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _installmentCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'First Payment Pct', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _firstPaymentPct = double.tryParse(v ?? ''),
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
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _offeredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _offeredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Offered At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_offeredAt != null ? _fmt(_offeredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _respondedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _respondedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Responded At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_respondedAt != null ? _fmt(_respondedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Negotiation Offer'),
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