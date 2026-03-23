import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';

/// Mobile camera view — uses camera package in production.
/// TODO: Replace with CameraPreview(controller) using camera ^0.10.5+5 for production.
/// Requires: permission_handler ^11.1.0, camera ^0.10.5+5
/// AndroidManifest: CAMERA Permission
/// Info.plist: NSCameraUsageDescription
class MobileCameraView extends StatelessWidget {
  const MobileCameraView({super.key});

  
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D0D0D),
      child: Stack(
        children: [
          // Simulated camera viewfinder grid
          CustomPaint(painter: _ViewfinderGridPainter(), child: Container()),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.videocam_rounded,
                  color: AppTheme.textMuted,
                  size: 48,
                ),
                const SizedBox(height: 12),
                Text(
                  'Camera Preview',
                  style: GoogleFonts.sora(
                    fontSize: 14,
                    color: AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Connect camera package for live preview',
                  style: GoogleFonts.sora(
                    fontSize: 11,
                    color: AppTheme.textMuted.withAlpha(150),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewfinderGridPainter extends CustomPainter {
  
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..strokeWidth = 1;

    // Rule of thirds grid
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 2 / 3, 0),
      Offset(size.width * 2 / 3, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 2 / 3),
      Offset(size.width, size.height * 2 / 3),
      paint,
    );
  }

  
  bool shouldRepaint(_ViewfinderGridPainter old) => false;
}
