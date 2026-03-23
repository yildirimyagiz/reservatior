import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MarketingCampaign Form Widget  |  Fields: name, type, status, targetType, subject, content, templateId, scheduledAt, sentAt, completedAt, sentCount, openCount, clickCount, conversionCount, budget, actualSpend, objective

class MarketingCampaignFormWidget extends StatefulWidget {
  final MarketingCampaign? item;
  final void Function(MarketingCampaign)? onSubmit;
  const MarketingCampaignFormWidget({super.key, this.item, this.onSubmit});
  @override State<MarketingCampaignFormWidget> createState() => _MarketingCampaignFormWidgetState();
}

class _MarketingCampaignFormWidgetState extends State<MarketingCampaignFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _status;
  String? _targetType;
  String? _subject;
  String? _content;
  String? _templateId;
  DateTime? _scheduledAt;
  DateTime? _sentAt;
  DateTime? _completedAt;
  int? _sentCount;
  int? _openCount;
  int? _clickCount;
  int? _conversionCount;
  double? _budget;
  double? _actualSpend;
  String? _objective;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _targetType = widget.item?.targetType?.toString();
    _subject = widget.item?.subject?.toString();
    _content = widget.item?.content?.toString();
    _templateId = widget.item?.templateId?.toString();
    _scheduledAt = widget.item?.scheduledAt;
    _sentAt = widget.item?.sentAt;
    _completedAt = widget.item?.completedAt;
    _sentCount = widget.item?.sentCount;
    _openCount = widget.item?.openCount;
    _clickCount = widget.item?.clickCount;
    _conversionCount = widget.item?.conversionCount;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _objective = widget.item?.objective?.toString();
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
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_targetType?.isNotEmpty == true) 'targetType': _targetType,
        if (_subject?.isNotEmpty == true) 'subject': _subject,
        if (_content?.isNotEmpty == true) 'content': _content,
        if (_templateId?.isNotEmpty == true) 'templateId': _templateId,
        if (_scheduledAt != null) 'scheduledAt': _scheduledAt!.toIso8601String(),
        if (_sentAt != null) 'sentAt': _sentAt!.toIso8601String(),
        if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
        if (_sentCount != null) 'sentCount': _sentCount,
        if (_openCount != null) 'openCount': _openCount,
        if (_clickCount != null) 'clickCount': _clickCount,
        if (_conversionCount != null) 'conversionCount': _conversionCount,
        if (_budget != null) 'budget': _budget,
        if (_actualSpend != null) 'actualSpend': _actualSpend,
        if (_objective?.isNotEmpty == true) 'objective': _objective,
    };
    final result = widget.item != null
        ? MarketingCampaign.fromJson({...widget.item!.toJson(), ...data})
        : MarketingCampaign.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Target Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _targetType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _content = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Template Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _templateId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _scheduledAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _scheduledAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Scheduled At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_scheduledAt != null ? _fmt(_scheduledAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _sentAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _sentAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Sent At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_sentAt != null ? _fmt(_sentAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _completedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedAt != null ? _fmt(_completedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sent Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _sentCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Open Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _openCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Click Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _clickCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Conversion Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _conversionCount = int.tryParse(v ?? ''),
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
                decoration: InputDecoration(labelText: 'Objective', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _objective = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Marketing Campaign'),
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