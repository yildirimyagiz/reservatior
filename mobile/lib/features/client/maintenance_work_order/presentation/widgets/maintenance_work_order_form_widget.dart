import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MaintenanceWorkOrderFormWidget extends ConsumerStatefulWidget {
  final MaintenanceWorkOrder? item;
  final Function(MaintenanceWorkOrder) onSubmit;
  const MaintenanceWorkOrderFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MaintenanceWorkOrderFormWidget> createState() =>
      _MaintenanceWorkOrderFormWidgetState();
}

class _MaintenanceWorkOrderFormWidgetState
    extends ConsumerState<MaintenanceWorkOrderFormWidget> {
  String? _propertyId;
  String? _tenantId;
  String? _reportedBy;
  String? _title;
  String? _description;
  String? _category;
  DateTime? _reportedAt;
  DateTime? _dueDate;
  String? _assignedTo;
  String? _assignedVendor;
  double? _estimatedCost;
  double? _actualCost;
  String? _userId;
  String? _organizationId;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _tenantId = widget.item?.tenantId;
    _reportedBy = widget.item?.reportedBy;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _category = widget.item?.category;
    _reportedAt = widget.item?.reportedAt;
    _dueDate = widget.item?.dueDate;
    _assignedTo = widget.item?.assignedTo;
    _assignedVendor = widget.item?.assignedVendor;
    _estimatedCost = widget.item?.estimatedCost;
    _actualCost = widget.item?.actualCost;
    _userId = widget.item?.userId;
    _organizationId = widget.item?.organizationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.maintenanceworkorder'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.maintenanceworkorder'.tr()}",
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
              initialValue: _reportedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reportedby'.tr()),
              onChanged: (v) => _reportedBy = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_reported_at'.tr()}: ${_reportedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _reportedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _reportedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_due_date'.tr()}: ${_dueDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dueDate = d);
              },
            ),
            TextFormField(
              initialValue: _assignedTo?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assignedto'.tr()),
              onChanged: (v) => _assignedTo = v,
            ),
            TextFormField(
              initialValue: _assignedVendor?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assignedvendor'.tr()),
              onChanged: (v) => _assignedVendor = v,
            ),
            TextFormField(
              initialValue: _estimatedCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.estimatedcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _estimatedCost = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _actualCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualCost = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _organizationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.organizationid'.tr()),
              onChanged: (v) => _organizationId = v,
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
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_reportedBy != null) 'reportedBy': _reportedBy,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_category != null) 'category': _category,
                  if (_reportedAt != null)
                    'reportedAt': _reportedAt!.toIso8601String(),
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_assignedTo != null) 'assignedTo': _assignedTo,
                  if (_assignedVendor != null)
                    'assignedVendor': _assignedVendor,
                  if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
                  if (_actualCost != null) 'actualCost': _actualCost,
                  if (_userId != null) 'userId': _userId,
                  if (_organizationId != null)
                    'organizationId': _organizationId,
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
                  widget.onSubmit(MaintenanceWorkOrder.fromJson(json));
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
