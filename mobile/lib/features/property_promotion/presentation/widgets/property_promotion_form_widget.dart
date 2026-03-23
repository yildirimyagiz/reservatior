import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyPromotion Form Widget  |  Fields: propertyId, agencyId, agentId, promotionType, status, startDate, endDate, price, currency, isAutoRenew, paymentHistoryId, userId

class PropertyPromotionFormWidget extends StatefulWidget {
  final PropertyPromotion? item;
  final void Function(PropertyPromotion)? onSubmit;
  const PropertyPromotionFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyPromotionFormWidget> createState() => _PropertyPromotionFormWidgetState();
}

class _PropertyPromotionFormWidgetState extends State<PropertyPromotionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _agencyId;
  String? _agentId;
  String? _promotionType;
  String? _status;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _price;
  String? _currency;
  bool _isAutoRenew = false;
  String? _paymentHistoryId;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _agencyId = widget.item?.agencyId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _promotionType = widget.item?.promotionType?.toString();
    _status = widget.item?.status?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _price = widget.item?.price;
    _currency = widget.item?.currency?.toString();
    _isAutoRenew = widget.item?.isAutoRenew ?? false;
    _paymentHistoryId = widget.item?.paymentHistoryId?.toString();
    _userId = widget.item?.userId?.toString();
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
        if (_agencyId?.isNotEmpty == true) 'agencyId': _agencyId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_promotionType?.isNotEmpty == true) 'promotionType': _promotionType,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_price != null) 'price': _price,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        'isAutoRenew': _isAutoRenew,
        if (_paymentHistoryId?.isNotEmpty == true) 'paymentHistoryId': _paymentHistoryId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
    };
    final result = widget.item != null
        ? PropertyPromotion.fromJson({...widget.item!.toJson(), ...data})
        : PropertyPromotion.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Agency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Promotion Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _promotionType = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _price = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Auto Renew'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isAutoRenew,
                  onChanged: (v) { ss(() {}); setState(() => _isAutoRenew = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment History Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _paymentHistoryId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Promotion'),
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