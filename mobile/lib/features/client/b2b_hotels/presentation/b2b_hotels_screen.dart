import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class B2bHotelsScreen extends StatefulWidget {
  const B2bHotelsScreen({super.key});

  @override
  State<B2bHotelsScreen> createState() => _B2bHotelsScreenState();
}

class _B2bHotelsScreenState extends State<B2bHotelsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text('B2B Hotels', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: Colors.white38,
              labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w600),
              tabs: const [Tab(text: 'Partners'), Tab(text: 'Deals')],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [_HotelPartnersTab(), _HotelDealsTab()],
        ),
      ),
    );
  }
}

class _HotelPartnersTab extends StatelessWidget {
  const _HotelPartnersTab();

  static const _hotels = [
    _Hotel('Four Seasons Istanbul', 'Istanbul · TR', '5★', 92, 'Active'),
    _Hotel('Atlantis The Palm', 'Dubai · AE', '5★', 148, 'Active'),
    _Hotel('The Savoy', 'London · UK', '5★', 67, 'Active'),
    _Hotel('Hotel Arts', 'Barcelona · ES', '5★', 41, 'Pending'),
    _Hotel('Le Royal Monceau', 'Paris · FR', '5★', 55, 'Active'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(children: [
          _Kpi('Partners', '${_hotels.length}', AppColors.primary),
          const SizedBox(width: 12),
          _Kpi('Active', '${_hotels.where((h) => h.status == "Active").length}', AppColors.success),
          const SizedBox(width: 12),
          _Kpi('Total Bookings', '${_hotels.fold(0, (s, h) => s + h.bookings)}', AppColors.info),
        ]),
        const SizedBox(height: 20),
        ..._hotels.map((h) => _HotelTile(hotel: h)),
      ],
    );
  }
}

class _Hotel {
  final String name;
  final String location;
  final String stars;
  final int bookings;
  final String status;
  const _Hotel(this.name, this.location, this.stars, this.bookings, this.status);
}

class _Kpi extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _Kpi(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.darkBorder)),
        child: Column(children: [
          Text(value, style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 18)),
          Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10), textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _HotelTile extends StatelessWidget {
  final _Hotel hotel;
  const _HotelTile({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final ok = hotel.status == 'Active';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.darkBorder)),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
          child: Icon(Icons.hotel_outlined, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(hotel.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
            Text('${hotel.location} · ${hotel.stars} · ${hotel.bookings} bookings', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
          decoration: BoxDecoration(
            color: (ok ? AppColors.success : AppColors.warning).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(hotel.status, style: GoogleFonts.outfit(color: ok ? AppColors.success : AppColors.warning, fontSize: 10, fontWeight: FontWeight.w700)),
        ),
      ]),
    );
  }
}

class _HotelDealsTab extends StatelessWidget {
  const _HotelDealsTab();

  @override
  Widget build(BuildContext context) {
    final deals = [
      ('Summer Relocation Package', 'Four Seasons + Airport + Styling', '15% off', AppColors.success),
      ('Long-Stay Corporate Rate', '30+ nights at partner hotels', '20% off', AppColors.primary),
      ('Luxury Referral Bundle', 'Client referral + hotel stay', '\$500 credit', AppColors.warning),
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: deals.map((d) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: d.$4.withValues(alpha: 0.25)),
        ),
        child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(d.$1, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
            const SizedBox(height: 3),
            Text(d.$2, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: d.$4.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: d.$4.withValues(alpha: 0.4))),
            child: Text(d.$3, style: GoogleFonts.outfit(color: d.$4, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ]),
      )).toList(),
    );
  }
}
