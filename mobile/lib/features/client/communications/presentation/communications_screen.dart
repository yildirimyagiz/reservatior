import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/communication_log.dart';
import 'package:reservatior/shared/models/communication_template.dart';
import 'package:reservatior/shared/providers/communication_log_provider.dart';
import 'package:reservatior/shared/providers/communication_template_provider.dart';

class CommunicationsScreen extends ConsumerStatefulWidget {
  final int initialTab;
  const CommunicationsScreen({super.key, this.initialTab = 0});

  @override
  ConsumerState<CommunicationsScreen> createState() =>
      _CommunicationsScreenState();
}

class _CommunicationsScreenState extends ConsumerState<CommunicationsScreen> {
  late int _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Communications',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Templates'),
                    icon: Icon(Icons.library_books),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Logs'),
                    icon: Icon(Icons.forum_outlined),
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (s) => setState(() => _tab = s.first),
                style: SegmentedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  foregroundColor: Colors.white70,
                  selectedBackgroundColor: AppColors.primary,
                  selectedForegroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          if (_tab == 0) const _TemplatesPanel() else const _LogsPanel(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _TemplatesPanel extends ConsumerWidget {
  const _TemplatesPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTemplates = ref.watch(communicationTemplateListProvider);

    return asyncTemplates.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load templates'),
      ),
      data: (templates) {
        if (templates.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.library_books,
              title: 'No templates yet',
              subtitle: 'Reusable messages will appear here',
            ),
          );
        }
        final active = templates.where((t) => t.isActive).length;
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline,
                        color: AppColors.success, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$active of ${templates.length} templates active',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < templates.length; i++)
                _TemplateTile(template: templates[i])
                    .animate()
                    .fadeIn(delay: (40 * i).ms),
            ]),
          ),
        );
      },
    );
  }
}

class _TemplateTile extends StatelessWidget {
  final CommunicationTemplate template;
  const _TemplateTile({required this.template});

  @override
  Widget build(BuildContext context) {
    final body = template.subject ?? template.title ?? template.name;
    final channels = template.channels.isEmpty
        ? template.templateType
        : template.channels.join(', ');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: template.isActive
              ? AppColors.darkBorder
              : AppColors.darkBorder.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (template.isActive ? AppColors.success : Colors.white10)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              template.isActive ? Icons.mail_outline : Icons.visibility_off,
              color:
                  template.isActive ? AppColors.success : Colors.white38,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$channels · ${template.templateType}'
                  '${template.category != null ? ' · ${template.category}' : ''}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          if (template.isActive)
            Icon(Icons.check_circle, size: 18, color: AppColors.success)
          else
            Text(
              'INACTIVE',
              style: GoogleFonts.outfit(
                  color: Colors.white38, fontSize: 10),
            ),
        ],
      ),
    );
  }
}

class _LogsPanel extends ConsumerWidget {
  const _LogsPanel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLogs = ref.watch(communicationLogListProvider);

    return asyncLogs.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: _CenteredMessage(icon: Icons.cloud_off, title: 'Could not load logs'),
      ),
      data: (logs) {
        if (logs.isEmpty) {
          return const SliverFillRemaining(
            child: _CenteredMessage(
              icon: Icons.forum_outlined,
              title: 'No messages yet',
              subtitle: 'Sent communications will appear here',
            ),
          );
        }
        final sorted = [...logs]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _LogTile(log: sorted[index])
                  .animate()
                  .fadeIn(delay: (40 * index).ms),
              childCount: sorted.length,
            ),
          ),
        );
      },
    );
  }
}

class _LogTile extends StatelessWidget {
  final CommunicationLog log;
  const _LogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.chat_bubble_outline,
                color: AppColors.info, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        log.type.name,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (!log.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  log.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white54,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  log.channel?.name ??
                      '${DateFormat.yMMMd().add_Hm().format(log.timestamp)}'
                      '${log.entityType != null ? ' · ${log.entityType}' : ''}',
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _CenteredMessage({
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white38, size: 40),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                )),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                      color: Colors.white38, fontSize: 12)),
            ],
          ],
        ),
      ),
    );
  }
}
