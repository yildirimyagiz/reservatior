import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── TaxRecord Form Widget  |  Fields: profileId, transactionId, propertyId, contactId, recordType, profileData, categoryData, lineItemData, auditData, ruleData, depreciationData, form1099Data, isActive

class TaxRecordFormWidget extends StatefulWidget {
  final TaxRecord? item;
  final void Function(TaxRecord)? onSubmit;
  const TaxRecordFormWidget({super.key, this.item, this.onSubmit});
  @override State<TaxRecordFormWidget> createState() => _TaxRecordFormWidgetState();
}

class _TaxRecordFormWidgetState extends State<TaxRecordFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _profileId;
  String? _transactionId;
  String? _propertyId;
  String? _contactId;
  String? _recordType;
  String? _profileData;
  String? _categoryData;
  String? _lineItemData;
  String? _auditData;
  String? _ruleData;
  String? _depreciationData;
  String? _form1099Data;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _profileId = widget.item?.profileId?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _recordType = widget.item?.recordType?.toString();
    _profileData = widget.item?.profileData?.toString();
    _categoryData = widget.item?.categoryData?.toString();
    _lineItemData = widget.item?.lineItemData?.toString();
    _auditData = widget.item?.auditData?.toString();
    _ruleData = widget.item?.ruleData?.toString();
    _depreciationData = widget.item?.depreciationData?.toString();
    _form1099Data = widget.item?.form1099Data?.toString();
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
        if (_profileId?.isNotEmpty == true) 'profileId': _profileId,
        if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_recordType?.isNotEmpty == true) 'recordType': _recordType,
        if (_profileData?.isNotEmpty == true) 'profileData': _profileData,
        if (_categoryData?.isNotEmpty == true) 'categoryData': _categoryData,
        if (_lineItemData?.isNotEmpty == true) 'lineItemData': _lineItemData,
        if (_auditData?.isNotEmpty == true) 'auditData': _auditData,
        if (_ruleData?.isNotEmpty == true) 'ruleData': _ruleData,
        if (_depreciationData?.isNotEmpty == true) 'depreciationData': _depreciationData,
        if (_form1099Data?.isNotEmpty == true) 'form1099Data': _form1099Data,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? TaxRecord.fromJson({...widget.item!.toJson(), ...data})
        : TaxRecord.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Profile Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _profileId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Record Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _recordType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Profile Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _profileData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _categoryData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Line Item Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lineItemData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Audit Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _auditData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _ruleData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Depreciation Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _depreciationData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Form1099 Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _form1099Data = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tax Record'),
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