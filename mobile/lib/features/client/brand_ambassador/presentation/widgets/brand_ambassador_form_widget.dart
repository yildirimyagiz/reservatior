import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class BrandAmbassadorFormWidget extends ConsumerStatefulWidget {
  final BrandAmbassador? item;
  final Function(BrandAmbassador) onSubmit;
  const BrandAmbassadorFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<BrandAmbassadorFormWidget> createState() =>
      _BrandAmbassadorFormWidgetState();
}

class _BrandAmbassadorFormWidgetState
    extends ConsumerState<BrandAmbassadorFormWidget> {
  String? _fullName;
  String? _emailCiphertext;
  String? _phoneCiphertext;
  int? _followerCount;
  double? _engagementRate;
  DateTime? _contractStart;
  DateTime? _contractEnd;
  double? _equityPercent;
  double? _upfrontFee;
  String? _currency;
  String? _tier;
  String? _agencyName;
  String? _agencyContact;
  bool? _ndaSigned;
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
    _fullName = widget.item?.fullName;
    _emailCiphertext = widget.item?.emailCiphertext;
    _phoneCiphertext = widget.item?.phoneCiphertext;
    _followerCount = widget.item?.followerCount;
    _engagementRate = widget.item?.engagementRate;
    _contractStart = widget.item?.contractStart;
    _contractEnd = widget.item?.contractEnd;
    _equityPercent = widget.item?.equityPercent;
    _upfrontFee = widget.item?.upfrontFee;
    _currency = widget.item?.currency;
    _tier = widget.item?.tier;
    _agencyName = widget.item?.agencyName;
    _agencyContact = widget.item?.agencyContact;
    _ndaSigned = widget.item?.ndaSigned;
    _ndaSignedAt = widget.item?.ndaSignedAt;
    _notes = widget.item?.notes;
    _pitchSentAt = widget.item?.pitchSentAt;
    _respondedAt = widget.item?.respondedAt;
    _signedAt = widget.item?.signedAt;
    _actualReach = widget.item?.actualReach;
    _totalRoi = widget.item?.totalRoi;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.brandambassador'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.brandambassador'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _fullName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fullname'.tr()),
              onChanged: (v) => _fullName = v,
            ),
            TextFormField(
              initialValue: _emailCiphertext?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.emailciphertext'.tr()),
              onChanged: (v) => _emailCiphertext = v,
            ),
            TextFormField(
              initialValue: _phoneCiphertext?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phoneciphertext'.tr()),
              onChanged: (v) => _phoneCiphertext = v,
            ),
            TextFormField(
              initialValue: _followerCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.followercount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _followerCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _engagementRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.engagementrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _engagementRate = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_contract_start'.tr()}: ${_contractStart ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _contractStart ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _contractStart = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_contract_end'.tr()}: ${_contractEnd ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _contractEnd ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _contractEnd = d);
              },
            ),
            TextFormField(
              initialValue: _equityPercent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.equitypercent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _equityPercent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _upfrontFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.upfrontfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _upfrontFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _tier?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tier'.tr()),
              onChanged: (v) => _tier = v,
            ),
            TextFormField(
              initialValue: _agencyName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyname'.tr()),
              onChanged: (v) => _agencyName = v,
            ),
            TextFormField(
              initialValue: _agencyContact?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencycontact'.tr()),
              onChanged: (v) => _agencyContact = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.ndasigned'.tr()),
              value: _ndaSigned ?? false,
              onChanged: (v) => setState(() => _ndaSigned = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_nda_signed_at'.tr()}: ${_ndaSignedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _ndaSignedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _ndaSignedAt = d);
              },
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_pitch_sent_at'.tr()}: ${_pitchSentAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _pitchSentAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _pitchSentAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_responded_at'.tr()}: ${_respondedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _respondedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _respondedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_signed_at'.tr()}: ${_signedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _signedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _signedAt = d);
              },
            ),
            TextFormField(
              initialValue: _actualReach?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualreach'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualReach = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalRoi?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalroi'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalRoi = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_fullName != null) 'fullName': _fullName,
                  if (_emailCiphertext != null)
                    'emailCiphertext': _emailCiphertext,
                  if (_phoneCiphertext != null)
                    'phoneCiphertext': _phoneCiphertext,
                  if (_followerCount != null) 'followerCount': _followerCount,
                  if (_engagementRate != null)
                    'engagementRate': _engagementRate,
                  if (_contractStart != null)
                    'contractStart': _contractStart!.toIso8601String(),
                  if (_contractEnd != null)
                    'contractEnd': _contractEnd!.toIso8601String(),
                  if (_equityPercent != null) 'equityPercent': _equityPercent,
                  if (_upfrontFee != null) 'upfrontFee': _upfrontFee,
                  if (_currency != null) 'currency': _currency,
                  if (_tier != null) 'tier': _tier,
                  if (_agencyName != null) 'agencyName': _agencyName,
                  if (_agencyContact != null) 'agencyContact': _agencyContact,
                  'ndaSigned': _ndaSigned,
                  if (_ndaSignedAt != null)
                    'ndaSignedAt': _ndaSignedAt!.toIso8601String(),
                  if (_notes != null) 'notes': _notes,
                  if (_pitchSentAt != null)
                    'pitchSentAt': _pitchSentAt!.toIso8601String(),
                  if (_respondedAt != null)
                    'respondedAt': _respondedAt!.toIso8601String(),
                  if (_signedAt != null)
                    'signedAt': _signedAt!.toIso8601String(),
                  if (_actualReach != null) 'actualReach': _actualReach,
                  if (_totalRoi != null) 'totalRoi': _totalRoi,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(BrandAmbassador.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
