import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MarketingCampaignFormWidget extends ConsumerStatefulWidget {
  final MarketingCampaign? item;
  final Function(MarketingCampaign) onSubmit;
  const MarketingCampaignFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MarketingCampaignFormWidget> createState() =>
      _MarketingCampaignFormWidgetState();
}

class _MarketingCampaignFormWidgetState
    extends ConsumerState<MarketingCampaignFormWidget> {
  String? _name;
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
    _name = widget.item?.name;
    _targetType = widget.item?.targetType;
    _subject = widget.item?.subject;
    _content = widget.item?.content;
    _templateId = widget.item?.templateId;
    _scheduledAt = widget.item?.scheduledAt;
    _sentAt = widget.item?.sentAt;
    _completedAt = widget.item?.completedAt;
    _sentCount = widget.item?.sentCount;
    _openCount = widget.item?.openCount;
    _clickCount = widget.item?.clickCount;
    _conversionCount = widget.item?.conversionCount;
    _budget = widget.item?.budget;
    _actualSpend = widget.item?.actualSpend;
    _objective = widget.item?.objective;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.marketingcampaign'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.marketingcampaign'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _targetType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targettype'.tr()),
              onChanged: (v) => _targetType = v,
            ),
            TextFormField(
              initialValue: _subject?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.subject'.tr()),
              onChanged: (v) => _subject = v,
            ),
            TextFormField(
              initialValue: _content?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.content'.tr()),
              onChanged: (v) => _content = v,
            ),
            TextFormField(
              initialValue: _templateId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.templateid'.tr()),
              onChanged: (v) => _templateId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_scheduled_at'.tr()}: ${_scheduledAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _scheduledAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _scheduledAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_sent_at'.tr()}: ${_sentAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _sentAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _sentAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_completed_at'.tr()}: ${_completedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completedAt = d);
              },
            ),
            TextFormField(
              initialValue: _sentCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sentcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _sentCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _openCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.opencount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _openCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _clickCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.clickcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _clickCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _conversionCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.conversioncount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _conversionCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _budget?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.budget'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _budget = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _actualSpend?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualspend'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualSpend = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _objective?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.objective'.tr()),
              onChanged: (v) => _objective = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_name != null) 'name': _name,
                  if (_targetType != null) 'targetType': _targetType,
                  if (_subject != null) 'subject': _subject,
                  if (_content != null) 'content': _content,
                  if (_templateId != null) 'templateId': _templateId,
                  if (_scheduledAt != null)
                    'scheduledAt': _scheduledAt!.toIso8601String(),
                  if (_sentAt != null) 'sentAt': _sentAt!.toIso8601String(),
                  if (_completedAt != null)
                    'completedAt': _completedAt!.toIso8601String(),
                  if (_sentCount != null) 'sentCount': _sentCount,
                  if (_openCount != null) 'openCount': _openCount,
                  if (_clickCount != null) 'clickCount': _clickCount,
                  if (_conversionCount != null)
                    'conversionCount': _conversionCount,
                  if (_budget != null) 'budget': _budget,
                  if (_actualSpend != null) 'actualSpend': _actualSpend,
                  if (_objective != null) 'objective': _objective,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(MarketingCampaign.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
