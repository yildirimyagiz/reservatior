import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PlanFormWidget extends ConsumerStatefulWidget {
  final Plan? item;
  final Function(Plan) onSubmit;
  const PlanFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<PlanFormWidget> createState() => _PlanFormWidgetState();
}

class _PlanFormWidgetState extends ConsumerState<PlanFormWidget> {
  String? _key;
  String? _name;
  int? _priceMonthlyCents;
  @override
  void initState() {
    super.initState();
    _key = widget.item?.key;
    _name = widget.item?.name;
    _priceMonthlyCents = widget.item?.priceMonthlyCents;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.plan'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.plan'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _key?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.key'.tr()),
              onChanged: (v) => _key = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _priceMonthlyCents?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricemonthlycents'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _priceMonthlyCents = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_key != null) 'key': _key,
                  if (_name != null) 'name': _name,
                  if (_priceMonthlyCents != null)
                    'priceMonthlyCents': _priceMonthlyCents,
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
                  widget.onSubmit(Plan.fromJson(json));
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
