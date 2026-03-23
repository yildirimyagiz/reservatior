import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyOffer Form Widget  |  Fields: propertyId, listingId, contactId, originalOfferId, offerPrice, currency, closingDate, financingType, earnestMoneyDeposit, dueDiligencePeriod, inspectionContingency, appraisalContingency, specialConditions, status, validUntil

class PropertyOfferFormWidget extends StatefulWidget {
  final PropertyOffer? item;
  final void Function(PropertyOffer)? onSubmit;
  const PropertyOfferFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyOfferFormWidget> createState() => _PropertyOfferFormWidgetState();
}

class _PropertyOfferFormWidgetState extends State<PropertyOfferFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _contactId;
  String? _originalOfferId;
  double? _offerPrice;
  String? _currency;
  DateTime? _closingDate;
  String? _financingType;
  double? _earnestMoneyDeposit;
  int? _dueDiligencePeriod;
  bool _inspectionContingency = false;
  bool _appraisalContingency = false;
  String? _specialConditions;
  String? _status;
  DateTime? _validUntil;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _originalOfferId = widget.item?.originalOfferId?.toString();
    _offerPrice = widget.item?.offerPrice;
    _currency = widget.item?.currency?.toString();
    _closingDate = widget.item?.closingDate;
    _financingType = widget.item?.financingType?.toString();
    _earnestMoneyDeposit = widget.item?.earnestMoneyDeposit;
    _dueDiligencePeriod = widget.item?.dueDiligencePeriod;
    _inspectionContingency = widget.item?.inspectionContingency ?? false;
    _appraisalContingency = widget.item?.appraisalContingency ?? false;
    _specialConditions = widget.item?.specialConditions?.toString();
    _status = widget.item?.status?.toString();
    _validUntil = widget.item?.validUntil;
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
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_originalOfferId?.isNotEmpty == true) 'originalOfferId': _originalOfferId,
        if (_offerPrice != null) 'offerPrice': _offerPrice,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_closingDate != null) 'closingDate': _closingDate!.toIso8601String(),
        if (_financingType?.isNotEmpty == true) 'financingType': _financingType,
        if (_earnestMoneyDeposit != null) 'earnestMoneyDeposit': _earnestMoneyDeposit,
        if (_dueDiligencePeriod != null) 'dueDiligencePeriod': _dueDiligencePeriod,
        'inspectionContingency': _inspectionContingency,
        'appraisalContingency': _appraisalContingency,
        if (_specialConditions?.isNotEmpty == true) 'specialConditions': _specialConditions,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_validUntil != null) 'validUntil': _validUntil!.toIso8601String(),
    };
    final result = widget.item != null
        ? PropertyOffer.fromJson({...widget.item!.toJson(), ...data})
        : PropertyOffer.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Original Offer Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _originalOfferId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Offer Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _offerPrice = double.tryParse(v ?? ''),
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
                    context: context, initialDate: _closingDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _closingDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Closing Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_closingDate != null ? _fmt(_closingDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Financing Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _financingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Earnest Money Deposit', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _earnestMoneyDeposit = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Due Diligence Period', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _dueDiligencePeriod = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Inspection Contingency'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _inspectionContingency,
                  onChanged: (v) { ss(() {}); setState(() => _inspectionContingency = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Appraisal Contingency'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _appraisalContingency,
                  onChanged: (v) { ss(() {}); setState(() => _appraisalContingency = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Special Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _specialConditions = v?.isEmpty == true ? null : v,
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Offer'),
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