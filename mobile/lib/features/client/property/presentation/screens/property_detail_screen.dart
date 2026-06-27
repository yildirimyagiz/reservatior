import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sizer/sizer.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/widgets/ai_reusable_widgets.dart';
import 'package:reservatior/features/client/booking/presentation/widgets/booking_calendar_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/video_player_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/photos_grid_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/property_overview_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyDetailScreen extends ConsumerStatefulWidget {
  final Property property;
  const PropertyDetailScreen({super.key, required this.property});

  @override
  ConsumerState<PropertyDetailScreen> createState() =>
      _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends ConsumerState<PropertyDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showBookingCalendar() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: AppColors.darkBg,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'mobile.property.scheduleViewing'.tr(),
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white54),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10),
            Expanded(
              child: BookingCalendarWidget(property: widget.property.toJson()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          _buildContent(),
          _buildTopActions(context),
          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Hero Section: Video or Main Image
          SizedBox(
            height: 50.h,
            child: VideoPlayerWidget(
              videoUrl: 'https://storage.reservatior.com/reels/demo-high-end.mp4',
              autoPlay: false,
            ),
          ),

          // Main Header Info
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: AppColors.darkBg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.gold.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        widget.property.listingType.name.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w900,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      '\$${(widget.property.listingPrice ?? 0).toStringAsFixed(0)}',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),
                Text(
                  widget.property.name,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: AppColors.gold,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      '${widget.property.addressLine1}, ${widget.property.city}',
                      style: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),

                // Specifications Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSpecItem(
                      Icons.bed_outlined,
                      '${widget.property.bedrooms ?? 0}',
                      'mobile.property.beds'.tr(),
                    ),
                    _buildSpecItem(
                      Icons.bathtub_outlined,
                      '${widget.property.bathrooms ?? 0}',
                      'mobile.property.baths'.tr(),
                    ),
                    _buildSpecItem(
                      Icons.square_foot,
                      '${widget.property.areaSqm?.toInt() ?? 0}',
                      'mobile.property.sqftAlt'.tr(),
                    ),
                    _buildSpecItem(
                      Icons.garage_outlined,
                      '${widget.property.parkingSpaces ?? 0}',
                      'mobile.property.parking'.tr(),
                    ),
                  ],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

                SizedBox(height: 4.h),

                // Tabs Section
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.gold,
                  labelColor: AppColors.gold,
                  unselectedLabelColor: Colors.white24,
                  labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'mobile.property.tabOverviewAlt'.tr()),
                    Tab(text: 'mobile.property.tabGallery'.tr()),
                    Tab(text: 'mobile.property.tabAiInsights'.tr()),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      PropertyOverviewWidget(
                        property: widget.property.toJson(),
                      ),
                      PhotosGridWidget(
                        photos: widget.property.photos
                            .map((e) => e.toJson())
                            .toList(),
                      ),
                      _buildAIInsights(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white54, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.outfit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(color: Colors.white24, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildAIInsights() {
    final rentalYield = widget.property.rentalYield ?? 6.2;
    // Calculate a yield score out of 100
    final yieldScore = (rentalYield * 10).clamp(0.0, 100.0);
    
    // Check property risks
    final isFloodZone = widget.property.floodZone != null && 
        widget.property.floodZone!.isNotEmpty && 
        widget.property.floodZone!.toUpperCase() != 'NONE';
    final hasLeadPaintWarning = widget.property.leadPaintCompliance == false;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Core Investment Score Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withOpacity(0.12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppColors.gold, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'mobile.property.aiRating'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'mobile.property.investmentScore'.tr(),
                        style: GoogleFonts.outfit(color: Colors.white54, fontSize: 14),
                      ),
                      AiScoreBadge(score: yieldScore, label: 'ROI Yield'),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  Text(
                    'mobile.property.aiDesc'.tr(),
                    style: GoogleFonts.outfit(color: Colors.white70, height: 1.5, fontSize: 13),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms),
            SizedBox(height: 2.h),
            
            // Risk & Compliance AI Section
            Text(
              'AI Risk & Compliance',
              style: GoogleFonts.outfit(
                color: Colors.white54,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 1.5.h),
            
            if (isFloodZone)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AiRiskAlertCard(
                  title: 'Environmental Hazard',
                  reason: 'This property is identified within active flood zone: ${widget.property.floodZone}. Flood insurance may be required.',
                  severity: 'HIGH',
                ),
              ),
              
            if (hasLeadPaintWarning)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AiRiskAlertCard(
                  title: 'Lead Paint Compliance Warning',
                  reason: 'No lead paint compliance certification recorded for this building structure.',
                  severity: 'MEDIUM',
                ),
              ),
              
            if (!isFloodZone && !hasLeadPaintWarning)
              AiRiskAlertCard(
                title: 'All Clear',
                reason: 'AI Analysis indicates minimal environmental or architectural compliance risk flags.',
                severity: 'LOW',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopActions(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.white,
                ),
                onPressed: () => setState(() => _isLiked = !_isLiked),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        decoration: BoxDecoration(
          color: AppColors.darkSurface.withOpacity(0.9),
          border: Border(top: BorderSide(color: AppColors.darkBorder)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  side: const BorderSide(color: AppColors.gold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'mobile.property.messageAgent'.tr(),
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _showBookingCalendar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'mobile.property.bookViewing'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
