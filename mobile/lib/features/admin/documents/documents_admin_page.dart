import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/document_provider.dart';

class DocumentsAdminPage extends ConsumerWidget {
  const DocumentsAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.04),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                floating: true,
                pinned: true,
                backgroundColor: AppColors.darkBg.withOpacity(0.8),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'mobile.auto.admin_documents_filesystem'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                          letterSpacing: 2,
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                      Text(
                        'mobile.auto.admin_documents_title'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: ref
                      .watch(documentListProvider)
                      .when(
                        data: (docs) {
                          if (docs.isEmpty) {
                            return Center(
                              child: Text(
                                'mobile.auto.admin_documents_empty'.tr(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: docs.length,
                            itemBuilder: (context, index) {
                              final d = docs[index];
                              return Card(
                                    color: Colors.white.withOpacity(0.05),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blueAccent
                                            .withOpacity(0.15),
                                        child: Icon(
                                          _getDocIcon(d.fileUrl),
                                          color: Colors.blueAccent,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        d.title,
                                        style: GoogleFonts.outfit(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        d.description ??
                                            d.fileUrl.split('/').last,
                                        style: GoogleFonts.outfit(
                                          color: Colors.blueAccent,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: const Icon(
                                        Icons.download_rounded,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(delay: (100 * index).ms)
                                  .slideX(begin: 0.1);
                            },
                          );
                        },
                        loading: () => Center(
                          child: Text(
                            'mobile.auto.admin_documents_loading'.tr(),
                            style: GoogleFonts.outfit(color: Colors.white54),
                          ).animate().shimmer(duration: 2.seconds),
                        ),
                        error: (err, _) => Center(
                          child: Text(
                            '${'admin.error.connection'.tr()}: $err',
                            style: GoogleFonts.outfit(color: Colors.redAccent),
                          ),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
        child: const Icon(Icons.upload_file, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }

  IconData _getDocIcon(String url) {
    if (url.endsWith('.pdf')) return Icons.picture_as_pdf;
    if (url.endsWith('.doc') || url.endsWith('.docx')) return Icons.description;
    if (url.endsWith('.xls') || url.endsWith('.xlsx')) return Icons.table_chart;
    if (url.endsWith('.jpg') || url.endsWith('.png')) return Icons.image;
    return Icons.insert_drive_file;
  }
}
