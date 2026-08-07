import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/ai_studio/data/ai_service_task_service.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

final aiServiceTaskServiceProvider = Provider<AiServiceTaskService>((ref) {
  return AiServiceTaskService(ref.watch(dioClientProvider));
});

enum _StudioAction { ocr, translation, video, brochure, staging }

class AIStudioScreen extends ConsumerStatefulWidget {
  const AIStudioScreen({super.key});

  @override
  ConsumerState<AIStudioScreen> createState() => _AIStudioScreenState();
}

class _AIStudioScreenState extends ConsumerState<AIStudioScreen> {
  _StudioAction _action = _StudioAction.ocr;
  final _inputCtrl = TextEditingController();
  final _propertyCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  String _targetLang = 'tr';
  String _roomType = 'living_room';
  String _style = 'modern';

  bool _processing = false;
  double _progress = 0;
  String? _taskId;
  String? _error;
  Map<String, dynamic>? _output;
  Timer? _poll;

  @override
  void dispose() {
    _poll?.cancel();
    _inputCtrl.dispose();
    _propertyCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  Future<void> _startTask() async {
    setState(() {
      _processing = true;
      _progress = 0.05;
      _error = null;
      _output = null;
      _taskId = null;
    });

    String taskType;
    Map<String, dynamic> inputData;

    switch (_action) {
      case _StudioAction.ocr:
        taskType = 'DOCUMENT_OCR';
        inputData = {
          'file_path': _inputCtrl.text.trim().isEmpty
              ? 'demo-document.pdf'
              : _inputCtrl.text.trim(),
          'original_name': 'document.pdf',
          'mime_type': 'application/pdf',
        };
      case _StudioAction.translation:
        taskType = 'TRANSLATION_LOCALIZATION';
        inputData = {
          'text': _inputCtrl.text.trim().isEmpty
              ? 'Real Estate is a great investment opportunity.'
              : _inputCtrl.text.trim(),
          'targetLang': _targetLang,
        };
      case _StudioAction.video:
        taskType = 'REELS_VIDEO_GEN';
        inputData = {
          'videoUrl': _inputCtrl.text.trim().isEmpty
              ? 'https://assets.mixkit.co/videos/preview/mixkit-modern-apartment-living-room-42865-large.mp4'
              : _inputCtrl.text.trim(),
          'targetLang': _targetLang,
        };
      case _StudioAction.brochure:
        taskType = 'MARKETING_BROCHURE_GEN';
        inputData = {
          'propertyId': _propertyCtrl.text.trim().isEmpty
              ? 'demo-property-123'
              : _propertyCtrl.text.trim(),
        };
      case _StudioAction.staging:
        taskType = 'VIRTUAL_STAGING';
        inputData = {
          'imageUrl': _imageCtrl.text.trim().isEmpty
              ? 'https://example.com/empty-room.jpg'
              : _imageCtrl.text.trim(),
          'roomType': _roomType,
          'style': _style,
        };
    }

    try {
      final service = ref.read(aiServiceTaskServiceProvider);
      final task = await service.createTask(
        taskType: taskType,
        inputData: inputData,
      );
      final id = task['id']?.toString();
      setState(() {
        _taskId = id;
        _progress = 0.15;
      });
      if (id != null) {
        _pollTask(id);
      } else {
        setState(() {
          _processing = false;
          _progress = 1;
          _output = task;
        });
      }
    } catch (e) {
      setState(() {
        _processing = false;
        _error = e.toString();
      });
    }
  }

  void _pollTask(String id) {
    _poll?.cancel();
    var ticks = 0;
    _poll = Timer.periodic(const Duration(seconds: 2), (timer) async {
      ticks++;
      if (ticks > 30) {
        timer.cancel();
        setState(() {
          _processing = false;
          _error = 'Task timeout';
        });
        return;
      }
      final task =
          await ref.read(aiServiceTaskServiceProvider).getTask(id);
      if (task == null) return;
      final progress = (task['progress'] as num?)?.toDouble() ?? _progress;
      final status = task['status']?.toString().toUpperCase() ?? '';
      final output = task['outputData'] ?? task['result'] ?? task['output'];
      setState(() {
        _progress = (progress / 100).clamp(0.15, 0.95);
        if (output is Map<String, dynamic>) _output = output;
      });
      if (status.contains('COMPLETE') ||
          status.contains('SUCCESS') ||
          status.contains('DONE') ||
          progress >= 100) {
        timer.cancel();
        setState(() {
          _processing = false;
          _progress = 1;
          if (output is Map<String, dynamic>) {
            _output = output;
          } else if (output != null) {
            _output = {'result': output};
          } else {
            _output = task;
          }
        });
      } else if (status.contains('FAIL') || status.contains('ERROR')) {
        timer.cancel();
        setState(() {
          _processing = false;
          _error = task['error']?.toString() ?? 'Task failed';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'AI Studio',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'mobile.auto.ai_studio_subtitle'.tr(),
                  style: GoogleFonts.outfit(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ).animate().fadeIn(),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _StudioAction.values.map((a) {
                    final selected = _action == a;
                    return ChoiceChip(
                      label: Text(_label(a)),
                      selected: selected,
                      onSelected: (_) => setState(() => _action = a),
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.darkCard,
                      labelStyle: GoogleFonts.outfit(
                        color: selected ? Colors.white : Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _buildInputs(),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _processing ? null : _startTask,
                    icon: _processing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(
                      _processing ? 'Processing…' : 'Run synthesis',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                if (_processing || _progress > 0) ...[
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.white12,
                    color: AppColors.primary,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  if (_taskId != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Task: $_taskId',
                        style: GoogleFonts.outfit(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  _ResultCard(
                    title: 'Error',
                    body: _error!,
                    color: AppColors.error,
                  ),
                ],
                if (_output != null) ...[
                  const SizedBox(height: 16),
                  _ResultCard(
                    title: 'Output',
                    body: _output.toString(),
                    color: AppColors.success,
                  ),
                ],
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputs() {
    switch (_action) {
      case _StudioAction.ocr:
      case _StudioAction.video:
        return _field(
          controller: _inputCtrl,
          hint: _action == _StudioAction.ocr
              ? 'Document path or URL'
              : 'Video URL',
          maxLines: 2,
        );
      case _StudioAction.translation:
        return Column(
          children: [
            _field(
              controller: _inputCtrl,
              hint: 'Text to translate',
              maxLines: 4,
            ),
            const SizedBox(height: 12),
            _dropdown(
              value: _targetLang,
              items: const ['tr', 'en', 'ar', 'de', 'es', 'fr'],
              onChanged: (v) => setState(() => _targetLang = v ?? 'tr'),
              label: 'Target language',
            ),
          ],
        );
      case _StudioAction.brochure:
        return _field(
          controller: _propertyCtrl,
          hint: 'Property ID',
        );
      case _StudioAction.staging:
        return Column(
          children: [
            _field(controller: _imageCtrl, hint: 'Room image URL'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _dropdown(
                    value: _roomType,
                    items: const [
                      'living_room',
                      'bedroom',
                      'kitchen',
                      'bathroom',
                    ],
                    onChanged: (v) =>
                        setState(() => _roomType = v ?? 'living_room'),
                    label: 'Room',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _dropdown(
                    value: _style,
                    items: const ['modern', 'minimal', 'luxury', 'scandinavian'],
                    onChanged: (v) => setState(() => _style = v ?? 'modern'),
                    label: 'Style',
                  ),
                ),
              ],
            ),
          ],
        );
    }
  }

  String _label(_StudioAction a) => switch (a) {
        _StudioAction.ocr => 'OCR',
        _StudioAction.translation => 'Translate',
        _StudioAction.video => 'Video',
        _StudioAction.brochure => 'Brochure',
        _StudioAction.staging => 'Staging',
      };

  Widget _field({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.outfit(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(color: Colors.white38),
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String label,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.darkBorder),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.darkCard,
          style: GoogleFonts.outfit(color: Colors.white),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String title;
  final String body;
  final Color color;

  const _ResultCard({
    required this.title,
    required this.body,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            body,
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
