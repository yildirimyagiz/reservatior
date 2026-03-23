import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

/// Beautiful achievement badge widget with animations
class AchievementBadgeWidget extends StatelessWidget {
  final Achievement achievement;
  final double size;
  final bool showGlow;
  final VoidCallback? onTap;

  const AchievementBadgeWidget({
    Key? key,
    required this.achievement,
    this.size = 80,
    this.showGlow = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted = achievement.isCompleted ?? false;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect for unlocked achievements
          if (showGlow && isCompleted)
            Container(
              width: size * 1.3,
              height: size * 1.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _getBadgeColor(achievement).withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          
          // Main badge container
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isCompleted
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getBadgeColor(achievement),
                        _getBadgeColor(achievement).withOpacity(0.7),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.grey[400]!,
                        Colors.grey[600]!,
                      ],
                    ),
              border: Border.all(
                color: isCompleted ? Colors.white : Colors.grey[300]!,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _getBadgeIcon(achievement),
                size: size * 0.5,
                color: isCompleted ? Colors.white : Colors.grey[500],
              ),
            ),
          ),
          
          // Lock overlay for locked achievements
          if (!isCompleted)
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: Icon(
                Icons.lock,
                size: size * 0.3,
                color: Colors.white,
              ),
            ),
          
          // Points badge
          if (achievement.pointsReward != null && achievement.pointsReward! > 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Text(
                  '+${achievement.pointsReward}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getBadgeColor(Achievement achievement) {
    final points = achievement.pointsReward ?? 0;
    
    if (points >= 100) {
      return const Color(0xFFFFD700); // Gold
    } else if (points >= 50) {
      return const Color(0xFFC0C0C0); // Silver
    } else if (points >= 25) {
      return const Color(0xFFCD7F32); // Bronze
    } else {
      return Colors.blue; // Regular
    }
  }

  IconData _getBadgeIcon(Achievement achievement) {
    final goalType = achievement.goalType?.toString().toLowerCase() ?? '';
    
    if (goalType.contains('property')) return Icons.home;
    if (goalType.contains('listing')) return Icons.list_alt;
    if (goalType.contains('deal')) return Icons.handshake;
    if (goalType.contains('appointment')) return Icons.calendar_today;
    if (goalType.contains('client')) return Icons.people;
    if (goalType.contains('revenue')) return Icons.attach_money;
    if (goalType.contains('message')) return Icons.message;
    if (goalType.contains('review')) return Icons.star;
    if (goalType.contains('login')) return Icons.login;
    if (goalType.contains('profile')) return Icons.person;
    
    return Icons.emoji_events; // Default trophy icon
  }
}
