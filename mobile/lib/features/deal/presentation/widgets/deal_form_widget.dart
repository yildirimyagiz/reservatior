import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Deal Form Widget  |  Fields: listingId, propertyId, clientId, agentId, locationId, dealType, offerPrice, listPrice, salePrice, commissionRate, commissionAmount, closingDate, financingType, loanAmount, downPayment, earnestMoney, escrowAmount, closingCosts, sellerConcessions, buyerCredits, inspectionPeriod, financingContingency, appraisalContingency, titleContingency, attorneyReview, multipleOffers

class DealFormWidget extends StatefulWidget {
  final Deal? item;
  final void Function(Deal)? onSubmit;
  const DealFormWidget({super.key, this.item, this.onSubmit});
  @override State<DealFormWidget> createState() => _DealFormWidgetState();
}

class _DealFormWidgetState extends State<DealFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _agentId;
  bool _appraisalContingency = false;
  bool _attorneyReview = false;
  double? _buyerCredits;
  String? _clientId;
  double? _closingCosts;
  DateTime? _closingDate;
  double? _commissionAmount;
  double? _commissionRate;
  String? _dealType;
  double? _downPayment;
  double? _earnestMoney;
  double? _escrowAmount;
  bool _financingContingency = false;
  String? _financingType;
  int? _inspectionPeriod;
  double? _listPrice;
  String? _listingId;
  double? _loanAmount;
  String? _locationId;
  bool _multipleOffers = false;
  double? _offerPrice;
  String? _propertyId;
  double? _salePrice;
  double? _sellerConcessions;
  bool _titleContingency = false;

  @override
  void initState() {
    super.initState();
    _agentId = widget.item?.agentId?.toString();
    _appraisalContingency = widget.item?.appraisalContingency ?? false;
    _attorneyReview = widget.item?.attorneyReview ?? false;
    _buyerCredits = widget.item?.buyerCredits;
    _clientId = widget.item?.clientId?.toString();
    _closingCosts = widget.item?.closingCosts;
    _closingDate = widget.item?.closingDate;
    _commissionAmount = widget.item?.commissionAmount;
    _commissionRate = widget.item?.commissionRate;
    _dealType = widget.item?.dealType?.toString();
    _downPayment = widget.item?.downPayment;
    _earnestMoney = widget.item?.earnestMoney;
    _escrowAmount = widget.item?.escrowAmount;
    _financingContingency = widget.item?.financingContingency ?? false;
    _financingType = widget.item?.financingType?.toString();
    _inspectionPeriod = widget.item?.inspectionPeriod;
    _listPrice = widget.item?.listPrice;
    _listingId = widget.item?.listingId?.toString();
    _loanAmount = widget.item?.loanAmount;
    _locationId = widget.item?.locationId?.toString();
    _multipleOffers = widget.item?.multipleOffers ?? false;
    _offerPrice = widget.item?.offerPrice;
    _propertyId = widget.item?.propertyId?.toString();
    _salePrice = widget.item?.salePrice;
    _sellerConcessions = widget.item?.sellerConcessions;
    _titleContingency = widget.item?.titleContingency ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_agentId?.isNotEmpty == true) 'agentId': _agentId,
        'appraisalContingency': _appraisalContingency,
        'attorneyReview': _attorneyReview,
        if (_buyerCredits != null) 'buyerCredits': _buyerCredits,
        if (_clientId?.isNotEmpty == true) 'clientId': _clientId,
        if (_closingCosts != null) 'closingCosts': _closingCosts,
        if (_closingDate != null) 'closingDate': _closingDate!.toIso8601String(),
        if (_commissionAmount != null) 'commissionAmount': _commissionAmount,
        if (_commissionRate != null) 'commissionRate': _commissionRate,
        if (_dealType?.isNotEmpty == true) 'dealType': _dealType,
        if (_downPayment != null) 'downPayment': _downPayment,
        if (_earnestMoney != null) 'earnestMoney': _earnestMoney,
        if (_escrowAmount != null) 'escrowAmount': _escrowAmount,
        'financingContingency': _financingContingency,
        if (_financingType?.isNotEmpty == true) 'financingType': _financingType,
        if (_inspectionPeriod != null) 'inspectionPeriod': _inspectionPeriod,
        if (_listPrice != null) 'listPrice': _listPrice,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_loanAmount != null) 'loanAmount': _loanAmount,
        if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
        'multipleOffers': _multipleOffers,
        if (_offerPrice != null) 'offerPrice': _offerPrice,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_salePrice != null) 'salePrice': _salePrice,
        if (_sellerConcessions != null) 'sellerConcessions': _sellerConcessions,
        'titleContingency': _titleContingency,
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
                decoration: InputDecoration(labelText: 'Agent Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _agentId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _agentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Appraisal Contingency'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _appraisalContingency,
                  onChanged: (v) { ss(() {}); setState(() => _appraisalContingency = v); },
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Attorney Review'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _attorneyReview,
                  onChanged: (v) { ss(() {}); setState(() => _attorneyReview = v); },
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Buyer Credits', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _buyerCredits?.toString() ?? '',
                onSaved: (v) => _buyerCredits = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Client Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _clientId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _clientId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Closing Costs', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _closingCosts?.toString() ?? '',
                onSaved: (v) => _closingCosts = double.tryParse(v ?? ''),
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
                decoration: const InputDecoration(labelText: 'Commission Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _commissionAmount?.toString() ?? '',
                onSaved: (v) => _commissionAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _commissionRate?.toString() ?? '',
                onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Deal Type', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _dealType?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _dealType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Down Payment', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _downPayment?.toString() ?? '',
                onSaved: (v) => _downPayment = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Earnest Money', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _earnestMoney?.toString() ?? '',
                onSaved: (v) => _earnestMoney = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Escrow Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _escrowAmount?.toString() ?? '',
                onSaved: (v) => _escrowAmount = double.tryParse(v ?? ''),
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
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Financing Type', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _financingType?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _financingType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Inspection Period', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                initialValue: _inspectionPeriod?.toString() ?? '',
                onSaved: (v) => _inspectionPeriod = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'List Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _listPrice?.toString() ?? '',
                onSaved: (v) => _listPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _listingId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Loan Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _loanAmount?.toString() ?? '',
                onSaved: (v) => _loanAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _locationId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Multiple Offers'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _multipleOffers,
                  onChanged: (v) { ss(() {}); setState(() => _multipleOffers = v); },
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Offer Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _offerPrice?.toString() ?? '',
                onSaved: (v) => _offerPrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _propertyId?.toString() ?? '',
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sale Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _salePrice?.toString() ?? '',
                onSaved: (v) => _salePrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Seller Concessions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                initialValue: _sellerConcessions?.toString() ?? '',
                onSaved: (v) => _sellerConcessions = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Title Contingency'),
                  secondary: const Icon(Icons.person),
                  value: _titleContingency,
                  onChanged: (v) { ss(() {}); setState(() => _titleContingency = v); },
                ),
              ),
              const SizedBox(height: 12),
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
