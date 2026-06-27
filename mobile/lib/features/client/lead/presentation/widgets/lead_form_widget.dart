import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LeadFormWidget extends ConsumerStatefulWidget {
  final Lead? item;
  final Function(Lead) onSubmit;
  const LeadFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LeadFormWidget> createState() => _LeadFormWidgetState();
}

class _LeadFormWidgetState extends ConsumerState<LeadFormWidget> {
  String? _campaignId;
  String? _sourceId;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  double? _budget;
  String? _timeline;
  String? _notes;
  String? _sourceDetail;
  String? _assignedToUserId;
  String? _assignedToContactId;
  String? _interestedPropertyId;
  String? _interestedListingId;
  String? _agentTeamId;
  @override
  void initState() {
    super.initState();
    _campaignId = widget.item?.campaignId;
    _sourceId = widget.item?.sourceId;
    _firstName = widget.item?.firstName;
    _lastName = widget.item?.lastName;
    _email = widget.item?.email;
    _phone = widget.item?.phone;
    _budget = widget.item?.budget;
    _timeline = widget.item?.timeline;
    _notes = widget.item?.notes;
    _sourceDetail = widget.item?.sourceDetail;
    _assignedToUserId = widget.item?.assignedToUserId;
    _assignedToContactId = widget.item?.assignedToContactId;
    _interestedPropertyId = widget.item?.interestedPropertyId;
    _interestedListingId = widget.item?.interestedListingId;
    _agentTeamId = widget.item?.agentTeamId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.lead'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.lead'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _campaignId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.campaignid'.tr()),
              onChanged: (v) => _campaignId = v,
            ),
            TextFormField(
              initialValue: _sourceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sourceid'.tr()),
              onChanged: (v) => _sourceId = v,
            ),
            TextFormField(
              initialValue: _firstName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.firstname'.tr()),
              onChanged: (v) => _firstName = v,
            ),
            TextFormField(
              initialValue: _lastName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lastname'.tr()),
              onChanged: (v) => _lastName = v,
            ),
            TextFormField(
              initialValue: _email?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.email'.tr()),
              onChanged: (v) => _email = v,
            ),
            TextFormField(
              initialValue: _phone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.phone'.tr()),
              onChanged: (v) => _phone = v,
            ),
            TextFormField(
              initialValue: _budget?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.budget'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _budget = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _timeline?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timeline'.tr()),
              onChanged: (v) => _timeline = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            TextFormField(
              initialValue: _sourceDetail?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sourcedetail'.tr()),
              onChanged: (v) => _sourceDetail = v,
            ),
            TextFormField(
              initialValue: _assignedToUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assignedtouserid'.tr()),
              onChanged: (v) => _assignedToUserId = v,
            ),
            TextFormField(
              initialValue: _assignedToContactId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.assignedtocontactid'.tr(),
              ),
              onChanged: (v) => _assignedToContactId = v,
            ),
            TextFormField(
              initialValue: _interestedPropertyId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.interestedpropertyid'.tr(),
              ),
              onChanged: (v) => _interestedPropertyId = v,
            ),
            TextFormField(
              initialValue: _interestedListingId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.interestedlistingid'.tr(),
              ),
              onChanged: (v) => _interestedListingId = v,
            ),
            TextFormField(
              initialValue: _agentTeamId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentteamid'.tr()),
              onChanged: (v) => _agentTeamId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_campaignId != null) 'campaignId': _campaignId,
                  if (_sourceId != null) 'sourceId': _sourceId,
                  if (_firstName != null) 'firstName': _firstName,
                  if (_lastName != null) 'lastName': _lastName,
                  if (_email != null) 'email': _email,
                  if (_phone != null) 'phone': _phone,
                  if (_budget != null) 'budget': _budget,
                  if (_timeline != null) 'timeline': _timeline,
                  if (_notes != null) 'notes': _notes,
                  if (_sourceDetail != null) 'sourceDetail': _sourceDetail,
                  if (_assignedToUserId != null)
                    'assignedToUserId': _assignedToUserId,
                  if (_assignedToContactId != null)
                    'assignedToContactId': _assignedToContactId,
                  if (_interestedPropertyId != null)
                    'interestedPropertyId': _interestedPropertyId,
                  if (_interestedListingId != null)
                    'interestedListingId': _interestedListingId,
                  if (_agentTeamId != null) 'agentTeamId': _agentTeamId,
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
                  widget.onSubmit(Lead.fromJson(json));
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
