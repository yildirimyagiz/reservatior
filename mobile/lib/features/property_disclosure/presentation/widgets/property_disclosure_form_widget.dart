import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyDisclosure Form Widget  |  Fields: propertyId, packStatus, createdDate, submittedDate, energyPerformanceCertificate, floorPlan, leaseholdInfo, boundaryPlan, planningPermission, propertyQuestionnaire, electricalSafety, gasSafety, fireSafety, completionNotes

class PropertyDisclosureFormWidget extends StatefulWidget {
  final PropertyDisclosure? item;
  final void Function(PropertyDisclosure)? onSubmit;
  const PropertyDisclosureFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyDisclosureFormWidget> createState() => _PropertyDisclosureFormWidgetState();
}

class _PropertyDisclosureFormWidgetState extends State<PropertyDisclosureFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _packStatus;
  DateTime? _createdDate;
  DateTime? _submittedDate;
  String? _energyPerformanceCertificate;
  String? _floorPlan;
  String? _leaseholdInfo;
  String? _boundaryPlan;
  String? _planningPermission;
  String? _propertyQuestionnaire;
  String? _electricalSafety;
  String? _gasSafety;
  String? _fireSafety;
  String? _completionNotes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _packStatus = widget.item?.packStatus?.toString();
    _createdDate = widget.item?.createdDate;
    _submittedDate = widget.item?.submittedDate;
    _energyPerformanceCertificate = widget.item?.energyPerformanceCertificate?.toString();
    _floorPlan = widget.item?.floorPlan?.toString();
    _leaseholdInfo = widget.item?.leaseholdInfo?.toString();
    _boundaryPlan = widget.item?.boundaryPlan?.toString();
    _planningPermission = widget.item?.planningPermission?.toString();
    _propertyQuestionnaire = widget.item?.propertyQuestionnaire?.toString();
    _electricalSafety = widget.item?.electricalSafety?.toString();
    _gasSafety = widget.item?.gasSafety?.toString();
    _fireSafety = widget.item?.fireSafety?.toString();
    _completionNotes = widget.item?.completionNotes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_packStatus?.isNotEmpty == true) 'packStatus': _packStatus,
        if (_createdDate != null) 'createdDate': _createdDate!.toIso8601String(),
        if (_submittedDate != null) 'submittedDate': _submittedDate!.toIso8601String(),
        if (_energyPerformanceCertificate?.isNotEmpty == true) 'energyPerformanceCertificate': _energyPerformanceCertificate,
        if (_floorPlan?.isNotEmpty == true) 'floorPlan': _floorPlan,
        if (_leaseholdInfo?.isNotEmpty == true) 'leaseholdInfo': _leaseholdInfo,
        if (_boundaryPlan?.isNotEmpty == true) 'boundaryPlan': _boundaryPlan,
        if (_planningPermission?.isNotEmpty == true) 'planningPermission': _planningPermission,
        if (_propertyQuestionnaire?.isNotEmpty == true) 'propertyQuestionnaire': _propertyQuestionnaire,
        if (_electricalSafety?.isNotEmpty == true) 'electricalSafety': _electricalSafety,
        if (_gasSafety?.isNotEmpty == true) 'gasSafety': _gasSafety,
        if (_fireSafety?.isNotEmpty == true) 'fireSafety': _fireSafety,
        if (_completionNotes?.isNotEmpty == true) 'completionNotes': _completionNotes,
    };
    final result = widget.item != null
        ? PropertyDisclosure.fromJson({...widget.item!.toJson(), ...data})
        : PropertyDisclosure.fromJson(data);
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
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pack Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _packStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _createdDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _createdDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Created Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_createdDate != null ? _fmt(_createdDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _submittedDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _submittedDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Submitted Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_submittedDate != null ? _fmt(_submittedDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Energy Performance Certificate', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _energyPerformanceCertificate = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Floor Plan', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _floorPlan = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Leasehold Info', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseholdInfo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Boundary Plan', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _boundaryPlan = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Planning Permission', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _planningPermission = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Questionnaire', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyQuestionnaire = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Electrical Safety', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _electricalSafety = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gas Safety', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _gasSafety = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fire Safety', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _fireSafety = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Completion Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _completionNotes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Disclosure'),
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