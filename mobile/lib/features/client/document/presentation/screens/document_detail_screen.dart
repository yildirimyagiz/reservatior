import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/providers/document_analysis_provider.dart';

class DocumentDetailScreen extends ConsumerWidget {
  final DocumentAnalysis analysis;
  const DocumentDetailScreen({super.key, required this.analysis});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(
      documentAnalysisJobStatusProvider(analysis.id ?? 'pending'),
    );

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Text(
          analysis.id,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfidenceCard(),
            const SizedBox(height: 32),
            _buildExtractedContent(),
            const SizedBox(height: 32),
            _buildJobStatusTracker(status),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildConfidenceCard() {
    final isHigh = (analysis.confidence ?? 0) > 0.8;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isHigh
            ? AppColors.success.withOpacity(0.05)
            : AppColors.warning.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHigh
              ? AppColors.success.withOpacity(0.2)
              : AppColors.warning.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isHigh ? Icons.verified_user : Icons.warning_amber_rounded,
            size: 32,
            color: isHigh ? AppColors.success : AppColors.warning,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.ai_confidence'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w900,
                    color: Colors.white38,
                  ),
                ),
                Text(
                  '${((analysis.confidence ?? 0) * 100).toStringAsFixed(1)}%',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isHigh ? AppColors.success : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildExtractedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.extracted_insights'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Text(
            analysis.id ??
                'mobile.leftovers.no_significant_text_extracted_from_this'.tr(),
            style: const TextStyle(
              color: AppColors.textPrimaryDark,
              height: 1.6,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobStatusTracker(AsyncValue<Map<String, dynamic>> status) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.ai_processing_cycle'.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        status.when(
          data: (data) => _buildStatusChip(data['status'] ?? 'Completed'),
          loading: () => const CircularProgressIndicator(
            color: AppColors.gold,
            strokeWidth: 2,
          ),
          error: (_, __) => _buildStatusChip('Completed'), // Fallback
        ),
      ],
    );
  }

  Widget _buildStatusChip(String val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sync_alt, color: AppColors.primary, size: 16),
          const SizedBox(width: 12),
          Text(
            val.toUpperCase(),
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
