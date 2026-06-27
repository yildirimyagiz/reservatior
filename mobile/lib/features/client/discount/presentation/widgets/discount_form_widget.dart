import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class DiscountFormWidget extends ConsumerStatefulWidget {
  final Discount? item;
  final Function(Discount) onSubmit;
  const DiscountFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<DiscountFormWidget> createState() => _DiscountFormWidgetState();
}

class _DiscountFormWidgetState extends ConsumerState<DiscountFormWidget> {
  String? _name;
  String? _description;
  String? _code;
  double? _value;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _maxUsage;
  int? _currentUsage;
  bool? _isActive;
  String? _propertyId;
  String? _pricingRuleId;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _description = widget.item?.description;
    _code = widget.item?.code;
    _value = widget.item?.value;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _maxUsage = widget.item?.maxUsage;
    _currentUsage = widget.item?.currentUsage;
    _isActive = widget.item?.isActive;
    _propertyId = widget.item?.propertyId;
    _pricingRuleId = widget.item?.pricingRuleId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.discount'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.discount'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
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
              initialValue: _code?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.code'.tr()),
              onChanged: (v) => _code = v,
            ),
            TextFormField(
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _value = double.tryParse(v ?? ""),
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
              initialValue: _maxUsage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxusage'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxUsage = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currentUsage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currentusage'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _currentUsage = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _pricingRuleId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricingruleid'.tr()),
              onChanged: (v) => _pricingRuleId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_code != null) 'code': _code,
                  if (_value != null) 'value': _value,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_maxUsage != null) 'maxUsage': _maxUsage,
                  if (_currentUsage != null) 'currentUsage': _currentUsage,
                  'isActive': _isActive,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_pricingRuleId != null) 'pricingRuleId': _pricingRuleId,
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
                  widget.onSubmit(Discount.fromJson(json));
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
