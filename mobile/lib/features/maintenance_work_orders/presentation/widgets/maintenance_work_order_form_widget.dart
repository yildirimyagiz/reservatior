import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MaintenanceWorkOrder Form Widget ──
// Fields: propertyId, tenantId, reportedBy, title, description, priority, category, status, reportedAt, dueDate, assignedTo, assignedVendor, estimatedCost, actualCost, userId, organizationId, isActive

class MaintenanceWorkOrderFormWidget extends StatefulWidget {
  final MaintenanceWorkOrder? item;
  final void Function(MaintenanceWorkOrder)? onSubmit;
  const MaintenanceWorkOrderFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<MaintenanceWorkOrderFormWidget> createState() => _MaintenanceWorkOrderFormWidgetState();
}

class _MaintenanceWorkOrderFormWidgetState extends State<MaintenanceWorkOrderFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _tenantId;
  String? _reportedBy;
  String? _title;
  String? _description;
  String? _priority;
  String? _category;
  String? _status;
  DateTime? _reportedAt;
  DateTime? _dueDate;
  String? _assignedTo;
  String? _assignedVendor;
  double? _estimatedCost;
  double? _actualCost;
  String? _userId;
  String? _organizationId;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _tenantId = widget.item?.tenantId?.toString();
    _reportedBy = widget.item?.reportedBy?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _priority = widget.item?.priority?.toString();
    _category = widget.item?.category?.toString();
    _status = widget.item?.status?.toString();
    _reportedAt = widget.item?.reportedAt;
    _dueDate = widget.item?.dueDate;
    _assignedTo = widget.item?.assignedTo?.toString();
    _assignedVendor = widget.item?.assignedVendor?.toString();
    _estimatedCost = widget.item?.estimatedCost;
    _actualCost = widget.item?.actualCost;
    _userId = widget.item?.userId?.toString();
    _organizationId = widget.item?.organizationId?.toString();
    _isActive = widget.item?.isActive ?? false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId != null) 'propertyId': _propertyId,
        if (_tenantId != null) 'tenantId': _tenantId,
        if (_reportedBy != null) 'reportedBy': _reportedBy,
        if (_title != null) 'title': _title,
        if (_description != null) 'description': _description,
        if (_priority != null) 'priority': _priority,
        if (_category != null) 'category': _category,
        if (_status != null) 'status': _status,
        if (_reportedAt != null) 'reportedAt': _reportedAt!.toIso8601String(),
        if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
        if (_assignedTo != null) 'assignedTo': _assignedTo,
        if (_assignedVendor != null) 'assignedVendor': _assignedVendor,
        if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
        if (_actualCost != null) 'actualCost': _actualCost,
        if (_userId != null) 'userId': _userId,
        if (_organizationId != null) 'organizationId': _organizationId,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? MaintenanceWorkOrder.fromJson({...widget.item!.toJson(), ...data})
        : MaintenanceWorkOrder.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _tenantId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reported By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _reportedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Priority', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _priority = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _reportedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _reportedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Reported At',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_reportedAt != null ? _fmt(_reportedAt) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dueDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  child: Text(_dueDate != null ? _fmt(_dueDate) : 'Tap to select'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _assignedTo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned Vendor', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _assignedVendor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Estimated Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _estimatedCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSaved: (v) => _actualCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Maintenance Work Order'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
