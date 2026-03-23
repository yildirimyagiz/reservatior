import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── FacilityBlock Form Widget  |  Fields: facilityId, name, floors, unitsPerFloor, totalUnits, yearBuilt, architect, features, images

class FacilityBlockFormWidget extends StatefulWidget {
  final FacilityBlock? item;
  final void Function(FacilityBlock)? onSubmit;
  const FacilityBlockFormWidget({super.key, this.item, this.onSubmit});
  @override State<FacilityBlockFormWidget> createState() => _FacilityBlockFormWidgetState();
}

class _FacilityBlockFormWidgetState extends State<FacilityBlockFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _facilityId;
  String? _name;
  int? _floors;
  int? _unitsPerFloor;
  int? _totalUnits;
  int? _yearBuilt;
  String? _architect;
  String? _featuresRaw;  // comma-separated input for List<String>
  String? _imagesRaw;    // comma-separated input for List<String>

  @override
  void initState() {
    super.initState();
    _facilityId = widget.item?.facilityId?.toString();
    _name = widget.item?.name?.toString();
    _floors = widget.item?.floors;
    _unitsPerFloor = widget.item?.unitsPerFloor;
    _totalUnits = widget.item?.totalUnits;
    _yearBuilt = widget.item?.yearBuilt;
    _architect = widget.item?.architect?.toString();
    _featuresRaw = widget.item?.features?.join(', ');
    _imagesRaw = widget.item?.images?.join(', ');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_facilityId?.isNotEmpty == true) 'facilityId': _facilityId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_floors != null) 'floors': _floors,
        if (_unitsPerFloor != null) 'unitsPerFloor': _unitsPerFloor,
        if (_totalUnits != null) 'totalUnits': _totalUnits,
        if (_yearBuilt != null) 'yearBuilt': _yearBuilt,
        if (_architect?.isNotEmpty == true) 'architect': _architect,
        if (_featuresRaw?.isNotEmpty == true)
          'features': _featuresRaw!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
        if (_imagesRaw?.isNotEmpty == true)
          'images': _imagesRaw!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
    };
    final result = widget.item != null
        ? FacilityBlock.fromJson({...widget.item!.toJson(), ...data})
        : FacilityBlock.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Facility Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _facilityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Floors', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _floors = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Units Per Floor', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _unitsPerFloor = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Units', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalUnits = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year Built', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _yearBuilt = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Architect', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _architect = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Facility Block'),
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