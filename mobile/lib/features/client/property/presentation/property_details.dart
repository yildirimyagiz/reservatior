import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/features/client/booking/presentation/widgets/booking_calendar_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/photos_grid_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/property_overview_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/detail/video_player_widget.dart';

class PropertyDetails extends ConsumerStatefulWidget {
  final Property property;
  const PropertyDetails({super.key, required this.property});

  @override
  ConsumerState<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends ConsumerState<PropertyDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isSaved = false;
  String _currentRoom = 'mobile.leftovers.living_room'.tr();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onRoomChange(String room) {
    setState(() {
      _currentRoom = room;
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.gold,
        content: Text(
          _isSaved
              ? 'mobile.leftovers.property_added_to_your_favorites'.tr()
              : 'mobile.leftovers.property_removed_from_favorites'.tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Column(
        children: [
          // Hero Section: Immersive Video Player
          SizedBox(
            height: 45.h,
            child: VideoPlayerWidget(
              videoUrl: widget.property.videoContents.isNotEmpty
                  ? widget.property.videoContents.first.url
                  : null,
            ),
          ),

          // Glassmorphic Tab Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              border: Border(
                bottom: BorderSide(color: AppColors.darkBorder, width: 1),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.gold,
              labelColor: AppColors.gold,
              unselectedLabelColor: Colors.white24,
              labelStyle: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'OVERVIEW'),
                Tab(text: 'PHOTOS'),
                Tab(text: 'VIRTUAL'),
                Tab(text: 'BOOKING'),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PropertyOverviewWidget(property: widget.property.toJson()),
                PhotosGridWidget(
                  photos: widget.property.photos
                      .map((e) => e.toJson())
                      .toList(),
                ),
                _buildVirtualTourTab(context),
                BookingCalendarWidget(property: widget.property.toJson()),
              ],
            ),
          ),

          // Agent Profile & Quick Actions
          _buildAgentSection(),

          // Sticky Bottom Logic
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildAgentSection() {
    final agent = widget.property.agents.isNotEmpty
        ? widget.property.agents.first
        : null;

    if (agent == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withOpacity(0.5),
        border: Border(top: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 2),
              image: DecorationImage(
                image: NetworkImage(
                  agent.logoUrl ?? 'https://picsum.photos/200',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.name ?? 'mobile.leftovers.elite_agent'.tr(),
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text('mobile.auto.exclusive_property_partner'.tr(),
                  style: GoogleFonts.outfit(
                    color: AppColors.gold.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.gold),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.gold.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined, color: AppColors.gold),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.gold.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.fromLTRB(
        5.w,
        1.5.h,
        5.w,
        MediaQuery.of(context).padding.bottom + 1.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        border: Border(top: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: IconButton(
              icon: Icon(
                _isSaved ? Icons.favorite : Icons.favorite_border,
                color: _isSaved ? Colors.red : Colors.white38,
              ),
              onPressed: _toggleSave,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _tabController.animateTo(3),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('mobile.auto.request_private_viewing'.tr(),
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVirtualTourTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.panorama_photosphere, color: AppColors.gold),
              SizedBox(width: 12),
              Text('mobile.auto.ai_driven_virtual_navigator'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Container(
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.darkBorder),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1618221195710-dd6b41faeaa6?w=800',
                ),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_circle_filled,
                      color: AppColors.gold,
                      size: 64,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text('mobile.auto.start_360_tour'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9)),
          SizedBox(height: 4.h),
          Text('mobile.auto.immersive_rooms'.tr(),
            style: GoogleFonts.outfit(
              color: AppColors.gold,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              fontSize: 12,
            ),
          ),
          SizedBox(height: 2.h),
          ...widget.property.photos.take(3).map((photo) {
            return Container(
              margin: EdgeInsets.only(bottom: 1.5.h),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.darkSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      photo.url,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Panoramic View: ${photo.id.substring(0, 8)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.view_in_ar, color: AppColors.gold, size: 20),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
