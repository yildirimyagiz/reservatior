import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../presentation/guided_recording_screen.dart';

class RecordingControlsWidget extends StatelessWidget {
  final PropertySection section;
  final bool isRecording;
  final bool isRecorded;
  final bool isSkipped;
  final Animation<double> recordPulse;
  final VoidCallback onRecord;
  final VoidCallback onTips;
  final VoidCallback onChecklist;
  final VoidCallback onSkip;
  final VoidCallback onReRecord;
  final bool isTipsActive;
  final bool isChecklistActive;
  final int recordedCount;
  final int totalSections;

  const RecordingControlsWidget({
    super.key,
    required this.section,
    required this.isRecording,
    required this.isRecorded,
    required this.isSkipped,
    required this.recordPulse,
    required this.onRecord,
    required this.onTips,
    required this.onChecklist,
    required this.onSkip,
    required this.onReRecord,
    required this.isTipsActive,
    required this.isChecklistActive,
    required this.recordedCount,
    required this.totalSections,
  });

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        children: [
          // Duration target + angle hint
          if (!isRecording) _buildShootingHint(),
          const SizedBox(height: 16),
          // Main controls row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Tips + Checklist
              _buildLeftControls(),
              // Center: Record button
              _buildRecordButton(),
              // Right: Skip + Re-record
              _buildRightControls(),
            ],
          ),
          const SizedBox(height: 16),
          // Bottom strip: section completion summary
          _buildCompletionStrip(),
        ],
      ),
    );
  }

  Widget _buildShootingHint() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.glassSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.timer_outlined, size: 14, color: section.color),
              const SizedBox(width: 6),
              Text(
                section.durationTarget,
                style: GoogleFonts.sora(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: section.color,
                ),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 12, color: AppTheme.glassBorder),
              const SizedBox(width: 12),
              const Icon(
                Icons.camera_outlined,
                size: 14,
                color: AppTheme.textMuted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  section.angleAdvice,
                  style: GoogleFonts.sora(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeftControls() {
    return Column(
      children: [
        _buildControlButton(
          icon: isTipsActive
              ? Icons.lightbulb_rounded
              : Icons.lightbulb_outline_rounded,
          label: 'Tips',
          isActive: isTipsActive,
          activeColor: AppTheme.primary,
          onTap: onTips,
        ),
        const SizedBox(height: 12),
        _buildControlButton(
          icon: isChecklistActive
              ? Icons.checklist_rounded
              : Icons.checklist_outlined,
          label: 'Rooms',
          isActive: isChecklistActive,
          activeColor: AppTheme.aiAccent,
          onTap: onChecklist,
        ),
      ],
    );
  }

  Widget _buildRightControls() {
    return Column(
      children: [
        if (isRecorded)
          _buildControlButton(
            icon: Icons.replay_rounded,
            label: 'Re-record',
            isActive: false,
            activeColor: AppTheme.warning,
            onTap: onReRecord,
          )
        else
          _buildControlButton(
            icon: Icons.skip_next_rounded,
            label: 'Skip',
            isActive: isSkipped,
            activeColor: AppTheme.textMuted,
            onTap: isRecording ? null : onSkip,
          ),
        const SizedBox(height: 12),
        _buildControlButton(
          icon: Icons.flip_camera_ios_outlined,
          label: 'Flip',
          isActive: false,
          activeColor: AppTheme.textMuted,
          onTap: () {
            // TODO: Implement camera flip with camera package for production
          },
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required Color activeColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 210),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isActive
                      ? activeColor.withAlpha(40)
                      : AppTheme.glassSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isActive
                        ? activeColor.withAlpha(120)
                        : AppTheme.glassBorder,
                  ),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? activeColor
                      : onTap == null
                      ? AppTheme.textMuted.withAlpha(80)
                      : AppTheme.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.sora(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isActive ? activeColor : AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordButton() {
    return GestureDetector(
      onTap: onRecord,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulse ring when recording
          if (isRecording)
            AnimatedBuilder(
              animation: recordPulse,
              builder: (context, child) => Transform.scale(
                scale: recordPulse.value,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.error.withAlpha(100),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          // Button background ring
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isRecording
                    ? AppTheme.error
                    : Colors.white.withAlpha(180),
                width: 3,
              ),
            ),
          ),
          // Inner button
          AnimatedContainer(
            duration: const Duration(milliseconds: 210),
            width: isRecording ? 32 : 60,
            height: isRecording ? 32 : 60,
            decoration: BoxDecoration(
              color: isRecording ? AppTheme.error : Colors.white,
              borderRadius: BorderRadius.circular(isRecording ? 8 : 30),
            ),
          ),
          // Recorded check overlay
          if (isRecorded && !isRecording)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.success.withAlpha(200),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompletionStrip() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.glassSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.glassBorder),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.videocam_rounded,
                size: 14,
                color: AppTheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '$recordedCount of $totalSections sections recorded',
                style: GoogleFonts.sora(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
              const Spacer(),
              if (recordedCount == totalSections)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.successMuted,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.success.withAlpha(60)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome_rounded,
                        size: 12,
                        color: AppTheme.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Generate Video',
                        style: GoogleFonts.sora(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.success,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  '${totalSections - recordedCount} remaining',
                  style: GoogleFonts.sora(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textMuted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
