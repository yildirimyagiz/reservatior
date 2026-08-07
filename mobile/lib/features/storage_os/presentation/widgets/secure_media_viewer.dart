import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

enum MediaType { video, pdf, image }

class SecureMediaViewer extends StatefulWidget {
  final String mediaId;
  final MediaType type;
  final double? width;
  final double? height;

  const SecureMediaViewer({
    super.key,
    required this.mediaId,
    required this.type,
    this.width,
    this.height,
  });

  @override
  State<SecureMediaViewer> createState() => _SecureMediaViewerState();
}

class _SecureMediaViewerState extends State<SecureMediaViewer> {
  bool _loading = true;
  String? _error;
  String? _presignedUrl;

  @override
  void initState() {
    super.initState();
    _fetchSignedUrl();
  }

  void _fetchSignedUrl() async {
    try {
      setState(() {
        _loading = true;
        _error = null;
      });
      
      // Simulate API call to storage OS
      await Future.delayed(const Duration(milliseconds: 800));
      
      if (!mounted) return;
      setState(() {
        _presignedUrl = 'https://storage-os.reservatior.com/secure/${widget.mediaId}?token=mock-token-${DateTime.now().millisecondsSinceEpoch}&expires=300';
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'os.storage.failed'.tr(defaultValue: 'Failed to securely load media. You may not have permission.');
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.width ?? double.infinity;
    final h = widget.height ?? 200.0;

    if (_loading) {
      return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'os.storage.authorizing'.tr(defaultValue: 'Authorizing Media Request...'),
            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w500),
          ),
        ),
      );
    }

    if (_error != null || _presignedUrl == null) {
      return Container(
        width: w,
        height: h,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[50],
          border: Border.all(color: Colors.red[200]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            _error ?? 'os.storage.unavailable'.tr(defaultValue: 'Media unavailable'),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[600]),
          ),
        ),
      );
    }

    if (widget.type == MediaType.video) {
      return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.play_arrow, color: Colors.white, size: 24),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  'os.storage.stream_active'.tr(defaultValue: '[Storage OS HLS Stream Active]'),
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (widget.type == MediaType.image) {
      return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(Icons.image, size: 48, color: Colors.grey[400]),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'os.storage.expires'.tr(defaultValue: 'URL Expires in 5m'),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (widget.type == MediaType.pdf) {
      return Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 48),
            const SizedBox(height: 8),
            Text(
              'os.storage.secure_doc'.tr(defaultValue: 'Secure Document (Watermarked)'),
              style: TextStyle(color: Colors.grey[700], fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {},
              child: Text('os.storage.open_viewer'.tr(defaultValue: 'Open Viewer')),
            ),
          ],
        ),
      );
    }

    return const SizedBox();
  }
}
