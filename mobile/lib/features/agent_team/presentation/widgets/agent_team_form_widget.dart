import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AgentTeam Form Widget  |  Fields: name, leaderId

class AgentTeamFormWidget extends StatefulWidget {
  final AgentTeam? item;
  final void Function(AgentTeam)? onSubmit;
  const AgentTeamFormWidget({super.key, this.item, this.onSubmit});
  @override State<AgentTeamFormWidget> createState() => _AgentTeamFormWidgetState();
}

class _AgentTeamFormWidgetState extends State<AgentTeamFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _leaderId;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _leaderId = widget.item?.leaderId?.toString();
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
        if (_leaderId?.isNotEmpty == true) 'leaderId': _leaderId,
    };
    final result = widget.item != null
        ? AgentTeam.fromJson({...widget.item!.toJson(), ...data})
        : AgentTeam.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Leader Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _leaderId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agent Team'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
