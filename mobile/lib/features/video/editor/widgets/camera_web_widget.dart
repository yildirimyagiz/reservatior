import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import '../../../../core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class WebCameraView extends StatefulWidget {
  const WebCameraView({super.key});

  
  State<WebCameraView> createState() => _WebCameraViewState();
}

class _WebCameraViewState extends State<WebCameraView> {
  bool _hasPermission = false;
  bool _isInitializing = true;
  String? _errorMessage;
  html.VideoElement? _videoElement;
  static const String _viewId = 'propfilm-camera-view';
  bool _viewRegistered = false;

  
  void initState() {
    super.initState();
    _initWebCamera();
  }

  Future<void> _initWebCamera() async {
    try {
      final stream = await html.window.navigator.mediaDevices?.getUserMedia({
        'video': {
          'facingMode': 'environment',
          'width': {'ideal': 1920},
          'height': {'ideal': 1080},
        },
        'audio': true,
      });

      if (stream == null) {
        setState(() {
          _isInitializing = false;
          _errorMessage =
              'Camera stream unavailable. Check browser permissions.';
        });
        return;
      }

      _videoElement = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..srcObject = stream;

      if (!_viewRegistered) {
        _viewRegistered = true;
        // ignore: undefined_prefixed_name
        ui_web.platformViewRegistry.registerViewFactory(
          _viewId,
          (int viewId) => _videoElement!,
        );
      }

      setState(() {
        _hasPermission = true;
        _isInitializing = false;
      });
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _errorMessage =
            'Camera access denied. Please allow camera Permission in your browser and retry.';
      });
    }
  }

  
  void dispose() {
    _videoElement?.srcObject?.getTracks().forEach((track) => track.stop());
    super.dispose();
  }

  
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return _buildInitializing();
    }
    if (!_hasPermission || _errorMessage != null) {
      return _buildPermissionError();
    }
    return const HtmlElementView(viewType: 'propfilm-camera-view');
  }

  Widget _buildInitializing() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppTheme.primary,
              strokeWidth: 2,
            ),
            const SizedBox(height: 16),
            Text(
              'Initializing camera…',
              style: GoogleFonts.sora(
                fontSize: 13,
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionError() {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppTheme.errorMuted,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.videocam_off_rounded,
                color: AppTheme.error,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Camera Unavailable',
              style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ??
                  'Allow camera access in your browser to start recording.',
              style: GoogleFonts.sora(
                fontSize: 12,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isInitializing = true;
                  _errorMessage = null;
                  _hasPermission = false;
                });
                _initWebCamera();
              },
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
