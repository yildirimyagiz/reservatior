import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../gen_models/models_library.dart';
import '../../../../shared/providers/achievement_provider.dart';
import 'achievement_badge_widget.dart';
import 'achievement_progress_widget.dart';
import 'package:intl/intl.dart';

/// Beautiful achievement card with all information
class AchievementCardWidget extends ConsumerWidget {
  final Achievement achievement;
  final VoidCallback? onTap;
  final bool showProgress;
  final bool isCompact;

  const AchievementCardWidget({
    Key? key,
    required this.achievement,
    this.onTap,
    this.showProgress = true,
    this.isCompact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isCompleted = ref.watch(isAchievementCompletedProvider(achievement));
    final goalTypeDisplay = ref.watch(goalTypeDisplayProvider(achievement.goalType));
    
    return Card(
      elevation: isCompleted ? 4 : 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isCompleted
            ? BorderSide(color: theme.colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isCompact ? _buildCompactView(context, ref) : _buildFullView(context, ref),
        ),
      ),
    );
  }

  Widget _buildCompactView(BuildContext context, WidgetRef ref) {
    final isCompleted = ref.watch(isAchievementCompletedProvider(achievement));
    
    return Row(
      children: [
        // Badge
        AchievementBadgeWidget(
          achievement: achievement,
          size: 60,
          showGlow: isCompleted,
        ),
        
        const SizedBox(width: 16),
        
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                achievement.goalType?.toString().split('.').last ?? 'Achievement',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              if (showProgress && !isCompleted)
                AchievementProgressWidget(
                  achievement: achievement,
                  showNumbers: false,
                  height: 8,
                ),
            ],
          ),
        ),
        
        // Points
        if (achievement.pointsReward != null && achievement.pointsReward! > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stars,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 4),
                Text(
                  '+${achievement.pointsReward}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildFullView(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isCompleted = ref.watch(isAchievementCompletedProvider(achievement));
    final goalTypeDisplay = ref.watch(goalTypeDisplayProvider(achievement.goalType));
    final completion = ref.watch(achievementCompletionProvider(achievement));
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with badge and title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge
            AchievementBadgeWidget(
              achievement: achievement,
              size: 80,
              showGlow: isCompleted,
            ),
            
            const SizedBox(width: 16),
            
            // Title and description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Goal Type
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      goalTypeDisplay,
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Title
                  Text(
                    'Complete ${achievement.goalValue ?? 0} ${goalTypeDisplay}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  if (achievement.bonusReward != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        achievement.bonusReward!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Progress bar
        if (showProgress && !isCompleted)
          AchievementProgressWidget(
            achievement: achievement,
            showPercentage: true,
            showNumbers: true,
          ),
        
        if (isCompleted && achievement.completedAt != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Completed on ${DateFormat('MMM dd, yyyy').format(achievement.completedAt!)}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        
        const SizedBox(height: 12),
        
        // Footer with points and date
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Points reward
            if (achievement.pointsReward != null && achievement.pointsReward! > 0)
              Row(
                children: [
                  Icon(
                    Icons.stars,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '+${achievement.pointsReward} Points',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            
            // Created date
            Text(
              'Created ${DateFormat('MMM dd').format(achievement.createdAt ?? DateTime.now())}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
