import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/achievement_provider.dart';
import '../widgets/achievement_card_widget.dart';
import 'achievement_detail_page.dart';

/// Page to display list of achievements
class AchievementsListPage extends ConsumerStatefulWidget {
  final String? userId;
  final bool? showCompleted;

  const AchievementsListPage({
    Key? key,
    this.userId,
    this.showCompleted,
  }) : super(key: key);

  @override
  ConsumerState<AchievementsListPage> createState() => _AchievementsListPageState();
}

class _AchievementsListPageState extends ConsumerState<AchievementsListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
    
    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.userId != null) {
        ref.read(achievementListProvider.notifier).loadUserAchievements(widget.userId!);
      } else {
        ref.read(achievementListProvider.notifier).loadAchievements();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(achievementListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final achievementListState = ref.watch(achievementListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All', icon: Icon(Icons.emoji_events)),
            Tab(text: 'Unlocked', icon: Icon(Icons.check_circle)),
            Tab(text: 'Locked', icon: Icon(Icons.lock)),
          ],
          onTap: (index) {
            if (widget.userId != null) {
              if (index == 0) {
                ref.read(achievementListProvider.notifier)
                    .loadUserAchievements(widget.userId!);
              } else if (index == 1) {
                ref.read(achievementListProvider.notifier)
                    .loadUserAchievements(widget.userId!, unlocked: true);
              } else {
                ref.read(achievementListProvider.notifier)
                    .loadUserAchievements(widget.userId!, unlocked: false);
              }
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              // Navigate to leaderboard
            },
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              // Navigate to stats
            },
          ),
        ],
      ),
      body: achievementListState.when(
        initial: () => const Center(
          child: Text('Pull to refresh'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        loaded: (achievements, currentPage, hasMore, total) {
          if (achievements.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No achievements yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start completing goals to unlock achievements!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(achievementListProvider.notifier).refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: achievements.length + (hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == achievements.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final achievement = achievements[index];
                return AchievementCardWidget(
                  achievement: achievement,
                  showProgress: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AchievementDetailPage(
                          achievementId: achievement.id!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(achievementListProvider.notifier).refresh();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
