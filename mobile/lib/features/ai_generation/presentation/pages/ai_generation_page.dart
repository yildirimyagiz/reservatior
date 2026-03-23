import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AI Content Generation Page - Generate property descriptions and marketing content
class AIGenerationPage extends StatefulWidget {
  const AIGenerationPage({Key? key}) : super(key: key);

  @override
  State<AIGenerationPage> createState() => _AIGenerationPageState();
}

class _AIGenerationPageState extends State<AIGenerationPage> {
  final _propertyTypeController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  String _generatedContent = '';
  bool _isGenerating = false;

  @override
  void dispose() {
    _propertyTypeController.dispose();
    _bedroomsController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Content Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Generation Type Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Content Type',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text('Property Description'),
                          selected: true,
                          onSelected: (value) {},
                        ),
                        ChoiceChip(
                          label: const Text('Marketing Copy'),
                          selected: false,
                          onSelected: (value) {},
                        ),
                        ChoiceChip(
                          label: const Text('Social Media'),
                          selected: false,
                          onSelected: (value) {},
                        ),
                        ChoiceChip(
                          label: const Text('Email Campaign'),
                          selected: false,
                          onSelected: (value) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Input Form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Property Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _propertyTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Property Type',
                        hintText: 'e.g., Modern Apartment, Villa',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _bedroomsController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Bedrooms',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.bed),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Price',
                              prefixText: '\$',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.attach_money),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _locationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        hintText: 'City, Neighborhood',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isGenerating ? null : _generateContent,
                        icon: _isGenerating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.auto_awesome),
                        label: Text(_isGenerating ? 'Generating...' : 'Generate Content'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_generatedContent.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Generated Content',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: _generatedContent));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied to clipboard')),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      Text(_generatedContent),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _generateContent,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Regenerate'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Content saved!')),
                                );
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _generateContent() {
    setState(() => _isGenerating = true);

    // Simulate AI generation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _generatedContent = _createDescription();
          _isGenerating = false;
        });
      }
    });
  }

  String _createDescription() {
    final type = _propertyTypeController.text.isEmpty ? 'Property' : _propertyTypeController.text;
    final beds = _bedroomsController.text.isEmpty ? '2' : _bedroomsController.text;
    final price = _priceController.text.isEmpty ? '500,000' : _priceController.text;
    final location = _locationController.text.isEmpty ? 'prime location' : _locationController.text;

    return '''
Discover this stunning $type in $location! 

This beautiful property features $beds spacious bedrooms with modern finishes throughout. Priced at \$$price, this home offers incredible value for discerning buyers.

✨ Key Features:
• $beds Bedrooms with ample closet space
• Modern kitchen with premium appliances
• Open-concept living area perfect for entertaining
• Prime location in $location
• Move-in ready condition

Don't miss this exceptional opportunity! Contact us today to schedule your private showing.

🏡 Price: \$$price
📍 Location: $location
🛏️ Bedrooms: $beds
    ''';
  }
}
