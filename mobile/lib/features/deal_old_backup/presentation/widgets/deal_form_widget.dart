import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Deal Form Widget  |  Fields: listingId, propertyId, clientId, agentId, locationId, dealStatus, dealType, offerPrice, listPrice, salePrice, commissionRate, commissionAmount, closingDate, financingType, loanAmount, downPayment, earnestMoney, escrowAmount, closingCosts, sellerConcessions, buyerCredits, inspectionPeriod, financingContingency, appraisalContingency, titleContingency, attorneyReview, multipleOffers

class DealFormWidget extends StatefulWidget {
  final Deal? item;
  final void Function(Deal)? onSubmit;
  const DealFormWidget({super.key, this.item, this.onSubmit});
  @override State<DealFormWidget> createState() => _DealFormWidgetState();
}

class _DealFormWidgetState extends State<DealFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _propertyId;
  String? _clientId;
  String? _agentId;
  String? _locationId;
  String? _dealStatus;
  String? _dealType;
  double? _offerPrice;
  double? _listPrice;
  double? _salePrice;
  double? _commissionRate;
  double? _commissionAmount;
  DateTime? _closingDate;
  String? _financingType;
  double? _loanAmount;
  double? _downPayment;
  double? _earnestMoney;
  double? _escrowAmount;
  double? _closingCosts;
  double? _sellerConcessions;
  double? _buyerCredits;
  int? _inspectionPeriod;
  bool _financingContingency = false;
  bool _appraisalContingency = false;
  bool _titleContingency = false;
  bool _attorneyReview = false;
  bool _multipleOffers = false;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _clientId = widget.item?.clientId?.toString();
    _agentId = widget.item?.agentId?.toString();
    _locationId = widget.item?.locationId?.toString();
    _dealStatus = widget.item?.dealStatus?.toString();
    _dealType = widget.item?.dealType?.toString();
    _offerPrice = widget.item?.offerPrice;
    _listPrice = widget.item?.listPrice;
    _salePrice = widget.item?.salePrice;
    _commissionRate = widget.item?.commissionRate;
    _commissionAmount = widget.item?.commissionAmount;
    _closingDate = widget.item?.closingDate;
    _financingType = widget.item?.financingType?.toString();
    _loanAmount = widget.item?.loanAmount;
    _downPayment = widget.item?.downPayment;
    _earnestMoney = widget.item?.earnestMoney;
    _escrowAmount = widget.item?.escrowAmount;
    _closingCosts = widget.item?.closingCosts;
    _sellerConcessions = widget.item?.sellerConcessions;
    _buyerCredits = widget.item?.buyerCredits;
    _inspectionPeriod = widget.item?.inspectionPeriod;
    _financingContingency = widget.item?.financingContingency ?? false;
    _appraisalContingency = widget.item?.appraisalContingency ?? false;
    _titleContingency = widget.item?.titleContingency ?? false;
    _attorneyReview = widget.item?.attorneyReview ?? false;
    _multipleOffers = widget.item?.multipleOffers ?? false;
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
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_clientId?.isNotEmpty == true) 'clientId': _clientId,
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
        if (_dealStatus?.isNotEmpty == true) 'dealStatus': _dealStatus,
        if (_dealType?.isNotEmpty == true) 'dealType': _dealType,
        if (_offerPrice != null) 'offerPrice': _offerPrice,
        if (_listPrice != null) 'listPrice': _listPrice,
        if (_salePrice != null) 'salePrice': _salePrice,
        if (_commissionRate != null) 'commissionRate': _commissionRate,
        if (_commissionAmount != null) 'commissionAmount': _commissionAmount,
        if (_closingDate != null) 'closingDate': _closingDate!.toIso8601String(),
        if (_financingType?.isNotEmpty == true) 'financingType': _financingType,
        if (_loanAmount != null) 'loanAmount': _loanAmount,
        if (_downPayment != null) 'downPayment': _downPayment,
        if (_earnestMoney != null) 'earnestMoney': _earnestMoney,
        if (_escrowAmount != null) 'escrowAmount': _escrowAmount,
        if (_closingCosts != null) 'closingCosts': _closingCosts,
        if (_sellerConcessions != null) 'sellerConcessions': _sellerConcessions,
        if (_buyerCredits != null) 'buyerCredits': _buyerCredits,
        if (_inspectionPeriod != null) 'inspectionPeriod': _inspectionPeriod,
        'financingContingency': _financingContingency,
        'appraisalContingency': _appraisalContingency,
        'titleContingency': _titleContingency,
        'attorneyReview': _attorneyReview,
        'multipleOffers': _multipleOffers,
    };
    final result = widget.item != null
        ? Deal.fromJson({...widget.item!.toJson(), ...data})
        : Deal.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Client Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _clientId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _dealStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dealType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Offer Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _offerPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'List Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _listPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sale Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _salePrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _commissionAmount = double.tryParse(v ?? ''),
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
                decoration: const InputDecoration(labelText: 'Loan Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _loanAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Down Payment', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _downPayment = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Earnest Money', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _earnestMoney = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Escrow Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _escrowAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Closing Costs', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _closingCosts = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seller Concessions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _sellerConcessions = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Buyer Credits', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _buyerCredits = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Inspection Period', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _inspectionPeriod = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Financing Contingency'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _financingContingency,
                  onChanged: (v) { ss(() {}); setState(() => _financingContingency = v); },
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
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Title Contingency'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _titleContingency,
                  onChanged: (v) { ss(() {}); setState(() => _titleContingency = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Attorney Review'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _attorneyReview,
                  onChanged: (v) { ss(() {}); setState(() => _attorneyReview = v); },
                ),
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Multiple Offers'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _multipleOffers,
                  onChanged: (v) { ss(() {}); setState(() => _multipleOffers = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Deal'),
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