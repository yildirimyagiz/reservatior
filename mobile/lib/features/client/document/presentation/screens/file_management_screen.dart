import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class FileManagementScreen extends ConsumerStatefulWidget {
  const FileManagementScreen({super.key});
  @override
  ConsumerState<FileManagementScreen> createState() =>
      _FileManagementScreenState();
}

class _FileManagementScreenState extends ConsumerState<FileManagementScreen> {
  String _viewMode = 'list';
  String _filter = 'all';

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final filtered = _filter == 'all'
        ? _files
        : _files.where((f) => f['type'] == _filter).toList();
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.files'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _viewMode == 'list'
                  ? Icons.grid_view_rounded
                  : Icons.list_rounded,
              color: colors.textSecondary,
            ),
            onPressed: () => setState(
              () => _viewMode = _viewMode == 'list' ? 'grid' : 'list',
            ),
          ),
          IconButton(
            icon: Icon(Icons.upload_file_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final f in ['all', 'pdf', 'image', 'doc', 'video'])
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(f == 'all' ? 'All' : f.toUpperCase()),
                      selected: _filter == f,
                      onSelected: (_) => setState(() => _filter = f),
                      selectedColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: _filter == f
                            ? Colors.white
                            : colors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: colors.card,
                      side: BorderSide(color: colors.border),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filtered.length} files',
                  style: TextStyle(color: colors.textSecondary, fontSize: 13),
                ),
                Text('mobile.auto.2_4_gb_used'.tr(),
                  style: TextStyle(color: colors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: _viewMode == 'list'
                ? _buildListView(filtered, colors)
                : _buildGridView(filtered, colors),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(
    List<Map<String, dynamic>> files,
    ThemeAwareColors colors,
  ) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: files.length,
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemBuilder: (_, i) => _buildFileRow(files[i], colors, i),
    );
  }

  Widget _buildGridView(
    List<Map<String, dynamic>> files,
    ThemeAwareColors colors,
  ) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: files.length,
      itemBuilder: (_, i) => _buildFileGridCard(files[i], colors, i),
    );
  }

  Widget _buildFileRow(
    Map<String, dynamic> file,
    ThemeAwareColors colors,
    int index,
  ) {
    return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (file['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  file['icon'] as IconData,
                  color: file['color'] as Color,
                  size: 22,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file['name'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${file['size']} • ${file['date']}',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: colors.textSecondary,
                  size: 20,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(child: Text('mobile.auto.download'.tr())),
                  PopupMenuItem(child: Text('mobile.auto.share'.tr())),
                  PopupMenuItem(child: Text('mobile.auto.delete'.tr())),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 50 * index))
        .slideX(begin: 0.03);
  }

  Widget _buildFileGridCard(
    Map<String, dynamic> file,
    ThemeAwareColors colors,
    int index,
  ) {
    return Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: (file['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  file['icon'] as IconData,
                  color: file['color'] as Color,
                  size: 28,
                ),
              ),
              SizedBox(height: 10),
              Text(
                file['name'] as String,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: colors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                file['size'] as String,
                style: TextStyle(color: colors.textSecondary, fontSize: 10),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 60 * index))
        .scale(begin: const Offset(0.95, 0.95));
  }

  static final _files = [
    {
      'name': 'mobile.leftovers.property_deed_45park_pdf'.tr(),
      'type': 'pdf',
      'size': 'mobile.leftovers.2_4_mb'.tr(),
      'date': 'mobile.leftovers.apr_1'.tr(),
      'icon': Icons.picture_as_pdf_rounded,
      'color': Colors.red,
    },
    {
      'name': 'mobile.leftovers.apartment_photos_zip'.tr(),
      'type': 'image',
      'size': 'mobile.leftovers.45_mb'.tr(),
      'date': 'mobile.leftovers.mar_28'.tr(),
      'icon': Icons.image_rounded,
      'color': Colors.blue,
    },
    {
      'name': 'mobile.leftovers.lease_agreement_v2_docx'.tr(),
      'type': 'doc',
      'size': 'mobile.leftovers.1_1_mb'.tr(),
      'date': 'mobile.leftovers.mar_25'.tr(),
      'icon': Icons.description_rounded,
      'color': Colors.indigo,
    },
    {
      'name': 'mobile.leftovers.property_tour_mp4'.tr(),
      'type': 'video',
      'size': 'mobile.leftovers.120_mb'.tr(),
      'date': 'mobile.leftovers.mar_22'.tr(),
      'icon': Icons.videocam_rounded,
      'color': Colors.purple,
    },
    {
      'name': 'mobile.leftovers.floor_plan_blueprint_pdf'.tr(),
      'type': 'pdf',
      'size': 'mobile.leftovers.5_6_mb'.tr(),
      'date': 'mobile.leftovers.mar_20'.tr(),
      'icon': Icons.picture_as_pdf_rounded,
      'color': Colors.red,
    },
    {
      'name': 'mobile.leftovers.client_contract_pdf'.tr(),
      'type': 'pdf',
      'size': 'mobile.leftovers.890_kb'.tr(),
      'date': 'mobile.leftovers.mar_18'.tr(),
      'icon': Icons.picture_as_pdf_rounded,
      'color': Colors.red,
    },
    {
      'name': 'mobile.leftovers.marketing_brochure_pdf'.tr(),
      'type': 'doc',
      'size': 'mobile.leftovers.3_2_mb'.tr(),
      'date': 'mobile.leftovers.mar_15'.tr(),
      'icon': Icons.description_rounded,
      'color': Colors.indigo,
    },
    {
      'name': 'mobile.leftovers.interior_3d_render_png'.tr(),
      'type': 'image',
      'size': 'mobile.leftovers.8_5_mb'.tr(),
      'date': 'mobile.leftovers.mar_12'.tr(),
      'icon': Icons.image_rounded,
      'color': Colors.blue,
    },
  ];
}
