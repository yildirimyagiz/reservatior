import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EDevletContractWizard extends ConsumerStatefulWidget {
  const EDevletContractWizard({super.key});

  @override
  ConsumerState<EDevletContractWizard> createState() => _EDevletContractWizardState();
}

class _EDevletContractWizardState extends ConsumerState<EDevletContractWizard> {
  int _activeStep = 1;
  bool _eidsVerified = false;
  bool _smsSent = false;
  String _smsCode = '';
  String? _barcodeNo;
  String _selectedAgentId = 'ag_101';

  static const _agents = [
    {
      'id': 'ag_101',
      'name': 'Murat Yılmaz',
      'agency': 'Vizyon Gayrimenkul Kadıköy',
      'licenseNo': '34001928',
      'commissionShare': '%3.5 Standart',
    },
    {
      'id': 'ag_102',
      'name': 'Selin Kaya',
      'agency': 'Turyap Beşiktaş Yetkili Ofisi',
      'licenseNo': '34008102',
      'commissionShare': '%3.5 Standart',
    },
    {
      'id': 'ag_103',
      'name': 'Reservatior Direkt',
      'agency': 'Yalnızca Platform Hizmeti',
      'licenseNo': 'RESERV-DIRECT',
      'commissionShare': '%1.5 İndirimli',
    },
  ];

  Future<void> _simulate(Future<void> Function() fn) async {
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 700));
    await fn();
  }

  @override
  Widget build(BuildContext context) {
    final selectedAgent = _agents.firstWhere((a) => a['id'] == _selectedAgentId);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'e-Devlet Contract Wizard',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Listing, agent selection & in-app approval engine',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStepIndicator(),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: _buildStepContent(selectedAgent),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    const titles = ['Listing & Agent', 'In-App Approval', 'Tenant Approval', 'Contract'];
    return Row(
      children: List.generate(4, (i) {
        final step = i + 1;
        final isDone = _activeStep > step;
        final isCurrent = _activeStep == step;
        final color = isDone ? AppColors.success : isCurrent ? AppColors.primary : AppColors.textSecondaryDark;
        return Expanded(
          child: Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.15),
                  border: Border.all(color: color),
                ),
                child: Center(
                  child: isDone
                      ? Icon(Icons.check_circle, color: AppColors.success, size: 22)
                      : Text('$step', style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w800, color: color)),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                titles[i],
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 9,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                  color: isCurrent ? Colors.white : AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        );
      }),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildStepContent(Map<String, String> selectedAgent) {
    switch (_activeStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2(selectedAgent);
      case 3:
        return _buildStep3();
      default:
        return _buildStep4(selectedAgent);
    }
  }

  Widget _buildStep1() {
    return Container(
      key: const ValueKey('step1'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '1. Listing Info & Agent Selection',
                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _eidsVerified ? AppColors.success.withValues(alpha: 0.15) : AppColors.warning.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _eidsVerified ? 'Doğrulanmış Taşınmaz' : 'EİDS Kontrolü',
                  style: GoogleFonts.outfit(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: _eidsVerified ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _fieldLabel('İlan Başlığı'),
          _buildInput(initial: 'Moda Cad. 2+1 Lüks Kiralık Daire'),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel('Takbis / Tapu ID'),
                    _buildInput(initial: '16749021'),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: ElevatedButton(
                  onPressed: _eidsVerified
                      ? null
                      : () => _simulate(() async {
                            setState(() => _eidsVerified = true);
                          }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.info,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(_eidsVerified ? '✓' : 'Sorgula', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _fieldLabel('Aylık Kira Bedeli (TL)'),
          _buildInput(initial: '35.000'),
          const SizedBox(height: 18),
          Text(
            'Yetkili Emlak Danışmanı / Acente Seçimi',
            style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 10),
          ..._agents.map((a) {
            final isSelected = a['id'] == _selectedAgentId;
            return GestureDetector(
              onTap: () => setState(() => _selectedAgentId = a['id']!),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : AppColors.darkSurface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.darkBorder,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                      child: const Center(child: Icon(Icons.person, color: AppColors.primaryLight, size: 18)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(a['name']!, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                          Text(a['agency']!, style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Lisans: ${a['licenseNo']}', style: GoogleFonts.jetBrainsMono(fontSize: 9, color: AppColors.textSecondaryDark)),
                        Text(a['commissionShare']!, style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.info)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !_eidsVerified
                  ? null
                  : () => setState(() {
                        _activeStep = 2;
                        _smsSent = false;
                      }),
              style: ElevatedButton.styleFrom(
                backgroundColor: _eidsVerified ? AppColors.primary : AppColors.darkMuted,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                _eidsVerified ? 'Devam Et: İlan Onayı Adımına Geç' : 'Önce EİDS Doğrulaması Gerekli',
                style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(Map<String, String> selectedAgent) {
    return Container(
      key: const ValueKey('step2'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.verified_user_outlined, color: AppColors.primary, size: 34),
          ),
          const SizedBox(height: 14),
          Text(
            '2. Platform İçi Doğrudan İlan Onayı',
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'SMS onay kodu ile ilanınızı ve seçtiğiniz emlakçıyı anında yetkilendirin.',
            style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.person, color: AppColors.primaryLight, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(selectedAgent['name']!, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                      Text(
                        '${selectedAgent['agency']} (Lisans: ${selectedAgent['licenseNo']})',
                        style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Yetkilendirilecek', style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.info)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (!_smsSent)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _smsSent = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text('SMS Onay Kodu Gönder (Platform İçi Doğrulama)', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13)),
              ),
            )
          else
            Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => _smsCode = v),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jetBrainsMono(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 6),
                  decoration: InputDecoration(
                    hintText: '6 Haneli Kod',
                    hintStyle: GoogleFonts.jetBrainsMono(fontSize: 16, color: AppColors.textSecondaryDark),
                    filled: true,
                    fillColor: AppColors.darkSurface,
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Demo kod: 884192',
                  style: GoogleFonts.outfit(fontSize: 10, color: AppColors.warning),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_smsCode == '884192') {
                        setState(() {
                          _activeStep = 3;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Geçersiz SMS Kodu! (Demo: 884192)', style: GoogleFonts.outfit(fontSize: 12))),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.info,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text('İlanı Onayla & Yetkilendir', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    return Container(
      key: const ValueKey('step3'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.info.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.credit_card_outlined, color: AppColors.info, size: 34),
          ),
          const SizedBox(height: 14),
          Text(
            '3. Kiracı Onayı & Depozito Hesabı',
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Mülk sahibi ve emlakçı yetkilendirme onayı alındı! Kiracı ödeme ve imza sürecini başlatacaktır.',
            style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => setState(() {
                _barcodeNo = 'TR-RSV-2026-${10000000 + DateTime.now().millisecondsSinceEpoch % 90000000}';
                _activeStep = 4;
              }),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.info,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text('Kiracı Onayını Tamamla', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4(Map<String, String> selectedAgent) {
    return Container(
      key: const ValueKey('step4'),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.check_circle_outline, color: AppColors.success, size: 42),
          ).animate().fadeIn(duration: 400.ms).scale(),
          const SizedBox(height: 14),
          Text(
            'İlan & Sözleşme Başarıyla Yayınlandı!',
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Platform içi doğrudan onay ile resmi zaman damgalı sözleşmeniz üretildi.',
            style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.darkSurface.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Yetkili Emlak Danışmanı:', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                    Text('${selectedAgent['name']}', style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Barkod Referans No:', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                    Text('$_barcodeNo', style: GoogleFonts.jetBrainsMono(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.primaryLight)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.download, size: 18),
              label: Text('Barkodlu Kontratı İndir', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondaryDark)),
    );
  }

  Widget _buildInput({required String initial}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: TextField(
        controller: TextEditingController(text: initial),
        style: GoogleFonts.outfit(fontSize: 13, color: Colors.white),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
