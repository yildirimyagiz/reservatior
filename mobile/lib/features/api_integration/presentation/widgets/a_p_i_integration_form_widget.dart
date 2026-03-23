import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ApiIntegration Form Widget  |  Simplified form for ApiIntegration

class ApiIntegrationFormWidget extends StatefulWidget {
  final ApiIntegration? item;
  final void Function(ApiIntegration)? onSubmit;
  const ApiIntegrationFormWidget({super.key, this.item, this.onSubmit});
  @override State<ApiIntegrationFormWidget> createState() => _ApiIntegrationFormWidgetState();
}

class _ApiIntegrationFormWidgetState extends State<ApiIntegrationFormWidget> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: widget.item?.name ?? '',
            decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
            onSaved: (v) {}, // Simplified - just a placeholder
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: widget.item?.platform?.toString() ?? '',
            decoration: const InputDecoration(labelText: 'Platform', border: OutlineInputBorder()),
            onSaved: (v) {},
          ),
          const SizedBox(height: 12),
          TextFormField(
            initialValue: widget.item?.baseUrl ?? '',
            decoration: const InputDecoration(labelText: 'Base URL', border: OutlineInputBorder()),
            onSaved: (v) {},
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_key.currentState!.validate()) {
                _key.currentState!.save();
                widget.onSubmit?.call(widget.item ?? ApiIntegration(config: {}));
              }
            },
            icon: const Icon(Icons.check),
            label: Text(widget.item == null ? 'Create' : 'Update'),
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
          ),
        ],
      ),
    );
  }
}
