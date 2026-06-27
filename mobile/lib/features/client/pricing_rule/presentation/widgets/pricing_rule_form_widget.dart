import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PricingRuleFormWidget extends ConsumerStatefulWidget {
  final PricingRule? item;
  final Function(PricingRule) onSubmit;
  const PricingRuleFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PricingRuleFormWidget> createState() =>
      _PricingRuleFormWidgetState();
}

class _PricingRuleFormWidgetState extends ConsumerState<PricingRuleFormWidget> {
  String? _listingId;
  String? _name;
  String? _description;
  String? _ruleType;
  int? _priority;
  bool? _isActive;
  double? _basePrice;
  String? _strategy;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _minNights;
  int? _maxNights;
  String? _currencyId;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _ruleType = widget.item?.ruleType;
    _priority = widget.item?.priority;
    _isActive = widget.item?.isActive;
    _basePrice = widget.item?.basePrice;
    _strategy = widget.item?.strategy;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _currencyId = widget.item?.currencyId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.pricingrule'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.pricingrule'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
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
              initialValue: _ruleType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ruletype'.tr()),
              onChanged: (v) => _ruleType = v,
            ),
            TextFormField(
              initialValue: _priority?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.priority'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _priority = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _basePrice?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.baseprice'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _basePrice = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _strategy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.strategy'.tr()),
              onChanged: (v) => _strategy = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _minNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minnights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxNights?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxnights'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxNights = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currencyid'.tr()),
              onChanged: (v) => _currencyId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_ruleType != null) 'ruleType': _ruleType,
                  if (_priority != null) 'priority': _priority,
                  'isActive': _isActive,
                  if (_basePrice != null) 'basePrice': _basePrice,
                  if (_strategy != null) 'strategy': _strategy,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_minNights != null) 'minNights': _minNights,
                  if (_maxNights != null) 'maxNights': _maxNights,
                  if (_currencyId != null) 'currencyId': _currencyId,
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
                  widget.onSubmit(PricingRule.fromJson(json));
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
