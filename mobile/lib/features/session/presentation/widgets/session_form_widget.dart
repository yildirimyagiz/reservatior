import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Session Form Widget  |  Fields: userId, tokenHash, expiresAt, ip, userAgent

class SessionFormWidget extends StatefulWidget {
  final Session? item;
  final void Function(Session)? onSubmit;
  const SessionFormWidget({super.key, this.item, this.onSubmit});
  @override State<SessionFormWidget> createState() => _SessionFormWidgetState();
}

class _SessionFormWidgetState extends State<SessionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _tokenHash;
  DateTime? _expiresAt;
  String? _ip;
  String? _userAgent;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _tokenHash = widget.item?.tokenHash?.toString();
    _expiresAt = widget.item?.expiresAt;
    _ip = widget.item?.ip?.toString();
    _userAgent = widget.item?.userAgent?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_tokenHash?.isNotEmpty == true) 'tokenHash': _tokenHash,
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_ip?.isNotEmpty == true) 'ip': _ip,
        if (_userAgent?.isNotEmpty == true) 'userAgent': _userAgent,
    };
    final result = widget.item != null
        ? Session.fromJson({...widget.item!.toJson(), ...data})
        : Session.fromJson(data);
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
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Token Hash', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tokenHash = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ip', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _ip = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Agent', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _userAgent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Session'),
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