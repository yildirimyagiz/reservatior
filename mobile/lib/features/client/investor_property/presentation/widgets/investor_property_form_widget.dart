import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class InvestorPropertyFormWidget extends ConsumerStatefulWidget {
  final InvestorProperty? item;
  final Function(InvestorProperty) onSubmit;
  const InvestorPropertyFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<InvestorPropertyFormWidget> createState() =>
      _InvestorPropertyFormWidgetState();
}

class _InvestorPropertyFormWidgetState
    extends ConsumerState<InvestorPropertyFormWidget> {
  String? _portfolioId;
  String? _propertyId;
  DateTime? _acquiredAt;
  double? _acquiredCost;
  double? _mortgageBalance;
  double? _mortgageRate;
  int? _mortgageTerm;
  String? _insuranceProvider;
  double? _insuranceAmount;
  @override
  void initState() {
    super.initState();
    _portfolioId = widget.item?.portfolioId;
    _propertyId = widget.item?.propertyId;
    _acquiredAt = widget.item?.acquiredAt;
    _acquiredCost = widget.item?.acquiredCost;
    _mortgageBalance = widget.item?.mortgageBalance;
    _mortgageRate = widget.item?.mortgageRate;
    _mortgageTerm = widget.item?.mortgageTerm;
    _insuranceProvider = widget.item?.insuranceProvider;
    _insuranceAmount = widget.item?.insuranceAmount;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.investorproperty'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.investorproperty'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _portfolioId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.portfolioid'.tr()),
              onChanged: (v) => _portfolioId = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_acquired_at'.tr()}: ${_acquiredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _acquiredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _acquiredAt = d);
              },
            ),
            TextFormField(
              initialValue: _acquiredCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.acquiredcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _acquiredCost = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mortgageBalance?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgagebalance'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _mortgageBalance = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mortgageRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgagerate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _mortgageRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _mortgageTerm?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.mortgageterm'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _mortgageTerm = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _insuranceProvider?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.insuranceprovider'.tr()),
              onChanged: (v) => _insuranceProvider = v,
            ),
            TextFormField(
              initialValue: _insuranceAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.insuranceamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _insuranceAmount = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_portfolioId != null) 'portfolioId': _portfolioId,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_acquiredAt != null)
                    'acquiredAt': _acquiredAt!.toIso8601String(),
                  if (_acquiredCost != null) 'acquiredCost': _acquiredCost,
                  if (_mortgageBalance != null)
                    'mortgageBalance': _mortgageBalance,
                  if (_mortgageRate != null) 'mortgageRate': _mortgageRate,
                  if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
                  if (_insuranceProvider != null)
                    'insuranceProvider': _insuranceProvider,
                  if (_insuranceAmount != null)
                    'insuranceAmount': _insuranceAmount,
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
                  widget.onSubmit(InvestorProperty.fromJson(json));
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
