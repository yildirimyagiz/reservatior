import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/providers/admin/command_center_provider.dart';

class CommandCenterModal extends ConsumerStatefulWidget {
  const CommandCenterModal({super.key});

  @override
  ConsumerState<CommandCenterModal> createState() => _CommandCenterModalState();
}

class _CommandCenterModalState extends ConsumerState<CommandCenterModal> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commands = ref.watch(filteredCommandsProvider);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width > 600 ? 600 : MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: AppColors.darkBg.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 24,
                spreadRadius: 8,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white54, size: 28),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            focusNode: _focusNode,
                            style: GoogleFonts.outfit(color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                              hintText: 'mobile.admin.command.placeholder'.tr(),
                              hintStyle: GoogleFonts.outfit(color: Colors.white30, fontSize: 18),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              ref.read(commandSearchQueryProvider.notifier).state = value;
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white54),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  
                  // Results List
                  Expanded(
                    child: commands.isEmpty
                        ? Center(
                            child: Text(
                              'mobile.admin.command.no_results'.tr(),
                              style: const TextStyle(color: Colors.white54),
                            ),
                          )
                        : ListView.builder(
                            itemCount: commands.length,
                            itemBuilder: (context, index) {
                              final cmd = commands[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context); // Close the modal
                                  context.go(cmd.route); // Navigate
                                },
                                hoverColor: Colors.white.withValues(alpha: 0.05),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.gold.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(cmd.icon, color: AppColors.gold, size: 24),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cmd.title,
                                              style: GoogleFonts.outfit(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              cmd.subtitle,
                                              style: const TextStyle(
                                                color: Colors.white54,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  
                  // Footer Shortcuts info
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.2),
                      border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildShortcutBadge('↑↓', 'Gezin'),
                        const SizedBox(width: 16),
                        _buildShortcutBadge('Enter', 'Seç'),
                        const SizedBox(width: 16),
                        _buildShortcutBadge('ESC', 'Kapat'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShortcutBadge(String keys, String label) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(keys, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}
