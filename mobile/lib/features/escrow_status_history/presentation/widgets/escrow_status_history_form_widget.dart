import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── EscrowStatusHistory Form Widget  |  Fields: escrowId, fromStatus, toStatus, changedBy, reason, metadata, changedAt

class EscrowStatusHistoryFormWidget extends StatefulWidget {
  final EscrowStatusHistory? item;
  final void Function(EscrowStatusHistory)? onSubmit;
  const EscrowStatusHistoryFormWidget({super.key, this.item, this.onSubmit});
  @override State<EscrowStatusHistoryFormWidget> createState() => _EscrowStatusHistoryFormWidgetState();
}

class _EscrowStatusHistoryFormWidgetState extends State<EscrowStatusHistoryFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _escrowId;
  String? _fromStatus;
  String? _toStatus;
  String? _changedBy;
  String? _reason;
  String? _metadata;
  DateTime? _changedAt;

  @override
  void initState() {
    super.initState();
    _escrowId = widget.item?.escrowId?.toString();
    _fromStatus = widget.item?.fromStatus?.toString();
    _toStatus = widget.item?.toStatus?.toString();
    _changedBy = widget.item?.changedBy?.toString();
    _reason = widget.item?.reason?.toString();
    _metadata = widget.item?.metadata?.toString();
    _changedAt = widget.item?.changedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_escrowId?.isNotEmpty == true) 'escrowId': _escrowId,
        if (_fromStatus?.isNotEmpty == true) 'fromStatus': _fromStatus,
        if (_toStatus?.isNotEmpty == true) 'toStatus': _toStatus,
        if (_changedBy?.isNotEmpty == true) 'changedBy': _changedBy,
        if (_reason?.isNotEmpty == true) 'reason': _reason,
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
        if (_changedAt != null) 'changedAt': _changedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? EscrowStatusHistory.fromJson({...widget.item!.toJson(), ...data})
        : EscrowStatusHistory.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Escrow Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _escrowId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'From Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _fromStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'To Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _toStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Changed By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _changedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reason', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reason = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _changedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _changedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Changed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_changedAt != null ? _fmt(_changedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Escrow Status History'),
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