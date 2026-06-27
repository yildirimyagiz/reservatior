import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class SavedSearch {
  final String id;
  final String name;
  final String filters;
  final int resultCount;
  final String createdAt;
  final bool notificationsEnabled;

  SavedSearch({
    required this.id,
    required this.name,
    required this.filters,
    required this.resultCount,
    required this.createdAt,
    required this.notificationsEnabled,
  });
}

class SavedSearchesWidget extends StatefulWidget {
  final List<SavedSearch> searches;
  final Function(String) onLoadSearch;
  final Function(String) onDeleteSearch;
  final Function(String) onToggleNotifications;

  const SavedSearchesWidget({
    super.key,
    required this.searches,
    required this.onLoadSearch,
    required this.onDeleteSearch,
    required this.onToggleNotifications,
  });

  @override
  State<SavedSearchesWidget> createState() => _SavedSearchesWidgetState();
}

class _SavedSearchesWidgetState extends State<SavedSearchesWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
    if (_expanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searches.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: FadeTransition(
              opacity: _expandAnimation,
              child: _buildSearchList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggleExpanded,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.bookmark, size: 20, color: AppColors.gold),
              SizedBox(width: 12),
              Expanded(
                child: Text('mobile.auto.saved_searches'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.searches.length}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: _expanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: widget.searches.map((search) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildSearchItem(search),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchItem(SavedSearch search) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchHeader(search),
          const SizedBox(height: 8),
          _buildSearchFooter(search),
        ],
      ),
    );
  }

  Widget _buildSearchHeader(SavedSearch search) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                search.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                search.filters,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationToggle(search),
            const SizedBox(width: 4),
            _buildDeleteButton(search),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(SavedSearch search) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onToggleNotifications(search.id),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: search.notificationsEnabled
                ? AppColors.gold.withOpacity(0.1)
                : AppColors.darkCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: search.notificationsEnabled
                  ? AppColors.gold.withOpacity(0.3)
                  : AppColors.darkBorder.withOpacity(0.2),
            ),
          ),
          child: Icon(
            Icons.notifications,
            size: 16,
            color: search.notificationsEnabled
                ? AppColors.gold
                : AppColors.textSecondaryDark,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton(SavedSearch search) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onDeleteSearch(search.id),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.darkBorder.withOpacity(0.2)),
          ),
          child: Icon(
            Icons.delete,
            size: 16,
            color: AppColors.textSecondaryDark,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchFooter(SavedSearch search) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${search.resultCount} properties',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondaryDark),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => widget.onLoadSearch(search.id),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('mobile.auto.load_search'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkBg,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
