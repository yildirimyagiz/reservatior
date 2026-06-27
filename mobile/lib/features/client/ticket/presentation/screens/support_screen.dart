import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        title: Text('mobile.auto.support'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w800,
            color: colors.textPrimary,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(height: 12),
                Text('mobile.auto.how_can_we_help'.tr(),
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text('mobile.auto.our_support_team_is_available_24_7'.tr(),
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.1),
          SizedBox(height: 20),
          TextField(
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'mobile.auto.search_help_articles'.tr(),
              hintStyle: TextStyle(color: colors.textSecondary),
              prefixIcon: Icon(Icons.search, color: colors.textSecondary),
              filled: true,
              fillColor: colors.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.quick_help_faqs'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ..._helpTopics.asMap().entries.map(
            (e) => _tile(context, e.value, colors, e.key),
          ),
          SizedBox(height: 24),
          Text('mobile.auto.contact_concierge'.tr(),
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _contactCard(
                  context,
                  Icons.chat_rounded,
                  'mobile.leftovers.live_chat'.tr(),
                  Colors.blue,
                  colors,
                  () => _startLiveChatSession(context, colors),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactCard(
                  context,
                  Icons.email_rounded,
                  'Email',
                  Colors.green,
                  colors,
                  () => _openEmailSupportModal(context, colors),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _contactCard(
                  context,
                  Icons.phone_rounded,
                  'Call',
                  Colors.orange,
                  colors,
                  () => _startSimulatedCall(context, colors),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
    );
  }

  void _showFaqDialog(BuildContext context, Map<String, dynamic> topic, ThemeAwareColors colors) {
    final title = topic['title'] as String;
    final List<Map<String, String>> faqs = _getFaqsForTopic(title);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.border, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(topic['icon'] as IconData, color: topic['color'] as Color, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      '$title Guide',
                      style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  physics: const BouncingScrollPhysics(),
                  itemCount: faqs.length,
                  itemBuilder: (context, index) {
                    final faq = faqs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            faq['q']!,
                            style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            faq['a']!,
                            style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13, height: 1.5),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.05);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getFaqsForTopic(String title) {
    if (title == 'mobile.leftovers.getting_started'.tr()) {
      return [
        {'q': 'mobile.leftovers.how_to_invite_team_members'.tr(), 'a': 'mobile.leftovers.to_add_agency_staff_or_agents_navigate_t'.tr()},
        {'q': 'mobile.leftovers.how_to_launch_your_first_portfolio'.tr(), 'a': 'mobile.leftovers.go_to_home_tab_click_the_green_icon_choo'.tr()},
        {'q': 'mobile.leftovers.how_to_synch_digital_twin_scans'.tr(), 'a': 'Ensure you have the matterport link or custom 3D file, select the address, and tap "Link Digital Twin" in property options.'},
      ];
    } else if (title == 'mobile.leftovers.account_billing'.tr()) {
      return [
        {'q': 'mobile.leftovers.how_to_upgrade_my_plan'.tr(), 'a': 'mobile.leftovers.click_upgrade_in_the_profile_tab_or_visi'.tr()},
        {'q': 'mobile.leftovers.which_payment_methods_are_supported'.tr(), 'a': 'mobile.leftovers.we_accept_all_major_international_credit'.tr()},
        {'q': 'mobile.leftovers.how_do_refunds_get_processed'.tr(), 'a': 'mobile.leftovers.refunds_are_processed_automatically_for'.tr()},
      ];
    } else if (title == 'mobile.leftovers.property_management'.tr()) {
      return [
        {'q': 'mobile.leftovers.how_are_tenant_leads_processed'.tr(), 'a': 'mobile.leftovers.ai_scoring_ranks_incoming_leads_automati'.tr()},
        {'q': 'mobile.leftovers.how_do_i_sign_rental_contracts'.tr(), 'a': 'mobile.leftovers.utilize_our_secure_cryptographic_e_signa'.tr()},
      ];
    } else if (title == 'mobile.leftovers.ai_features'.tr()) {
      return [
        {'q': 'mobile.leftovers.how_works_the_ai_valuation_engine'.tr(), 'a': 'mobile.leftovers.our_models_run_daily_comparative_market'.tr()},
        {'q': 'mobile.leftovers.is_virtual_staging_raytraced'.tr(), 'a': 'mobile.leftovers.yes_we_run_stable_diffusion_high_definit'.tr()},
      ];
    } else {
      return [
        {'q': 'mobile.leftovers.how_to_obtain_developer_api_keys'.tr(), 'a': 'mobile.leftovers.api_keys_are_generated_automatically_for'.tr()},
        {'q': 'mobile.leftovers.can_i_hook_slack_discord_webhooks'.tr(), 'a': 'mobile.leftovers.yes_real_time_alerts_can_be_configured_t'.tr()},
      ];
    }
  }

  void _startLiveChatSession(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LiveChatWidget(colors: colors),
    );
  }

  void _openEmailSupportModal(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => EmailSupportWidget(colors: colors),
    );
  }

  void _startSimulatedCall(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => CallSupportWidget(colors: colors),
    );
  }

  Widget _tile(BuildContext context, Map<String, dynamic> t, ThemeAwareColors c, int i) => GestureDetector(
    onTap: () => _showFaqDialog(context, t, c),
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (t['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              t['icon'] as IconData,
              color: t['color'] as Color,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['title'] as String,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                    fontSize: 14,
                  ),
                ),
                Text(
                  t['desc'] as String,
                  style: TextStyle(color: c.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: c.textSecondary, size: 20),
        ],
      ),
    ),
  ).animate().fadeIn(delay: Duration(milliseconds: 60 * i)).slideX(begin: 0.03);

  Widget _contactCard(
    BuildContext context,
    IconData ic,
    String label,
    Color color,
    ThemeAwareColors c,
    VoidCallback onTap,
  ) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(ic, color: color, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: c.textPrimary,
            ),
          ),
        ],
      ),
    ),
  );

  static final _helpTopics = [
    {
      'title': 'mobile.leftovers.getting_started'.tr(),
      'desc': 'mobile.leftovers.setup_guide_first_steps'.tr(),
      'icon': Icons.rocket_launch_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'mobile.leftovers.account_billing'.tr(),
      'desc': 'mobile.leftovers.subscription_payment_help'.tr(),
      'icon': Icons.credit_card_rounded,
      'color': Colors.green,
    },
    {
      'title': 'mobile.leftovers.property_management'.tr(),
      'desc': 'mobile.leftovers.listings_bookings_tenants'.tr(),
      'icon': Icons.home_work_rounded,
      'color': Colors.orange,
    },
    {
      'title': 'mobile.leftovers.ai_features'.tr(),
      'desc': 'mobile.leftovers.valuation_staging_analytics'.tr(),
      'icon': Icons.auto_awesome,
      'color': Colors.purple,
    },
    {
      'title': 'Integrations',
      'desc': 'mobile.leftovers.api_webhooks_third_party'.tr(),
      'icon': Icons.extension_rounded,
      'color': Colors.teal,
    },
  ];
}

// ─── CUSTOM SIMULATED SUPPORT WIDGETS ───────────────────────────────────────────

class LiveChatWidget extends StatefulWidget {
  final ThemeAwareColors colors;
  const LiveChatWidget({super.key, required this.colors});

  @override
  State<LiveChatWidget> createState() => _LiveChatWidgetState();
}

class _LiveChatWidgetState extends State<LiveChatWidget> {
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'mobile.leftovers.hello_i_am_reservatior_s_luxury_ai_suppo'.tr(),
      'isUser': false,
    }
  ];
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _controller.clear();
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      String response = "Thank you for reaching out! I've logged your request in ticket #REV-${1000 + _messages.length}. An enterprise account manager will assist you shortly.";
      
      final lower = text.toLowerCase();
      if (lower.contains('valuation') || lower.contains('ai')) {
        response = 'mobile.leftovers.our_neural_valuation_models_run_live_cal'.tr();
      } else if (lower.contains('billing') || lower.contains('price')) {
        response = 'mobile.leftovers.for_billing_questions_i_can_check_your_a'.tr();
      } else if (lower.contains('listings') || lower.contains('twin')) {
        response = 'mobile.leftovers.to_update_digital_twins_or_properties_ma'.tr();
      }

      setState(() {
        _isTyping = false;
        _messages.add({'text': response, 'isUser': false});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: widget.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: widget.colors.border),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: widget.colors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.support_agent_rounded, color: Colors.blue, size: 24),
                    SizedBox(width: 12),
                    Text('mobile.auto.ai_customer_support'.tr(),
                      style: GoogleFonts.outfit(color: widget.colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                  child: Text('mobile.auto.online'.tr(), style: TextStyle(color: Colors.greenAccent, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['isUser'] as bool;
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? AppColors.primary : widget.colors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                      ),
                      border: Border.all(color: widget.colors.border),
                    ),
                    child: Text(
                      msg['text'] as String,
                      style: GoogleFonts.outfit(color: isUser ? Colors.white : widget.colors.textPrimary, fontSize: 13, height: 1.4),
                    ),
                  ),
                ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.05);
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent)),
                  ),
                  SizedBox(width: 8),
                  Text('mobile.auto.agent_is_typing'.tr(), style: TextStyle(color: widget.colors.textSecondary, fontSize: 11, fontStyle: FontStyle.italic)),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, left: 16, right: 16, top: 12),
            decoration: BoxDecoration(color: widget.colors.background, border: Border(top: BorderSide(color: widget.colors.border))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: widget.colors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'mobile.auto.ask_a_support_question'.tr(),
                      hintStyle: TextStyle(color: widget.colors.textSecondary, fontSize: 13),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: widget.colors.card,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmailSupportWidget extends StatefulWidget {
  final ThemeAwareColors colors;
  const EmailSupportWidget({super.key, required this.colors});

  @override
  State<EmailSupportWidget> createState() => _EmailSupportWidgetState();
}

class _EmailSupportWidgetState extends State<EmailSupportWidget> {
  final _subjectController = TextEditingController(text: 'mobile.leftovers.assistance_needed_with_digital_twin_sync'.tr());
  final _msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 24, left: 24, right: 24, top: 24),
      decoration: BoxDecoration(
        color: widget.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: widget.colors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: widget.colors.border, borderRadius: BorderRadius.circular(2)))),
          SizedBox(height: 24),
          Text('mobile.auto.new_support_ticket'.tr(),
            style: GoogleFonts.outfit(color: widget.colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('mobile.auto.ticket_will_be_routed_to_support_reservatior_com'.tr(), style: TextStyle(color: widget.colors.textSecondary, fontSize: 11)),
          const SizedBox(height: 16),
          TextField(
            controller: _subjectController,
            style: TextStyle(color: widget.colors.textPrimary),
            decoration: InputDecoration(
              labelText: 'Subject',
              labelStyle: TextStyle(color: widget.colors.textSecondary),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _msgController,
            maxLines: 4,
            style: TextStyle(color: widget.colors.textPrimary),
            decoration: InputDecoration(
              labelText: 'mobile.leftovers.message_body'.tr(),
              labelStyle: TextStyle(color: widget.colors.textSecondary),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: 'mobile.auto.describe_your_issue_in_detail'.tr(),
              hintStyle: TextStyle(color: widget.colors.textSecondary, fontSize: 13),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('mobile.support.ticket_submitted'.tr()),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text('mobile.auto.submit_ticket'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

class CallSupportWidget extends StatefulWidget {
  final ThemeAwareColors colors;
  const CallSupportWidget({super.key, required this.colors});

  @override
  State<CallSupportWidget> createState() => _CallSupportWidgetState();
}

class _CallSupportWidgetState extends State<CallSupportWidget> {
  String _status = 'mobile.leftovers.connecting_secure_line'.tr();
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _status = 'mobile.leftovers.ringing_luxury_client_concierge'.tr();
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _status = 'mobile.leftovers.connected_to_alexander_wright_vip'.tr();
        _connected = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: widget.colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        border: Border.all(color: widget.colors.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: widget.colors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 32),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 2.seconds).fadeOut(duration: 2.seconds),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.phone_in_talk_rounded, color: Colors.white, size: 36),
              ),
            ],
          ),
          SizedBox(height: 32),
          Text('mobile.auto.reservatior_voip_concierge'.tr(),
            style: GoogleFonts.outfit(color: widget.colors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _status,
            style: GoogleFonts.outfit(color: _connected ? Colors.greenAccent : widget.colors.textSecondary, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.call_end_rounded, color: Colors.white),
                SizedBox(width: 10),
                Text('mobile.auto.end_call'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
