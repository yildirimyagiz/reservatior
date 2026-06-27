import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/api_token_provider.dart';

class ApiTokensScreen extends ConsumerWidget {
  const ApiTokensScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(apiTokenListProvider);
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withOpacity(0.8),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
              title: Text(
                'mobile.auto.api_tokens'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          items.when(
            data: (data) => SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (c, i) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.vpn_key,
                          color: Colors.amberAccent,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i].name ?? 'Token',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '•••••${data[i].id.substring(data[i].id.length - 4)}',
                                style: GoogleFonts.outfit(
                                  color: Colors.white30,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.copy, color: Colors.white24, size: 16),
                      ],
                    ),
                  ).animate().fadeIn(delay: (i * 50).ms),
                  childCount: data.length,
                ),
              ),
            ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, s) =>
                SliverFillRemaining(child: Center(child: Text('$e'))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('admin.common.coming_soon'.tr()),
      backgroundColor: Colors.orange,
    ),
  );
},
        backgroundColor: Colors.amberAccent.shade700,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
