import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── OrgSubscription Form Widget  |  Fields: planId, status, stripeCustomerId, stripeSubscriptionId, currentPeriodEnd

class OrgSubscriptionFormWidget extends StatefulWidget {
  final OrgSubscription? item;
  final void Function(OrgSubscription)? onSubmit;
  const OrgSubscriptionFormWidget({super.key, this.item, this.onSubmit});
  @override State<OrgSubscriptionFormWidget> createState() => _OrgSubscriptionFormWidgetState();
}

class _OrgSubscriptionFormWidgetState extends State<OrgSubscriptionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _planId;
  String? _status;
  String? _stripeCustomerId;
  String? _stripeSubscriptionId;
  DateTime? _currentPeriodEnd;

  @override
  void initState() {
    super.initState();
    _planId = widget.item?.planId?.toString();
    _status = widget.item?.status?.toString();
    _stripeCustomerId = widget.item?.stripeCustomerId?.toString();
    _stripeSubscriptionId = widget.item?.stripeSubscriptionId?.toString();
    _currentPeriodEnd = widget.item?.currentPeriodEnd;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_planId?.isNotEmpty == true) 'planId': _planId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_stripeCustomerId?.isNotEmpty == true) 'stripeCustomerId': _stripeCustomerId,
        if (_stripeSubscriptionId?.isNotEmpty == true) 'stripeSubscriptionId': _stripeSubscriptionId,
        if (_currentPeriodEnd != null) 'currentPeriodEnd': _currentPeriodEnd!.toIso8601String(),
    };
    final result = widget.item != null
        ? OrgSubscription.fromJson({...widget.item!.toJson(), ...data})
        : OrgSubscription.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Plan Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _planId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Customer Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _stripeCustomerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stripe Subscription Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _stripeSubscriptionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _currentPeriodEnd ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _currentPeriodEnd = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Current Period End',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_currentPeriodEnd != null ? _fmt(_currentPeriodEnd) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Org Subscription'),
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