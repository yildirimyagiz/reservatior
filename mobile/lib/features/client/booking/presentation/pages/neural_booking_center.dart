import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/booking_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/features/client/booking/presentation/widgets/booking_list_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class NeuralBookingCenter extends ConsumerStatefulWidget {
  const NeuralBookingCenter({super.key});

  @override
  ConsumerState<NeuralBookingCenter> createState() =>
      _NeuralBookingCenterState();
}

class _NeuralBookingCenterState extends ConsumerState<NeuralBookingCenter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withOpacity(0.8),
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'mobile.ai.booking.operations'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                color: AppColors.primary,
              ),
            ),
            Text(
              'mobile.ai.booking.control'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          _pulseAction(Icons.radar_rounded, Colors.orange),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3.0, color: AppColors.primary),
            insets: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white24,
          labelStyle: GoogleFonts.outfit(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
          tabs: [
            Tab(text: 'mobile.ai.booking.tabOperations'.tr()),
            Tab(text: 'mobile.ai.booking.tabMarketIntel'.tr()),
            Tab(text: 'mobile.ai.booking.tabDynamicRules'.tr()),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.6),
            radius: 1.2,
            colors: [AppColors.primary.withOpacity(0.05), Colors.transparent],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildOperationsTab(),
            _buildMarketIntelTab(),
            _buildPricingRulesTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        elevation: 12,
        onPressed: () {},
        icon: const Icon(Icons.bolt_rounded, color: Colors.white),
        label: Text(
          'mobile.ai.booking.fastSync'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ).animate().slideY(begin: 1, end: 0, delay: 400.ms),
    );
  }

  Widget _pulseAction(IconData icon, Color color) {
    return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon, color: color, size: 20),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2.seconds, color: color.withOpacity(0.2));
  }

  Widget _buildOperationsTab() {
    final itemsAsync = ref.watch(bookingListProvider);
    return itemsAsync.when(
      data: (data) => RefreshIndicator(
        onRefresh: () async => ref.refresh(bookingListProvider),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            top: 140,
            left: 16,
            right: 16,
            bottom: 100,
          ),
          child:
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNeuralStatusCard(),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'mobile.ai.booking.activeReservations'.tr(),
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: Colors.white54,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const Icon(
                            Icons.tune_rounded,
                            color: Colors.white24,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      BookingListWidget(items: data as List<Booking>),
                    ],
                  )
                  .animate()
                  .scale(
                    duration: 300.ms,
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1.0, 1.0),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms),
        ),
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(
        child: Text(
          'mobile.ai.booking.syncError'.tr(),
          style: GoogleFonts.outfit(color: Colors.redAccent),
        ),
      ),
    );
  }

  Widget _buildNeuralStatusCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.5, 1.5),
                    duration: 1.seconds,
                    curve: Curves.easeOut,
                  )
                  .animate()
                  .fadeOut(),
              SizedBox(width: 12),
              Text(
                'mobile.ai.booking.syncActive'.tr(),
                style: GoogleFonts.outfit(
                  color: AppColors.success,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                'mobile.ai.booking.latency'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '98.4%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),
          Text(
            'mobile.ai.booking.globalParity'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.984,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'mobile.ai.booking.syncDesc'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ).animate().scale(
      duration: 600.ms,
      curve: Curves.easeOutBack,
      begin: const Offset(0.95, 0.95),
      end: const Offset(1.0, 1.0),
    );
  }

  Widget _buildMarketIntelTab() {
    return ListView(
      padding: const EdgeInsets.only(top: 140, left: 16, right: 16, bottom: 20),
      children: [
        _buildIntelCard(
          'mobile.ai.booking.indexGlobal'.tr(),
          '₺1,450',
          Icons.language_rounded,
          Colors.blue,
        ),
        _buildIntelCard(
          'mobile.ai.booking.indexLocal'.tr(),
          '₺1,380',
          Icons.near_me_rounded,
          Colors.green,
        ),
        _buildIntelCard(
          'mobile.ai.booking.indexLuxury'.tr(),
          '₺1,620',
          Icons.auto_awesome_rounded,
          Colors.orange,
        ),
        _buildIntelCard(
          'mobile.ai.booking.indexSaturation'.tr(),
          'HIGH',
          Icons.analytics_rounded,
          Colors.redAccent,
        ),
      ].animate(interval: 100.ms).fadeIn().slideX(begin: 0.1),
    );
  }

  Widget _buildIntelCard(
    String provider,
    String val,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'mobile.ai.booking.telemetry'.tr(),
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            val,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRulesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.auto_fix_high_rounded,
            color: AppColors.primary,
            size: 80,
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 3.seconds),
          SizedBox(height: 24),
          Text(
            'mobile.ai.booking.engine'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'mobile.ai.booking.aiSuggestion'.tr(),
            style: GoogleFonts.outfit(
              color: AppColors.success,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white10),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'mobile.ai.booking.calibrate'.tr(),
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
