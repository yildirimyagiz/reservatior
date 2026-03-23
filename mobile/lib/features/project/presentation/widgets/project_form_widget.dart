import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Project Form Widget  |  Fields: name, description, projectType, propertyId, address, status, startDate, estimatedEndDate, actualEndDate, budget, currency, actualCost, managerId, contractorId, milestones, phases

class ProjectFormWidget extends StatefulWidget {
  final Project? item;
  final void Function(Project)? onSubmit;
  const ProjectFormWidget({super.key, this.item, this.onSubmit});
  @override State<ProjectFormWidget> createState() => _ProjectFormWidgetState();
}

class _ProjectFormWidgetState extends State<ProjectFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _description;
  String? _projectType;
  String? _propertyId;
  String? _address;
  String? _status;
  DateTime? _startDate;
  DateTime? _estimatedEndDate;
  DateTime? _actualEndDate;
  double? _budget;
  String? _currency;
  double? _actualCost;
  String? _managerId;
  String? _contractorId;
  String? _milestones;
  String? _phases;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _projectType = widget.item?.projectType?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _address = widget.item?.address?.toString();
    _status = widget.item?.status?.toString();
    _startDate = widget.item?.startDate;
    _estimatedEndDate = widget.item?.estimatedEndDate;
    _actualEndDate = widget.item?.actualEndDate;
    _budget = widget.item?.budget;
    _currency = widget.item?.currency?.toString();
    _actualCost = widget.item?.actualCost;
    _managerId = widget.item?.managerId?.toString();
    _contractorId = widget.item?.contractorId?.toString();
    _milestones = widget.item?.milestones?.toString();
    _phases = widget.item?.phases?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_projectType?.isNotEmpty == true) 'projectType': _projectType,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_address?.isNotEmpty == true) 'address': _address,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_estimatedEndDate != null) 'estimatedEndDate': _estimatedEndDate!.toIso8601String(),
        if (_actualEndDate != null) 'actualEndDate': _actualEndDate!.toIso8601String(),
        if (_budget != null) 'budget': _budget,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_actualCost != null) 'actualCost': _actualCost,
        if (_managerId?.isNotEmpty == true) 'managerId': _managerId,
        if (_contractorId?.isNotEmpty == true) 'contractorId': _contractorId,
        if (_milestones?.isNotEmpty == true) 'milestones': _milestones,
        if (_phases?.isNotEmpty == true) 'phases': _phases,
    };
    final result = widget.item != null
        ? Project.fromJson({...widget.item!.toJson(), ...data})
        : Project.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Project Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _projectType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _estimatedEndDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _estimatedEndDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Estimated End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_estimatedEndDate != null ? _fmt(_estimatedEndDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _actualEndDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _actualEndDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Actual End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_actualEndDate != null ? _fmt(_actualEndDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _budget = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _actualCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Manager Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _managerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contractor Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contractorId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Milestones', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _milestones = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phases', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _phases = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Project'),
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
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}