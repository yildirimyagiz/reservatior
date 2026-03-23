import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../presentation/guided_recording_screen.dart';

class RecordingSectionChecklistWidget extends StatelessWidget {
  final List<PropertySection> sections;
  final int currentIndex;
  final Set<int> recordedSections;
  final Set<int> skippedSections;
  final ValueChanged<int> onSectionTap;
  final VoidCallback onClose;

  const RecordingSectionChecklistWidget({
    super.key,
    required this.sections,
    required this.currentIndex,
    required this.recordedSections,
    required this.skippedSections,
    required this.onSectionTap,
    required this.onClose,
  });

  
  Widget build(BuildContext context) {
    final recordedCount = recordedSections.length;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: AppTheme.background.withAlpha(225),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: const Border(
              top: BorderSide(color: AppTheme.glassBorder, width: 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(),
              _buildHeader(recordedCount),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: sections.length,
                  itemBuilder: (context, i) => _buildSectionItem(context, i),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppTheme.glassBorder,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(int recordedCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Section Checklist',
                style: GoogleFonts.sora(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '$recordedCount of ${sections.length} sections recorded',
                style: GoogleFonts.sora(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Mini progress ring
          SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: recordedCount / sections.length,
                  backgroundColor: AppTheme.surfaceVariant,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppTheme.primary,
                  ),
                  strokeWidth: 3,
                ),
                Text(
                  '${((recordedCount / sections.length) * 100).toInt()}%',
                  style: GoogleFonts.sora(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppTheme.glassSurface,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: AppTheme.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionItem(BuildContext context, int i) {
    final section = sections[i];
    final isRecorded = recordedSections.contains(i);
    final isSkipped = skippedSections.contains(i);
    final isCurrent = i == currentIndex;

    Color statusColor;
    IconData statusIcon;
    String statusLabel;

    if (isRecorded) {
      statusColor = AppTheme.success;
      statusIcon = Icons.check_circle_rounded;
      statusLabel = 'Recorded';
    } else if (isSkipped) {
      statusColor = AppTheme.textMuted;
      statusIcon = Icons.skip_next_rounded;
      statusLabel = 'Skipped';
    } else if (isCurrent) {
      statusColor = AppTheme.primary;
      statusIcon = Icons.radio_button_checked_rounded;
      statusLabel = 'Current';
    } else {
      statusColor = AppTheme.surfaceVariant;
      statusIcon = Icons.radio_button_unchecked_rounded;
      statusLabel = 'Pending';
    }

    return GestureDetector(
      onTap: () => onSectionTap(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 210),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isCurrent
              ? AppTheme.primary.withAlpha(15)
              : AppTheme.glassSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isCurrent
                ? AppTheme.primary.withAlpha(80)
                : isRecorded
                ? AppTheme.success.withAlpha(40)
                : AppTheme.glassBorder,
            width: isCurrent ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: section.color.withAlpha(25),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(section.icon, size: 16, color: section.color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.name,
                    style: GoogleFonts.sora(
                      fontSize: 13,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isCurrent
                          ? AppTheme.textPrimary
                          : isRecorded
                          ? AppTheme.textSecondary
                          : AppTheme.textSecondary,
                    ),
                  ),
                  Text(
                    section.nameLocal,
                    style: GoogleFonts.sora(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(statusIcon, size: 18, color: statusColor),
                const SizedBox(height: 2),
                Text(
                  statusLabel,
                  style: GoogleFonts.sora(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
