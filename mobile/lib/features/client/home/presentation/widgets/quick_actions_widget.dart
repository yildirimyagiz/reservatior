import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.quick_actions'.tr(), style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: -0.5)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildAction(context, _actions[0], 0)),
            Expanded(child: _buildAction(context, _actions[1], 1)),
            Expanded(child: _buildAction(context, _actions[2], 2)),
            Expanded(child: _buildAction(context, _actions[3], 3)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildAction(context, _actions[4], 4)),
            Expanded(child: _buildAction(context, _actions[5], 5)),
            Expanded(child: _buildAction(context, _actions[6], 6)),
            Expanded(child: _buildAction(context, _actions[7], 7)),
          ],
        ),
      ],
    );
  }

  Widget _buildAction(BuildContext context, Map<String, dynamic> action, int index) {
    return GestureDetector(
      onTap: () => context.push(action['route'] as String),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (action['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: (action['color'] as Color).withOpacity(0.15)),
            ),
            child: Icon(action['icon'] as IconData, color: action['color'] as Color, size: 26),
          ),
          const SizedBox(height: 8),
          Text((action['label'] as String).tr(), style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ],
      ),
    ).animate().fadeIn(delay: (index * 60).ms).scale(begin: const Offset(0.9, 0.9));
  }

  static final _actions = [
    {'icon': Icons.search_rounded, 'label': 'mobile.auto.quick_action_search', 'route': '/search', 'color': Color(0xFF3B82F6)},
    {'icon': Icons.apartment_rounded, 'label': 'mobile.auto.quick_action_listings', 'route': '/listings', 'color': Color(0xFF10B981)},
    {'icon': Icons.calendar_month_rounded, 'label': 'mobile.auto.quick_action_calendar', 'route': '/calendar', 'color': Color(0xFFF59E0B)},
    {'icon': Icons.people_alt_rounded, 'label': 'mobile.auto.quick_action_leads', 'route': '/leads', 'color': Color(0xFF8B5CF6)},
    {'icon': Icons.chat_bubble_rounded, 'label': 'mobile.auto.quick_action_messages', 'route': '/messages', 'color': Color(0xFFEC4899)},
    {'icon': Icons.analytics_rounded, 'label': 'mobile.auto.quick_action_analytics', 'route': '/analytics', 'color': Color(0xFF14B8A6)},
    {'icon': Icons.receipt_long_rounded, 'label': 'mobile.auto.quick_action_deals', 'route': '/deals', 'color': Color(0xFFEF4444)},
    {'icon': Icons.support_agent_rounded, 'label': 'mobile.auto.quick_action_support', 'route': '/support', 'color': Color(0xFF6366F1)},
  ];
}
