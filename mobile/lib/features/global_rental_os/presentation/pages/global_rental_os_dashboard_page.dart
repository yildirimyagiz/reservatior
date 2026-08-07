import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Global Hybrid Rental OS — Main Dashboard
/// Shows overview stats, quick access to sub-pages, and country coverage.
class GlobalRentalOsDashboardPage extends StatefulWidget {
  const GlobalRentalOsDashboardPage({super.key});

  @override
  State<GlobalRentalOsDashboardPage> createState() => _GlobalRentalOsDashboardPageState();
}

class _GlobalRentalOsDashboardPageState extends State<GlobalRentalOsDashboardPage> {
  List<dynamic> _countries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final res = await http.get(
        Uri.parse('http://localhost:3000/api/os/global-hybrid-rental/countries'),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          _countries = data['countries'] ?? [];
          _loading = false;
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: const Color(0xFF0F1117).withOpacity(0.9),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Global Hybrid Rental OS',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    '23 Countries · 15 Currencies · 10 AI Agents',
                    style: GoogleFonts.outfit(fontSize: 10, color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),

          // Stats Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  _statCard('23', 'Countries', const Color(0xFF10B981), Icons.flag_outlined),
                  const SizedBox(width: 8),
                  _statCard('15+', 'Currencies', const Color(0xFFF59E0B), Icons.currency_exchange),
                  const SizedBox(width: 8),
                  _statCard('10', 'AI Agents', const Color(0xFF8B5CF6), Icons.psychology_outlined),
                  const SizedBox(width: 8),
                  _statCard('6', 'Models', const Color(0xFF3B82F6), Icons.layers_outlined),
                ],
              ),
            ),
          ),

          // Quick Access Cards
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUICK ACCESS',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white30,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _navCard(
                          'Country Intelligence',
                          'Browse 23 countries',
                          Icons.public_outlined,
                          const Color(0xFF10B981),
                          () => context.push('/global-rental-os/countries'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _navCard(
                          'Saga Orchestrator',
                          '10-step pipeline',
                          Icons.play_circle_outline,
                          const Color(0xFF8B5CF6),
                          () => context.push('/global-rental-os/saga'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _navCard(
                          'Revenue DAG',
                          '8-node pipeline',
                          Icons.account_tree_outlined,
                          const Color(0xFFF59E0B),
                          () => context.push('/global-rental-os/revenue'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _navCard(
                          'Partner Network',
                          '5 tiers · 15 roles',
                          Icons.people_outline,
                          const Color(0xFF3B82F6),
                          () => context.push('/global-rental-os/partners'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Country Coverage
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Row(
                children: [
                  Text(
                    'COUNTRY COVERAGE',
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white30,
                      letterSpacing: 2,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/global-rental-os/countries'),
                    child: Text(
                      'View All →',
                      style: GoogleFonts.outfit(fontSize: 11, color: const Color(0xFF10B981), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Country list
          _loading
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(color: Color(0xFF6366F1)),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2.2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                        final c = _countries[i];
                        final demand = c['corporateHousingDemand'] ?? 'MEDIUM';
                        final color = _demandColor(demand);
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2433),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: color.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    c['countryCode'] ?? '',
                                    style: GoogleFonts.outfit(
                                      color: color,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      c['countryName'] ?? '',
                                      style: GoogleFonts.outfit(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${c['currency']} · ${c['vatRate']}% VAT',
                                      style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: _countries.length > 8 ? 8 : _countries.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.15)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 4),
            Text(value, style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
            Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 8, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _navCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2433),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 10),
            Text(title, style: GoogleFonts.outfit(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(subtitle, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9)),
          ],
        ),
      ),
    );
  }

  Color _demandColor(String demand) {
    switch (demand) {
      case 'VERY_HIGH': return const Color(0xFF10B981);
      case 'HIGH': return const Color(0xFF3B82F6);
      case 'MEDIUM': return const Color(0xFFF59E0B);
      default: return const Color(0xFFEF4444);
    }
  }
}
