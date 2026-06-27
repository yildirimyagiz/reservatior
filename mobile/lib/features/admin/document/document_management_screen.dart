import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/providers/admin/document_provider.dart';

class DocumentManagementScreen extends ConsumerWidget {
  const DocumentManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docsAsync = ref.watch(adminDocumentsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding:  EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'mobile.admin.document.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          docsAsync.when(
            loading: () =>  SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              ),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text('admin.common.error_prefix'.tr() + err.toString(),
                  style:  TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
            data: (docs) {
              if (docs.isEmpty) {
                return  SliverFillRemaining(
                  child: Center(
                    child: Text('admin.common.no_documents'.tr(),
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                );
              }
              return SliverPadding(
                padding:  EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final doc = docs[index];
                    return Container(
                          margin:  EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: const Icon(
                              Icons.description,
                              color: Colors.blueAccent,
                              size: 32,
                            ),
                            title: Text(
                              doc.title,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 SizedBox(height: 4),
                                Text('admin.common.type_prefix'.tr() + doc.documentType.name,
                                  style:  TextStyle(color: Colors.white70),
                                ),
                                 SizedBox(height: 4),
                                Text('admin.common.size_prefix'.tr() + doc.fileSize.toString() + ' bytes',
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.download,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: Duration(milliseconds: 50 * index))
                        .slideX();
                  }, childCount: docs.length),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
