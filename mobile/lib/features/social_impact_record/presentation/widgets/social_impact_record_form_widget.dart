import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SocialImpactRecord Form Widget  |  Fields: counterId, reservationId, impactType, quantity, amount, currency, description, verifiedAt, verifiedBy, proofUrl

class SocialImpactRecordFormWidget extends StatefulWidget {
  final SocialImpactRecord? item;
  final void Function(SocialImpactRecord)? onSubmit;
  const SocialImpactRecordFormWidget({super.key, this.item, this.onSubmit});
  @override State<SocialImpactRecordFormWidget> createState() => _SocialImpactRecordFormWidgetState();
}

class _SocialImpactRecordFormWidgetState extends State<SocialImpactRecordFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _counterId;
  String? _reservationId;
  String? _impactType;
  int? _quantity;
  double? _amount;
  String? _currency;
  String? _description;
  DateTime? _verifiedAt;
  String? _verifiedBy;
  String? _proofUrl;

  @override
  void initState() {
    super.initState();
    _counterId = widget.item?.counterId?.toString();
    _reservationId = widget.item?.reservationId?.toString();
    _impactType = widget.item?.impactType?.toString();
    _quantity = widget.item?.quantity;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _description = widget.item?.description?.toString();
    _verifiedAt = widget.item?.verifiedAt;
    _verifiedBy = widget.item?.verifiedBy?.toString();
    _proofUrl = widget.item?.proofUrl?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_counterId?.isNotEmpty == true) 'counterId': _counterId,
        if (_reservationId?.isNotEmpty == true) 'reservationId': _reservationId,
        if (_impactType?.isNotEmpty == true) 'impactType': _impactType,
        if (_quantity != null) 'quantity': _quantity,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_verifiedAt != null) 'verifiedAt': _verifiedAt!.toIso8601String(),
        if (_verifiedBy?.isNotEmpty == true) 'verifiedBy': _verifiedBy,
        if (_proofUrl?.isNotEmpty == true) 'proofUrl': _proofUrl,
    };
    final result = widget.item != null
        ? SocialImpactRecord.fromJson({...widget.item!.toJson(), ...data})
        : SocialImpactRecord.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Counter Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _counterId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reservation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reservationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Impact Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _impactType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _quantity = int.tryParse(v ?? ''),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _verifiedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _verifiedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Verified At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_verifiedAt != null ? _fmt(_verifiedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Verified By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _verifiedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Proof Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _proofUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Social Impact Record'),
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