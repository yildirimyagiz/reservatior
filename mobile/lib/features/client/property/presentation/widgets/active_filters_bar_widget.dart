import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ActiveFilter {
  final String id;
  final String label;
  final String category;

  ActiveFilter({required this.id, required this.label, required this.category});
}

class ActiveFiltersBarWidget extends StatelessWidget {
  final List<ActiveFilter> filters;
  final Function(String) onRemoveFilter;
  final VoidCallback onClearAll;
  final int resultCount;

  const ActiveFiltersBarWidget({
    super.key,
    required this.filters,
    required this.onRemoveFilter,
    required this.onClearAll,
    required this.resultCount,
  });

  @override
  Widget build(BuildContext context) {
    if (filters.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildFilterChips(),
            const SizedBox(height: 12),
            _buildResultCount(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.filter_list, size: 20, color: AppColors.gold),
            SizedBox(width: 8),
            Text('mobile.auto.active_filters'.tr(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${filters.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
          ],
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClearAll,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text('mobile.auto.clear_all'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.gold,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filters.map((filter) => _buildFilterChip(filter)).toList(),
    );
  }

  Widget _buildFilterChip(ActiveFilter filter) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            child: Text(
              filter.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkBg,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onRemoveFilter(filter.id),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(Icons.close, size: 14, color: AppColors.darkBg),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCount() {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.darkBorder.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.home, size: 18, color: AppColors.textSecondaryDark),
          SizedBox(width: 8),
          Text('mobile.auto.properties_found'.tr(),
            style: TextStyle(fontSize: 14, color: AppColors.textPrimaryDark),
          ),
          const SizedBox(width: 4),
          Text(
            resultCount.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryDark,
            ),
          ),
        ],
      ),
    );
  }
}
