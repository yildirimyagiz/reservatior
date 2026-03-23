import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/video_content_entity.dart';

// ── Video Upload Widget ─────────────────────────────────────────
// Dosya seç / drag-drop, metadata form, ilerleme göstergesi.

class VideoUploadWidget extends StatefulWidget {
  final void Function(String filePath, String title, VideoType type, VideoQuality quality)? onUpload;
  final VoidCallback? onCancel;

  const VideoUploadWidget({super.key, this.onUpload, this.onCancel});

  @override
  State<VideoUploadWidget> createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();

  String? _selectedFilePath;
  String? _selectedFileName;
  int? _fileSize;
  VideoType _type = VideoType.promotional;
  VideoQuality _quality = VideoQuality.high;
  bool _isPublic = false;
  bool _isFeatured = false;
  double _uploadProgress = 0;
  bool _isUploading = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _selectedFilePath = file.path;
        _selectedFileName = file.name;
        _fileSize = file.size;
        if (_titleCtrl.text.isEmpty) {
          _titleCtrl.text = file.name.replaceAll(RegExp(r'\.[^.]+$'), '');
        }
      });
    }
  }

  Future<void> _startUpload() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir video dosyası seçin'), backgroundColor: Colors.red),
      );
      return;
    }
    _formKey.currentState!.save();
    setState(() => _isUploading = true);

    // Simulated progress — real impl calls upload API
    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (mounted) setState(() => _uploadProgress = i / 100);
    }

    widget.onUpload?.call(_selectedFilePath!, _titleCtrl.text, _type, _quality);
  }

  String _fmtSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Drop zone ──
          GestureDetector(
            onTap: _isUploading ? null : _pickFile,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 140,
              decoration: BoxDecoration(
                color: _selectedFilePath != null ? Colors.green.withOpacity(0.05) : Colors.blue.withOpacity(0.04),
                border: Border.all(
                  color: _selectedFilePath != null ? Colors.green : Colors.blue.withOpacity(0.4),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _selectedFilePath == null
                  ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.blue[400]),
                      const SizedBox(height: 8),
                      const Text('Video dosyası seçmek için tıklayın', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('MP4, MOV, AVI, MKV, WebM — max 2GB', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ])
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(children: [
                        const Icon(Icons.video_file, size: 40, color: Colors.green),
                        const SizedBox(width: 16),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(_selectedFileName!, style: const TextStyle(fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
                          if (_fileSize != null) Text(_fmtSize(_fileSize!), style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                        ])),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => setState(() { _selectedFilePath = null; _selectedFileName = null; _fileSize = null; }),
                        ),
                      ]),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // ── Title ──
          TextFormField(
            controller: _titleCtrl,
            decoration: const InputDecoration(labelText: 'Başlık *', prefixIcon: Icon(Icons.title), border: OutlineInputBorder()),
            validator: (v) => v?.isEmpty == true ? 'Başlık zorunlu' : null,
          ),
          const SizedBox(height: 12),

          // ── Description ──
          TextFormField(
            controller: _descCtrl,
            decoration: const InputDecoration(labelText: 'Açıklama', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
            maxLines: 2,
          ),
          const SizedBox(height: 12),

          // ── Type + Quality row ──
          Row(children: [
            Expanded(
              child: DropdownButtonFormField<VideoType>(
                value: _type,
                decoration: const InputDecoration(labelText: 'Tür', border: OutlineInputBorder(), prefixIcon: Icon(Icons.category)),
                items: VideoType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name, style: const TextStyle(fontSize: 13)))).toList(),
                onChanged: (v) => setState(() => _type = v!),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<VideoQuality>(
                value: _quality,
                decoration: const InputDecoration(labelText: 'Kalite', border: OutlineInputBorder(), prefixIcon: Icon(Icons.high_quality)),
                items: VideoQuality.values.map((q) => DropdownMenuItem(value: q, child: Text(q.name, style: const TextStyle(fontSize: 13)))).toList(),
                onChanged: (v) => setState(() => _quality = v!),
              ),
            ),
          ]),
          const SizedBox(height: 12),

          // ── Tags ──
          TextFormField(
            controller: _tagsCtrl,
            decoration: const InputDecoration(labelText: 'Etiketler (virgülle ayırın)', prefixIcon: Icon(Icons.tag), border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),

          // ── Switches ──
          Row(children: [
            Expanded(child: SwitchListTile(
              title: const Text('Herkese Açık', style: TextStyle(fontSize: 13)),
              value: _isPublic,
              onChanged: (v) => setState(() => _isPublic = v),
              dense: true,
            )),
            Expanded(child: SwitchListTile(
              title: const Text('Öne Çıkan', style: TextStyle(fontSize: 13)),
              value: _isFeatured,
              onChanged: (v) => setState(() => _isFeatured = v),
              dense: true,
            )),
          ]),
          const SizedBox(height: 16),

          // ── Upload progress ──
          if (_isUploading) ...[
            Row(children: [
              Expanded(child: LinearProgressIndicator(value: _uploadProgress, minHeight: 8, borderRadius: BorderRadius.circular(4))),
              const SizedBox(width: 12),
              Text('${(_uploadProgress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 16),
          ],

          // ── Buttons ──
          Row(children: [
            if (widget.onCancel != null)
              Expanded(child: OutlinedButton(
                onPressed: _isUploading ? null : widget.onCancel,
                child: const Text('İptal'),
              )),
            if (widget.onCancel != null) const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _isUploading ? null : _startUpload,
                icon: _isUploading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.cloud_upload),
                label: Text(_isUploading ? 'Yükleniyor...' : 'Yükle'),
                style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
