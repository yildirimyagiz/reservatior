import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class PriceRangeSliderWidget extends StatefulWidget {
  final int minPrice;
  final int maxPrice;
  final int currentMin;
  final int currentMax;
  final Function(int, int) onRangeChange;
  final String currency;

  const PriceRangeSliderWidget({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.currentMin,
    required this.currentMax,
    required this.onRangeChange,
    this.currency = 'USD',
  });

  @override
  State<PriceRangeSliderWidget> createState() => _PriceRangeSliderWidgetState();
}

class _PriceRangeSliderWidgetState extends State<PriceRangeSliderWidget>
    with SingleTickerProviderStateMixin {
  late int _localMin;
  late int _localMax;
  bool _expanded = true;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _localMin = widget.currentMin;
    _localMax = widget.currentMax;
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

  @override
  void didUpdateWidget(PriceRangeSliderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentMin != widget.currentMin ||
        oldWidget.currentMax != widget.currentMax) {
      setState(() {
        _localMin = widget.currentMin;
        _localMax = widget.currentMax;
      });
    }
  }

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return '\$${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '\$${(price / 1000).toStringAsFixed(0)}K';
    }
    return '\$${price.toString()}';
  }

  void _handleMinChange(double value) {
    final intValue = value.round();
    if (intValue <= _localMax) {
      setState(() {
        _localMin = intValue;
      });
      widget.onRangeChange(_localMin, _localMax);
    }
  }

  void _handleMaxChange(double value) {
    final intValue = value.round();
    if (intValue >= _localMin) {
      setState(() {
        _localMax = intValue;
      });
      widget.onRangeChange(_localMin, _localMax);
    }
  }

  double _getMinPercent() {
    return ((_localMin - widget.minPrice) / (widget.maxPrice - widget.minPrice))
        .clamp(0.0, 1.0);
  }

  double _getMaxPercent() {
    return ((_localMax - widget.minPrice) / (widget.maxPrice - widget.minPrice))
        .clamp(0.0, 1.0);
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
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.attach_money, size: 20, color: AppColors.gold),
              SizedBox(width: 12),
              Expanded(
                child: Text('mobile.auto.price_range'.tr(),
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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        children: [
          _buildPriceDisplay(),
          const SizedBox(height: 16),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('mobile.auto.min_price'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryDark,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatPrice(_localMin),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('mobile.auto.max_price'.tr(),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondaryDark,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.darkSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatPrice(_localMax),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    final minPercent = _getMinPercent();
    final maxPercent = _getMaxPercent();

    return Container(
      height: 60,
      child: Stack(
        children: [
          // Track background
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // Active track
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: maxPercent,
              child: Container(
                margin: EdgeInsets.only(
                  left: minPercent * MediaQuery.of(context).size.width,
                ),
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          // Min slider
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 0,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 10,
                  elevation: 4,
                ),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                thumbColor: AppColors.gold,
                overlayColor: AppColors.gold.withOpacity(0.2),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                min: widget.minPrice.toDouble(),
                max: widget.maxPrice.toDouble(),
                value: _localMin.toDouble(),
                onChanged: _handleMinChange,
              ),
            ),
          ),

          // Max slider
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 0,
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 10,
                  elevation: 4,
                ),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                thumbColor: AppColors.gold,
                overlayColor: AppColors.gold.withOpacity(0.2),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
              ),
              child: Slider(
                min: widget.minPrice.toDouble(),
                max: widget.maxPrice.toDouble(),
                value: _localMax.toDouble(),
                onChanged: _handleMaxChange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
