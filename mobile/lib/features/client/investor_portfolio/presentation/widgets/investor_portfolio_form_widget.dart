import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class InvestorPortfolioFormWidget extends ConsumerStatefulWidget {
  final InvestorPortfolio? item;
  final Function(InvestorPortfolio) onSubmit;
  const InvestorPortfolioFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<InvestorPortfolioFormWidget> createState() =>
      _InvestorPortfolioFormWidgetState();
}

class _InvestorPortfolioFormWidgetState
    extends ConsumerState<InvestorPortfolioFormWidget> {
  String? _userId;
  String? _name;
  double? _targetIrr;
  String? _investmentHorizon;
  double? _totalInvested;
  double? _currentValue;
  double? _totalReturns;
  String? _organizationId;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _targetIrr = widget.item?.targetIrr;
    _investmentHorizon = widget.item?.investmentHorizon;
    _totalInvested = widget.item?.totalInvested;
    _currentValue = widget.item?.currentValue;
    _totalReturns = widget.item?.totalReturns;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.investorportfolio'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.investorportfolio'.tr()}",
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
              initialValue: _targetIrr?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targetirr'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _targetIrr = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _investmentHorizon?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.investmenthorizon'.tr()),
              onChanged: (v) => _investmentHorizon = v,
            ),
            TextFormField(
              initialValue: _totalInvested?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalinvested'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalInvested = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currentValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalReturns?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalreturns'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalReturns = double.tryParse(v ?? ""),
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
                  if (_name != null) 'name': _name,
                  if (_targetIrr != null) 'targetIrr': _targetIrr,
                  if (_investmentHorizon != null)
                    'investmentHorizon': _investmentHorizon,
                  if (_totalInvested != null) 'totalInvested': _totalInvested,
                  if (_currentValue != null) 'currentValue': _currentValue,
                  if (_totalReturns != null) 'totalReturns': _totalReturns,
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
                  widget.onSubmit(InvestorPortfolio.fromJson(json));
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
