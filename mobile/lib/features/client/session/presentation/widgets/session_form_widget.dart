import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SessionFormWidget extends ConsumerStatefulWidget {
  final Session? item;
  final Function(Session) onSubmit;
  const SessionFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<SessionFormWidget> createState() => _SessionFormWidgetState();
}

class _SessionFormWidgetState extends ConsumerState<SessionFormWidget> {
  String? _userId;
  String? _tokenHash;
  DateTime? _expiresAt;
  String? _ip;
  String? _userAgent;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _tokenHash = widget.item?.tokenHash;
    _expiresAt = widget.item?.expiresAt;
    _ip = widget.item?.ip;
    _userAgent = widget.item?.userAgent;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.session'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.session'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _tokenHash?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tokenhash'.tr()),
              onChanged: (v) => _tokenHash = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            TextFormField(
              initialValue: _ip?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.ip'.tr()),
              onChanged: (v) => _ip = v,
            ),
            TextFormField(
              initialValue: _userAgent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.useragent'.tr()),
              onChanged: (v) => _userAgent = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_tokenHash != null) 'tokenHash': _tokenHash,
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
                  if (_ip != null) 'ip': _ip,
                  if (_userAgent != null) 'userAgent': _userAgent,
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
                  widget.onSubmit(Session.fromJson(json));
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
