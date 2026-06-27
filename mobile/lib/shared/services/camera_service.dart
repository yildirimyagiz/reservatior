import 'package:camera/camera.dart';
import 'package:logger/logger.dart';

class CameraService {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  final Logger _logger = Logger();

  Future<void> initialize() async {
    try {
      _cameras = await availableCameras();
    } catch (e) {
      _logger.e('Error getting cameras: $e');
    }
  }

  Future<CameraController?> getController() async {
    if (_cameras.isEmpty) {
      await initialize();
    }
    if (_cameras.isEmpty) return null;

    if (_controller != null) return _controller;

    _controller = CameraController(
      _cameras[0],
      ResolutionPreset.high,
      enableAudio: true,
    );

    try {
      await _controller!.initialize();
    } catch (e) {
      _logger.e('Error initializing camera controller: $e');
      return null;
    }

    return _controller;
  }

  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return null;
    try {
      return await _controller!.takePicture();
    } catch (e) {
      _logger.e('Error taking picture: $e');
      return null;
    }
  }

  Future<void> startVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    try {
      await _controller!.startVideoRecording();
    } catch (e) {
      _logger.e('Error starting video recording: $e');
    }
  }

  Future<XFile?> stopVideoRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return null;
    try {
      return await _controller!.stopVideoRecording();
    } catch (e) {
      _logger.e('Error stopping video recording: $e');
      return null;
    }
  }

  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
