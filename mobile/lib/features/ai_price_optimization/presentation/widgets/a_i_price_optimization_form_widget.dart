import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

class AIPriceOptimizationFormWidget extends StatefulWidget {
  final AIPriceOptimization? a_i_price_optimization;
  final Function(AIPriceOptimization)? onSubmit;

  const AIPriceOptimizationFormWidget({
    super.key,
    this.a_i_price_optimization,
    this.onSubmit,
  });

  @override
  State<AIPriceOptimizationFormWidget> createState() => _AIPriceOptimizationFormWidgetState();
}

class _AIPriceOptimizationFormWidgetState extends State<AIPriceOptimizationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _orgIdController;

  @override
  void initState() {
    super.initState();
    _orgIdController = TextEditingController(text: widget.a_i_price_optimization?.orgId);
  }

  @override
  void dispose() {
    _orgIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _orgIdController,
                decoration: const InputDecoration(
                  labelText: 'Organization ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Organization ID is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedAIPriceOptimization = AIPriceOptimization(
                          id: widget.a_i_price_optimization?.id,
                          orgId: _orgIdController.text,
                          priceRange: {},
                          factors: {},
                          comparableData: {},
                          marketTrends: {},
                          createdAt: widget.a_i_price_optimization?.createdAt ?? DateTime.now(),
                        );
                        widget.onSubmit?.call(updatedAIPriceOptimization);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
