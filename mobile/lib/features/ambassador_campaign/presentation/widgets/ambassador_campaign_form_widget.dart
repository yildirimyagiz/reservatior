import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AmbassadorCampaign Form Widget  |  Fields: ambassadorId, name, description, startDate, endDate, budget, actualSpend, currency, status, targetReach, actualReach, impressions, clicks, conversions, conversionValue, roi, content

class AmbassadorCampaignFormWidget extends StatefulWidget {
  final AmbassadorCampaign? item;
  final void Function(AmbassadorCampaign)? onSubmit;
  const AmbassadorCampaignFormWidget({super.key, this.item, this.onSubmit});
  @override State<AmbassadorCampaignFormWidget> createState() => _AmbassadorCampaignFormWidgetState();
}

class _AmbassadorCampaignFormWidgetState extends State<AmbassadorCampaignFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _ambassadorId;
  String? _name;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _budget;
  double? _actualSpend;
  String? _currency;
  String? _status;
  int? _targetReach;
  int? _actualReach;
  int? _impressions;
  int? _clicks;
  int? _conversions;
  double? _conversionValue;
  double? _roi;
  String? _content;

  @override
  void initState() {
    super.initState();
    _ambassadorId = widget.item?.ambassadorId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _targetReach = widget.item?.targetReach;
    _actualReach = widget.item?.actualReach;
    _impressions = widget.item?.impressions;
    _clicks = widget.item?.clicks;
    _conversions = widget.item?.conversions;
    _conversionValue = widget.item?.conversionValue;
    _roi = widget.item?.roi;
    _content = widget.item?.content?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_ambassadorId?.isNotEmpty == true) 'ambassadorId': _ambassadorId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_budget != null) 'budget': _budget,
        if (_actualSpend != null) 'actualSpend': _actualSpend,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_targetReach != null) 'targetReach': _targetReach,
        if (_actualReach != null) 'actualReach': _actualReach,
        if (_impressions != null) 'impressions': _impressions,
        if (_clicks != null) 'clicks': _clicks,
        if (_conversions != null) 'conversions': _conversions,
        if (_conversionValue != null) 'conversionValue': _conversionValue,
        if (_roi != null) 'roi': _roi,
        if (_content?.isNotEmpty == true) 'content': _content,
    };
    final result = widget.item != null
        ? AmbassadorCampaign.fromJson({...widget.item!.toJson(), ...data})
        : AmbassadorCampaign.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Ambassador Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _ambassadorId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Budget', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _budget = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Spend', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _actualSpend = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Target Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _targetReach = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Reach', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _actualReach = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Impressions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _impressions = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Clicks', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _clicks = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Conversions', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _conversions = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Conversion Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _conversionValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Roi', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _roi = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _content = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ambassador Campaign'),
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