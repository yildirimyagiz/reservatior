import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class AnimatedLogoAvatarWidget extends StatelessWidget {
  const AnimatedLogoAvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      child: Text('mobile.auto.reservatior'.tr(),
        style: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 2,
        ),
      )
      .animate()
      .fadeOut(delay: 1200.ms, duration: 300.ms)
      .swap(
        builder: (_, __) => Text('mobile.auto.r'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF10B981),
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .fadeOut(delay: 600.ms, duration: 300.ms)
        .swap(
          builder: (_, __) => GestureDetector(
            onTap: () => context.push('/profile'),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF10B981)]),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF3B82F6).withOpacity(0.3), blurRadius: 12, spreadRadius: 1),
                ],
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80'),
              ),
            ),
          )
          .animate()
          .scale(begin: const Offset(0.5, 0.5), duration: 400.ms, curve: Curves.elasticOut)
          .fadeIn(duration: 400.ms),
        ),
      ),
    );
  }
}
