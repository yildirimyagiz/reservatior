import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── BrandAmbassador Form Widget  |  Fields: fullName, emailCiphertext, phoneCiphertext, category, followerCount, engagementRate, contractStart, contractEnd, equityPercent, upfrontFee, currency, tier, status, agencyName, agencyContact, ndaSigned, ndaSignedAt, notes, pitchSentAt, respondedAt, signedAt, actualReach, totalRoi

class BrandAmbassadorFormWidget extends StatefulWidget {
  final BrandAmbassador? item;
  final void Function(BrandAmbassador)? onSubmit;
  const BrandAmbassadorFormWidget({super.key, this.item, this.onSubmit});
  @override State<BrandAmbassadorFormWidget> createState() => _BrandAmbassadorFormWidgetState();
}

class _BrandAmbassadorFormWidgetState extends State<BrandAmbassadorFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _fullName;
  String? _emailCiphertext;
  String? _phoneCiphertext;
  String? _category;
  int? _followerCount;
  double? _engagementRate;
  DateTime? _contractStart;
  DateTime? _contractEnd;
  double? _equityPercent;
  double? _upfrontFee;
  String? _currency;
  String? _tier;
  String? _status;
  String? _agencyName;
  String? _agencyContact;
  bool _ndaSigned = false;
  DateTime? _ndaSignedAt;
  String? _notes;
  DateTime? _pitchSentAt;
  DateTime? _respondedAt;
  DateTime? _signedAt;
  int? _actualReach;
  double? _totalRoi;

  @override
  void initState() {
    super.initState();
    _fullName = widget.item?.fullName?.toString();
    _emailCiphertext = widget.item?.emailCiphertext?.toString();
    _phoneCiphertext = widget.item?.phoneCiphertext?.toString();
    _category = widget.item?.category?.toString();
    _followerCount = widget.item?.followerCount;
    _engagementRate = widget.item?.engagementRate;
    _contractStart = widget.item?.contractStart;
    _contractEnd = widget.item?.contractEnd;
    _equityPercent = widget.item?.equityPercent;
    _upfrontFee = widget.item?.upfrontFee;
    _currency = widget.item?.currency?.toString();
    _tier = widget.item?.tier?.toString();
    _status = widget.item?.status?.toString();
    _agencyName = widget.item?.agencyName?.toString();
    _agencyContact = widget.item?.agencyContact?.toString();
    _ndaSigned = widget.item?.ndaSigned ?? false;
    _ndaSignedAt = widget.item?.ndaSignedAt;
    _notes = widget.item?.notes?.toString();
    _pitchSentAt = widget.item?.pitchSentAt;
    _respondedAt = widget.item?.respondedAt;
    _signedAt = widget.item?.signedAt;
    _actualReach = widget.item?.actualReach;
    _totalRoi = widget.item?.totalRoi;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_fullName?.isNotEmpty == true) 'fullName': _fullName,
        if (_emailCiphertext?.isNotEmpty == true) 'emailCiphertext': _emailCiphertext,
        if (_phoneCiphertext?.isNotEmpty == true) 'phoneCiphertext': _phoneCiphertext,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_followerCount != null) 'followerCount': _followerCount,
        if (_engagementRate != null) 'engagementRate': _engagementRate,
        if (_contractStart != null) 'contractStart': _contractStart!.toIso8601String(),
        if (_contractEnd != null) 'contractEnd': _contractEnd!.toIso8601String(),
        if (_equityPercent != null) 'equityPercent': _equityPercent,
        if (_upfrontFee != null) 'upfrontFee': _upfrontFee,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_tier?.isNotEmpty == true) 'tier': _tier,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_agencyName?.isNotEmpty == true) 'agencyName': _agencyName,
        if (_agencyContact?.isNotEmpty == true) 'agencyContact': _agencyContact,
        'ndaSigned': _ndaSigned,
        if (_ndaSignedAt != null) 'ndaSignedAt': _ndaSignedAt!.toIso8601String(),
        if (_notes?.isNotEmpty == true) 'notes': _notes,
        if (_pitchSentAt != null) 'pitchSentAt': _pitchSentAt!.toIso8601String(),
        if (_respondedAt != null) 'respondedAt': _respondedAt!.toIso8601String(),
        if (_signedAt != null) 'signedAt': _signedAt!.toIso8601String(),
        if (_actualReach != null) 'actualReach': _actualReach,
        if (_totalRoi != null) 'totalRoi': _totalRoi,
    };
    final result = widget.item != null
        ? BrandAmbassador.fromJson({...widget.item!.toJson(), ...data})
        : BrandAmbassador.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Full Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _fullName?.toString() ?? '',
                onSaved: (v) => _fullName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email Ciphertext', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder()),
                initialValue: _emailCiphertext?.toString() ?? '',
                onSaved: (v) => _emailCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Ciphertext', prefixIcon: const Icon(Icons.phone), border: const OutlineInputBorder()),
                initialValue: _phoneCiphertext?.toString() ?? '',
                onSaved: (v) => _phoneCiphertext = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _category?.toString() ?? '',
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Follower Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _followerCount?.toString() ?? '',
                onSaved: (v) => _followerCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Engagement Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _engagementRate?.toString() ?? '',
                onSaved: (v) => _engagementRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _contractStart ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _contractStart = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Contract Start',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_contractStart != null ? _fmt(_contractStart) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _contractEnd ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _contractEnd = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Contract End',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_contractEnd != null ? _fmt(_contractEnd) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Equity Percent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _equityPercent?.toString() ?? '',
                onSaved: (v) => _equityPercent = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Upfront Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _upfrontFee?.toString() ?? '',
                onSaved: (v) => _upfrontFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _currency?.toString() ?? '',
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tier', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _tier?.toString() ?? '',
                onSaved: (v) => _tier = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _agencyName?.toString() ?? '',
                onSaved: (v) => _agencyName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agency Contact', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _agencyContact?.toString() ?? '',
                onSaved: (v) => _agencyContact = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Nda Signed'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _ndaSigned,
                  onChanged: (v) { ss(() {}); setState(() => _ndaSigned = v); },
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _ndaSignedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _ndaSignedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Nda Signed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_ndaSignedAt != null ? _fmt(_ndaSignedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _notes?.toString() ?? '',
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _pitchSentAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _pitchSentAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Pitch Sent At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_pitchSentAt != null ? _fmt(_pitchSentAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _respondedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _respondedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Responded At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_respondedAt != null ? _fmt(_respondedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _signedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _signedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Signed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_signedAt != null ? _fmt(_signedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _actualReach?.toString() ?? '',
                onSaved: (v) => _actualReach = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Roi', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _totalRoi?.toString() ?? '',
                onSaved: (v) => _totalRoi = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Brand Ambassador'),
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