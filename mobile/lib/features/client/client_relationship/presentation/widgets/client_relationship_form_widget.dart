import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ClientRelationshipFormWidget extends ConsumerStatefulWidget {
  final ClientRelationship? item;
  final Function(ClientRelationship) onSubmit;
  const ClientRelationshipFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ClientRelationshipFormWidget> createState() =>
      _ClientRelationshipFormWidgetState();
}

class _ClientRelationshipFormWidgetState
    extends ConsumerState<ClientRelationshipFormWidget> {
  String? _agentId;
  String? _clientId;
  DateTime? _firstContact;
  DateTime? _lastContact;
  String? _contactFrequency;
  @override
  void initState() {
    super.initState();
    _agentId = widget.item?.agentId;
    _clientId = widget.item?.clientId;
    _firstContact = widget.item?.firstContact;
    _lastContact = widget.item?.lastContact;
    _contactFrequency = widget.item?.contactFrequency;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.clientrelationship'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.clientrelationship'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            TextFormField(
              initialValue: _clientId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.clientid'.tr()),
              onChanged: (v) => _clientId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_first_contact'.tr()}: ${_firstContact ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _firstContact ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _firstContact = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_contact'.tr()}: ${_lastContact ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastContact ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastContact = d);
              },
            ),
            TextFormField(
              initialValue: _contactFrequency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactfrequency'.tr()),
              onChanged: (v) => _contactFrequency = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_agentId != null) 'agentId': _agentId,
                  if (_clientId != null) 'clientId': _clientId,
                  if (_firstContact != null)
                    'firstContact': _firstContact!.toIso8601String(),
                  if (_lastContact != null)
                    'lastContact': _lastContact!.toIso8601String(),
                  if (_contactFrequency != null)
                    'contactFrequency': _contactFrequency,
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
                  widget.onSubmit(ClientRelationship.fromJson(json));
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
