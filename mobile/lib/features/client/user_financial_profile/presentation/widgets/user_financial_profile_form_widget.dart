import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class UserFinancialProfileFormWidget extends ConsumerStatefulWidget {
  final UserFinancialProfile? item;
  final Function(UserFinancialProfile) onSubmit;
  const UserFinancialProfileFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<UserFinancialProfileFormWidget> createState() =>
      _UserFinancialProfileFormWidgetState();
}

class _UserFinancialProfileFormWidgetState
    extends ConsumerState<UserFinancialProfileFormWidget> {
  String? _userId;
  String? _currency;
  double? _monthlyIncome;
  double? _monthlyObligations;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _currency = widget.item?.currency;
    _monthlyIncome = widget.item?.monthlyIncome;
    _monthlyObligations = widget.item?.monthlyObligations;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.userfinancialprofile'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.userfinancialprofile'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _monthlyIncome?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.monthlyincome'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _monthlyIncome = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _monthlyObligations?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.monthlyobligations'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _monthlyObligations = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_currency != null) 'currency': _currency,
                  if (_monthlyIncome != null) 'monthlyIncome': _monthlyIncome,
                  if (_monthlyObligations != null)
                    'monthlyObligations': _monthlyObligations,
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
                  widget.onSubmit(UserFinancialProfile.fromJson(json));
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
