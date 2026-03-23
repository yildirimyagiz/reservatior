import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../presentation/guided_recording_screen.dart';

class RecordingSectionHeaderWidget extends StatelessWidget {
  final PropertySection section;
  final int currentIndex;
  final int totalSections;
  final bool isRecording;
  final String recordingTimer;
  final String listingTitle;
  final VoidCallback onBack;
  final VoidCallback onNavigatePrev;
  final VoidCallback onNavigateNext;

  const RecordingSectionHeaderWidget({
    super.key,
    required this.section,
    required this.currentIndex,
    required this.totalSections,
    required this.isRecording,
    required this.recordingTimer,
    required this.listingTitle,
    required this.onBack,
    required this.onNavigatePrev,
    required this.onNavigateNext,
  });

  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildGlassButton(
                icon: Icons.arrow_back_ios_rounded,
                onTap: onBack,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listingTitle,
                      style: GoogleFonts.sora(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: section.color.withAlpha(40),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            section.icon,
                            size: 11,
                            color: section.color,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          section.name,
                          style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          section.nameLocal,
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isRecording) _buildRecordingTimer() else _buildSectionNav(),
            ],
          ),
          const SizedBox(height: 12),
          _buildProgressBar(),
        ],
      ),
    );
  }

  Widget _buildGlassButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppTheme.glassSurface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.glassBorder),
            ),
            child: Icon(icon, size: 16, color: AppTheme.textPrimary),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingTimer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.error.withAlpha(40),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.error.withAlpha(80)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTheme.error,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                recordingTimer,
                style: GoogleFonts.sora(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.error,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionNav() {
    return Row(
      children: [
        _buildNavArrow(
          icon: Icons.chevron_left_rounded,
          enabled: currentIndex > 0,
          onTap: onNavigatePrev,
        ),
        const SizedBox(width: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.glassSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Text(
                '${currentIndex + 1}/$totalSections',
                style: GoogleFonts.sora(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        _buildNavArrow(
          icon: Icons.chevron_right_rounded,
          enabled: currentIndex < totalSections - 1,
          onTap: onNavigateNext,
        ),
      ],
    );
  }

  Widget _buildNavArrow({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.glassSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.glassBorder),
            ),
            child: Icon(
              icon,
              size: 18,
              color: enabled
                  ? AppTheme.textPrimary
                  : AppTheme.textMuted.withAlpha(80),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: LinearProgressIndicator(
        value: (currentIndex + 1) / totalSections,
        backgroundColor: Colors.white.withAlpha(30),
        valueColor: AlwaysStoppedAnimation<Color>(section.color),
        minHeight: 3,
      ),
    );
  }
}
