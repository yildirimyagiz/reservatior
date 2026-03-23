import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Referral Form Widget  |  Fields: userId, code, commissionRate, bonusPoints, expiresAt, totalReferrals, successfulReferrals, totalEarnings, trackingHistory, organizationId

class ReferralFormWidget extends StatefulWidget {
  final Referral? item;
  final void Function(Referral)? onSubmit;
  const ReferralFormWidget({super.key, this.item, this.onSubmit});
  @override State<ReferralFormWidget> createState() => _ReferralFormWidgetState();
}

class _ReferralFormWidgetState extends State<ReferralFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _code;
  double? _commissionRate;
  int? _bonusPoints;
  DateTime? _expiresAt;
  int? _totalReferrals;
  int? _successfulReferrals;
  double? _totalEarnings;
  String? _trackingHistory;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _code = widget.item?.code?.toString();
    _commissionRate = widget.item?.commissionRate;
    _bonusPoints = widget.item?.bonusPoints;
    _expiresAt = widget.item?.expiresAt;
    _totalReferrals = widget.item?.totalReferrals;
    _successfulReferrals = widget.item?.successfulReferrals;
    _totalEarnings = widget.item?.totalEarnings;
    _trackingHistory = widget.item?.trackingHistory?.toString();
    _organizationId = widget.item?.organizationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_code?.isNotEmpty == true) 'code': _code,
        if (_commissionRate != null) 'commissionRate': _commissionRate,
        if (_bonusPoints != null) 'bonusPoints': _bonusPoints,
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_totalReferrals != null) 'totalReferrals': _totalReferrals,
        if (_successfulReferrals != null) 'successfulReferrals': _successfulReferrals,
        if (_totalEarnings != null) 'totalEarnings': _totalEarnings,
        if (_trackingHistory?.isNotEmpty == true) 'trackingHistory': _trackingHistory,
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    final result = widget.item != null
        ? Referral.fromJson({...widget.item!.toJson(), ...data})
        : Referral.fromJson(data);
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
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _code = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _commissionRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bonus Points', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _bonusPoints = int.tryParse(v ?? ''),
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Referrals', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalReferrals = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Successful Referrals', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _successfulReferrals = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Earnings', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalEarnings = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tracking History', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _trackingHistory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Referral'),
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