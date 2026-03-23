import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── EscrowAccount Form Widget  |  Fields: reservationId, totalAmount, depositAmount, currency, status, heldAt, releasedAt

class EscrowAccountFormWidget extends StatefulWidget {
  final EscrowAccount? item;
  final void Function(EscrowAccount)? onSubmit;
  const EscrowAccountFormWidget({super.key, this.item, this.onSubmit});
  @override State<EscrowAccountFormWidget> createState() => _EscrowAccountFormWidgetState();
}

class _EscrowAccountFormWidgetState extends State<EscrowAccountFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _reservationId;
  double? _totalAmount;
  double? _depositAmount;
  String? _currency;
  String? _status;
  DateTime? _heldAt;
  DateTime? _releasedAt;

  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId?.toString();
    _totalAmount = widget.item?.totalAmount;
    _depositAmount = widget.item?.depositAmount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _heldAt = widget.item?.heldAt;
    _releasedAt = widget.item?.releasedAt;
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
        if (_totalAmount != null) 'totalAmount': _totalAmount,
        if (_depositAmount != null) 'depositAmount': _depositAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_heldAt != null) 'heldAt': _heldAt!.toIso8601String(),
        if (_releasedAt != null) 'releasedAt': _releasedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? EscrowAccount.fromJson({...widget.item!.toJson(), ...data})
        : EscrowAccount.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Total Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deposit Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _depositAmount = double.tryParse(v ?? ''),
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _heldAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _heldAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Held At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_heldAt != null ? _fmt(_heldAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _releasedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _releasedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Released At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_releasedAt != null ? _fmt(_releasedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Escrow Account'),
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