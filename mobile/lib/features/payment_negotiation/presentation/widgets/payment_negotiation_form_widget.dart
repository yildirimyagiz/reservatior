import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PaymentNegotiation Form Widget  |  Fields: reservationId, tenantContactId, ownerContactId, ownerUserId, status, maxInstallments, minFirstPaymentPct, platformValidated, validationNotes, agreedOfferId, agreedAt, expiresAt, reminderSentAt

class PaymentNegotiationFormWidget extends StatefulWidget {
  final PaymentNegotiation? item;
  final void Function(PaymentNegotiation)? onSubmit;
  const PaymentNegotiationFormWidget({super.key, this.item, this.onSubmit});
  @override State<PaymentNegotiationFormWidget> createState() => _PaymentNegotiationFormWidgetState();
}

class _PaymentNegotiationFormWidgetState extends State<PaymentNegotiationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _reservationId;
  String? _tenantContactId;
  String? _ownerContactId;
  String? _ownerUserId;
  String? _status;
  int? _maxInstallments;
  double? _minFirstPaymentPct;
  bool _platformValidated = false;
  String? _validationNotes;
  String? _agreedOfferId;
  DateTime? _agreedAt;
  DateTime? _expiresAt;
  DateTime? _reminderSentAt;

  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId?.toString();
    _tenantContactId = widget.item?.tenantContactId?.toString();
    _ownerContactId = widget.item?.ownerContactId?.toString();
    _ownerUserId = widget.item?.ownerUserId?.toString();
    _status = widget.item?.status?.toString();
    _maxInstallments = widget.item?.maxInstallments;
    _minFirstPaymentPct = widget.item?.minFirstPaymentPct;
    _platformValidated = widget.item?.platformValidated ?? false;
    _validationNotes = widget.item?.validationNotes?.toString();
    _agreedOfferId = widget.item?.agreedOfferId?.toString();
    _agreedAt = widget.item?.agreedAt;
    _expiresAt = widget.item?.expiresAt;
    _reminderSentAt = widget.item?.reminderSentAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_tenantContactId?.isNotEmpty == true) 'tenantContactId': _tenantContactId,
        if (_ownerContactId?.isNotEmpty == true) 'ownerContactId': _ownerContactId,
        if (_ownerUserId?.isNotEmpty == true) 'ownerUserId': _ownerUserId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_maxInstallments != null) 'maxInstallments': _maxInstallments,
        if (_minFirstPaymentPct != null) 'minFirstPaymentPct': _minFirstPaymentPct,
        'platformValidated': _platformValidated,
        if (_validationNotes?.isNotEmpty == true) 'validationNotes': _validationNotes,
        if (_agreedOfferId?.isNotEmpty == true) 'agreedOfferId': _agreedOfferId,
        if (_agreedAt != null) 'agreedAt': _agreedAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_reminderSentAt != null) 'reminderSentAt': _reminderSentAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? PaymentNegotiation.fromJson({...widget.item!.toJson(), ...data})
        : PaymentNegotiation.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ownerContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Owner User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ownerUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Installments', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxInstallments = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min First Payment Pct', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _minFirstPaymentPct = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Platform Validated'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _platformValidated,
                  onChanged: (v) { ss(() {}); setState(() => _platformValidated = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Validation Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _validationNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agreed Offer Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agreedOfferId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _agreedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _agreedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Agreed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_agreedAt != null ? _fmt(_agreedAt) : 'Tap to select date'),
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
                    context: context, initialDate: _reminderSentAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _reminderSentAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Reminder Sent At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_reminderSentAt != null ? _fmt(_reminderSentAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Payment Negotiation'),
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