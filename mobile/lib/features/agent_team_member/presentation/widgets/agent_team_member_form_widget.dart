import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AgentTeamMember Form Widget  |  Fields: teamId, userId, role

class AgentTeamMemberFormWidget extends StatefulWidget {
  final AgentTeamMember? item;
  final void Function(AgentTeamMember)? onSubmit;
  const AgentTeamMemberFormWidget({super.key, this.item, this.onSubmit});
  @override State<AgentTeamMemberFormWidget> createState() => _AgentTeamMemberFormWidgetState();
}

class _AgentTeamMemberFormWidgetState extends State<AgentTeamMemberFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _teamId;
  String? _userId;
  String? _role;

  @override
  void initState() {
    super.initState();
    _teamId = widget.item?.teamId?.toString();
    _userId = widget.item?.userId?.toString();
    _role = widget.item?.role?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_teamId?.isNotEmpty == true) 'teamId': _teamId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_role?.isNotEmpty == true) 'role': _role,
    };
    final result = widget.item != null
        ? AgentTeamMember.fromJson({...widget.item!.toJson(), ...data})
        : AgentTeamMember.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Team Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _teamId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Role', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _role = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agent Team Member'),
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