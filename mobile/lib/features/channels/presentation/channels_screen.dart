import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/enums/channel_category.dart';
import 'package:reservatior/shared/enums/channel_type.dart';
import 'package:reservatior/shared/models/channel.dart';
import 'package:reservatior/shared/providers/channel_provider.dart';

class ChannelsScreen extends ConsumerStatefulWidget {
  const ChannelsScreen({super.key});

  @override
  ConsumerState<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends ConsumerState<ChannelsScreen> {
  ChannelCategory? _categoryFilter;

  @override
  Widget build(BuildContext context) {
    final asyncChannels = ref.watch(channelListProvider);
    final channels = asyncChannels.value ?? <Channel>[];

    final visible = _categoryFilter == null
        ? channels
        : channels.where((c) => c.category == _categoryFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'Channels',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      selected: _categoryFilter == null,
                      onTap: () => setState(() => _categoryFilter = null),
                    ),
                    ...ChannelCategory.values.map((c) => _FilterChip(
                          label: c.name,
                          selected: _categoryFilter == c,
                          onTap: () => setState(() => _categoryFilter = c),
                        )),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                asyncChannels.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Could not load channels',
                      style: GoogleFonts.outfit(color: Colors.white54)),
                  data: (data) {
                    if (visible.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Icon(Icons.forum_outlined, color: Colors.white24, size: 32),
                            const SizedBox(height: 10),
                            Text('No channels here',
                                style: GoogleFonts.outfit(
                                    color: Colors.white38, fontSize: 13)),
                          ],
                        ),
                      );
                    }
                    return Column(
                      children: visible
                          .map((c) => _ChannelTile(channel: c))
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ChannelTile extends StatelessWidget {
  final Channel channel;
  const _ChannelTile({required this.channel});

  @override
  Widget build(BuildContext context) {
    final accent = _categoryColor(channel.category);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_typeIcon(channel.type), color: accent, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      '${channel.type.name} channel',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accent.withValues(alpha: 0.4)),
                ),
                child: Text(
                  channel.category.name,
                  style: GoogleFonts.outfit(
                      color: accent, fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          if (channel.description != null && channel.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              channel.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.mail_outlined, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                '${channel.communicationLogs.length} messages',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
              const Spacer(),
              Icon(Icons.access_time, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                DateFormat.yMMMd().format(channel.createdAt),
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }

  Color _categoryColor(ChannelCategory category) {
    switch (category) {
      case ChannelCategory.AGENT:
        return AppColors.info;
      case ChannelCategory.AGENCY:
        return AppColors.primary;
      case ChannelCategory.TENANT:
        return AppColors.success;
      case ChannelCategory.PROPERTY:
        return AppColors.gold;
      case ChannelCategory.PAYMENT:
        return AppColors.warning;
      case ChannelCategory.SYSTEM:
        return AppColors.error;
      case ChannelCategory.REPORT:
        return AppColors.primary;
      case ChannelCategory.RESERVATION:
        return AppColors.success;
      case ChannelCategory.TASK:
        return AppColors.warning;
      case ChannelCategory.TICKET:
        return AppColors.error;
    }
  }

  IconData _typeIcon(ChannelType type) {
    switch (type) {
      case ChannelType.PUBLIC:
        return Icons.public;
      case ChannelType.PRIVATE:
        return Icons.lock_outline;
      case ChannelType.GROUP:
        return Icons.group_outlined;
    }
  }
}
