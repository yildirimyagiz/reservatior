import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class FilterOption {
  final String id;
  final String label;
  final String value;

  FilterOption({required this.id, required this.label, required this.value});
}

class FilterSectionWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<FilterOption> options;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionChange;
  final bool multiSelect;
  final bool isExpanded;

  const FilterSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.options,
    required this.selectedValues,
    required this.onSelectionChange,
    this.multiSelect = true,
    this.isExpanded = true,
  });

  @override
  State<FilterSectionWidget> createState() => _FilterSectionWidgetState();
}

class _FilterSectionWidgetState extends State<FilterSectionWidget>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _expanded = widget.isExpanded;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_expanded) {
      _animationController.value = 1.0;
    }
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

  void _handleOptionToggle(String value) {
    final newValues = List<String>.from(widget.selectedValues);

    if (widget.multiSelect) {
      if (newValues.contains(value)) {
        newValues.remove(value);
      } else {
        newValues.add(value);
      }
    } else {
      if (newValues.contains(value)) {
        newValues.clear();
      } else {
        newValues.clear();
        newValues.add(value);
      }
    }

    widget.onSelectionChange(newValues);
  }

  @override
  Widget build(BuildContext context) {
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
              child: _buildOptions(),
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
              Icon(widget.icon, size: 20, color: AppColors.gold),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              if (widget.selectedValues.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.selectedValues.length}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBg,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
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

  Widget _buildOptions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: widget.options.map((option) {
          final isSelected = widget.selectedValues.contains(option.value);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildOption(option, isSelected),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOption(FilterOption option, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleOptionToggle(option.value),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.gold.withOpacity(0.1)
                : AppColors.darkSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? AppColors.gold.withOpacity(0.3)
                  : AppColors.darkBorder.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              _buildCheckbox(isSelected),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.gold
                        : AppColors.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isSelected) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: widget.multiSelect ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: widget.multiSelect ? BorderRadius.circular(4) : null,
        border: Border.all(
          color: isSelected ? AppColors.gold : AppColors.textSecondaryDark,
          width: 2,
        ),
        color: isSelected ? AppColors.gold : Colors.transparent,
      ),
      child: isSelected
          ? Icon(Icons.check, size: 14, color: AppColors.darkBg)
          : null,
    );
  }
}
