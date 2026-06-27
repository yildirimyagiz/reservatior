import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class OrgSubscriptionFormWidget extends ConsumerStatefulWidget {
  final OrgSubscription? item;
  final Function(OrgSubscription) onSubmit;
  const OrgSubscriptionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<OrgSubscriptionFormWidget> createState() =>
      _OrgSubscriptionFormWidgetState();
}

class _OrgSubscriptionFormWidgetState
    extends ConsumerState<OrgSubscriptionFormWidget> {
  String? _planId;
  String? _status;
  String? _stripeCustomerId;
  String? _stripeSubscriptionId;
  DateTime? _currentPeriodEnd;
  @override
  void initState() {
    super.initState();
    _planId = widget.item?.planId;
    _status = widget.item?.status;
    _stripeCustomerId = widget.item?.stripeCustomerId;
    _stripeSubscriptionId = widget.item?.stripeSubscriptionId;
    _currentPeriodEnd = widget.item?.currentPeriodEnd;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.orgsubscription'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.orgsubscription'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _planId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.planid'.tr()),
              onChanged: (v) => _planId = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _stripeCustomerId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.stripecustomerid'.tr()),
              onChanged: (v) => _stripeCustomerId = v,
            ),
            TextFormField(
              initialValue: _stripeSubscriptionId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.stripesubscriptionid'.tr(),
              ),
              onChanged: (v) => _stripeSubscriptionId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_current_period_end'.tr()}: ${_currentPeriodEnd ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _currentPeriodEnd ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _currentPeriodEnd = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_planId != null) 'planId': _planId,
                  if (_status != null) 'status': _status,
                  if (_stripeCustomerId != null)
                    'stripeCustomerId': _stripeCustomerId,
                  if (_stripeSubscriptionId != null)
                    'stripeSubscriptionId': _stripeSubscriptionId,
                  if (_currentPeriodEnd != null)
                    'currentPeriodEnd': _currentPeriodEnd!.toIso8601String(),
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
                  widget.onSubmit(OrgSubscription.fromJson(json));
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
