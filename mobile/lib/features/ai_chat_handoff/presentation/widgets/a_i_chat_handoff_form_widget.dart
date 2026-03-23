import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../gen_models/abcx3_common.library.dart';

class AIChatHandoffFormWidget extends StatefulWidget {
  final AIChatHandoff? handoff;
  final Function(AIChatHandoff)? onSubmit;

  const AIChatHandoffFormWidget({
    super.key,
    this.handoff,
    this.onSubmit,
  });

  @override
  State<AIChatHandoffFormWidget> createState() => _AIChatHandoffFormWidgetState();
}

class _AIChatHandoffFormWidgetState extends State<AIChatHandoffFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _handoffToController;
  late final TextEditingController _handoffReasonController;
  late final TextEditingController _sessionIdController;
  late final TextEditingController _notesController;
  late final TextEditingController _resolvedByController;
  bool _isResolved = false;

  @override
  void initState() {
    super.initState();
    _handoffToController = TextEditingController(text: widget.handoff?.handoffTo);
    _handoffReasonController = TextEditingController(text: widget.handoff?.handoffReason);
    _sessionIdController = TextEditingController(text: widget.handoff?.sessionId);
    _notesController = TextEditingController(text: widget.handoff?.notes);
    _resolvedByController = TextEditingController(text: widget.handoff?.resolvedBy);
    _isResolved = widget.handoff?.resolvedAt != null;
  }

  @override
  void dispose() {
    _handoffToController.dispose();
    _handoffReasonController.dispose();
    _sessionIdController.dispose();
    _notesController.dispose();
    _resolvedByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _handoffToController,
                  decoration: const InputDecoration(
                    labelText: 'Handoff To (Agent/Dept)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Handoff target is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _handoffReasonController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Handoff Reason',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _sessionIdController,
                  decoration: const InputDecoration(
                    labelText: 'Session ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Internal Notes',
                    border: OutlineInputBorder(),
                  ),
                ),
                const Divider(height: 32),
                CheckboxListTile(
                  title: const Text('Is Resolved?'),
                  value: _isResolved,
                  onChanged: (val) {
                    setState(() {
                      _isResolved = val ?? false;
                    });
                  },
                ),
                if (_isResolved) ...[
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _resolvedByController,
                    decoration: const InputDecoration(
                      labelText: 'Resolved By',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final handoff = (widget.handoff ?? AIChatHandoff()).copyWith(
                    handoffTo: Value(_handoffToController.text),
                    handoffReason: Value(_handoffReasonController.text.isEmpty ? null : _handoffReasonController.text),
                    sessionId: Value(_sessionIdController.text.isEmpty ? null : _sessionIdController.text),
                    notes: Value(_notesController.text.isEmpty ? null : _notesController.text),
                    resolvedBy: Value(_resolvedByController.text.isEmpty ? null : _resolvedByController.text),
                    resolvedAt: Value(_isResolved ? (widget.handoff?.resolvedAt ?? DateTime.now()) : null),
                    handoffAt: Value(widget.handoff?.handoffAt ?? DateTime.now()),
                  );
                  widget.onSubmit?.call(handoff);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Handoff'),
            ),
          ],
        ),
      ],
    );
  }
}
