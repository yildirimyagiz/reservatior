import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class RecordingControlsWidget extends StatefulWidget {
  final bool isRecording;
  final bool isPaused;
  final int recordingDuration;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;
  final VoidCallback onAddChapterMarker;

  const RecordingControlsWidget({
    super.key,
    required this.isRecording,
    required this.isPaused,
    required this.recordingDuration,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    required this.onAddChapterMarker,
  });

  @override
  State<RecordingControlsWidget> createState() =>
      _RecordingControlsWidgetState();
}

class _RecordingControlsWidgetState extends State<RecordingControlsWidget>
    with TickerProviderStateMixin {
  bool _isHydrated = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _isHydrated = true;

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final mins = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (!_isHydrated) {
      return _buildShimmerLoading();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          if (widget.isRecording) _buildRecordingDuration(),
          _buildControlButtons(),
          _buildHelperText(),
        ],
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingDuration() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          color: Colors.white.withOpacity(
                            _pulseAnimation.value,
                          ),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              Text(
                formatDuration(widget.recordingDuration),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.isPaused ? 'mobile.leftovers.recording_paused'.tr() : 'mobile.leftovers.recording_in_progress'.tr(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!widget.isRecording) ...[
            _buildStartRecordingButton(),
          ] else ...[
            _buildPauseResumeButton(),
            const SizedBox(width: 16),
            _buildStopRecordingButton(),
            const SizedBox(width: 16),
            _buildChapterMarkerButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildStartRecordingButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onStartRecording,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gold, AppColors.gold.withOpacity(0.8)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Icons.videocam, size: 36, color: AppColors.darkBg),
        ),
      ),
    );
  }

  Widget _buildPauseResumeButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.isPaused
            ? widget.onResumeRecording
            : widget.onPauseRecording,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            widget.isPaused ? Icons.play_arrow : Icons.pause,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildStopRecordingButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onStopRecording,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChapterMarkerButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.isPaused ? null : widget.onAddChapterMarker,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: widget.isPaused
                ? AppColors.darkSurface
                : AppColors.gold.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.isPaused
                  ? AppColors.darkBorder.withOpacity(0.3)
                  : AppColors.gold.withOpacity(0.5),
            ),
          ),
          child: Icon(
            Icons.bookmark,
            size: 28,
            color: widget.isPaused
                ? AppColors.textSecondaryDark
                : AppColors.gold,
          ),
        ),
      ),
    );
  }

  Widget _buildHelperText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          if (!widget.isRecording) ...[
            Text('mobile.auto.tap_the_record_button_to_start_your_property_walkthrough'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondaryDark,
              ),
            ),
          ] else ...[
            Text('mobile.auto.follow_the_ai_prompts_to_guide_your_recording'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildHelperItem(Icons.pause, 'Pause'),
                const SizedBox(width: 16),
                _buildHelperItem(Icons.stop, 'Stop'),
                const SizedBox(width: 16),
                _buildHelperItem(Icons.bookmark, 'mobile.leftovers.mark_chapter'.tr()),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHelperItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondaryDark),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
        ),
      ],
    );
  }
}
