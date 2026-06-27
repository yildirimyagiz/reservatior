import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'dart:ui' as ui;

class ExpenseListWidget extends StatelessWidget {
  final List<Expense> items;
  const ExpenseListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty)
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text('mobile.auto.no_expense_items_found'.tr(),
            style: TextStyle(color: AppColors.textSecondaryDark),
          ),
        ),
      );

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        final item = items[i];
        final heroTag = 'hero_expense_${item.id}';
        String title = 'Expense';
        try {
          title =
              (item as dynamic).description ??
              (item as dynamic).name ??
              item.id;
        } catch (_) {
          title = item.id;
        }

        return Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_rounded,
                            color: Colors.redAccent,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('mobile.auto.ref'.tr().split('').first +
                                    item.id.split('-').first.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  color: Colors.white38,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '-\$${(item as dynamic).amount ?? '0.00'}',
                              style: GoogleFonts.outfit(
                                color: Colors.redAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white24,
                              size: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: (i * 100).ms)
            .slideX(begin: 0.1, end: 0);
      },
    );
  }
}
