import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReferralFormWidget extends ConsumerStatefulWidget {
  final Referral? item;
  final Function(Referral) onSubmit;
  const ReferralFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ReferralFormWidget> createState() => _ReferralFormWidgetState();
}

class _ReferralFormWidgetState extends ConsumerState<ReferralFormWidget> {
  String? _userId;
  String? _code;
  double? _commissionRate;
  int? _bonusPoints;
  DateTime? _expiresAt;
  int? _totalReferrals;
  int? _successfulReferrals;
  double? _totalEarnings;
  String? _organizationId;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _code = widget.item?.code;
    _commissionRate = widget.item?.commissionRate;
    _bonusPoints = widget.item?.bonusPoints;
    _expiresAt = widget.item?.expiresAt;
    _totalReferrals = widget.item?.totalReferrals;
    _successfulReferrals = widget.item?.successfulReferrals;
    _totalEarnings = widget.item?.totalEarnings;
    _organizationId = widget.item?.organizationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.referral'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.referral'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _code?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.code'.tr()),
              onChanged: (v) => _code = v,
            ),
            TextFormField(
              initialValue: _commissionRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.commissionrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _commissionRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bonusPoints?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bonuspoints'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bonusPoints = int.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            TextFormField(
              initialValue: _totalReferrals?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalreferrals'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalReferrals = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _successfulReferrals?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.successfulreferrals'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _successfulReferrals = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalEarnings?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalearnings'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalEarnings = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_code != null) 'code': _code,
                  if (_commissionRate != null)
                    'commissionRate': _commissionRate,
                  if (_bonusPoints != null) 'bonusPoints': _bonusPoints,
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  if (_totalReferrals != null)
                    'totalReferrals': _totalReferrals,
                  if (_successfulReferrals != null)
                    'successfulReferrals': _successfulReferrals,
                  if (_totalEarnings != null) 'totalEarnings': _totalEarnings,
                  if (_organizationId != null)
                    'organizationId': _organizationId,
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
                  widget.onSubmit(Referral.fromJson(json));
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
