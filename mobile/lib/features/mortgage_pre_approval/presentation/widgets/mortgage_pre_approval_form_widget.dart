import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MortgagePreApproval Form Widget  |  Fields: dealId, contactId, lenderName, mortgageType, mortgageTerm, interestRate, arrangementFee, valuationFee, loanAmount, depositAmount, loanToValue, monthlyPayment, totalPayable, offerStatus, offerDate, expiryDate, acceptedDate, solicitorName, solicitorEmail

class MortgagePreApprovalFormWidget extends StatefulWidget {
  final MortgagePreApproval? item;
  final void Function(MortgagePreApproval)? onSubmit;
  const MortgagePreApprovalFormWidget({super.key, this.item, this.onSubmit});
  @override State<MortgagePreApprovalFormWidget> createState() => _MortgagePreApprovalFormWidgetState();
}

class _MortgagePreApprovalFormWidgetState extends State<MortgagePreApprovalFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _dealId;
  String? _contactId;
  String? _lenderName;
  String? _mortgageType;
  int? _mortgageTerm;
  double? _interestRate;
  double? _arrangementFee;
  double? _valuationFee;
  double? _loanAmount;
  double? _depositAmount;
  double? _loanToValue;
  double? _monthlyPayment;
  double? _totalPayable;
  String? _offerStatus;
  DateTime? _offerDate;
  DateTime? _expiryDate;
  DateTime? _acceptedDate;
  String? _solicitorName;
  String? _solicitorEmail;

  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _lenderName = widget.item?.lenderName?.toString();
    _mortgageType = widget.item?.mortgageType?.toString();
    _mortgageTerm = widget.item?.mortgageTerm;
    _interestRate = widget.item?.interestRate;
    _arrangementFee = widget.item?.arrangementFee;
    _valuationFee = widget.item?.valuationFee;
    _loanAmount = widget.item?.loanAmount;
    _depositAmount = widget.item?.depositAmount;
    _loanToValue = widget.item?.loanToValue;
    _monthlyPayment = widget.item?.monthlyPayment;
    _totalPayable = widget.item?.totalPayable;
    _offerStatus = widget.item?.offerStatus?.toString();
    _offerDate = widget.item?.offerDate;
    _expiryDate = widget.item?.expiryDate;
    _acceptedDate = widget.item?.acceptedDate;
    _solicitorName = widget.item?.solicitorName?.toString();
    _solicitorEmail = widget.item?.solicitorEmail?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_lenderName?.isNotEmpty == true) 'lenderName': _lenderName,
        if (_mortgageType?.isNotEmpty == true) 'mortgageType': _mortgageType,
        if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
        if (_interestRate != null) 'interestRate': _interestRate,
        if (_arrangementFee != null) 'arrangementFee': _arrangementFee,
        if (_valuationFee != null) 'valuationFee': _valuationFee,
        if (_loanAmount != null) 'loanAmount': _loanAmount,
        if (_depositAmount != null) 'depositAmount': _depositAmount,
        if (_loanToValue != null) 'loanToValue': _loanToValue,
        if (_monthlyPayment != null) 'monthlyPayment': _monthlyPayment,
        if (_totalPayable != null) 'totalPayable': _totalPayable,
        if (_offerStatus?.isNotEmpty == true) 'offerStatus': _offerStatus,
        if (_offerDate != null) 'offerDate': _offerDate!.toIso8601String(),
        if (_expiryDate != null) 'expiryDate': _expiryDate!.toIso8601String(),
        if (_acceptedDate != null) 'acceptedDate': _acceptedDate!.toIso8601String(),
        if (_solicitorName?.isNotEmpty == true) 'solicitorName': _solicitorName,
        if (_solicitorEmail?.isNotEmpty == true) 'solicitorEmail': _solicitorEmail,
    };
    final result = widget.item != null
        ? MortgagePreApproval.fromJson({...widget.item!.toJson(), ...data})
        : MortgagePreApproval.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lender Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _lenderName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mortgage Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mortgageType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mortgage Term', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _mortgageTerm = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Interest Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _interestRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Arrangement Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _arrangementFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valuation Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _valuationFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Loan Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _loanAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deposit Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _depositAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Loan To Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _loanToValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Payment', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _monthlyPayment = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Payable', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalPayable = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Offer Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _offerStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _offerDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _offerDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Offer Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_offerDate != null ? _fmt(_offerDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiryDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiryDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expiry Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiryDate != null ? _fmt(_expiryDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _acceptedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _acceptedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Accepted Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_acceptedDate != null ? _fmt(_acceptedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _solicitorName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Solicitor Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                onSaved: (v) => _solicitorEmail = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mortgage Pre Approval'),
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