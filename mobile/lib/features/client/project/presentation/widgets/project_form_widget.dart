import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ProjectFormWidget extends ConsumerStatefulWidget {
  final Project? item;
  final Function(Project) onSubmit;
  const ProjectFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ProjectFormWidget> createState() => _ProjectFormWidgetState();
}

class _ProjectFormWidgetState extends ConsumerState<ProjectFormWidget> {
  String? _name;
  String? _description;
  String? _projectType;
  String? _propertyId;
  String? _addres;
  String? _status;
  DateTime? _startDate;
  DateTime? _estimatedEndDate;
  DateTime? _actualEndDate;
  double? _budget;
  String? _currency;
  double? _actualCost;
  String? _managerId;
  String? _contractorId;
  @override
  void initState() {
    super.initState();
    _name = widget.item?.name;
    _description = widget.item?.description;
    _projectType = widget.item?.projectType;
    _propertyId = widget.item?.propertyId;
    _addres = widget.item?.addres;
    _status = widget.item?.status;
    _startDate = widget.item?.startDate;
    _estimatedEndDate = widget.item?.estimatedEndDate;
    _actualEndDate = widget.item?.actualEndDate;
    _budget = widget.item?.budget;
    _currency = widget.item?.currency;
    _actualCost = widget.item?.actualCost;
    _managerId = widget.item?.managerId;
    _contractorId = widget.item?.contractorId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.project'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.project'.tr()}",
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
              initialValue: _projectType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projecttype'.tr()),
              onChanged: (v) => _projectType = v,
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _addres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addres'.tr()),
              onChanged: (v) => _addres = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
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
              title: Text("${'mobile.admin.field_estimated_end_date'.tr()}: ${_estimatedEndDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _estimatedEndDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _estimatedEndDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_actual_end_date'.tr()}: ${_actualEndDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _actualEndDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _actualEndDate = d);
              },
            ),
            TextFormField(
              initialValue: _budget?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.budget'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _budget = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _actualCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualCost = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _managerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.managerid'.tr()),
              onChanged: (v) => _managerId = v,
            ),
            TextFormField(
              initialValue: _contractorId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractorid'.tr()),
              onChanged: (v) => _contractorId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_projectType != null) 'projectType': _projectType,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_addres != null) 'addres': _addres,
                  if (_status != null) 'status': _status,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_estimatedEndDate != null)
                    'estimatedEndDate': _estimatedEndDate!.toIso8601String(),
                  if (_actualEndDate != null)
                    'actualEndDate': _actualEndDate!.toIso8601String(),
                  if (_budget != null) 'budget': _budget,
                  if (_currency != null) 'currency': _currency,
                  if (_actualCost != null) 'actualCost': _actualCost,
                  if (_managerId != null) 'managerId': _managerId,
                  if (_contractorId != null) 'contractorId': _contractorId,
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
                  widget.onSubmit(Project.fromJson(json));
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
