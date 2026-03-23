import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../gen_models/abcx3_common.library.dart';
import '../../../../gen_models/enums/a_i_chat_role.dart';

class AIChatMessageFormWidget extends StatefulWidget {
  final AIChatMessage? message;
  final Function(AIChatMessage)? onSubmit;

  const AIChatMessageFormWidget({
    super.key,
    this.message,
    this.onSubmit,
  });

  @override
  State<AIChatMessageFormWidget> createState() => _AIChatMessageFormWidgetState();
}

class _AIChatMessageFormWidgetState extends State<AIChatMessageFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _contentController;
  late final TextEditingController _sessionIdController;
  late final TextEditingController _listingIdController;
  late final TextEditingController _reservationIdController;
  AIChatRole _selectedRole = AIChatRole.USER;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.message?.content);
    _sessionIdController = TextEditingController(text: widget.message?.sessionId);
    _listingIdController = TextEditingController(text: widget.message?.listingId);
    _reservationIdController = TextEditingController(text: widget.message?.reservationId);
    _selectedRole = widget.message?.role ?? AIChatRole.USER;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _sessionIdController.dispose();
    _listingIdController.dispose();
    _reservationIdController.dispose();
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
                 DropdownButtonFormField<AIChatRole>(
                  initialValue: _selectedRole,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(),
                  ),
                  items: AIChatRole.values.map((role) {
                    return DropdownMenuItem<AIChatRole>(
                      value: role,
                      child: Text(role.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Content is required';
                    }
                    return null;
                  },
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
                  controller: _listingIdController,
                  decoration: const InputDecoration(
                    labelText: 'Listing ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reservationIdController,
                  decoration: const InputDecoration(
                    labelText: 'Reservation ID',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                  final message = (widget.message ?? AIChatMessage(
                    paymentPlan: {},
                    metadata: {},
                  )).copyWith(
                    content: Value(_contentController.text),
                    sessionId: Value(_sessionIdController.text.isEmpty ? null : _sessionIdController.text),
                    role: Value(_selectedRole),
                    listingId: Value(_listingIdController.text.isEmpty ? null : _listingIdController.text),
                    reservationId: Value(_reservationIdController.text.isEmpty ? null : _reservationIdController.text),
                  );
                  widget.onSubmit?.call(message);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Message'),
            ),
          ],
        ),
      ],
    );
  }
}
