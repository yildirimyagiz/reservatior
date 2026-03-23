import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

/// Progress bar widget for achievements
class AchievementProgressWidget extends StatelessWidget {
  final Achievement achievement;
  final bool showPercentage;
  final bool showNumbers;
  final double height;

  const AchievementProgressWidget({
    Key? key,
    required this.achievement,
    this.showPercentage = true,
    this.showNumbers = true,
    this.height = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final current = achievement.currentValue ?? 0;
    final target = achievement.goalValue ?? 100;
    final percentage = (current / target * 100).clamp(0, 100);
    final isCompleted = achievement.isCompleted ?? false;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        Stack(
          children: [
            // Background
            Container(
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(height / 2),
              ),
            ),
            
            // Progress
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: height,
              width: percentage / 100 * MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isCompleted
                      ? [Colors.green, Colors.lightGreen]
                      : [theme.colorScheme.primary, theme.colorScheme.secondary],
                ),
                borderRadius: BorderRadius.circular(height / 2),
                boxShadow: [
                  BoxShadow(
                    color: isCompleted
                        ? Colors.green.withOpacity(0.3)
                        : theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            
            // Percentage text overlay
            if (showPercentage && percentage > 15)
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        
        // Numbers below
        if (showNumbers)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$current / $target',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (isCompleted)
                  const Row(
                    children: [
                      Icon(Icons.check_circle, size: 16, color: Colors.green),
                      SizedBox(width: 4),
                      Text(
                        'Completed!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                else
                  Text(
                    '${target - current} remaining',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
