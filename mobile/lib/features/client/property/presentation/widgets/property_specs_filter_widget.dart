import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertySpecsFilterWidget extends StatefulWidget {
  final int bedrooms;
  final int bathrooms;
  final int minSize;
  final int maxSize;
  final List<String> furnishing;
  final Function(int) onBedroomsChange;
  final Function(int) onBathroomsChange;
  final Function(int, int) onSizeChange;
  final Function(List<String>) onFurnishingChange;

  const PropertySpecsFilterWidget({
    super.key,
    required this.bedrooms,
    required this.bathrooms,
    required this.minSize,
    required this.maxSize,
    required this.furnishing,
    required this.onBedroomsChange,
    required this.onBathroomsChange,
    required this.onSizeChange,
    required this.onFurnishingChange,
  });

  @override
  State<PropertySpecsFilterWidget> createState() =>
      _PropertySpecsFilterWidgetState();
}

class _PropertySpecsFilterWidgetState extends State<PropertySpecsFilterWidget>
    with SingleTickerProviderStateMixin {
  bool _expanded = true;
  late int _localMinSize;
  late int _localMaxSize;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  final List<Map<String, dynamic>> bedroomOptions = [
    {'value': 0, 'label': 'mobile.auto.studio'},
    {'value': 1, 'label': '1'},
    {'value': 2, 'label': '2'},
    {'value': 3, 'label': '3'},
    {'value': 4, 'label': '4'},
    {'value': 5, 'label': '5+'},
  ];

  final List<Map<String, dynamic>> bathroomOptions = [
    {'value': 1, 'label': '1'},
    {'value': 2, 'label': '2'},
    {'value': 3, 'label': '3'},
    {'value': 4, 'label': '4+'},
  ];

  final List<Map<String, dynamic>> furnishingOptions = [
    {'id': 'furnished', 'label': 'mobile.auto.furnished'},
    {'id': 'semi-furnished', 'label': 'mobile.auto.semi_furnished'},
    {'id': 'unfurnished', 'label': 'mobile.auto.unfurnished'},
  ];

  @override
  void initState() {
    super.initState();
    _localMinSize = widget.minSize;
    _localMaxSize = widget.maxSize;
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

  void _handleFurnishingToggle(String value) {
    final newValues = List<String>.from(widget.furnishing);
    if (newValues.contains(value)) {
      newValues.remove(value);
    } else {
      newValues.add(value);
    }
    widget.onFurnishingChange(newValues);
  }

  void _handleSizeChange() {
    widget.onSizeChange(_localMinSize, _localMaxSize);
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
              Icon(Icons.home_work, size: 20, color: AppColors.gold),
              SizedBox(width: 12),
              Expanded(
                child: Text('mobile.auto.property_specifications'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
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
          _buildBedroomSection(),
          SizedBox(height: 16),
          _buildBathroomSection(),
          SizedBox(height: 16),
          _buildSizeSection(),
          SizedBox(height: 16),
          _buildFurnishingSection(),
        ],
      ),
    );
  }

  Widget _buildBedroomSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.bedrooms'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
          ),
          itemCount: bedroomOptions.length,
          itemBuilder: (context, index) {
            final option = bedroomOptions[index];
            final isSelected = widget.bedrooms == option['value'];
            return _buildBedroomButton(option, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildBedroomButton(Map<String, dynamic> option, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onBedroomsChange(option['value']),
        borderRadius: BorderRadius.circular(8),
        child: Container(
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
          child: Center(
            child: Text(
              option['label'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.gold : AppColors.textPrimaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBathroomSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.bathrooms'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.5,
          ),
          itemCount: bathroomOptions.length,
          itemBuilder: (context, index) {
            final option = bathroomOptions[index];
            final isSelected = widget.bathrooms == option['value'];
            return _buildBathroomButton(option, isSelected);
          },
        ),
      ],
    );
  }

  Widget _buildBathroomButton(Map<String, dynamic> option, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onBathroomsChange(option['value']),
        borderRadius: BorderRadius.circular(8),
        child: Container(
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
          child: Center(
            child: Text(
              option['label'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.gold : AppColors.textPrimaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSizeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.size_sq_ft'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  _localMinSize = int.tryParse(value) ?? 0;
                },
                onEditingComplete: _handleSizeChange,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'mobile.auto.min'.tr(),
                  hintStyle: TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.gold),
                  ),
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  contentPadding: EdgeInsets.all(12),
                ),
                style: TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 8),
            Text(
              '-',
              style: TextStyle(
                color: AppColors.textSecondaryDark,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  _localMaxSize = int.tryParse(value) ?? 0;
                },
                onEditingComplete: _handleSizeChange,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'mobile.auto.max'.tr(),
                  hintStyle: TextStyle(
                    color: AppColors.textSecondaryDark,
                    fontSize: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.darkBorder.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.gold),
                  ),
                  filled: true,
                  fillColor: AppColors.darkSurface,
                  contentPadding: EdgeInsets.all(12),
                ),
                style: TextStyle(
                  color: AppColors.textPrimaryDark,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFurnishingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.furnishing'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        ...furnishingOptions.map((option) {
          final isSelected = widget.furnishing.contains(option['id']);
          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _buildFurnishingOption(option, isSelected),
          );
        }),
      ],
    );
  }

  Widget _buildFurnishingOption(Map<String, dynamic> option, bool isSelected) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleFurnishingToggle(option['id']),
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
                  option['label'],
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
