import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class CommunicationCenterScreen extends ConsumerStatefulWidget {
  const CommunicationCenterScreen({super.key});
  @override
  ConsumerState<CommunicationCenterScreen> createState() =>
      _CommunicationCenterScreenState();
}

class _CommunicationCenterScreenState
    extends ConsumerState<CommunicationCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text(
          'mobile.communication.title'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          tabs: [
            Tab(text: 'mobile.communication.tabLogs'.tr()),
            Tab(text: 'mobile.communication.tabTemplates'.tr()),
            Tab(text: 'mobile.communication.tabChannels'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLogs(colors),
          _buildTemplates(colors),
          _buildChannels(colors),
        ],
      ),
    );
  }

  Widget _buildLogs(ThemeAwareColors colors) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _logs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) =>
          Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (_logs[i]['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _logs[i]['icon'] as IconData,
                        color: _logs[i]['color'] as Color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _logs[i]['title'] as String,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _logs[i]['desc'] as String,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _logs[i]['time'] as String,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 60 * i))
              .slideX(begin: 0.03),
    );
  }

  Widget _buildTemplates(ThemeAwareColors colors) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _templates.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) =>
          Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.article_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _templates[i]['name'] as String,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _templates[i]['type'] as String,
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _templates[i]['preview'] as String,
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 60 * i))
              .slideX(begin: 0.03),
    );
  }

  Widget _buildChannels(ThemeAwareColors colors) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _channels.asMap().entries.map((e) {
        final ch = e.value;
        return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (ch['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      ch['icon'] as IconData,
                      color: ch['color'] as Color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ch['name'] as String,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          ch['desc'] as String,
                          style: TextStyle(
                            color: colors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: ch['active'] as bool,
                    onChanged: (_) {},
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 60 * e.key))
            .slideX(begin: 0.03);
      }).toList(),
    );
  }

  static final _logs = [
    {
      'title': 'mobile.communication.log1Title'.tr(),
      'desc': 'mobile.communication.log1Desc'.tr(),
      'time': 'mobile.communication.time2h'.tr(),
      'icon': Icons.email_outlined,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.communication.log2Title'.tr(),
      'desc': 'mobile.communication.log2Desc'.tr(),
      'time': 'mobile.communication.time5h'.tr(),
      'icon': Icons.sms_outlined,
      'color': Colors.green,
    },
    {
      'title': 'mobile.communication.log3Title'.tr(),
      'desc': 'mobile.communication.log3Desc'.tr(),
      'time': 'mobile.communication.time1d'.tr(),
      'icon': Icons.phone_outlined,
      'color': Colors.orange,
    },
    {
      'title': 'mobile.communication.log4Title'.tr(),
      'desc': 'mobile.communication.log4Desc'.tr(),
      'time': 'mobile.communication.time2d'.tr(),
      'icon': Icons.chat_outlined,
      'color': Colors.teal,
    },
  ];
  static final _templates = [
    {
      'name': 'mobile.communication.tpl1Name'.tr(),
      'type': 'mobile.communication.tpl1Type'.tr(),
      'preview': 'mobile.communication.tpl1Preview'.tr(),
    },
    {
      'name': 'mobile.communication.tpl2Name'.tr(),
      'type': 'mobile.communication.tpl2Type'.tr(),
      'preview': 'mobile.communication.tpl2Preview'.tr(),
    },
    {
      'name': 'mobile.communication.tpl3Name'.tr(),
      'type': 'mobile.communication.tpl3Type'.tr(),
      'preview': 'mobile.communication.tpl3Preview'.tr(),
    },
    {
      'name': 'mobile.communication.tpl4Name'.tr(),
      'type': 'mobile.communication.tpl4Type'.tr(),
      'preview': 'mobile.communication.tpl4Preview'.tr(),
    },
  ];
  static final _channels = [
    {
      'name': 'mobile.communication.ch1Name'.tr(),
      'desc': 'mobile.communication.ch1Desc'.tr(),
      'icon': Icons.email_rounded,
      'color': Colors.blue,
      'active': true,
    },
    {
      'name': 'mobile.communication.ch2Name'.tr(),
      'desc': 'mobile.communication.ch2Desc'.tr(),
      'icon': Icons.sms_rounded,
      'color': Colors.green,
      'active': true,
    },
    {
      'name': 'mobile.communication.ch3Name'.tr(),
      'desc': 'mobile.communication.ch3Desc'.tr(),
      'icon': Icons.notifications_rounded,
      'color': Colors.orange,
      'active': true,
    },
    {
      'name': 'mobile.communication.ch4Name'.tr(),
      'desc': 'mobile.communication.ch4Desc'.tr(),
      'icon': Icons.chat_rounded,
      'color': Colors.teal,
      'active': false,
    },
  ];
}
