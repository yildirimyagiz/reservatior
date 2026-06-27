import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/providers/property_amenity_provider.dart';
import 'package:reservatior/shared/providers/property_document_provider.dart';
import 'package:reservatior/shared/providers/property_disclosure_provider.dart';
import 'package:reservatior/core/services/ai_translation_service.dart';
import 'package:reservatior/shared/widgets/social_export_hub.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_image_gallery.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui;

class PropertyDetailsScreen extends ConsumerStatefulWidget {
  final String propertyId;

  const PropertyDetailsScreen({super.key, required this.propertyId});

  @override
  ConsumerState<PropertyDetailsScreen> createState() =>
      _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends ConsumerState<PropertyDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? _translatedDescription;
  bool _isTranslating = false;
  bool _showInternalBooking = false;

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

  @override
  Widget build(BuildContext context) {
    final propertyAsync = ref.watch(propertyDetailsProvider(widget.propertyId));

    return Scaffold(
      backgroundColor: const Color(0xFF09090E),
      body: propertyAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
          ),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                SelectableText(
                  'Error: $error\n\nStack: $stack',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        data: (property) => _buildContent(property),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAIConcierge(context);
        },
        backgroundColor: const Color(0xFF1BFFFF),
        icon: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF09090E)),
        label: Text(
          'Ask AI Concierge',
          style: GoogleFonts.outfit(
            color: const Color(0xFF09090E),
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.5),
    );
  }

  void _showAIConcierge(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: const Color(0xFF09090E),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          border: Border.all(color: const Color(0xFF1BFFFF).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              'AI Property Concierge',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildChatBubble('Hello! I am your AI concierge for this property. You can ask me about neighborhood schools, negotiation strategies, or building amenities. How can I help you today?', false),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Ask anything...',
                          hintStyle: TextStyle(color: Colors.white38),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1BFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Color(0xFF09090E)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: isUser ? 40 : 0,
          right: isUser ? 0 : 40,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: isUser
            ? const LinearGradient(colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)])
            : LinearGradient(colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.1)]),
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(20),
          ),
          border: Border.all(color: isUser ? Colors.transparent : Colors.white.withOpacity(0.1)),
        ),
        child: Text(
          text,
          style: GoogleFonts.outfit(color: isUser ? Colors.black87 : Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  Widget _buildContent(Property property) {
    final images = property.photos.map((p) {
      final u = p.url ?? '';
      if (u.startsWith('/')) {
        return 'http://127.0.0.1:3000$u';
      }
      return u;
    }).where((url) => url.isNotEmpty).toList() ?? [];

    final priceVal = property.listingPrice != null
        ? '\$${property.listingPrice!.toStringAsFixed(0)}'
        : 'mobile.property.priceTbd'.tr();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Premium Image Gallery with Floating Glass Action Bar
        SliverAppBar(
          expandedHeight: 320,
          pinned: true,
          stretch: true,
          backgroundColor: const Color(0xFF09090E),
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
                onPressed: () => _shareProperty(property),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Consumer(
                builder: (context, ref, child) {
                  final isFavorite = ref
                      .watch(propertyFavoritesProvider.notifier)
                      .isFavorite(property.id);
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFavorite ? Colors.redAccent : Colors.white,
                      size: 20,
                    ),
                    onPressed: () => _toggleFavorite(property.id),
                  );
                },
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
              StretchMode.blurBackground,
            ],
            background: Stack(
              fit: StackFit.expand,
              children: [
                PropertyImageGallery(
                  images: images,
                  heroTag: 'property_${property.id}',
                  height: 320,
                  showIndicator: false,
                ),
                // Premium gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xFF09090E),
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Main Property Information Panel
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price Tag & Status Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFFD700), Color(0xFFF59E0B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        priceVal,
                        style: GoogleFonts.outfit(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getStatusColor(property.listingStatus?.name).withOpacity(0.2),
                            _getStatusColor(property.listingStatus?.name).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _getStatusColor(property.listingStatus?.name).withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        property.listingStatus?.name ?? 'mobile.property.available'.tr(),
                        style: GoogleFonts.outfit(
                          color: _getStatusColor(property.listingStatus?.name),
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16),

                // Name of the property
                Text(
                  property.name ?? 'mobile.property.propertyName'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),

                const SizedBox(height: 10),

                // Map Address Link Row
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, color: Color(0xFFF59E0B), size: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${property.addressLine1 ?? ""}, ${property.city ?? ""}',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.white54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Quick stats row using our premium glass cards
                Row(
                  children: [
                    if (property.bedrooms != null)
                      _buildStatChip(Icons.bed_rounded, '${property.bedrooms} ${'mobile.property.beds'.tr()}'),
                    if (property.bathrooms != null)
                      _buildStatChip(
                        Icons.bathtub_rounded,
                        '${property.bathrooms} ${'mobile.property.baths'.tr()}',
                      ),
                    if (property.areaSqm != null)
                      _buildStatChip(
                        Icons.square_foot_rounded,
                        '${property.areaSqm}m²',
                      ),
                  ],
                ),
              ],
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05),
          ),
        ),

        // Beautiful glassmorphic persistent header tabs
        SliverPersistentHeader(
          pinned: true,
          delegate: _SliverAppBarDelegate(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF09090E),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(0.06),
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: const Color(0xFFF59E0B),
                indicatorWeight: 3,
                labelColor: const Color(0xFFF59E0B),
                unselectedLabelColor: Colors.white38,
                labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 0.5),
                unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600, fontSize: 13, letterSpacing: 0.5),
                tabs: [
                  Tab(text: 'Overview & Media'),
                  Tab(text: 'mobile.property.tabFeatures'.tr()),
                  Tab(text: 'mobile.property.tabLocation'.tr()),
                  Tab(text: 'mobile.property.tabDocuments'.tr()),
                ],
              ),
            ),
          ),
        ),

        // Dynamic, responsive Tab View Content
        SliverFillRemaining(
          child: Container(
            color: const Color(0xFF09090E),
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(property),
                _buildFeaturesTab(property),
                _buildLocationTab(property),
                _buildDocumentsTab(property),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFFF59E0B)),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Property property) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'mobile.property.descriptionTitle'.tr(),
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 12),
          
          // Instant Access / Smart Lock IoT Mockup
          Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFF1BFFFF).withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1BFFFF).withOpacity(0.1),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1BFFFF).withOpacity(0.5)),
                  ),
                  child: const Icon(Icons.sensor_door_outlined, color: Color(0xFF1BFFFF), size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Instant Access (IoT)',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Unlock this property physically for a self-guided tour via your phone.',
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1BFFFF),
                    foregroundColor: const Color(0xFF09090E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Unlocking Smart Lock... Access granted for 30 minutes!')),
                    );
                  },
                  child: Text('Unlock', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ).animate().shimmer(duration: 2000.ms),

          // Premium Glass Container for Description
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _translatedDescription ?? 'mobile.property.noDescription'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
                if (_translatedDescription == null) ...[
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _isTranslating ? null : () => _translateDescription(property),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1BFFFF).withOpacity(0.2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isTranslating)
                            const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                            )
                          else
                            const Icon(Icons.translate_rounded, size: 14, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            _isTranslating
                                ? 'mobile.property.translating'.tr()
                                : 'mobile.property.translateToTr'.tr(),
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 32),

          // Detail specs section
          Text(
            'mobile.property.detailsTitle'.tr(),
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                _buildDetailRow('mobile.property.type'.tr(), property.type?.name ?? 'mobile.property.notAvailable'.tr()),
                _buildDetailRow('mobile.property.listingType'.tr(), property.listingType?.name ?? 'mobile.property.notAvailable'.tr()),
                _buildDetailRow(
                  'mobile.property.yearBuilt'.tr(),
                  property.yearBuilt?.toString() ?? 'mobile.property.notAvailable'.tr(),
                ),
                _buildDetailRow(
                  'mobile.property.parkingSpaces'.tr(),
                  property.parkingSpaces?.toString() ?? 'mobile.property.notAvailable'.tr(),
                ),
              ],
            ),
          ),
          
          if (property.videoContents.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'Virtual Tour',
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ...property.videoContents.map((video) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: PropertyVideoPlayer(videoUrl: video.url ?? ''),
            )),
          ],

          if (property.floorPlans.isNotEmpty) ...[
            const SizedBox(height: 32),
            Text(
              'Floor Plans',
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: property.floorPlans.length,
                itemBuilder: (context, index) {
                  final plan = property.floorPlans[index];
                  final url = plan.imageUrl?.startsWith('/') == true 
                      ? 'http://127.0.0.1:3000${plan.imageUrl}' 
                      : plan.imageUrl;
                      
                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                            child: url != null 
                              ? Image.network(url, fit: BoxFit.cover)
                              : const Icon(Icons.image, color: Colors.white24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            plan.name ?? 'Floor Plan',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 32),
          if (property.orgId == "org_google_aggregator" && !_showInternalBooking) ...[
            Text(
              'Compare Prices',
              style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Builder(
              builder: (context) {
                final offersAsync = ref.watch(propertyAffiliateOffersProvider(property.id));
                return offersAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF59E0B))),
                  error: (error, stack) => const Text('Error loading offers', style: TextStyle(color: Colors.red)),
                  data: (offers) {
                    if (offers.isEmpty) return const Text('No offers available', style: TextStyle(color: Colors.white54));
                    return Column(
                      children: offers.map((offer) {
                        final isBestDeal = offer['isBestDeal'] == true;
                        return GestureDetector(
                          onTap: () async {
                            if (offer['isInternal'] == true) {
                              setState(() => _showInternalBooking = true);
                            } else {
                              final url = Uri.parse(offer['url']);
                              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not launch \${offer['provider']}')));
                              }
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isBestDeal ? const Color(0xFF10B981).withOpacity(0.1) : Colors.white.withOpacity(0.02),
                              border: Border.all(
                                color: isBestDeal ? const Color(0xFF10B981) : Colors.white.withOpacity(0.1),
                                width: isBestDeal ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 40, height: 40,
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: (offer['logoUrl'] != null && offer['logoUrl'].startsWith('http')) 
                                          ? Image.network(offer['logoUrl'], fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.grey))
                                          : Center(child: Text(offer['provider'][0], style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(offer['provider'] ?? '', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                        if (isBestDeal)
                                          Text('BEST DEAL', style: GoogleFonts.outfit(color: const Color(0xFF10B981), fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1)),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('\${offer['currency']} \${offer['price']}', style: GoogleFonts.outfit(color: isBestDeal ? const Color(0xFF10B981) : Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isBestDeal ? const Color(0xFF10B981) : Colors.white.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text('VIEW DEAL', style: GoogleFonts.outfit(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                );
              },
            ),
          ] else ...[
            if (_showInternalBooking)
              GestureDetector(
                onTap: () => setState(() => _showInternalBooking = false),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.white54, size: 16),
                      const SizedBox(width: 8),
                      Text('Back to Offers', style: GoogleFonts.outfit(color: Colors.white54)),
                    ],
                  ),
                ),
              ),
          property.listingType == 'BOOKING'
            ? GestureDetector(
                onTap: () {
                  context.push('/checkout/${property.id}', extra: property);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Rezervasyon Yap (SafeStay™)',
                        style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
            : Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('mobile.property.viewingRequested'.tr())),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'mobile.property.requestViewing'.tr(),
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('mobile.property.offerStarted'.tr())),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF59E0B).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'mobile.property.makeOffer'.tr(),
                      style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.verified_user_rounded, color: Color(0xFF10B981), size: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Reservatior SafeStay™',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Ödemeniz, siz tesise giriş yapıp memnun kalana kadar (Check-in sonrası 24 saat) havuz hesabımızda güvenle tutulur. Tesis fotoğraflardaki gibi değilse, anında %100 kesintisiz iade edilir.',
                  style: GoogleFonts.outfit(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFeaturesTab(Property property) {
    final amenitiesAsync = ref.watch(propertyAmenityListProvider(property.id));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'mobile.property.featuresTitle'.tr(),
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 16),

          amenitiesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF59E0B))),
            error: (error, stack) => Text('mobile.property.errorLoadingFeatures'.tr(), style: const TextStyle(color: Colors.red)),
            data: (amenities) {
              if (amenities.isEmpty) {
                return Text('mobile.property.noFeatures'.tr(), style: GoogleFonts.outfit(color: Colors.white60));
              }

              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: amenities.map((amenity) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFF59E0B).withOpacity(0.15),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: Color(0xFFF59E0B), size: 14),
                        const SizedBox(width: 8),
                        Text(
                          amenity.amenity?.name ?? '',
                          style: GoogleFonts.outfit(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTab(Property property) {
    if (property.lat == null || property.lng == null) {
      return Center(
        child: Text(
          'mobile.property.noLocation'.tr(),
          style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Map Canvas with Premium Border Radius
          Container(
            height: 280,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(property.lat!, property.lng!),
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(property.id),
                    position: LatLng(property.lat!, property.lng!),
                  ),
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mobile.property.neighborhood'.tr(),
                  style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Text(
                    'mobile.property.noNeighborhood'.tr(),
                    style: GoogleFonts.outfit(fontSize: 14, color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab(Property property) {
    final documentsAsync = ref.watch(propertyDocumentListProvider(property.id));
    final disclosuresAsync = ref.watch(propertyDisclosureListProvider(property.id));

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        Text(
          'mobile.property.documents'.tr(),
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        const SizedBox(height: 16),
        
        documentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF59E0B))),
          error: (error, stack) => Text('Error loading documents', style: const TextStyle(color: Colors.red)),
          data: (documents) {
            if (documents.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('mobile.property.noDocuments'.tr(), style: GoogleFonts.outfit(color: Colors.white60)),
              );
            }
            return Column(
              children: documents.map((doc) => _buildDocumentTile(
                doc.title ?? 'Document',
                doc.category ?? doc.mimeType,
                Icons.picture_as_pdf_rounded,
                doc.storageKey,
              )).toList(),
            );
          },
        ),

        const SizedBox(height: 24),
        Text(
          'mobile.property.disclosures'.tr(),
          style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        const SizedBox(height: 16),
        
        disclosuresAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF59E0B))),
          error: (error, stack) => Text('Error loading disclosures', style: const TextStyle(color: Colors.red)),
          data: (disclosures) {
            if (disclosures.isEmpty) {
              return Text('mobile.property.noDisclosures'.tr(), style: GoogleFonts.outfit(color: Colors.white60));
            }
            return Column(
              children: disclosures.map((disc) => _buildDocumentTile(
                disc.packStatus,
                'Document',
                Icons.verified_user_rounded,
                '',
              )).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDocumentTile(String name, String size, IconData icon, String url) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFFF59E0B), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  size,
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.file_download_outlined, color: Colors.white70, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.white38,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'available':
        return Colors.greenAccent;
      case 'pending':
        return Colors.amberAccent;
      case 'sold':
        return Colors.redAccent;
      case 'rented':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  void _toggleFavorite(String propertyId) {
    ref.read(propertyFavoritesProvider.notifier).toggleFavorite(propertyId);
  }

  void _shareProperty(Property property) {
    SocialExportHub.show(
      context,
      title: property.name ?? 'mobile.property.shareTitle'.tr(),
      description: 'mobile.property.shareDesc'.tr(namedArgs: {'city': property.city ?? ''}),
      mediaUrl: (property.photos != null && property.photos.isNotEmpty) ? property.photos!.first.url : null,
    );
  }

  Future<void> _translateDescription(Property property) async {
    final originalText =
        "This beautiful luxury property features modern amenities, spacious rooms, and a prime location in ${property.city}. Perfect for high-end living.";

    setState(() {
      _isTranslating = true;
    });

    try {
      final translation = await ref
          .read(aiTranslationServiceProvider)
          .translate(originalText, targetLang: 'tr');
      setState(() {
        _translatedDescription = translation;
        _isTranslating = false;
      });
    } catch (e) {
      setState(() {
        _isTranslating = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('mobile.property.translationFailed'.tr(namedArgs: {'error': e.toString()}))));
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
