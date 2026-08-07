import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DigitalTwinViewer extends StatefulWidget {
  final String modelId;
  final double? width;
  final double? height;

  const DigitalTwinViewer({
    super.key,
    required this.modelId,
    this.width,
    this.height,
  });

  @override
  State<DigitalTwinViewer> createState() => _DigitalTwinViewerState();
}

class _DigitalTwinViewerState extends State<DigitalTwinViewer> with SingleTickerProviderStateMixin {
  bool _loading = true;
  double _loadingProgress = 0;
  late AnimationController _wireframeController;

  @override
  void initState() {
    super.initState();
    _wireframeController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _simulateLoading();
  }

  void _simulateLoading() async {
    for (int i = 0; i <= 100; i += 10) {
      if (!mounted) return;
      setState(() {
        _loadingProgress = i / 100.0;
      });
      await Future.delayed(const Duration(milliseconds: 150));
    }
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _wireframeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 300,
      decoration: BoxDecoration(
        color: const Color(0xFF111827), // gray-900 equivalent
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Stack(
        children: [
          // Simulated 3D Background
          if (!_loading)
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _wireframeController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _wireframeController.value * 2 * 3.14159,
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo.withOpacity(0.5)),
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                          ),
                          itemCount: 16,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo.withOpacity(0.2)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
          if (_loading)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    'os.digital_twin.initializing'.tr(defaultValue: 'Initializing WebGL Engine...'),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'os.digital_twin.loading_geometry'.tr(defaultValue: 'Loading Model Geometry')} (${(_loadingProgress * 100).toInt()}%)',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: _loadingProgress,
                      backgroundColor: Colors.grey[800],
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
                    ),
                  ),
                ],
              ),
            ),

          if (!_loading) ...[
            // Status overlay top left
            Positioned(
              top: 16,
              left: 16,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.greenAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'os.digital_twin.connected'.tr(defaultValue: 'Digital Twin Connected'),
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${'os.digital_twin.model'.tr(defaultValue: 'Model')}: ${widget.modelId}',
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            // Zoom controls bottom right
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                children: [
                  _buildIconButton(Icons.add),
                  const SizedBox(height: 8),
                  _buildIconButton(Icons.remove),
                ],
              ),
            ),

            // Mode controls bottom left
            Positioned(
              bottom: 16,
              left: 16,
              child: Row(
                children: [
                  _buildTextButton('os.digital_twin.floorplan'.tr(defaultValue: 'Floorplan Mode')),
                  const SizedBox(width: 8),
                  _buildTextButton('os.digital_twin.measurements'.tr(defaultValue: 'Measurements')),
                ],
              ),
            ),

            // Center Text
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'os.digital_twin.canvas_simulated'.tr(defaultValue: '[WebGL Canvas Simulated]'),
                    style: TextStyle(color: Colors.indigo[300], fontSize: 12, fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'os.digital_twin.ready_threejs'.tr(defaultValue: 'Ready for Three.js / model-viewer integration'),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }

  Widget _buildTextButton(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
