import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SocialImpactCounter Form Widget  |  Fields: impactType, currency, partnerName, partnerUrl, partnerOrgId, campaignTag, isPublic, displayGoal

class SocialImpactCounterFormWidget extends StatefulWidget {
  final SocialImpactCounter? item;
  final void Function(SocialImpactCounter)? onSubmit;
  const SocialImpactCounterFormWidget({super.key, this.item, this.onSubmit});
  @override State<SocialImpactCounterFormWidget> createState() => _SocialImpactCounterFormWidgetState();
}

class _SocialImpactCounterFormWidgetState extends State<SocialImpactCounterFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _impactType;
  String? _currency;
  String? _partnerName;
  String? _partnerUrl;
  String? _partnerOrgId;
  String? _campaignTag;
  bool _isPublic = false;
  int? _displayGoal;

  @override
  void initState() {
    super.initState();
    _impactType = widget.item?.impactType?.toString();
    _currency = widget.item?.currency?.toString();
    _partnerName = widget.item?.partnerName?.toString();
    _partnerUrl = widget.item?.partnerUrl?.toString();
    _partnerOrgId = widget.item?.partnerOrgId?.toString();
    _campaignTag = widget.item?.campaignTag?.toString();
    _isPublic = widget.item?.isPublic ?? false;
    _displayGoal = widget.item?.displayGoal;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_impactType?.isNotEmpty == true) 'impactType': _impactType,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_partnerName?.isNotEmpty == true) 'partnerName': _partnerName,
        if (_partnerUrl?.isNotEmpty == true) 'partnerUrl': _partnerUrl,
        if (_partnerOrgId?.isNotEmpty == true) 'partnerOrgId': _partnerOrgId,
        if (_campaignTag?.isNotEmpty == true) 'campaignTag': _campaignTag,
        'isPublic': _isPublic,
        if (_displayGoal != null) 'displayGoal': _displayGoal,
    };
    final result = widget.item != null
        ? SocialImpactCounter.fromJson({...widget.item!.toJson(), ...data})
        : SocialImpactCounter.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Impact Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _impactType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Partner Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _partnerName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Partner Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _partnerUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Partner Org Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _partnerOrgId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Campaign Tag', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _campaignTag = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Public'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isPublic,
                  onChanged: (v) { ss(() {}); setState(() => _isPublic = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Display Goal', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _displayGoal = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Social Impact Counter'),
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