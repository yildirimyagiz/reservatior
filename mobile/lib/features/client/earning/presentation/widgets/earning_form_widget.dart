import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EarningFormWidget extends ConsumerStatefulWidget {
  final Earning? item;
  final Function(Earning) onSubmit;
  const EarningFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EarningFormWidget> createState() => _EarningFormWidgetState();
}

class _EarningFormWidgetState extends ConsumerState<EarningFormWidget> {
  String? _userId;
  String? _name;
  double? _percentage;
  double? _fixedAmount;
  bool? _appliesToUsers;
  bool? _appliesToAgents;
  bool? _appliesToVendors;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _name = widget.item?.name;
    _percentage = widget.item?.percentage;
    _fixedAmount = widget.item?.fixedAmount;
    _appliesToUsers = widget.item?.appliesToUsers;
    _appliesToAgents = widget.item?.appliesToAgents;
    _appliesToVendors = widget.item?.appliesToVendors;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.earning'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.earning'.tr()}",
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
              initialValue: _percentage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.percentage'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _percentage = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _fixedAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fixedamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fixedAmount = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.appliestousers'.tr()),
              value: _appliesToUsers ?? false,
              onChanged: (v) => setState(() => _appliesToUsers = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.appliestoagents'.tr()),
              value: _appliesToAgents ?? false,
              onChanged: (v) => setState(() => _appliesToAgents = v),
            ),
            SwitchListTile(
              title: Text('mobile.auto.appliestovendors'.tr()),
              value: _appliesToVendors ?? false,
              onChanged: (v) => setState(() => _appliesToVendors = v),
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
                  if (_percentage != null) 'percentage': _percentage,
                  if (_fixedAmount != null) 'fixedAmount': _fixedAmount,
                  'appliesToUsers': _appliesToUsers,
                  'appliesToAgents': _appliesToAgents,
                  'appliesToVendors': _appliesToVendors,
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
                  widget.onSubmit(Earning.fromJson(json));
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
