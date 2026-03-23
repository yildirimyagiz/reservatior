import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExtraCharge Form Widget  |  Fields: reservationId, name, description, amount, chargeType, isPaid, icon, logo, facilityId, includedServiceId

class ExtraChargeFormWidget extends StatefulWidget {
  final ExtraCharge? item;
  final void Function(ExtraCharge)? onSubmit;
  const ExtraChargeFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExtraChargeFormWidget> createState() => _ExtraChargeFormWidgetState();
}

class _ExtraChargeFormWidgetState extends State<ExtraChargeFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _reservationId;
  String? _name;
  String? _description;
  double? _amount;
  String? _chargeType;
  bool _isPaid = false;
  String? _icon;
  String? _logo;
  String? _facilityId;
  String? _includedServiceId;

  @override
  void initState() {
    super.initState();
    _reservationId = widget.item?.reservationId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _amount = widget.item?.amount;
    _chargeType = widget.item?.chargeType?.toString();
    _isPaid = widget.item?.isPaid ?? false;
    _icon = widget.item?.icon?.toString();
    _logo = widget.item?.logo?.toString();
    _facilityId = widget.item?.facilityId?.toString();
    _includedServiceId = widget.item?.includedServiceId?.toString();
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_amount != null) 'amount': _amount,
        if (_chargeType?.isNotEmpty == true) 'chargeType': _chargeType,
        'isPaid': _isPaid,
        if (_icon?.isNotEmpty == true) 'icon': _icon,
        if (_logo?.isNotEmpty == true) 'logo': _logo,
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
        if (_includedServiceId?.isNotEmpty == true) 'includedServiceId': _includedServiceId,
    };
    final result = widget.item != null
        ? ExtraCharge.fromJson({...widget.item!.toJson(), ...data})
        : ExtraCharge.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Charge Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _chargeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Paid'),
                  secondary: const Icon(Icons.link),
                  value: _isPaid,
                  onChanged: (v) { ss(() {}); setState(() => _isPaid = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Icon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _icon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Logo', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _logo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Included Service Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _includedServiceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Extra Charge'),
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