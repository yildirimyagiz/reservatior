import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class Location {
  final String id;
  final String name;
  final int count;

  Location({required this.id, required this.name, required this.count});
}

class LocationFilterWidget extends StatefulWidget {
  final List<Location> locations;
  final List<String> selectedLocations;
  final Function(List<String>) onLocationChange;

  const LocationFilterWidget({
    super.key,
    required this.locations,
    required this.selectedLocations,
    required this.onLocationChange,
  });

  @override
  State<LocationFilterWidget> createState() => _LocationFilterWidgetState();
}

class _LocationFilterWidgetState extends State<LocationFilterWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = true;
  String _searchQuery = '';
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
    _animationController.value = 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Location> get _filteredLocations {
    return widget.locations
        .where(
          (location) =>
              location.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
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

  void _handleLocationToggle(String locationId) {
    final newLocations = List<String>.from(widget.selectedLocations);
    if (newLocations.contains(locationId)) {
      newLocations.remove(locationId);
    } else {
      newLocations.add(locationId);
    }
    widget.onLocationChange(newLocations);
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
              child: _buildContent(),
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
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.location_on, size: 20, color: AppColors.gold),
              SizedBox(width: 12),
              Expanded(
                child: Text('mobile.auto.location'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
              if (widget.selectedLocations.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.selectedLocations.length}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkBg,
                    ),
                  ),
                ),
                SizedBox(width: 8),
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

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          _buildSearchField(),
          SizedBox(height: 12),
          _buildLocationList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.darkBorder.withOpacity(0.2)),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'mobile.auto.search_locations'.tr(),
          hintStyle: TextStyle(
            color: AppColors.textSecondaryDark,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 18,
            color: AppColors.textSecondaryDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: TextStyle(color: AppColors.textPrimaryDark, fontSize: 14),
      ),
    );
  }

  Widget _buildLocationList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 256),
      child: ListView(
        shrinkWrap: true,
        children: _filteredLocations.map((location) {
          final isSelected = widget.selectedLocations.contains(location.id);
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _buildLocationItem(location, isSelected),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLocationItem(Location location, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleLocationToggle(location.id),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(12),
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
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  location.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? AppColors.gold
                        : AppColors.textPrimaryDark,
                  ),
                ),
              ),
              Text(
                '${location.count} properties',
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? AppColors.gold.withOpacity(0.8)
                      : AppColors.textSecondaryDark,
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
        borderRadius: BorderRadius.circular(4),
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
