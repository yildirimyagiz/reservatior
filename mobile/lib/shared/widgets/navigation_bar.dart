import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../providers/notification_provider.dart';

// Custom widget for Notification badge in bottom navigation
class _NotificationIcon extends StatelessWidget {
  final int unreadCount;
  final bool isSelected;

  const _NotificationIcon({
    required this.unreadCount,
    required this.isSelected,
  });

  
  Widget build(BuildContext context) {
    return Badge(
      label: unreadCount > 0 ? Text('$unreadCount') : null,
      child: Icon(
        isSelected ? Icons.notifications : Icons.notifications_outlined,
      ),
    );
  }
}

class ReelStateNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ReelStateNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationsCountProvider);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        border: Border(
          top: BorderSide(
            color: AppColors.darkBorder,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildNavItem(
            context: context,
            icon: Icons.search_outlined,
            activeIcon: Icons.search,
            label: 'Search',
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildNavItem(
            context: context,
            icon: Icons.add_box_outlined,
            activeIcon: Icons.add_box,
            label: 'Create',
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
          _buildNavItem(
            context: context,
            icon: Icons.favorite_border,
            activeIcon: Icons.Favorite,
            label: 'Favorites',
            isSelected: currentIndex == 3,
            onTap: () => onTap(3),
          ),
          // Custom Notification item
          GestureDetector(
            onTap: () {
              onTap(4);
              context.push('/notifications');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NotificationIcon(
                    unreadCount: unreadCount,
                    isSelected: currentIndex == 4,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 12,
                      color: currentIndex == 4 ? AppColors.gold : AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.gold : AppColors.textSecondaryDark,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.gold : AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardNavigationRail extends ConsumerWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const DashboardNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: AppColors.darkSurface,
      selectedIconTheme: const IconThemeData(color: AppColors.gold),
      selectedLabelTextStyle: const TextStyle(color: AppColors.gold),
      unselectedIconTheme: const IconThemeData(color: AppColors.textSecondaryDark),
      unselectedLabelTextStyle: const TextStyle(color: AppColors.textSecondaryDark),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          selectedIcon: Icon(Icons.dashboard),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.business),
          selectedIcon: Icon(Icons.business),
          label: Text('Properties'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.apartment),
          selectedIcon: Icon(Icons.apartment),
          label: Text('Agencies'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.domain),
          selectedIcon: Icon(Icons.domain),
          label: Text('Facilities'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.Task),
          selectedIcon: Icon(Icons.Task),
          label: Text('Tasks'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.more_horiz),
          selectedIcon: Icon(Icons.more_horiz),
          label: Text('More'),
        ),
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const HomeAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
  });

  
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          if (showBackButton)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gold, AppColors.goldLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.home, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          Text(
            'Reservatior', 
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: actions ?? [
        IconButton(
          icon: const Icon(Icons.add_box_outlined, color: Colors.white),
          onPressed: () => context.push('/properties/new'),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () => context.push('/favorites'),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.white),
          onPressed: () => context.push('/communication'),
        ),
      ],
    );
  }

  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const DashboardAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(children: [
        Container(
          width: 28, 
          height: 28,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.gold, AppColors.goldLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ), 
            borderRadius: BorderRadius.circular(7)
          ),
          child: const Icon(Icons.home, color: Colors.white, size: 16)
        ),
        const SizedBox(width: 8),
        Text(
          title, 
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimaryDark
          )
        ),
      ]),
      actions: actions ?? [
        IconButton(
          icon: Badge(
            label: const Text('3'), 
            child: const Icon(Icons.notifications_outlined, color: AppColors.textPrimaryDark)
          ),
          onPressed: () => context.push('/notifications'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 4),
          child: GestureDetector(
            onTap: () => context.push('/profile'),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: AppColors.gold.withOpacity(0.15),
              child: const Text(
                'M',
                style: TextStyle(
                  color: AppColors.gold, 
                  fontWeight: FontWeight.w700, 
                  fontSize: 13
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
