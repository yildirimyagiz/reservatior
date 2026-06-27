import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class IncreaseFormWidget extends ConsumerStatefulWidget {
  final Increase? item;
  final Function(Increase) onSubmit;
  const IncreaseFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<IncreaseFormWidget> createState() => _IncreaseFormWidgetState();
}

class _IncreaseFormWidgetState extends ConsumerState<IncreaseFormWidget> {
  String? _propertyId;
  String? _tenantId;
  String? _proposedBy;
  double? _oldRent;
  double? _newRent;
  DateTime? _effectiveDate;
  String? _contractId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _tenantId = widget.item?.tenantId;
    _proposedBy = widget.item?.proposedBy;
    _oldRent = widget.item?.oldRent;
    _newRent = widget.item?.newRent;
    _effectiveDate = widget.item?.effectiveDate;
    _contractId = widget.item?.contractId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.increase'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.increase'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            TextFormField(
              initialValue: _proposedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.proposedby'.tr()),
              onChanged: (v) => _proposedBy = v,
            ),
            TextFormField(
              initialValue: _oldRent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.oldrent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _oldRent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _newRent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.newrent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _newRent = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_effective_date'.tr()}: ${_effectiveDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _effectiveDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _effectiveDate = d);
              },
            ),
            TextFormField(
              initialValue: _contractId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractid'.tr()),
              onChanged: (v) => _contractId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_proposedBy != null) 'proposedBy': _proposedBy,
                  if (_oldRent != null) 'oldRent': _oldRent,
                  if (_newRent != null) 'newRent': _newRent,
                  if (_effectiveDate != null)
                    'effectiveDate': _effectiveDate!.toIso8601String(),
                  if (_contractId != null) 'contractId': _contractId,
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
                  widget.onSubmit(Increase.fromJson(json));
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
