import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VirtualTour Form Widget  |  Fields: propertyId, name, description, tourType, videoUrl, embedCode, thumbnailUrl, duration, hotspots, isActive

class VirtualTourFormWidget extends StatefulWidget {
  final VirtualTour? item;
  final void Function(VirtualTour)? onSubmit;
  const VirtualTourFormWidget({super.key, this.item, this.onSubmit});
  @override State<VirtualTourFormWidget> createState() => _VirtualTourFormWidgetState();
}

class _VirtualTourFormWidgetState extends State<VirtualTourFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _name;
  String? _description;
  String? _tourType;
  String? _videoUrl;
  String? _embedCode;
  String? _thumbnailUrl;
  int? _duration;
  String? _hotspots;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _tourType = widget.item?.tourType?.toString();
    _videoUrl = widget.item?.videoUrl?.toString();
    _embedCode = widget.item?.embedCode?.toString();
    _thumbnailUrl = widget.item?.thumbnailUrl?.toString();
    _duration = widget.item?.duration;
    _hotspots = widget.item?.hotspots?.toString();
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
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_tourType?.isNotEmpty == true) 'tourType': _tourType,
        if (_videoUrl?.isNotEmpty == true) 'videoUrl': _videoUrl,
        if (_embedCode?.isNotEmpty == true) 'embedCode': _embedCode,
        if (_thumbnailUrl?.isNotEmpty == true) 'thumbnailUrl': _thumbnailUrl,
        if (_duration != null) 'duration': _duration,
        if (_hotspots?.isNotEmpty == true) 'hotspots': _hotspots,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? VirtualTour.fromJson({...widget.item!.toJson(), ...data})
        : VirtualTour.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Tour Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tourType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Video Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _videoUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Embed Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _embedCode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Thumbnail Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _thumbnailUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _duration = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Hotspots', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _hotspots = v?.isEmpty == true ? null : v,
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Virtual Tour'),
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