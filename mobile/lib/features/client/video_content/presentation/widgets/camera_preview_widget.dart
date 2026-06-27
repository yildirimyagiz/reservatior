import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class CameraPreviewWidget extends StatefulWidget {
  final bool isRecording;
  final bool isPaused;
  final Function(CameraController?) onCameraReady;
  final bool showBlurring;
  final String videoQuality;

  const CameraPreviewWidget({
    super.key,
    required this.isRecording,
    required this.isPaused,
    required this.onCameraReady,
    required this.showBlurring,
    required this.videoQuality,
  });

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _isHydrated = false;
  CameraPermissionStatus _cameraPermission = CameraPermissionStatus.prompt;
  LightingQuality _lightingQuality = LightingQuality.good;
  bool _framingGuide = true;
  CameraController? _cameraController;
  Timer? _lightingDetectionTimer;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isHydrated = true;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pulseController.dispose();
    _lightingDetectionTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    if (!_isHydrated) return;

    try {
      // Check camera permission
      final cameraPermission = await Permission.camera.request();
      final microphonePermission = await Permission.microphone.request();

      if (cameraPermission.isGranted && microphonePermission.isGranted) {
        setState(() {
          _cameraPermission = CameraPermissionStatus.granted;
        });

        // Get available cameras
        final cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          // Get video quality settings
          final resolution = _getVideoResolution();

          // Initialize camera controller
          _cameraController = CameraController(
            cameras[0], // Use back camera
            ResolutionPreset.high,
            enableAudio: true,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );

          await _cameraController!.initialize();

          if (mounted) {
            setState(() {});
            widget.onCameraReady(_cameraController);

            // Start lighting quality detection simulation
            _startLightingDetection();
          }
        }
      } else {
        setState(() {
          _cameraPermission = CameraPermissionStatus.denied;
        });
        widget.onCameraReady(null);
      }
    } catch (e) {
      setState(() {
        _cameraPermission = CameraPermissionStatus.denied;
      });
      widget.onCameraReady(null);
    }
  }

  ResolutionPreset _getVideoResolution() {
    switch (widget.videoQuality) {
      case 'high':
        return ResolutionPreset.high;
      case 'medium':
        return ResolutionPreset.medium;
      case 'low':
        return ResolutionPreset.low;
      default:
        return ResolutionPreset.high;
    }
  }

  void _startLightingDetection() {
    _lightingDetectionTimer = Timer.periodic(const Duration(seconds: 5), (
      timer,
    ) {
      if (mounted) {
        final qualities = [
          LightingQuality.good,
          LightingQuality.fair,
          LightingQuality.poor,
        ];
        setState(() {
          _lightingQuality =
              qualities[(DateTime.now().millisecond) % qualities.length];
        });
      }
    });
  }

  void _requestCameraPermission() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    _initializeCamera();
  }

  void _toggleFramingGuide() {
    setState(() {
      _framingGuide = !_framingGuide;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return _buildLoadingState();
    }

    if (_cameraPermission == CameraPermissionStatus.denied) {
      return _buildPermissionDenied();
    }

    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return _buildLoadingState();
    }

    return _buildCameraPreview();
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videocam_outlined,
              size: 48,
              color: AppColors.textSecondaryDark,
            ),
            SizedBox(height: 16),
            Text('mobile.auto.loading_camera'.tr(),
              style: TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDenied() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_outlined,
                size: 48,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              Text('mobile.auto.camera_access_required'.tr(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryDark,
                ),
              ),
              SizedBox(height: 8),
              Text('mobile.auto.please_allow_camera_and_microphone_access_to_record_your_property_walkthrough'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondaryDark,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _requestCameraPermission,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('mobile.auto.grant_access'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBg,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Camera preview
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _cameraController!.value.previewSize!.height,
                  height: _cameraController!.value.previewSize!.width,
                  child: CameraPreview(_cameraController!),
                ),
              ),
            ),

            // Framing guide overlay
            if (_framingGuide) _buildFramingGuide(),

            // Recording indicator
            if (widget.isRecording && !widget.isPaused)
              _buildRecordingIndicator(),

            // Paused indicator
            if (widget.isRecording && widget.isPaused) _buildPausedIndicator(),

            // Lighting quality indicator
            _buildLightingIndicator(),

            // Blurring indicator
            if (widget.showBlurring) _buildBlurringIndicator(),

            // Framing guide toggle button
            _buildFramingGuideToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildFramingGuide() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          margin: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Stack(
            children: [
              // Horizontal lines
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.33 - 32,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.66 - 32,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              // Vertical lines
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.33 - 32,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.66 - 32,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 1,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    return Positioned(
      top: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(_pulseAnimation.value),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(width: 8),
            Text('mobile.auto.rec'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPausedIndicator() {
    return Positioned(
      top: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.pause, size: 16, color: Colors.white),
            SizedBox(width: 8),
            Text('mobile.auto.paused'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLightingIndicator() {
    Color iconColor;
    switch (_lightingQuality) {
      case LightingQuality.good:
        iconColor = Colors.green;
        break;
      case LightingQuality.fair:
        iconColor = Colors.orange;
        break;
      case LightingQuality.poor:
        iconColor = Colors.red;
        break;
    }

    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wb_sunny, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Text(
              '${_lightingQuality.name} Light',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurringIndicator() {
    return Positioned(
      bottom: 16,
      left: 16,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.visibility_off, size: 16, color: AppColors.gold),
            SizedBox(width: 8),
            Text('mobile.auto.auto_blur_active'.tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFramingGuideToggle() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleFramingGuide,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.darkCard.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.center_focus_strong,
              size: 20,
              color: _framingGuide
                  ? AppColors.gold
                  : AppColors.textSecondaryDark,
            ),
          ),
        ),
      ),
    );
  }
}

enum CameraPermissionStatus { granted, denied, prompt }

enum LightingQuality { good, fair, poor }
