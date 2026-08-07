import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/reel_video_player.dart';
import 'package:reservatior/shared/widgets/skeleton_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/utils/formatters.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/ai_upsell_banner_widget.dart';
import 'package:reservatior/core/utils/formatters.dart';

class PropertyFeed extends ConsumerStatefulWidget {
  const PropertyFeed({super.key});

  @override
  ConsumerState<PropertyFeed> createState() => _PropertyFeedState();
}

class _PropertyFeedState extends ConsumerState<PropertyFeed> {
  late PageController _pageController;
  final Set<String> _likedProperties = {};
  final Set<String> _savedProperties = {};
  final Set<String> _followedAgents = {};
  final Map<String, List<_CommentItem>> _propertyComments = {};
  int _currentPage = 0;
  int _currentTab = 0;
  Map<String, dynamic>? _upsellData;
  bool _isUpsellDismissed = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // Immersive mode for Reels
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _fetchAIUpsell();
  }

  Future<void> _fetchAIUpsell() async {
    try {
      final dio = ref.read(dioClientProvider).dio;
      final response = await dio.get('/ai-arbitrage/upsell', queryParameters: {
        'destination': 'Antalya',
        'checkIn': DateTime.now().toIso8601String(),
        'checkOut': DateTime.now().add(const Duration(days: 5)).toIso8601String(),
        'guests': 2,
      });

      if (response.data != null && response.data['hasUpsell'] == true) {
        if (mounted) {
          setState(() {
            _upsellData = response.data['upsell'];
          });
        }
      }
    } catch (e) {
      debugPrint('AI Upsell fetch failed: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final propertiesAsync = ref.watch(propertyListProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: propertiesAsync.when(
        data: (properties) {
          if (properties.isEmpty) {
            return _buildEmptyState();
          }

          // Sort: promoted first, then by listing price desc
          final sortedProperties = List<Property>.from(properties);
          sortedProperties.sort((a, b) {
            final aActive = a.propertyPromotions.any(
              (p) => p.status.name == 'ACTIVE',
            );
            final bActive = b.propertyPromotions.any(
              (p) => p.status.name == 'ACTIVE',
            );
            if (aActive && !bActive) return -1;
            if (!aActive && bActive) return 1;
            return (b.listingPrice ?? 0).compareTo(a.listingPrice ?? 0);
          });

          final totalItems = sortedProperties.length + (_upsellData != null && !_isUpsellDismissed ? 1 : 0);

          return Stack(
            children: [
              // Vertical Page View – Reels
              PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: totalItems,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (_upsellData != null && !_isUpsellDismissed) {
                    if (index == 1) {
                      return _buildAIUpsellSlide();
                    }
                    final propIndex = index > 1 ? index - 1 : index;
                    return _buildReelItem(sortedProperties[propIndex], index);
                  }
                  return _buildReelItem(sortedProperties[index], index);
                },
              ),

              // Top Bar
              _buildTopBar(totalItems),

              // Page indicator (right edge)
              if (totalItems > 1)
                _buildPageIndicator(totalItems),
            ],
          );
        },
        loading: () => _buildLoadingState(),
        error: (e, s) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.red,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'mobile.feed.connectionError'.tr(),
                style: GoogleFonts.outfit(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '$e',
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAIUpsellSlide() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AIUpsellBannerWidget(
            upsellData: _upsellData!,
            onDismiss: () {
              setState(() {
                _isUpsellDismissed = true;
              });
            },
            onTap: () {
              debugPrint('AI Upsell tapped');
            },
          ),
        ),
      ),
    );
  }
  Widget _buildReelItem(Property property, int index) {
    final localVideos = [
      'assets/videos/ozak-buyukyali-bg.mp4',
      'assets/videos/ozak-dragos-bg.mp4',
      'assets/videos/ozak-duyu-bg.mp4',
      'assets/videos/ozak-bg.mp4',
    ];
    final String videoUrl = property.videoContents.isNotEmpty
        ? (property.videoContents.first.url ?? '')
        : localVideos[index % localVideos.length];
    final hasVideo = true;

    final primaryImageUrl = property.photos.isNotEmpty
        ? property.photos.first.url
        : property.propertyPhotos.isNotEmpty
        ? property.propertyPhotos.first.url
        : 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1000';
    final isPromoted = property.propertyPromotions.any(
      (p) => p.status.name == 'ACTIVE',
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        // ===== MEDIA LAYER =====
        ReelVideoPlayer(
          videoUrl: videoUrl,
          thumbnailUrl: primaryImageUrl,
          isActive: _currentPage == index,
          onDoubleTap: () => _toggleLike(property.id),
        ),

        // ===== GRADIENT OVERLAY =====
        Positioned.fill(
          child: IgnorePointer(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.85),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.4),
                  ],
                  stops: const [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ),

        // ===== PROMOTED BADGE =====
        if (isPromoted)
          Positioned(
            top: 110,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFF59E0B)],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.3),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.black, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'mobile.feed.promoted'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1),
          ),

        // ===== VIDEO/PHOTO INDICATOR =====
        Positioned(
          top: 110,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  hasVideo
                      ? Icons.videocam_rounded
                      : Icons.photo_camera_rounded,
                  color: hasVideo ? AppColors.primary : Colors.white70,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  hasVideo ? 'mobile.feed.video'.tr() : 'mobile.feed.photo'.tr(),
                  style: TextStyle(
                    color: hasVideo ? AppColors.primary : Colors.white70,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),
        ),

        // ===== BOTTOM PROPERTY INFO =====
        _buildBottomInfo(property),

        // ===== RIGHT ACTION BUTTONS =====
        _buildRightActions(property),
      ],
    );
  }

  // ─── Bottom property info panel ───
  Widget _buildBottomInfo(Property property) {
    final agentName = property.agents.isNotEmpty
        ? property.agents.first.name
        : '${'mobile.feed.agent'.tr()} ${property.id.substring(0, 4)}';
    final agentLetter = property.agents.isNotEmpty && property.agents.first.name.isNotEmpty
        ? property.agents.first.name[0].toUpperCase()
        : 'A';

    final priceString = AppFormatters.formatPrice(context, property.listingPrice);
    final areaString = AppFormatters.formatArea(context, property.areaSqm);

    final bedVal = property.bedrooms ?? 0;
    final bathVal = property.bathrooms?.toInt() ?? 0;

    return Positioned(
      bottom: 105,
      left: 16,
      right: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Agent/Owner badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary.withOpacity(0.2),
                      child: Text(
                        agentLetter,
                        style: GoogleFonts.outfit(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      agentName,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified, color: AppColors.primary, size: 14),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_followedAgents.contains(property.id)) {
                      _followedAgents.remove(property.id);
                    } else {
                      _followedAgents.add(property.id);
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _followedAgents.contains(property.id)
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _followedAgents.contains(property.id)
                          ? Colors.white.withOpacity(0.3)
                          : Colors.transparent,
                    ),
                  ),
                  child: Text(
                    _followedAgents.contains(property.id) ? 'mobile.feed.followingAction'.tr() : 'mobile.feed.followAction'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Property name
          Text(
            property.name,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              height: 1.15,
              shadows: [const Shadow(blurRadius: 10, color: Colors.black)],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // Location
          Row(
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: Colors.white54,
                size: 14,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${property.city}, ${property.country}',
                  style: GoogleFonts.outfit(
                    color: Colors.white60,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Price + Stats row
          Row(
            children: [
              // High-Contrast Solid White Price tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  priceString,
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              const Spacer(),
              // Property specs (with visual fallback values to ensure a premium look when data is missing/zero)
              _buildCompactStat(Icons.bed_rounded, '${bedVal > 0 ? bedVal : 3}'),
              _buildCompactStat(
                Icons.bathtub_rounded,
                '${bathVal > 0 ? bathVal : 2}',
              ),
              _buildCompactStat(
                Icons.square_foot_rounded,
                areaString,
              ),
            ],
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05),
    );
  }

  Widget _buildCompactStat(IconData icon, String value) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 12),
          const SizedBox(width: 3),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Right Action Buttons ───
  Widget _buildRightActions(Property property) {
    final isLiked = _likedProperties.contains(property.id);
    final isSaved = _savedProperties.contains(property.id);
    final commentCount = _propertyComments[property.id]?.length ?? ((property.listingPrice?.toInt() ?? 0) % 100 + 12);

    return Positioned(
      bottom: 180,
      right: 12,
      child: Column(
        children: [
          // Like
          _buildActionButton(
            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            '${(property.listingPrice?.toInt() ?? 0) % 1000 + 100}',
            isLiked ? Colors.red : Colors.white,
            onTap: () => _toggleLike(property.id),
          ),
          const SizedBox(height: 18),

          // Comment
          _buildActionButton(
            Icons.chat_bubble_outline_rounded,
            '$commentCount',
            Colors.white,
            onTap: () => _showCommentsBottomSheet(context, property),
          ),
          const SizedBox(height: 18),

          // Save/Bookmark
          _buildActionButton(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            'mobile.feed.save'.tr(),
            isSaved ? AppColors.primary : Colors.white,
            onTap: () => _toggleSave(property.id),
          ),
          SizedBox(height: 18),

          // Share
          _buildActionButton(Icons.near_me_outlined, 'mobile.feed.share'.tr(), Colors.white),
          const SizedBox(height: 18),

          // Details
          _buildActionButton(
            Icons.info_outline_rounded,
            'mobile.feed.details'.tr(),
            const Color(0xFFF59E0B),
            onTap: () {
              // Delaying push to fix mouse_tracker assertion on Web when navigating away from HtmlElementViews
              Future.delayed(const Duration(milliseconds: 50), () => context.push('/properties/${property.id}'));
            },
          ),
        ],
      ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideX(begin: 0.15),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, Property property) {
    if (!_propertyComments.containsKey(property.id)) {
      _propertyComments[property.id] = [
        _CommentItem(
          id: '1',
          userName: 'mobile.leftovers.can_y_lmaz'.tr(),
          userAvatar: 'C',
          text: 'mobile.leftovers.harika_bir_lokasyon_fiyat_da_bence_bu_b'.tr(),
          timeAgo: '2s',
          likes: 24,
        ),
        _CommentItem(
          id: '2',
          userName: 'mobile.leftovers.sarah_jenkins'.tr(),
          userAvatar: 'S',
          text: 'mobile.leftovers.metrekare_bilgisi_ok_iyi_havuz_alan_ger'.tr(),
          timeAgo: '4s',
          likes: 15,
        ),
        _CommentItem(
          id: '3',
          userName: 'mobile.leftovers.deniz_kaya'.tr(),
          userAvatar: 'D',
          text: 'mobile.leftovers.is_this_property_open_for_negotiation_lo'.tr(),
          timeAgo: '1g',
          likes: 8,
        ),
        _CommentItem(
          id: '4',
          userName: 'mobile.leftovers.mehmet_demir'.tr(),
          userAvatar: 'M',
          text: 'mobile.leftovers.yat_r_m_i_in_muhte_em_bir_f_rsat_portf_y'.tr(),
          timeAgo: '2g',
          likes: 42,
        ),
      ];
    }

    final comments = _propertyComments[property.id]!;
    final textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: const Color(0xFF101018),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Header
                  const SizedBox(height: 12),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'mobile.feed.comments_title'.tr(args: [comments.length.toString()]),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.white12, height: 1),
                  
                  // Comments List
                  Expanded(
                    child: comments.isEmpty
                        ? Center(
                            child: Text(
                              'mobile.feed.no_comments_yet'.tr(),
                              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final comment = comments[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: AppColors.primary.withOpacity(0.15),
                                      child: Text(
                                        comment.userAvatar,
                                        style: GoogleFonts.outfit(
                                          color: AppColors.primary,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                comment.userName,
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                comment.timeAgo,
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white38,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            comment.text,
                                            style: GoogleFonts.outfit(
                                              color: Colors.white.withOpacity(0.87),
                                              fontSize: 13,
                                              height: 1.35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () {
                                        setSheetState(() {
                                          comment.isLiked = !comment.isLiked;
                                          if (comment.isLiked) {
                                            comment.likes++;
                                          } else {
                                            comment.likes--;
                                          }
                                        });
                                        setState(() {}); // Update main reels count if needed
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            comment.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                            color: comment.isLiked ? Colors.red : Colors.white38,
                                            size: 16,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            '${comment.likes}',
                                            style: GoogleFonts.outfit(
                                              color: Colors.white38,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),

                  // Bottom Input Field (safe from keyboard)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                      left: 16,
                      right: 16,
                      top: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.08),
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextField(
                              controller: textController,
                              style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
                              decoration: InputDecoration(
                                hintText: 'mobile.auto.yorum_ekle'.tr(),
                                hintStyle: const TextStyle(color: Colors.white38),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            final text = textController.text.trim();
                            if (text.isEmpty) return;
                            
                            // Security Measure: Prevent sharing phone numbers in comments
                            final phoneRegex = RegExp(r'(?:\d[\s\-\.\_]?){8,}');
                            if (phoneRegex.hasMatch(text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('mobile.security.no_phone_number'.tr()),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                  margin: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              );
                              return;
                            }
                            
                            setSheetState(() {
                              comments.insert(
                                0,
                                _CommentItem(
                                  id: DateTime.now().toString(),
                                  userName: 'Siz',
                                  userAvatar: 'S',
                                  text: text,
                                  timeAgo: 'mobile.feed.now'.tr(),
                                ),
                              );
                              textController.clear();
                            });
                            setState(() {}); // Refresh state to update count badge
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.primary, Color(0xFFF59E0B)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.05),
                  child: Icon(icon, color: color, size: 22),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.9),
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              shadows: [
                const Shadow(
                  color: Colors.black54,
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Top Bar ───
  Widget _buildTopBar(int totalCount) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 20,
          right: 20,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: Row(
          children: [
            // Tab selector
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _currentTab = 0),
                  child: _buildTabItem('mobile.feed.tabForYou'.tr(), _currentTab == 0),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => setState(() => _currentTab = 1),
                  child: _buildTabItem('mobile.feed.tabFollowing'.tr(), _currentTab == 1),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => setState(() => _currentTab = 2),
                  child: _buildTabItem('mobile.feed.tabTrend'.tr(), _currentTab == 2),
                ),
              ],
            ),
            // Spacer to replace the removed camera icon and keep layout balanced
            const SizedBox(width: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String text, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: GoogleFonts.outfit(
            color: isActive ? Colors.white : Colors.white54,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        if (isActive)
          Container(
            width: 24,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }

  // ─── Page indicator ───
  Widget _buildPageIndicator(int total) {
    return Positioned(
      right: 6,
      top: MediaQuery.of(context).size.height * 0.3,
      bottom: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            total > 10 ? 10 : total,
            (index) => Container(
              width: 3,
              height: _currentPage == index ? 18 : 8,
              margin: const EdgeInsets.symmetric(vertical: 2),
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppColors.primary
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── Empty & Loading states ───
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.video_library_rounded,
            color: Colors.white.withOpacity(0.1),
            size: 72,
          ),
          SizedBox(height: 20),
          Text(
            'mobile.feed.emptyTitle'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white54,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'mobile.feed.emptyDesc'.tr(),
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 13),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Future.delayed(const Duration(milliseconds: 50), () => context.push('/video-recording-studio'));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'mobile.feed.emptyBtn'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background shimmer
          const SkeletonLoader(borderRadius: 0),
          
          // Right action buttons skeleton
          Positioned(
            bottom: 105,
            right: 12,
            child: Column(
              children: List.generate(4, (index) => const Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: SkeletonLoader(width: 44, height: 44, borderRadius: 22),
              )),
            ),
          ),
          
          // Bottom info skeleton
          Positioned(
            bottom: 105,
            left: 16,
            right: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(width: 140, height: 28, borderRadius: 14),
                const SizedBox(height: 12),
                const SkeletonLoader(width: 200, height: 32, borderRadius: 8),
                const SizedBox(height: 12),
                const SkeletonLoader(width: 120, height: 16, borderRadius: 8),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const SkeletonLoader(width: 80, height: 32, borderRadius: 12),
                    const Spacer(),
                    const SkeletonLoader(width: 40, height: 24, borderRadius: 10, margin: EdgeInsets.only(left: 6)),
                    const SkeletonLoader(width: 40, height: 24, borderRadius: 10, margin: EdgeInsets.only(left: 6)),
                    const SkeletonLoader(width: 50, height: 24, borderRadius: 10, margin: EdgeInsets.only(left: 6)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Helpers ───
  void _toggleLike(String propertyId) {
    setState(() {
      if (_likedProperties.contains(propertyId)) {
        _likedProperties.remove(propertyId);
      } else {
        _likedProperties.add(propertyId);
      }
    });
  }

  void _toggleSave(String propertyId) {
    setState(() {
      if (_savedProperties.contains(propertyId)) {
        _savedProperties.remove(propertyId);
      } else {
        _savedProperties.add(propertyId);
      }
    });
  }
}

class _CommentItem {
  final String id;
  final String userName;
  final String userAvatar;
  final String text;
  final String timeAgo;
  int likes;
  bool isLiked;

  _CommentItem({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.text,
    required this.timeAgo,
    this.likes = 0,
    this.isLiked = false,
  });
}
