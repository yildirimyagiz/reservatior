import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/achievement_provider.dart';
import '../widgets/achievement_badge_widget.dart';
import '../widgets/achievement_progress_widget.dart';
import 'package:intl/intl.dart';

/// Page to display achievement details
class AchievementDetailPage extends ConsumerWidget {
  final String achievementId;

  const AchievementDetailPage({
    Key? key,
    required this.achievementId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievementAsync = ref.watch(achievementByIdProvider(achievementId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievement Details'),
      ),
      body: achievementAsync.when(
        data: (achievement) {
          final isCompleted = ref.watch(isAchievementCompletedProvider(achievement));
          final completion = ref.watch(achievementCompletionProvider(achievement));
          final goalTypeDisplay = ref.watch(goalTypeDisplayProvider(achievement.goalType));
          
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(achievementByIdProvider(achievementId));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Header with badge
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          AchievementBadgeWidget(
                            achievement: achievement,
                            size: 120,
                            showGlow: isCompleted,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            goalTypeDisplay,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          if (isCompleted) ...[
                            const SizedBox(height: 8),
                            Chip(
                              label: const Text('COMPLETED'),
                              backgroundColor: Colors.green,
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Goal Info
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Goal',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoTile(
                                  context,
                                  'Target',
                                  '${achievement.goalValue ?? 0}',
                                  Icons.flag,
                                ),
                              ),
                              Expanded(
                                child: _buildInfoTile(
                                  context,
                                  'Current',
                                  '${achievement.currentValue ?? 0}',
                                  Icons.trending_up,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (!isCompleted)
                            AchievementProgressWidget(
                              achievement: achievement,
                              showPercentage: true,
                              showNumbers: true,
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Rewards
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rewards',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          if (achievement.pointsReward != null && achievement.pointsReward! > 0)
                            _buildRewardTile(
                              context,
                              'Points',
                              '+${achievement.pointsReward}',
                              Icons.stars,
                              Colors.amber,
                            ),
                          if (achievement.bonusReward != null)
                            _buildRewardTile(
                              context,
                              'Bonus',
                              achievement.bonusReward!,
                              Icons.card_giftcard,
                              Colors.purple,
                            ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Timeline
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Timeline',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildTimelineTile(
                            context,
                            'Created',
                            DateFormat('MMM dd, yyyy HH:mm').format(achievement.createdAt ?? DateTime.now()),
                            Icons.add_circle,
                          ),
                          if (achievement.updatedAt != null)
                            _buildTimelineTile(
                              context,
                              'Last Updated',
                              DateFormat('MMM dd, yyyy HH:mm').format(achievement.updatedAt!),
                              Icons.update,
                            ),
                          if (isCompleted && achievement.completedAt != null)
                            _buildTimelineTile(
                              context,
                              'Completed',
                              DateFormat('MMM dd, yyyy HH:mm').format(achievement.completedAt!),
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(achievementByIdProvider(achievementId));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRewardTile(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineTile(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
