import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyInventoryFormWidget extends ConsumerStatefulWidget {
  final PropertyInventory? item;
  final Function(PropertyInventory) onSubmit;
  const PropertyInventoryFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyInventoryFormWidget> createState() =>
      _PropertyInventoryFormWidgetState();
}

class _PropertyInventoryFormWidgetState
    extends ConsumerState<PropertyInventoryFormWidget> {
  String? _propertyId;
  String? _leaseId;
  String? _inventoryType;
  DateTime? _inventoryDate;
  String? _conductedBy;
  String? _overallCondition;
  bool? _cleaningRequired;
  String? _tenantSignature;
  String? _landlordSignature;
  String? _agentSignature;
  String? _reportUrl;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _leaseId = widget.item?.leaseId;
    _inventoryType = widget.item?.inventoryType;
    _inventoryDate = widget.item?.inventoryDate;
    _conductedBy = widget.item?.conductedBy;
    _overallCondition = widget.item?.overallCondition;
    _cleaningRequired = widget.item?.cleaningRequired;
    _tenantSignature = widget.item?.tenantSignature;
    _landlordSignature = widget.item?.landlordSignature;
    _agentSignature = widget.item?.agentSignature;
    _reportUrl = widget.item?.reportUrl;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyinventory'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyinventory'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _inventoryType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.inventorytype'.tr()),
              onChanged: (v) => _inventoryType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_inventory_date'.tr()}: ${_inventoryDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _inventoryDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _inventoryDate = d);
              },
            ),
            TextFormField(
              initialValue: _conductedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.conductedby'.tr()),
              onChanged: (v) => _conductedBy = v,
            ),
            TextFormField(
              initialValue: _overallCondition?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.overallcondition'.tr()),
              onChanged: (v) => _overallCondition = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.cleaningrequired'.tr()),
              value: _cleaningRequired ?? false,
              onChanged: (v) => setState(() => _cleaningRequired = v),
            ),
            TextFormField(
              initialValue: _tenantSignature?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantsignature'.tr()),
              onChanged: (v) => _tenantSignature = v,
            ),
            TextFormField(
              initialValue: _landlordSignature?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.landlordsignature'.tr()),
              onChanged: (v) => _landlordSignature = v,
            ),
            TextFormField(
              initialValue: _agentSignature?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentsignature'.tr()),
              onChanged: (v) => _agentSignature = v,
            ),
            TextFormField(
              initialValue: _reportUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reporturl'.tr()),
              onChanged: (v) => _reportUrl = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_inventoryType != null) 'inventoryType': _inventoryType,
                  if (_inventoryDate != null)
                    'inventoryDate': _inventoryDate!.toIso8601String(),
                  if (_conductedBy != null) 'conductedBy': _conductedBy,
                  if (_overallCondition != null)
                    'overallCondition': _overallCondition,
                  'cleaningRequired': _cleaningRequired,
                  if (_tenantSignature != null)
                    'tenantSignature': _tenantSignature,
                  if (_landlordSignature != null)
                    'landlordSignature': _landlordSignature,
                  if (_agentSignature != null)
                    'agentSignature': _agentSignature,
                  if (_reportUrl != null) 'reportUrl': _reportUrl,
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
                  widget.onSubmit(PropertyInventory.fromJson(json));
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
