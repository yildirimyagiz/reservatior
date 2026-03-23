import 'package:flutter/material.dart';

/// AI Image Analysis Page - Analyze property images with AI
class AIImageAnalysisPage extends StatefulWidget {
  const AIImageAnalysisPage({Key? key}) : super(key: key);

  @override
  State<AIImageAnalysisPage> createState() => _AIImageAnalysisPageState();
}

class _AIImageAnalysisPageState extends State<AIImageAnalysisPage> {
  bool _isAnalyzing = false;
  Map<String, dynamic>? _analysisResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Analysis'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload Area
            Card(
              child: InkWell(
                onTap: _selectImage,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud_upload, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Upload Property Image',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to select image or drag & drop',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (_isAnalyzing) ...[
              const SizedBox(height: 24),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Analyzing image with AI...'),
                    ],
                  ),
                ),
              ),
            ],

            if (_analysisResults != null) ...[
              const SizedBox(height: 24),
              
              // Room Detection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.room_preferences, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Room Detection',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildDetectionItem('Room Type', 'Living Room', Icons.living, 0.95),
                      _buildDetectionItem('Style', 'Modern Contemporary', Icons.style, 0.88),
                      _buildDetectionItem('Condition', 'Excellent', Icons.check_circle, 0.92),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Features Detected
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'Features Detected',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _buildFeatureChip('Hardwood Floors', 0.94),
                          _buildFeatureChip('Large Windows', 0.89),
                          _buildFeatureChip('High Ceilings', 0.85),
                          _buildFeatureChip('Modern Lighting', 0.91),
                          _buildFeatureChip('Fireplace', 0.78),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Quality Score
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.stars, color: Colors.amber),
                          const SizedBox(width: 8),
                          Text(
                            'Image Quality',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Overall Score'),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 0.87,
                                  backgroundColor: Colors.grey[200],
                                  color: Colors.green,
                                  minHeight: 10,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                const SizedBox(height: 4),
                                const Text('87/100', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(Icons.thumb_up, size: 48, color: Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Suggestions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lightbulb, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(
                            'AI Suggestions',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSuggestion('Improve lighting for better appeal'),
                      _buildSuggestion('Consider decluttering the space'),
                      _buildSuggestion('Add more angles for complete view'),
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

  Widget _buildDetectionItem(String label, String value, IconData icon, double confidence) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text('$label: $value'),
          ),
          Text(
            '${(confidence * 100).toInt()}%',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, double confidence) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Text(
            '${(confidence * 100).toInt()}%',
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
      backgroundColor: Colors.blue.withOpacity(0.1),
    );
  }

  Widget _buildSuggestion(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _selectImage() {
    setState(() => _isAnalyzing = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _analysisResults = {
            'roomType': 'Living Room',
            'confidence': 0.95,
          };
        });
      }
    });
  }
}
