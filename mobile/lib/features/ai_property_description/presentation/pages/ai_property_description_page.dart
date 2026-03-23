import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// AI Property Description Generator Page
class AIPropertyDescriptionPage extends StatefulWidget {
  const AIPropertyDescriptionPage({Key? key}) : super(key: key);

  @override
  State<AIPropertyDescriptionPage> createState() => _AIPropertyDescriptionPageState();
}

class _AIPropertyDescriptionPageState extends State<AIPropertyDescriptionPage> {
  String _generatedDescription = '';
  bool _isGenerating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Description Generator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Style Selection
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description Style', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(label: const Text('Professional'), selected: true, onSelected: (_) {}),
                      ChoiceChip(label: const Text('Luxury'), selected: false, onSelected: (_) {}),
                      ChoiceChip(label: const Text('Casual'), selected: false, onSelected: (_) {}),
                      ChoiceChip(label: const Text('Marketing'), selected: false, onSelected: (_) {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Generate Button
          ElevatedButton.icon(
            onPressed: _isGenerating ? null : _generateDescription,
            icon: _isGenerating ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.auto_awesome),
            label: Text(_isGenerating ? 'Generating...' : 'Generate Description'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
          ),
          
          if (_generatedDescription.isNotEmpty) ...[
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Generated Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        IconButton(icon: const Icon(Icons.copy), onPressed: () {
                          Clipboard.setData(ClipboardData(text: _generatedDescription));
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied!')));
                        }),
                      ],
                    ),
                    const Divider(),
                    Text(_generatedDescription),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: OutlinedButton(onPressed: _generateDescription, child: const Text('Regenerate'))),
                        const SizedBox(width: 12),
                        Expanded(child: ElevatedButton(onPressed: () {}, child: const Text('Use This'))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _generateDescription() {
    setState(() => _isGenerating = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _generatedDescription = 'Discover this stunning modern home in a prime location! This beautifully designed property features 3 spacious bedrooms and 2 elegant bathrooms, perfect for families seeking comfort and style.\n\n✨ Key Highlights:\n• Open-concept living area with abundant natural light\n• Gourmet kitchen with premium stainless steel appliances\n• Master suite with walk-in closet and spa-like bathroom\n• Beautifully landscaped backyard ideal for entertaining\n• Prime location near schools, shopping, and dining\n\nDon\'t miss this exceptional opportunity to own your dream home! Schedule your private showing today.';
          _isGenerating = false;
        });
      }
    });
  }
}
