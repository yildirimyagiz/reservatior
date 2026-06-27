import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LoyaltyAccountFormWidget extends ConsumerStatefulWidget {
  final LoyaltyAccount? item;
  final Function(LoyaltyAccount) onSubmit;
  const LoyaltyAccountFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<LoyaltyAccountFormWidget> createState() =>
      _LoyaltyAccountFormWidgetState();
}

class _LoyaltyAccountFormWidgetState
    extends ConsumerState<LoyaltyAccountFormWidget> {
  String? _userId;
  String? _name;
  String? _description;
  double? _pointsPerDollar;
  int? _pointsExpiryDays;
  bool? _tiersEnabled;
  int? _bronzeThreshold;
  int? _silverThreshold;
  int? _goldThreshold;
  int? _platinumThreshold;
  int? _diamondThreshold;
  int? _currentPoints;
  int? _totalEarned;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _pointsPerDollar = widget.item?.pointsPerDollar;
    _pointsExpiryDays = widget.item?.pointsExpiryDays;
    _tiersEnabled = widget.item?.tiersEnabled;
    _bronzeThreshold = widget.item?.bronzeThreshold;
    _silverThreshold = widget.item?.silverThreshold;
    _goldThreshold = widget.item?.goldThreshold;
    _platinumThreshold = widget.item?.platinumThreshold;
    _diamondThreshold = widget.item?.diamondThreshold;
    _currentPoints = widget.item?.currentPoints;
    _totalEarned = widget.item?.totalEarned;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.loyaltyaccount'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.loyaltyaccount'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _pointsPerDollar?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pointsperdollar'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _pointsPerDollar = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _pointsExpiryDays?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pointsexpirydays'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _pointsExpiryDays = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.tiersenabled'.tr()),
              value: _tiersEnabled ?? false,
              onChanged: (v) => setState(() => _tiersEnabled = v),
            ),
            TextFormField(
              initialValue: _bronzeThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bronzethreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bronzeThreshold = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _silverThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.silverthreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _silverThreshold = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _goldThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.goldthreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _goldThreshold = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _platinumThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.platinumthreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _platinumThreshold = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _diamondThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.diamondthreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _diamondThreshold = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currentPoints?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentpoints'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentPoints = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalEarned?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalearned'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalEarned = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_pointsPerDollar != null)
                    'pointsPerDollar': _pointsPerDollar,
                  if (_pointsExpiryDays != null)
                    'pointsExpiryDays': _pointsExpiryDays,
                  'tiersEnabled': _tiersEnabled,
                  if (_bronzeThreshold != null)
                    'bronzeThreshold': _bronzeThreshold,
                  if (_silverThreshold != null)
                    'silverThreshold': _silverThreshold,
                  if (_goldThreshold != null) 'goldThreshold': _goldThreshold,
                  if (_platinumThreshold != null)
                    'platinumThreshold': _platinumThreshold,
                  if (_diamondThreshold != null)
                    'diamondThreshold': _diamondThreshold,
                  if (_currentPoints != null) 'currentPoints': _currentPoints,
                  if (_totalEarned != null) 'totalEarned': _totalEarned,
                  'isActive': _isActive,
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
                  widget.onSubmit(LoyaltyAccount.fromJson(json));
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
