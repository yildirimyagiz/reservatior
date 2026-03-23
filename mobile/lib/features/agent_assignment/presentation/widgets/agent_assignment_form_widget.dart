import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AgentAssignment Form Widget  |  Fields: listingId, agentUserId, agencyOrgId, commissionBps

class AgentAssignmentFormWidget extends StatefulWidget {
  final AgentAssignment? item;
  final void Function(AgentAssignment)? onSubmit;
  const AgentAssignmentFormWidget({super.key, this.item, this.onSubmit});
  @override State<AgentAssignmentFormWidget> createState() => _AgentAssignmentFormWidgetState();
}

class _AgentAssignmentFormWidgetState extends State<AgentAssignmentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _agentUserId;
  String? _agencyOrgId;
  int? _commissionBps;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _agentUserId = widget.item?.agentUserId?.toString();
    _agencyOrgId = widget.item?.agencyOrgId?.toString();
    _commissionBps = widget.item?.commissionBps;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_agentUserId?.isNotEmpty == true) 'agentUserId': _agentUserId,
        if (_agencyOrgId?.isNotEmpty == true) 'agencyOrgId': _agencyOrgId,
        if (_commissionBps != null) 'commissionBps': _commissionBps,
    };
    final result = widget.item != null
        ? AgentAssignment.fromJson({...widget.item!.toJson(), ...data})
        : AgentAssignment.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Listing Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Agent User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _agentUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Agency Org Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _agencyOrgId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Bps', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _commissionBps = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Agent Assignment'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

