
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './camera_mobile_widget.dart';
import './camera_web_widget.dart';

// ignore: avoid_web_libraries_in_flutter

// Web-only imports
// ignore: uri_does_not_exist

class RecordingCameraWidget extends StatelessWidget {
  final bool isRecording;

  const RecordingCameraWidget({super.key, required this.isRecording});

  
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: kIsWeb ? const WebCameraView() : const MobileCameraView(),
    );
  }
}
