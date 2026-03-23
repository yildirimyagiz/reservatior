import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyInventory Form Widget  |  Fields: propertyId, leaseId, inventoryType, inventoryDate, conductedBy, rooms, overallCondition, damages, cleaningRequired, tenantSignature, landlordSignature, agentSignature, reportUrl, photos

class PropertyInventoryFormWidget extends StatefulWidget {
  final PropertyInventory? item;
  final void Function(PropertyInventory)? onSubmit;
  const PropertyInventoryFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyInventoryFormWidget> createState() => _PropertyInventoryFormWidgetState();
}

class _PropertyInventoryFormWidgetState extends State<PropertyInventoryFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _leaseId;
  String? _inventoryType;
  DateTime? _inventoryDate;
  String? _conductedBy;
  String? _rooms;
  String? _overallCondition;
  String? _damages;
  bool _cleaningRequired = false;
  String? _tenantSignature;
  String? _landlordSignature;
  String? _agentSignature;
  String? _reportUrl;
  String? _photos;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _inventoryType = widget.item?.inventoryType?.toString();
    _inventoryDate = widget.item?.inventoryDate;
    _conductedBy = widget.item?.conductedBy?.toString();
    _rooms = widget.item?.rooms?.toString();
    _overallCondition = widget.item?.overallCondition?.toString();
    _damages = widget.item?.damages?.toString();
    _cleaningRequired = widget.item?.cleaningRequired ?? false;
    _tenantSignature = widget.item?.tenantSignature?.toString();
    _landlordSignature = widget.item?.landlordSignature?.toString();
    _agentSignature = widget.item?.agentSignature?.toString();
    _reportUrl = widget.item?.reportUrl?.toString();
    _photos = widget.item?.photos?.toString();
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
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_inventoryType?.isNotEmpty == true) 'inventoryType': _inventoryType,
        if (_inventoryDate != null) 'inventoryDate': _inventoryDate!.toIso8601String(),
        if (_conductedBy?.isNotEmpty == true) 'conductedBy': _conductedBy,
        if (_rooms?.isNotEmpty == true) 'rooms': _rooms,
        if (_overallCondition?.isNotEmpty == true) 'overallCondition': _overallCondition,
        if (_damages?.isNotEmpty == true) 'damages': _damages,
        'cleaningRequired': _cleaningRequired,
        if (_tenantSignature?.isNotEmpty == true) 'tenantSignature': _tenantSignature,
        if (_landlordSignature?.isNotEmpty == true) 'landlordSignature': _landlordSignature,
        if (_agentSignature?.isNotEmpty == true) 'agentSignature': _agentSignature,
        if (_reportUrl?.isNotEmpty == true) 'reportUrl': _reportUrl,
        if (_photos?.isNotEmpty == true) 'photos': _photos,
    };
    final result = widget.item != null
        ? PropertyInventory.fromJson({...widget.item!.toJson(), ...data})
        : PropertyInventory.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Inventory Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _inventoryType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _inventoryDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _inventoryDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Inventory Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_inventoryDate != null ? _fmt(_inventoryDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conducted By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _conductedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rooms', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _rooms = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Overall Condition', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _overallCondition = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Damages', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _damages = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Cleaning Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _cleaningRequired,
                  onChanged: (v) { ss(() {}); setState(() => _cleaningRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tenant Signature', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tenantSignature = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Landlord Signature', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _landlordSignature = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Agent Signature', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _agentSignature = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Report Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reportUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Photos', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _photos = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Inventory'),
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