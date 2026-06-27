import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/providers/ai/gemini_hub_provider.dart';

class HomeSearchHubWidget extends ConsumerStatefulWidget {
  const HomeSearchHubWidget({super.key});

  @override
  ConsumerState<HomeSearchHubWidget> createState() => _HomeSearchHubWidgetState();
}

class _HomeSearchHubWidgetState extends ConsumerState<HomeSearchHubWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitSearch() {
    final query = _controller.text;
    if (query.isNotEmpty) {
      ref.read(geminiHubProvider.notifier).sendMessage(query);
      _focusNode.unfocus();
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'check_circle': return Icons.check_circle_outline;
      case 'history': return Icons.history;
      case 'home': return Icons.home_work_outlined;
      case 'monetization_on': return Icons.monetization_on_outlined;
      case 'payment': return Icons.payment_outlined;
      case 'build': return Icons.build_circle_outlined;
      case 'search': return Icons.search_rounded;
      case 'event': return Icons.event_available_outlined;
      default: return Icons.auto_awesome;
    }
  }

  @override
  Widget build(BuildContext context) {
    final geminiState = ref.watch(geminiHubProvider);

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withOpacity(0.5),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _focusNode.hasFocus ? AppColors.primary.withOpacity(0.5) : Colors.white.withOpacity(0.05),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: AppColors.primaryLight, size: 22)
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 2.seconds, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: GoogleFonts.outfit(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Ask Gemini (e.g. "My Tasks" or "Find properties")',
                        hintStyle: GoogleFonts.outfit(color: Colors.white54, fontSize: 15),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _submitSearch(),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white54, size: 18),
                      onPressed: () {
                        _controller.clear();
                        ref.read(geminiHubProvider.notifier).clearChat();
                        setState(() {});
                      },
                    ),
                  GestureDetector(
                    onTap: _submitSearch,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: geminiState.isLoading
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryLight))
                          : const Icon(Icons.send_rounded, color: AppColors.primaryLight, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            
            // Default Filters (When not searching)
            if (geminiState.messages.isEmpty && !geminiState.isLoading && _controller.text.isEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildMiniFilter('mobile.leftovers.property_type'.tr(), Icons.home_work_rounded)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildMiniFilter('mobile.leftovers.budget_range'.tr(), Icons.payments_rounded)),
                ],
              ),
            ],

            // Gemini Response Panel (Chat List)
            if (geminiState.messages.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                height: 300, // Fixed height for scrolling chat
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: geminiState.messages.length,
                  itemBuilder: (context, index) {
                    final msg = geminiState.messages[index];
                    final isUser = msg['role'] == 'user';
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (!isUser) ...[
                                const Icon(Icons.auto_awesome, color: AppColors.primaryLight, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  msg['intent']?.replaceAll('_', ' ') ?? 'AI ASSISTANT',
                                  style: GoogleFonts.outfit(
                                    color: AppColors.primaryLight,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  'YOU',
                                  style: GoogleFonts.outfit(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.person, color: Colors.white54, size: 16),
                              ]
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.white.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg['text'] ?? '',
                              style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.9), fontSize: 14, height: 1.4),
                            ),
                          ),
                          if (!isUser && msg['actions'] != null && (msg['actions'] as List).isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: (msg['actions'] as List).map((action) {
                                return ActionChip(
                                  onPressed: () {
                                    final route = action['route'] as String;
                                    if (route.startsWith('/')) {
                                      context.go(route);
                                    }
                                  },
                                  backgroundColor: AppColors.primary.withOpacity(0.2),
                                  side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  avatar: Icon(_getIconData(action['icon']), size: 16, color: AppColors.primaryLight),
                                  label: Text(
                                    action['label'],
                                    style: GoogleFonts.outfit(color: AppColors.primaryLight, fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                );
                              }).toList(),
                            ),
                          ]
                        ],
                      ),
                    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
                  },
                ),
              ).animate().fadeIn().slideY(begin: 0.1, end: 0),
            ],
            
            if (geminiState.error != null) ...[
              const SizedBox(height: 16),
              Text(
                geminiState.error!,
                style: GoogleFonts.outfit(color: Colors.redAccent, fontSize: 13),
              ).animate().fadeIn(),
            ]
          ],
        ),
      ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.95, 0.95)),
    );
  }

  Widget _buildMiniFilter(String label, IconData icon) {
    return GestureDetector(
      onTap: () => context.go('/search'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38, size: 14),
          ],
        ),
      ),
    );
  }
}
